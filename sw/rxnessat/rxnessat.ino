/*
nesRF Wireless Controller Retrofit: Receiver
Copyright 2014 Anthony Lieuallen

This code is responsible for what needs to happen in the receiver:
1) Read the state of all the buttons, via RF.
2) Transmit that to the console.
*/

// Define this to send debugging data out via Serial.
#define DEBUG

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
unsigned long gLastDataTime = 0;
volatile uint8_t gData = 0xFF;

// \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ //

#define lightLedOff() PORT_GRN &= ~PIN_GRN; PORT_YEL &= ~PIN_YEL;
#define lightLedGrn() PORT_YEL &= ~PIN_YEL; PORT_GRN |= PIN_GRN;
#define lightLedYel() PORT_GRN &= ~PIN_GRN; PORT_YEL |= PIN_YEL;

// \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ //

void ISR_latch1() {
  // This ISR is attached at the highest possible priority.  Since the
  // NES data protocol is very timing sensitive, the whole thing runs inside
  // this handler.

  // Copy the RF button data into the console data.
  uint8_t data = gData;

  for (uint8_t i = 0; i < 8; i++) {
    // Console is reading data now.  Wait for clock to rise.
    while (!(PINC & PIN_CLK1)) ;;

    // Set data pin for this bit.
    if (data & 0x01) {
      PORT_D0P1 |= PIN_D0P1;
    } else {
      PORT_D0P1 &= ~PIN_D0P1;
    }
    // Shift in next LSB of data.
    data = data >> 1;

    // Wait for clock to drop.  The NES sends a low-going clock pulse only
    // about a half a microsecond wide.  Limit how long to wait for it, as
    // otherwise we rarely miss it, and end up blocking forever for a clock
    // pulse that doesn't come.  But, unroll the loop so that we don't spend so
    // much time processing the loop itself that we regularly miss the clock.
    for (uint8_t j = 0; j < 48; j++) {
      if (!(PINC & PIN_CLK1)) break;
      if (!(PINC & PIN_CLK1)) break;
      if (!(PINC & PIN_CLK1)) break;
      if (!(PINC & PIN_CLK1)) break;
    }
  }

  // Force data high until the next cycle.
  PORT_D0P1 |= PIN_D0P1;
}

// \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ //

void loop(void) {
  unsigned long now = millis();

  if (gLastDataTime && (gLastDataTime + DATA_MIN_INTERVAL > now)) {
    lightLedGrn();
  } else {
    lightLedYel();
  }

  // TODO: Set appropriate masks and just read RF_IRQ pin to see pending data?
  uint16_t data_raw=0;
  while (radio.available()) {
    radio.read(&data_raw, sizeof(data_raw));
  }

  if (data_raw) {
    // TODO: Read multiple controllers.
    // TODO: Use battery/sleeping status bits?

    // Translate RF data to NES data.
    uint8_t data_nes = 0x00;
    data_nes = data_nes << 1; if (data_raw & _BV(7)) data_nes |= 1; // Right
    data_nes = data_nes << 1; if (data_raw & _BV(6)) data_nes |= 1; // Left
    data_nes = data_nes << 1; if (data_raw & _BV(5)) data_nes |= 1; // Down
    data_nes = data_nes << 1; if (data_raw & _BV(4)) data_nes |= 1; // Up
    data_nes = data_nes << 1; if (data_raw & _BV(3)) data_nes |= 1; // Start
    data_nes = data_nes << 1; if (data_raw & _BV(2)) data_nes |= 1; // Select
    data_nes = data_nes << 1; if (data_raw & _BV(0)) data_nes |= 1; // B
    data_nes = data_nes << 1; if (data_raw & _BV(8)) data_nes |= 1; // A
    #ifdef DEBUG
    printf("RX got %04x; Translt. %02x\n", data_raw, data_nes);
    #endif

    gData = data_nes;
    gLastDataTime = now;
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

  // Prime the data pin high (not asserting ground).
  PORT_D0P1 |= PIN_D0P1;
  // DATA output is fully interrupt driven, from LATCH.
  attachInterrupt(0, ISR_latch1, RISING);
  // TODO: Handle players 2 through 4.

  #ifdef DEBUG
  printf("\n");
  radio.printDetails();
  printf("\n");
  #endif
}
