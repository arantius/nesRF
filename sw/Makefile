all:

# Write fuses:
# Low: Internal 8MHz clock, 6/14 CK + 65 ms startup.
# High: SPI programming enable, preserve EEPROM, small disabled bootloader.
# Extended: 1.8v brownout
fuses8:
	avrdude -B 4 -p m328p -c usbasp -U lfuse:w:0xE2:m -U hfuse:w:0xD7:m -U efuse:w:0x06:m
# Low: External 16MHz crystal, 258/14 CK + 64 ms startup.
# Extended: 1.8v brownout
fuses16:
	avrdude -B 4 -p m328p -c usbasp -U lfuse:w:0xDE:m -U hfuse:w:0xD7:m -U efuse:w:0x04:m

# Program EEPROM data.
eeprom:
	avrdude -p m328p -c usbasp -U eeprom:w:eeprom.hex:i
# Program EEPROM data for second channel receiver.
eeprom2:
	avrdude -p m328p -c usbasp -U eeprom:w:eeprom2.hex:i
