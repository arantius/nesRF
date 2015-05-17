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

// Define one of CONS_NES or CONS_SNES to indicate which transmitter we are.
#define CONS_NES

// Addresses of data stored in EEPROM.
#define EEPROM_RF_CHAN 0x00 /* One byte, the RF channel. */
#define EEPROM_RF_ADDR 0x01 /* Five bytes, the RF address. */
#define EEPROM_BAT_LOW 0x06 /* Two bytes, low battery threshold. */

#define EVENT_PIN_CHANGE 1
#define EVENT_TIMER 2

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

#if defined(CONS_NES)
  RF24 radio(10, 8);  // CE, CS pins
#elif defined(CONS_SNES)
  RF24 radio(10, 9);  // CE, CS pins
#endif

#if defined(CONS_NES)
#define DDR_LED DDRC
#define PORT_LED PORTC
#define PIN_LED_GRN _BV(0)
#define PIN_LED_YEL _BV(1)
#elif defined(CONS_SNES)
#define DDR_LED DDRD
#define PORT_LED PORTD
#define PIN_LED_GRN _BV(6)
#define PIN_LED_YEL _BV(7)
#endif

// \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ //

volatile uint8_t event = 0;
uint16_t bat_low_thresh = 0;
uint8_t led_status = 0;

ISR(TIMER1_COMPA_vect) { event = EVENT_TIMER; }
SIGNAL(PCINT2_vect) { event = EVENT_PIN_CHANGE; }
SIGNAL(PCINT1_vect) { event = EVENT_PIN_CHANGE; }
SIGNAL(PCINT0_vect) { event = EVENT_PIN_CHANGE; }

// \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ //

void goToSleep() {
  // Go to sleep until an interrupt wakes us.
  set_sleep_mode(SLEEP_MODE_IDLE);
  sleep_mode();
  // Disable sleep until we're called again.
  sleep_disable();
}

inline void lightLedGreen() {
  PORT_LED |= PIN_LED_GRN;
  PORT_LED &= ~PIN_LED_YEL;
}

inline void lightLedOff() {
  PORT_LED &= ~PIN_LED_GRN;
  PORT_LED &= ~PIN_LED_YEL;
}

inline void lightLedYellow() {
  PORT_LED &= ~PIN_LED_GRN;
  PORT_LED |= PIN_LED_YEL;
}

// \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ // \\ //

void loop(void) {
  if (event == EVENT_TIMER) {
    // Blink LED with timer event.
    led_status = !led_status;
  }

  if (event) {
    event = 0;

    power_adc_enable();
    uint16_t batLvl = analogRead(7);
    power_adc_disable();

    // Read the state of all input pins into btnData.
    uint16_t btnData = 0xffff;
    #if defined(CONS_NES)
      if ((PINC & _BV(2)) == 0) btnData &= ~_BV(0x00);  // b
      if ((PINC & _BV(3)) == 0) btnData &= ~_BV(0x02);  // select
      if ((PINC & _BV(4)) == 0) btnData &= ~_BV(0x03);  // start
      if ((PINC & _BV(5)) == 0) btnData &= ~_BV(0x07);  // right
      if ((PIND & _BV(2)) == 0) btnData &= ~_BV(0x06);  // left
      if ((PIND & _BV(3)) == 0) btnData &= ~_BV(0x05);  // down
      if ((PIND & _BV(4)) == 0) btnData &= ~_BV(0x04);  // up
      if ((PIND & _BV(5)) == 0) btnData &= ~_BV(0x08);  // a
    #elif defined(CONS_SNES)
      if ((PINB & _BV(0)) == 0) btnData &= ~_BV(0x01);  // y
      if ((PINB & _BV(6)) == 0) btnData &= ~_BV(0x09);  // x
      if ((PINB & _BV(7)) == 0) btnData &= ~_BV(0x0B);  // rt
      if ((PINC & _BV(0)) == 0) btnData &= ~_BV(0x03);  // start
      if ((PINC & _BV(1)) == 0) btnData &= ~_BV(0x02);  // select
      if ((PINC & _BV(2)) == 0) btnData &= ~_BV(0x07);  // right
      if ((PINC & _BV(3)) == 0) btnData &= ~_BV(0x04);  // up
      if ((PINC & _BV(4)) == 0) btnData &= ~_BV(0x0a);  // lt
      if ((PINC & _BV(5)) == 0) btnData &= ~_BV(0x06);  // left
      if ((PIND & _BV(0)) == 0) btnData &= ~_BV(0x05);  // down
      if ((PIND & _BV(3)) == 0) btnData &= ~_BV(0x00);  // b
      if ((PIND & _BV(4)) == 0) btnData &= ~_BV(0x08);  // a
    #endif

    #ifdef DEBUG
    printf("BATT %04x; DATA %04x; ", batLvl, btnData);
    #endif

    //radio.setChannel(CHANNEL); // To reset PLOS_CNT
    uint8_t ok = radio.write(&btnData, sizeof(btnData));
    #ifdef DEBUG
    printf("%s!\n", ok ? "ok" : "fail");
    #endif

    if (batLvl == 0) {
      // Running from external power.
      if (PIND & _BV(5)) {
        // Not charging: solid green.
        lightLedGreen();
      } else {
        // Charging: solid yellow.
        lightLedYellow();
      }
    } else if (batLvl < bat_low_thresh) {
      // Battery low: Solid yellow status.
      lightLedYellow();
    } else if (led_status) {
      // Battery ok: Flash green/yellow with good/bad link.
      ok ? lightLedGreen() : lightLedYellow();
    } else {
      // Shouldn't happen, but otherwise light off.
      lightLedOff();
    }
  }

  // TODO: Count timer interrupts with no change, enter deep sleep.
  goToSleep();
}


