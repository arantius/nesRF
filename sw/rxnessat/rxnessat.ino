/*
nesRF Wireless Controller Retrofit: Receiver
Copyright 2014 Anthony Lieuallen

This code is responsible for what needs to happen in the receiver:
1) Read the state of all the buttons, via RF.
2) Transmit that to the console.
*/

// Define this to send debugging data out via Serial.
//#define DEBUG

// Addresses of data stored in EEPROM.
#define EEPROM_RF_CHAN 0x00 /* One byte, the RF channel. */
#define EEPROM_RF_ADDR 0x01 /* Five bytes, the RF address. */

#define BLINK_INTERVAL 333
#define DATA_MIN_INTERVAL 2048

// \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ //

#include <EEPROM.h>
#include <SPI.h>

#include "nRF24L01.h"
#include "RF24.h"
#ifdef DEBUG
#include "printf.h"
#endif

// \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ //

#define PORT_LATCH1 PORTD
#define PIN_LATCH1 _BV(2)

#define PORT_LATCH2 PORTD
#define PIN_LATCH2 _BV(3)

#define PORT_CLK1 PORTC
#define PIN_CLK1 _BV(5)

#define PORT_CLK2 PORTD
#define PIN_CLK2 _BV(6)

#define PORT_D0P1 PORTC
#define PIN_D0P1 _BV(4)

#define PORT_D0P2 PORTD
#define PIN_D0P2 _BV(5)

#define PORT_D3P2 PORTC
#define PIN_D3P2 _BV(1)

#define PORT_D4P2 PORTD
#define PIN_D4P2 _BV(4)

#define PORT_GRN PORTB
#define PIN_GRN _BV(0)

#define PORT_YEL PORTD
#define PIN_YEL _BV(7)

// \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ //

RF24 radio(10, 14);  // CE, CS pins
unsigned long gDataTimeMax = 0;
unsigned long gDataTime[2] = {0, 0};
uint16_t gNextTurbo = 0;
volatile uint8_t gData[2] = {0xFF, 0xFF};
uint8_t gShiftBit[2] = {1, 1};
uint8_t gTurboActive = 0;
uint8_t gTurboMask[2] = {0xFF, 0xFF};

// \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ //

#define lightLedOff() PORT_GRN &= ~PIN_GRN; PORT_YEL &= ~PIN_YEL;
#define lightLedGrn() PORT_YEL &= ~PIN_YEL; PORT_GRN |= PIN_GRN;
#define lightLedYel() PORT_GRN &= ~PIN_GRN; PORT_YEL |= PIN_YEL;

// \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ //

// TODO: Handle players 3 through 4.
void ISR_latch() {
  // NES protocol is, for each read: one wide high-going LATCH pulse,
  // followed by eight narrow low-going CLK pulses.  While CLK is low,
  // the console is reading data.

  // Initialize the bit mask.
  gShiftBit[0] = 1;
  gShiftBit[1] = 1;
  // Set the initial data line values.
  ISR_clock1();
  ISR_clock2();
}

inline void ISR_clock1() {
  // If clock is low we caught a falling edge; cancel and wait for rising.
  if (!(PINC & PIN_CLK1)) return;

  if ( (gData[0] & gShiftBit[0]) == 0
      || (gTurboActive && ((gTurboMask[0] & gShiftBit[0]) == 0))
  ) {
    PORT_D0P1 &= ~PIN_D0P1;
  } else {
    PORT_D0P1 |= PIN_D0P1;
  }

  gShiftBit[0] <<= 1;

  // In case we caught the falling edge, but couldn't read clock until
  // it rose, clear the interrupt flag so we don't re-execute on rising.
  PCIFR |= _BV(PCIF1);
}

inline void ISR_clock2() {
  // If clock is low we caught a falling edge; cancel and wait for rising.
  if (!(PIND & PIN_CLK2)) return;

  if ( (gData[1] & gShiftBit[1]) == 0
      || (gTurboActive && ((gTurboMask[1] & gShiftBit[1]) == 0))
  ) {
    PORT_D0P2 &= ~PIN_D0P2;
  } else {
    PORT_D0P2 |= PIN_D0P2;
  }

  gShiftBit[1] <<= 1;

  // In case we caught the falling edge, but couldn't read clock until
  // it rose, clear the interrupt flag so we don't re-execute on rising.
  PCIFR |= _BV(PCIF2);
}

SIGNAL(PCINT1_vect) { ISR_clock1(); }
SIGNAL(PCINT2_vect) { ISR_clock2(); }

// \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ //

