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

#define PIN_LATCH _BV(2)  // Pin D2
#define PIN_CLOCK _BV(3)  // Pin D3
#define PIN_DATA _BV(3)  // Pin C3

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

LedState gLedState = YELLOW_BLINK_ON;
unsigned long gLastDataTime = 0;
unsigned long gNextLedBlinkTime = 0;

volatile uint16_t gRfData = 0xFFFF;

// \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ //

void ISR_latch() {
  // This ISR is attached at the highest possible priority.  Since the
  // NES data protocol is very timing sensitive, the whole thing runs inside
  // this handler.

  // Copy the RF button data into the console data.
  uint16_t data = gRfData;

  for (uint8_t i = 0; i < 12; i++) {
    // Console is reading data now.  Wait for clock to rise.
    while ( !(PIND & PIN_CLOCK) ) { }

    // Set data pin for this bit.
    if (data & 0x01) {
      PORTC |= PIN_DATA;
    } else {
      PORTC &= ~PIN_DATA;
    }
    // Shift in next LSB of data.
    data = data >> 1;

    // Wait for clock to drop.  (Console will read DATA when CLOCK drops.)
    while (PIND & PIN_CLOCK) { }
  }

  // Force pin high for the rest of the cycle.  These bits aren't used for
  // normal controllers.
  PORTC &= PIN_DATA;
}

// \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ //

void lightLed(int ledState) {
  unsigned long now = millis();
  boolean switchBlink = now > gNextLedBlinkTime;
  if (switchBlink) {
    gNextLedBlinkTime = now + BLINK_INTERVAL;
  }

  // Set both off.
  PORTC &= ~(_BV(1) | _BV(2));
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
    PORTC |= _BV(1);
    break;
  case YELLOW_BLINK_ON:
    if (switchBlink) gLedState = YELLOW_BLINK_OFF;
  case YELLOW_SOLID:
    PORTC |= _BV(2);
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

  if (gLastDataTime && (gLastDataTime + DATA_MIN_INTERVAL > now)) {
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

    // Fix the first 4 bits high, then use the rest of the received data.
    gRfData = 0xF000 | data;
    // TODO: Use battery/sleeping status bits?

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

  // The LED indicator is hooked up to pins PC1 and PC2.
  DDRC |= _BV(1) | _BV(2);
  // The DATA pin is PC3.
  DDRC |= PIN_DATA;

  // The CLOCK and LATCH signals should be pullup enabled inputs.
  DDRD &= ~(PIN_LATCH | PIN_CLOCK);
  PORTD |= PIN_LATCH | PIN_CLOCK;

  // DATA output is fully interrupt driven, from LATCH and CLOCK.
  attachInterrupt(0, ISR_latch, RISING);

  #ifdef DEBUG
  printf("\n");
  radio.printDetails();
  printf("\n");
  #endif
}
