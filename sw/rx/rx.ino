/*
nesRF Wireless Controller Retrofit: Receiver
Copyright 2014 Anthony Lieuallen

This code is responsible for what needs to happen in the receiver:
1) Read the state of all the buttons, via RF.
2) Transmit that to the console.
*/

// Define this to send debugging data out via Serial.
#define DEBUG

// Define exactly one of CONS_NES or CONS_SNES.  This controls exactly
// which wire protocol will be delivered to the attached console.
#define CONS_SNES

// Addresses of data stored in EEPROM.
#define EEPROM_RF_CHAN 0x00 /* One byte, the RF channel. */
#define EEPROM_RF_ADDR 0x01 /* Five bytes, the RF address. */

#define BLINK_INTERVAL 333

// \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ //

#include <EEPROM.h>
#include <SPI.h>
#include <util/atomic.h>

#include "nRF24L01.h"
#include "RF24.h"
#ifdef DEBUG
#include "printf.h"
#endif

// \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ //

enum LedState {
  OFF,
  GREEN_SOLID,
  GREEN_BLINK_ON,
  GREEN_BLINK_OFF,
  YELLOW_SOLID,
  YELLOW_BLINK_ON,
  YELLOW_BLINK_OFF
};

RF24 radio(10, 9);  // CE, CS pins

volatile uint8_t gLatched = 0;
volatile uint16_t gRfData = 0xFFFF;
volatile uint16_t gConsData = 0xFFFF;

LedState gLedState = YELLOW_BLINK_ON;
unsigned long gLastDataTime = 0;
unsigned long gNextLedBlinkTime = 0;

// \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ //

void ISR_latch() {
  gLatched = 1;

  // Copy the RF button data into the console data.
  gConsData = gRfData;

  // Immediately present the first bit of data (CLOCK is already high for
  // the first latched pulse).
  setDataLine();
}


void ISR_clock() {
  // On each rising edge of CLOCK, set the next data bit.
  setDataLine();
}


inline void setDataLine() {
  if (gConsData & 0x01) {
    PORTD |= _BV(4);
  } else {
    PORTD &= ~_BV(4);
  }
  gConsData = gConsData >> 1;
}

// \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ //

void lightLed(int ledState) {
  unsigned long now = millis();
  boolean switchBlink = now > gNextLedBlinkTime;
  if (switchBlink) {
    gNextLedBlinkTime = now + BLINK_INTERVAL;
  }

  // Set both off.
  PORTC &= 0xF9;
  // Then just the right one on.
  switch (ledState) {
  case GREEN_BLINK_OFF:
    if (switchBlink) gLedState = GREEN_BLINK_ON;
    break;
  case YELLOW_BLINK_OFF:
    if (switchBlink) gLedState = YELLOW_BLINK_ON;
    break;
  case GREEN_BLINK_ON:
    if (switchBlink) gLedState = GREEN_BLINK_OFF;
  case GREEN_SOLID:
    PORTC |= 0x04;
    break;
  case YELLOW_BLINK_ON:
    if (switchBlink) gLedState = YELLOW_BLINK_OFF;
  case YELLOW_SOLID:
    PORTC |= 0x02;
    break;
  }
}


void lightLed() {
  lightLed(gLedState);
}

// \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ //

void loop(void) {
  unsigned long now = millis();
  uint16_t data;

  if (gLastDataTime && (gLastDataTime + 1536 > now)) {
    gLedState = GREEN_SOLID;
  } else {
    gLedState = YELLOW_SOLID;
  }
  lightLed();

  // TODO: Set appropriate masks and just read RF_IRQ pin to see pending data?
  if (radio.available()) {
    lightLed(OFF);
    // Read data from the radio.
    while (radio.available()) {
      radio.read(&data, sizeof(data));
    }
    #ifdef DEBUG
    printf("RX got %04x\n", data);
    #endif

    #if defined(CONS_SNES)
      ATOMIC_BLOCK(ATOMIC_RESTORESTATE) {
        // Fix the first 4 bits high, then use the rest of the received data.
        gRfData = 0xF000 | data;
        // TODO: Use battery/sleeping status bits?
      }
    #elif defined(CONS_NES)
      // TODO: reorder, then assign, all the right bits.
      #error NES support incomplete.
    #else
      #error Bad CONS_XXX defined.
    #endif

    gLastDataTime = now;
    lightLed();
  }

  // DEV: read data from Serial, send that to console.
  #ifdef DEBUG
  if (Serial.available()) {
    char c = Serial.read();
    switch (c) {
      case 'b': gRfData ^= _BV(0); break;
      case 'y': gRfData ^= _BV(1); break;
      case 'e': gRfData ^= _BV(2); break;  // sEelect
      case 't': gRfData ^= _BV(3); break;  // sTart
      case 'u': gRfData ^= _BV(4); break;
      case 'd': gRfData ^= _BV(5); break;
      case 'l': gRfData ^= _BV(6); break;
      case 'r': gRfData ^= _BV(7); break;
      case 'a': gRfData ^= _BV(8); break;
      case 'x': gRfData ^= _BV(9); break;
    }
    printf("Data: %04x\n", gRfData);
  }
  #endif

  if (gLatched) {
    gLatched = 0;
    // DEV: Twiddle LED on latch.
    PORTD ^= _BV(6);
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
  radio.setPALevel(RF24_PA_LOW);
  radio.setPayloadSize(sizeof(uint16_t));
  radio.setRetries(5, 5);  // delay, retries

  byte address[5] = {};
  for (int i = 0; i < 5; i++) {
    address[i] = EEPROM.read(EEPROM_RF_ADDR + i);
  }
  radio.stopListening();
  radio.openReadingPipe(0, address);
  radio.startListening();

  // The LED indicator is hooked up to pins PC1 and PC2.
  DDRC |= _BV(1) | _BV(2);
  // The DATA pin is PD4.
  DDRD |= _BV(4);

  // The CLOCK and LATCH signals should be pullup enabled inputs.
  DDRD &= ~(_BV(2) | _BV(3));
  PORTD |= _BV(2) | _BV(3);

  // DATA output is fully interrupt driven, from LATCH and CLOCK.
  attachInterrupt(0, ISR_latch, RISING);
  attachInterrupt(1, ISR_clock, RISING);

  // DEV: LED indicator on PD6.
  DDRD |= _BV(6);

  #ifdef DEBUG
  printf("\n");
  radio.printDetails();
  printf("\n");
  #endif
}
