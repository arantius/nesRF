/*
nesRF Wireless Controller Retrofit
Transmitter

Copyright 2014 Anthony Lieuallen

This code is responsible for what needs to happen in the controller:
1) Read the state of all the buttons.
2) Transmit that to the receiver.
3) Monitor the battery level, so the user can be warned as it drops.
4) Indicate when there is an RF connection (OK) or problem (error).
*/

#define DEBUG

// Addresses of data stored in EEPROM.
#define EEPROM_RF_CHAN 0x00 /* One byte, the RF channel. */
#define EEPROM_RF_ADDR 0x01 /* Five bytes, the RF address. */
#define EEPROM_BAT_LOW 0x06 /* Two bytes, low battery threshold. */

// \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ //

#include <EEPROM.h>
#include <SPI.h>

#include "nRF24L01.h"
#include "RF24.h"
#ifdef DEBUG
#include "printf.h"
#endif

// \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ //

RF24 radio(10, 9);  // CE, CS pins

// \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ //

//volatile uint8_t pin_has_changed = 0;
//
//SIGNAL(PCINT1_vect) {
//  pin_has_changed = 1;
//}

// \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ //

void setup() {
  #ifdef DEBUG
  Serial.begin(57600);
  printf_begin();
  printf("\n\n\nnesRF TX begin\n");
  #endif

  analogReference(INTERNAL);

  radio.begin();
  radio.setAutoAck(1);
  radio.setCRCLength(RF24_CRC_16);
  radio.setChannel(EEPROM.read(EEPROM_RF_CHAN));
  radio.setDataRate(RF24_1MBPS);
  radio.setPALevel(RF24_PA_LOW);
  radio.setPayloadSize(sizeof(uint32_t));
  radio.setRetries(5, 5);  // delay, retries

  byte address[5] = {};
  for (int i = 0; i < 5; i++) {
    address[i] = EEPROM.read(EEPROM_RF_ADDR + i);
  }

  radio.stopListening();
  radio.openWritingPipe(address);

  pinMode(3, OUTPUT);
  pinMode(4, OUTPUT);

  #ifdef DEBUG
  printf("\n");
  radio.printDetails();
  printf("\n");
  #endif
}


void loop(void) {
  digitalWrite(3, HIGH);
  digitalWrite(4, LOW);

  uint32_t c = analogRead(0);
  #ifdef DEBUG
  printf("Sending %04x ... ", c);
  #endif

  //radio.setChannel(CHANNEL); // To reset PLOS_CNT
  uint8_t ok = radio.write(&c, sizeof(c));

  digitalWrite(3, LOW);
  digitalWrite(4, !ok);

  #ifdef DEBUG
  printf("%s!\n", ok ? "ok" : "fail");
  #endif

  delay(999);
}
