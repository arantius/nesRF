all:

# Write fuses:
# Low: Internal 8MHz clock, 6/14 CK + 4.1 ms startup.
# High: SPI programming enable, preserve EEPROM, small disabled bootloader.
fuses:
	avrdude -B 4 -p m328p -c usbasp -U lfuse:w:0xE2:m -U hfuse:w:0xD7:m -U efuse:w:0x06:m

# Program EEPROM data.
eeprom:
	avrdude -p m328p -c usbasp -U eeprom:w:eeprom.hex:i
