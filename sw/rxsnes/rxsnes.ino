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
#define PIN_DATA _BV(2)  // Pin C2

#define PORT_GRN PORTC
#define PIN_GRN _BV(1)
#define PORT_YEL PORTC
#define PIN_YEL _BV(0)

// \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ //

RF24 radio(10, 9);  // CE, CS pins

unsigned long gLastDataTime = 0;
uint16_t gLatchData = 0xFFFF;
volatile uint16_t gRfData = 0xFFFF;
uint16_t gShiftBit = 0x0001;

// \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ //

#define lightLedOff() PORT_GRN &= ~PIN_GRN; PORT_YEL &= ~PIN_YEL;
#define lightLedGrn() PORT_YEL &= ~PIN_YEL; PORT_GRN |= PIN_GRN;
#define lightLedYel() PORT_GRN &= ~PIN_GRN; PORT_YEL |= PIN_YEL;

// \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ //

void ISR_latch() {
  gShiftBit = 0x0001;
  gLatchData = gRfData;
  ISR_clock();
}

void ISR_clock() {
  if ((gLatchData & gShiftBit) == 0) {
    PORTC &= ~PIN_DATA;
  } else {
    PORTC |= PIN_DATA;
  }
  gShiftBit <<= 1;
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
  if (radio.available()) {
    uint16_t data;
    radio.read(&data, sizeof(data));
    #ifdef DEBUG
    printf("RX got %04x\n", data);
    #endif

    // Fix the first 4 bits high, then use the rest of the received data.
    gRfData = 0xF000 | data;
    // TODO: Use battery/sleeping status bits?

    gLastDataTime = now;
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

  // Output mode: The LED indicator and DATA line, on port C.
  DDRC |= PIN_GRN | PIN_YEL | PIN_DATA;

  // The CLOCK and LATCH signals should be pullup enabled inputs.
  DDRD &= ~(PIN_LATCH | PIN_CLOCK);
  PORTD |= PIN_LATCH | PIN_CLOCK;

  attachInterrupt(0, ISR_latch, RISING);
  attachInterrupt(1, ISR_clock, RISING);

  #ifdef DEBUG
  printf("\n");
  radio.printDetails();
  printf("\n");
  #endif
}