void loop(void) {
  unsigned long now = millis();

  // Light the LED as per the last time any data was received.
  if (gDataTimeMax && (gDataTimeMax + DATA_MIN_INTERVAL > now)) {
    lightLedGrn();
  } else {
    lightLedYel();
  }

  // Reset either player's data if it's been too long since last data.
  for (uint8_t i = 0; i < 2; i++) {
    if (gDataTime[i] && (gDataTime[i] + DATA_MIN_INTERVAL < now)) {
      gDataTime[i] = 0;
      gDataTimeMax = gDataTime[2 - i];
      gData[i] = 0xFF;
    }
  }

  // Flip turbo status on a ~30Hz period.
  if (now > gNextTurbo) {
    gNextTurbo = now + 33;
    gTurboActive = ~gTurboActive;
  }

  // TODO: Set appropriate masks and just read RF_IRQ pin to see pending data?
  uint16_t data_raw = 0;
  uint8_t pipe;
  while (radio.available()) {
    uint8_t status = radio.get_status();
    pipe = (status >> 1) & 0x07;
    #ifdef DEBUG
    printf("Reading from pipe number %d ... ", pipe);
    #endif
    if (pipe > 1) {
      #ifdef DEBUG
      printf("Panic!  Data on unsupported pipe!\n");
      #endif
      return;
    }
    radio.read(&data_raw, sizeof(data_raw));
  }

  if (data_raw) {
    // TODO: Read multiple controllers.
    // TODO: Use battery/sleeping status bits?

    // Translate RF data to NES data.
    uint8_t data_nes = 0x00;
    uint8_t turbo_mask = 0xFF;
    data_nes = data_nes << 1; if (data_raw & _BV(7)) data_nes |= 1; // Right
    data_nes = data_nes << 1; if (data_raw & _BV(6)) data_nes |= 1; // Left
    data_nes = data_nes << 1; if (data_raw & _BV(5)) data_nes |= 1; // Down
    data_nes = data_nes << 1; if (data_raw & _BV(4)) data_nes |= 1; // Up
    data_nes = data_nes << 1; if (data_raw & _BV(3)) data_nes |= 1; // Start
    data_nes = data_nes << 1; if (data_raw & _BV(2)) data_nes |= 1; // Select
    data_nes = data_nes << 1; if (data_raw & _BV(0)) data_nes |= 1; // B
    if (!(data_raw & _BV(1))) turbo_mask &= ~_BV(1); // Y = B Turbo
    data_nes = data_nes << 1; if (data_raw & _BV(8)) data_nes |= 1; // A
    if (!(data_raw & _BV(9))) turbo_mask &= ~_BV(0); // X = A Turbo

    #ifdef DEBUG
    printf("RX got %04x; Translt. %02x; Turbo %02x\n",
        data_raw, data_nes, turbo_mask);
    #endif

    // TODO: X/Y as turbo for A/B.

    gData[pipe] = data_nes;
    gDataTimeMax = now;
    gDataTime[pipe] = now;
    gTurboMask[pipe] = turbo_mask;
  }
}


void setup() {
  #ifdef DEBUG
  Serial.begin(57600);
  printf_begin();
  printf("\n\n\nnesRF RX begin\n");
  #endif

  radio.begin();
  radio.setAutoAck(1);
  radio.setCRCLength(RF24_CRC_16);
  radio.setChannel(EEPROM.read(EEPROM_RF_CHAN));
  radio.setDataRate(RF24_1MBPS);
  radio.setPALevel(RF24_PA_MAX);
  radio.setPayloadSize(sizeof(uint16_t));
  radio.setRetries(7, 10);  // delay, retries

  byte address[5] = {};
  for (int i = 0; i < 5; i++) {
    address[i] = EEPROM.read(EEPROM_RF_ADDR + i);
  }

  radio.stopListening();
  radio.openReadingPipe(0, address);
  address[0]++;
  radio.openReadingPipe(1, address);
  address[0]++;
  radio.openReadingPipe(2, address);
  address[0]++;
  radio.openReadingPipe(3, address);
  radio.startListening();

  // The LED indicator is hooked up to pins PB0 (Green) and PD7 (Yellow).
  DDRB |= PIN_GRN;
  DDRD |= PIN_YEL;
  // Pins D0_1, D0_2, D3_2, D4_2.
  DDRC |= PIN_D0P1 | PIN_D3P2;
  DDRD |= PIN_D0P2 | PIN_D4P2;

  // The CLOCK and LATCH signals should be pullup enabled inputs.
  DDRC &= ~PIN_CLK1;
  DDRD &= ~(PIN_LATCH1 | PIN_LATCH2 | PIN_CLK2);
  PORTD |= PIN_CLK1;
  PORTD |= PIN_LATCH1 | PIN_LATCH2 | PIN_CLK2;

  // LATCH1 interrupt.
  attachInterrupt(0, ISR_latch, RISING);
  // CLK change interrupts.
  PCICR = _BV(PCIE1) | _BV(PCIE2);
  PCMSK1 = _BV(PCINT13);  // CLK1
  PCMSK2 = _BV(PCINT22);  // CLK2

  #ifdef DEBUG
  printf("\n");
  radio.printDetails();
  printf("\n");
  #endif
}