void setup() {
#if defined(CONS_NES)
  // The hardware has buttons on:
  //  PC2 B
  //  PC3 Select
  //  PC4 Start
  //  PC5 Right
  //  PD2 Left
  //  PD3 Down
  //  PD4 Up
  //  PD5 A
  // Also there's:
  //  PD5 CHRG_STAT
  // Make those pullup-enabled inputs.  But: there are other functions on
  // other pins of those ports, so ONLY these pins!
  DDRC &= ~(_BV(2) | _BV(3) | _BV(4) | _BV(5));
  PORTC |= _BV(2) | _BV(3) | _BV(4) | _BV(5);
  DDRD &= ~(_BV(2) | _BV(3) | _BV(4) | _BV(5));
  PORTD |= _BV(2) | _BV(3) | _BV(4) | _BV(5);
  // Also, make only these pins trigger PCINT.
  PCICR = _BV(1) | _BV(2);
  PCMSK1 = _BV(2) | _BV(3) | _BV(4) | _BV(5);
  PCMSK2 = _BV(2) | _BV(3) | _BV(4) | _BV(5);
#elif defined(CONS_SNES)
  // The hardware has buttons on:
  //  PB0 Y
  //  PB6 X
  //  PB7 Right trigger
  //  PC0 Start
  //  PC1 Select
  //  PC2 Right
  //  PC3 Up
  //  PC4 Left trigger
  //  PC5 Left
  //  PD0 Down
  //  PD3 B
  //  PD4 A
  // Also there's:
  //  PD5 CHRG_STAT
  // Make those pullup-enabled inputs.  But: there are other functions on
  // other pins of those ports, so ONLY these pins!
  DDRB &= ~(_BV(0) | _BV(6) | _BV(7));
  PORTB |= _BV(0) | _BV(6) | _BV(7);
  DDRC &= ~(_BV(0) | _BV(1) | _BV(2) | _BV(3) | _BV(4) | _BV(5));
  PORTC |= _BV(0) | _BV(1) | _BV(2) | _BV(3) | _BV(4) | _BV(5);
  DDRD &= ~(_BV(0) | _BV(3) | _BV(4) | _BV(5));
  PORTD |= _BV(0) | _BV(3) | _BV(4);
  // Also, make only these pins trigger PCINT.
  PCICR = _BV(0) | _BV(1) | _BV(2);
  PCMSK0 = _BV(0) | _BV(6) | _BV(7);
  PCMSK1 = _BV(0) | _BV(1) | _BV(2) | _BV(3) | _BV(4) | _BV(5);
  PCMSK2 = _BV(0) | _BV(3) | _BV(4);
  #ifdef DEBUG
  // If debug is enabled, ignore PD0/PD1 which is serial RX/TX.
  PCMSK2 = _BV(3) | _BV(4);
  #endif
#endif


  // Make the LED pins outputs.
  DDR_LED |= PIN_LED_GRN | PIN_LED_YEL;

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
  radio.setPALevel(RF24_PA_MAX);
  radio.setPayloadSize(sizeof(uint16_t));
  radio.setRetries(7, 10);  // delay, retries

  byte address[5] = {};
  for (int i = 0; i < 5; i++) {
    address[i] = EEPROM.read(EEPROM_RF_ADDR + i);
  }

  // Change address (player number) depending on button,
  // held at power on time.
#if defined(CONS_NES)
  if ((PINC & _BV(2)) == 0) {  // b
    address[0] += 2;
  }
  if ((PIND & _BV(5)) == 0) {  // a
    address[0] += 1;
  }
#elif defined(CONS_SNES)
  if ((PINB & _BV(0)) == 0) {  // y
    address[0] += 4;
  } else if ((PINB & _BV(6)) == 0) {  // x
    address[0] += 3;
  } else if ((PIND & _BV(3)) == 0) {  // b
    address[0] += 2;
  } else if ((PIND & _BV(4)) == 0) {  // a
    address[0] += 1;
  }
#endif

  radio.stopListening();
  radio.openWritingPipe(address);

  #ifdef DEBUG
  printf("\n");
  radio.printDetails();
  printf("\n");
  #endif

  analogReference(INTERNAL);
  bat_low_thresh = (EEPROM.read(EEPROM_BAT_LOW) << 8)
      + EEPROM.read(EEPROM_BAT_LOW + 1);

  // Set timer counter for ~667ms period.
  TCNT1 = 0;
  TCCR1A = 0;
  TCCR1B = _BV(WGM12) | _BV(CS12) | _BV(CS10);  // CTC mode, 1024 prescale.
  OCR1A = 5208;  // This counter value elapses every ~2/3rd of a second.
  TIMSK1 = _BV(OCIE1A);  // Enable timer compare interrupt.

  // Disable unused peripherals to save power.
  power_timer0_disable();
  power_timer2_disable();
  power_twi_disable();
  power_adc_disable();
  #ifndef DEBUG
  power_usart0_disable();
  #endif
}
