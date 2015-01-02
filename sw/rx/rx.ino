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
volatile uint16_t gData;

LedState gLedState = YELLOW_BLINK_ON;
unsigned long gLastDataTime = 0;
unsigned long gNextLedBlinkTime = 0;

// \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ //

void latch() {
  // This interrupt handler fires on the falling edge of LATCH.  Immediately
  // present the first bit on DATA out, then the next on each falling edge of
  // CLOCK.  A DATA high means NOT pressed, this is the format we expect
  // from the RF data.
  // The timing is critical, with only microseconds to react, so it all goes
  // right here inside the interrupt handler.
  uint16_t data = gData;

  #if defined(CONS_SNES)
    for (uint8_t i = 0; i < 12; i++) {
      // Set DATA output pin to LSB of data.
      if (data && 0x0001) {
        PORTD |= _BV(4);
      } else {
        PORTD = ~_BV(4);
      }
      // Shift next bit of data into place.
      data = data >> 1;
      // Wait for CLOCK to drop.
      while (PORTD && _BV(3)) ;;
    }

    // Data should stay high for the next four clock cycles.
    PORTD |= _BV(4);
    for (uint8_t i = 0; i < 4; i++) {
      // Wait for CLOCK to drop.
      while (PORTD && _BV(3)) ;;
    }
  #elif defined(CONS_NES)
    #error NES support incomplete.
  #else
    #error Bad CONS_XXX defined.
  #endif

  // All done, drive DATA low.
  PORTD &= 0xEF;
}


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

  if (radio.available()) {
    lightLed(OFF);
    // Read data from the radio.
    while (radio.available()) {
      radio.read(&data, sizeof(data));
    }
    #ifdef DEBUG
    printf("RX got %04x\n", data);
    #endif
    gLastDataTime = now;
    lightLed();

    // Export this data to where the LATCH interrupt handler can see it.
    ATOMIC_BLOCK(ATOMIC_RESTORESTATE) {
      gData = data;
    }
  }

  delay(1);
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

  // The LED indicator is hooked up to pins PC1 and PC2, make them outputs.
  DDRC |= 0x06;
  // The DATA output pin is PD4.
  DDRD |= 0x10;

  // The latch pin is hooked up to INT0.  We have 6us from its falling edge
  // to prepare serial data out.
  attachInterrupt(0, latch, FALLING);

  #ifdef DEBUG
  printf("\n");
  radio.printDetails();
  printf("\n");
  #endif
}
