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

// Define this to send debugging data out via Serial.
//#define DEBUG

// Addresses of data stored in EEPROM.
#define EEPROM_RF_CHAN 0x00 /* One byte, the RF channel. */
#define EEPROM_RF_ADDR 0x01 /* Five bytes, the RF address. */
#define EEPROM_BAT_LOW 0x06 /* Two bytes, low battery threshold. */

// \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ //

#include <avr/sleep.h>
#include <avr/power.h>
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

volatile uint8_t pin_has_changed = 0;

ISR(TIMER1_COMPA_vect) { pin_has_changed = 2; }
SIGNAL(PCINT2_vect) { pin_has_changed = 1; }
SIGNAL(PCINT0_vect) { pin_has_changed = 1; }

// \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ //

void goToSleep() {
  // Go to sleep until an interrupt wakes us.
  set_sleep_mode(SLEEP_MODE_IDLE);
  sleep_mode();
  // Disable sleep until we're called again.
  sleep_disable();
}

// \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ //

void loop(void) {
  if (pin_has_changed) {
    pin_has_changed = 0;

    // DEV flash LED during transmit
    digitalWrite(16, HIGH);

    power_adc_enable();
    uint16_t batLvl = analogRead(0);
    power_adc_disable();

    uint16_t btnData = 0xffff;
    // DEV crappy set btnData.
    if (!digitalRead(8)) btnData &= ~_BV(8);  // a
    if (!digitalRead(7)) btnData &= ~_BV(0);  // b
    if (!digitalRead(6)) btnData &= ~_BV(7);  // r
    if (!digitalRead(5)) btnData &= ~_BV(4);  // u
    if (!digitalRead(4)) btnData &= ~_BV(5);  // d
    if (!digitalRead(3)) btnData &= ~_BV(6);  // l
    /*
    // DEV: read data from Serial, send that to console.
    #ifdef DEBUG
    if (Serial.available()) {
      char c = Serial.read();
      switch (c) {
        case 'b': btnData ^= _BV(0); break;
        case 'y': btnData ^= _BV(1); break;
        case 'e': btnData ^= _BV(2); break;  // sEelect
        case 't': btnData ^= _BV(3); break;  // sTart
        case 'u': btnData ^= _BV(4); break;
        case 'd': btnData ^= _BV(5); break;
        case 'l': btnData ^= _BV(6); break;
        case 'r': btnData ^= _BV(7); break;
        case 'a': btnData ^= _BV(8); break;
        case 'x': btnData ^= _BV(9); break;
      }
    }
    #endif
    */

    #ifdef DEBUG
    printf("BATT %04x; DATA %04x; ", batLvl, btnData);
    #endif

    //radio.setChannel(CHANNEL); // To reset PLOS_CNT
    uint8_t ok = radio.write(&btnData, sizeof(btnData));
    #ifdef DEBUG
    printf("%s!\n", ok ? "ok" : "fail");
    #endif

    // DEV flash LED during transmit
    digitalWrite(16, LOW);
  }

  // TODO: Count timer interrupts with no change, enter deep sleep.
  goToSleep();
}


void setup() {
  // DEV: Arduino digital pin 3, 4, 5-8 have inputs.
  // That's PD2-7 and PB0.
  // Make them pullup inputs.
  DDRD &= _BV(0) | _BV(1);
  PORTD |= ~_BV(0) & ~_BV(1);
  DDRB &= ~_BV(0);
  PORTB |= _BV(0);
  // And make them trigger PCINT.
  PCMSK2 = ~_BV(0) & ~_BV(1);
  PCMSK0 = _BV(0);

  #ifdef DEBUG
  Serial.begin(57600);
  printf_begin();
  printf("\n\n\nnesRF TX begin\n");
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
  radio.openWritingPipe(address);

  #ifdef DEBUG
  printf("\n");
  radio.printDetails();
  printf("\n");
  #endif

  analogReference(INTERNAL);

  // Set timer counter for ~667ms period.
  TCNT1 = 0;
  TCCR1A = 0;
  TCCR1B = _BV(WGM12) | _BV(CS12) | _BV(CS10);  // CTC mode, 1024 prescale.
  OCR1A = 5208;  // This counter value elapses every ~2/3rd of a second.
  TIMSK1 = _BV(OCIE1A);  // Enable timer compare interrupt.

  // PCINT enable.
  PCICR = _BV(2) | _BV(0);

  // Disable unused peripherals to save power.
  power_timer0_disable();
  power_timer2_disable();
  power_twi_disable();
  power_adc_disable();
  #ifndef DEBUG
  power_usart0_disable();
  #endif

  // DEV only LED indicator.
  pinMode(16, OUTPUT);
}
