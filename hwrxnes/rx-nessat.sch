EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:special
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:nesrf
LIBS:rx-cache
EELAYER 25 0
EELAYER END
$Descr User 8000 6500
encoding utf-8
Sheet 1 1
Title "nesRF Receiver (NES, Satellite)"
Date "Saturday, February 21, 2015"
Rev "v0"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L C C3
U 1 1 54890E48
P 1650 2000
F 0 "C3" H 1650 2100 40  0000 L CNN
F 1 "0.1u" H 1656 1915 40  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 1688 1850 30  0001 C CNN
F 3 "" H 1650 2000 60  0000 C CNN
	1    1650 2000
	1    0    0    -1  
$EndComp
$Comp
L CONN_02X04 P4
U 1 1 54890EED
P 5250 950
F 0 "P4" H 5250 1200 50  0000 C CNN
F 1 "nRF" H 5250 700 50  0000 C CNN
F 2 "nesRF:nRF_Header_2x04" H 5250 -250 60  0001 C CNN
F 3 "" H 5250 -250 60  0000 C CNN
	1    5250 950 
	1    0    0    -1  
$EndComp
Text Label 3900 1900 0    60   ~ 0
RF_IRQ
Text Label 5000 800  2    60   ~ 0
RF_IRQ
$Comp
L CONN_02X03 P3
U 1 1 5489134F
P 6600 950
F 0 "P3" H 6600 1150 50  0000 C CNN
F 1 "ISP" H 6600 750 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_2x03" H 6600 -250 60  0001 C CNN
F 3 "" H 6600 -250 60  0000 C CNN
	1    6600 950 
	1    0    0    -1  
$EndComp
Text Label 3900 3250 0    60   ~ 0
~RST
$Comp
L R R1
U 1 1 54891382
P 1750 1550
F 0 "R1" V 1830 1550 40  0000 C CNN
F 1 "10k" V 1757 1551 40  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 1680 1550 30  0001 C CNN
F 3 "" H 1750 1550 30  0000 C CNN
	1    1750 1550
	1    0    0    -1  
$EndComp
Text Label 1750 1300 0    60   ~ 0
~RST
Text Label 3900 2000 0    60   ~ 0
RF_CE
Text Label 3900 2650 0    60   ~ 0
RF_CSN
Text Label 3900 2100 0    60   ~ 0
MOSI
Text Label 3900 2200 0    60   ~ 0
MISO
Text Label 3900 2300 0    60   ~ 0
SCK
Text Label 5000 900  2    60   ~ 0
MOSI
$Comp
L R R2
U 1 1 54891606
P 4700 1100
F 0 "R2" V 4780 1100 40  0000 C CNN
F 1 "10k" V 4707 1101 40  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 4630 1100 30  0001 C CNN
F 3 "" H 4700 1100 30  0000 C CNN
	1    4700 1100
	0    1    1    0   
$EndComp
Text Label 4350 1000 2    60   ~ 0
RF_CSN
$Comp
L TCR2EF U1
U 1 1 548916E3
P 1850 850
F 0 "U1" H 1850 850 60  0000 C CNN
F 1 "TCR2EF" V 1650 850 60  0000 C CNN
F 2 "nesRF:SOT23-5" H 1850 850 60  0001 C CNN
F 3 "" H 1850 850 60  0000 C CNN
	1    1850 850 
	0    1    1    0   
$EndComp
Text Label 5500 800  0    60   ~ 0
MISO
Text Label 5500 900  0    60   ~ 0
SCK
Text Label 5500 1000 0    60   ~ 0
RF_CE
Text Label 6850 950  0    60   ~ 0
MOSI
Text Label 6350 1050 2    60   ~ 0
~RST
Text Label 6350 950  2    60   ~ 0
SCK
Text Label 6350 850  2    60   ~ 0
MISO
$Comp
L C C1
U 1 1 54891DF6
P 1100 900
F 0 "C1" H 1100 1000 40  0000 L CNN
F 1 "0.1u" H 1106 815 40  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 1138 750 30  0001 C CNN
F 3 "" H 1100 900 60  0000 C CNN
	1    1100 900 
	0    1    1    0   
$EndComp
$Comp
L BI_LED D1
U 1 1 548A6224
P 6350 3650
F 0 "D1" H 6650 3750 50  0000 C CNN
F 1 "BI_LED" H 6700 3550 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03" H 6350 3650 60  0001 C CNN
F 3 "" H 6350 3650 60  0000 C CNN
	1    6350 3650
	1    0    0    -1  
$EndComp
Text Label 3900 1800 0    60   ~ 0
Green
Text Label 3900 4100 0    60   ~ 0
Yellow
$Comp
L R R3
U 1 1 548A749B
P 7150 3900
F 0 "R3" V 7230 3900 40  0000 C CNN
F 1 "180" V 7157 3901 40  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 7080 3900 30  0001 C CNN
F 3 "" H 7150 3900 30  0000 C CNN
	1    7150 3900
	1    0    0    -1  
$EndComp
Text Label 6700 3650 0    60   ~ 0
LEDCommon
NoConn ~ 2000 3250
NoConn ~ 2000 3150
NoConn ~ 2000 2400
$Comp
L C C4
U 1 1 548DB3A2
P 1850 2700
F 0 "C4" H 1850 2800 40  0000 L CNN
F 1 "0.1u" H 1856 2615 40  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 1888 2550 30  0001 C CNN
F 3 "" H 1850 2700 60  0000 C CNN
	1    1850 2700
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR01
U 1 1 548DC139
P 1300 1050
F 0 "#PWR01" H 1300 1050 30  0001 C CNN
F 1 "GND" H 1300 980 30  0001 C CNN
F 2 "" H 1300 1050 60  0000 C CNN
F 3 "" H 1300 1050 60  0000 C CNN
	1    1300 1050
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR02
U 1 1 548DCA3D
P 6900 1100
F 0 "#PWR02" H 6900 1100 30  0001 C CNN
F 1 "GND" H 6900 1030 30  0001 C CNN
F 2 "" H 6900 1100 60  0000 C CNN
F 3 "" H 6900 1100 60  0000 C CNN
	1    6900 1100
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR03
U 1 1 548DCABC
P 5550 1150
F 0 "#PWR03" H 5550 1150 30  0001 C CNN
F 1 "GND" H 5550 1080 30  0001 C CNN
F 2 "" H 5550 1150 60  0000 C CNN
F 3 "" H 5550 1150 60  0000 C CNN
	1    5550 1150
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR04
U 1 1 548DCCB3
P 7150 4200
F 0 "#PWR04" H 7150 4200 30  0001 C CNN
F 1 "GND" H 7150 4130 30  0001 C CNN
F 2 "" H 7150 4200 60  0000 C CNN
F 3 "" H 7150 4200 60  0000 C CNN
	1    7150 4200
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR05
U 1 1 548DD9EA
P 6900 800
F 0 "#PWR05" H 6900 890 20  0001 C CNN
F 1 "+5V" H 6900 890 30  0000 C CNN
F 2 "" H 6900 800 60  0000 C CNN
F 3 "" H 6900 800 60  0000 C CNN
	1    6900 800 
	1    0    0    -1  
$EndComp
$Comp
L C C2
U 1 1 548DEAAE
P 1550 1550
F 0 "C2" H 1550 1650 40  0000 L CNN
F 1 "0.1u" H 1556 1465 40  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 1588 1400 30  0001 C CNN
F 3 "" H 1550 1550 60  0000 C CNN
	1    1550 1550
	-1   0    0    -1  
$EndComp
$Comp
L C C5
U 1 1 548FB6E3
P 2700 950
F 0 "C5" H 2700 1050 40  0000 L CNN
F 1 "1u" H 2706 865 40  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 2738 800 30  0001 C CNN
F 3 "" H 2700 950 60  0000 C CNN
	1    2700 950 
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR06
U 1 1 548FBB31
P 2700 1250
F 0 "#PWR06" H 2700 1250 30  0001 C CNN
F 1 "GND" H 2700 1180 30  0001 C CNN
F 2 "" H 2700 1250 60  0000 C CNN
F 3 "" H 2700 1250 60  0000 C CNN
	1    2700 1250
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X01 P5
U 1 1 5495E84E
P 4700 3400
F 0 "P5" H 4700 3500 50  0000 C CNN
F 1 "RX" V 4800 3400 50  0000 C CNN
F 2 "nesRF:Small_1x_Pad" H 4700 3400 60  0001 C CNN
F 3 "" H 4700 3400 60  0000 C CNN
	1    4700 3400
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X01 P6
U 1 1 5495E867
P 5100 3500
F 0 "P6" H 5100 3600 50  0000 C CNN
F 1 "TX" V 5200 3500 50  0000 C CNN
F 2 "nesRF:Small_1x_Pad" H 5100 3500 60  0001 C CNN
F 3 "" H 5100 3500 60  0000 C CNN
	1    5100 3500
	1    0    0    -1  
$EndComp
Text Label 3900 3400 0    60   ~ 0
SER_RX
Text Label 3900 3500 0    60   ~ 0
SER_TX
Wire Wire Line
	6900 850  6900 800 
Wire Wire Line
	6850 850  6900 850 
Wire Wire Line
	5550 1100 5550 1150
Wire Wire Line
	5500 1100 5550 1100
Wire Wire Line
	6900 1050 6900 1100
Wire Wire Line
	6850 1050 6900 1050
Connection ~ 1300 900 
Wire Wire Line
	1300 850  1400 850 
Connection ~ 1250 1250
Wire Wire Line
	1250 1250 1250 1800
Wire Wire Line
	900  1250 1400 1250
Wire Wire Line
	1400 1250 1400 950 
Wire Wire Line
	1300 850  1300 1050
Connection ~ 1850 4000
Wire Wire Line
	1850 2900 1850 4000
Connection ~ 1850 1800
Wire Wire Line
	1850 1800 1850 2500
Wire Wire Line
	2000 1800 2000 2100
Wire Wire Line
	2000 3900 2000 4100
Wire Wire Line
	6700 3650 7150 3650
Connection ~ 2000 1900
Connection ~ 2000 4000
Connection ~ 900  900 
Wire Wire Line
	900  750  900  1250
Wire Wire Line
	5000 1100 5000 1350
Wire Wire Line
	900  750  1400 750 
Connection ~ 4450 1000
Wire Wire Line
	4450 1100 4450 1000
Wire Wire Line
	4350 1000 5000 1000
Wire Wire Line
	5000 1100 4950 1100
Connection ~ 1750 1800
Connection ~ 1650 1800
Wire Wire Line
	1650 2200 1650 4050
Wire Wire Line
	1650 4000 2000 4000
Wire Wire Line
	1250 1800 2000 1800
Wire Wire Line
	2300 750  3200 750 
Wire Wire Line
	2700 1150 2700 1250
Wire Wire Line
	3900 3500 4900 3500
Wire Wire Line
	3900 3400 4500 3400
Connection ~ 1250 1800
Connection ~ 2700 750 
Wire Wire Line
	5000 1350 3200 1350
Wire Wire Line
	3200 1350 3200 750 
Wire Wire Line
	1550 1300 1750 1300
Connection ~ 1550 1800
Wire Wire Line
	1550 1350 1550 1300
Wire Wire Line
	1550 1750 1550 1800
Text Label 2700 750  0    60   ~ 0
2.5v
Wire Wire Line
	7150 4150 7150 4200
$Comp
L CONN_01X05 P1
U 1 1 54E8B2D5
P 7000 1700
F 0 "P1" H 7000 2000 50  0000 C CNN
F 1 "PORT1" V 7100 1700 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x05" H 7000 1700 60  0001 C CNN
F 3 "" H 7000 1700 60  0000 C CNN
	1    7000 1700
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X07 P2
U 1 1 54E8B39D
P 7000 2750
F 0 "P2" H 7000 3150 50  0000 C CNN
F 1 "PORT2" V 7100 2750 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x07" H 7000 2750 60  0001 C CNN
F 3 "" H 7000 2750 60  0000 C CNN
	1    7000 2750
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR07
U 1 1 54E8B9C9
P 1650 4050
F 0 "#PWR07" H 1650 4050 30  0001 C CNN
F 1 "GND" H 1650 3980 30  0001 C CNN
F 2 "" H 1650 4050 60  0000 C CNN
F 3 "" H 1650 4050 60  0000 C CNN
	1    1650 4050
	1    0    0    -1  
$EndComp
Connection ~ 1650 4000
$Comp
L +5V #PWR08
U 1 1 54E8BB23
P 1250 1800
F 0 "#PWR08" H 1250 1890 20  0001 C CNN
F 1 "+5V" H 1250 1890 30  0000 C CNN
F 2 "" H 1250 1800 60  0000 C CNN
F 3 "" H 1250 1800 60  0000 C CNN
	1    1250 1800
	-1   0    0    1   
$EndComp
Wire Wire Line
	6250 1500 6800 1500
Wire Wire Line
	6250 2450 6800 2450
Text Label 6800 1600 2    60   ~ 0
CLK1
Text Label 6800 2550 2    60   ~ 0
CLK2
Text Label 6800 1700 2    60   ~ 0
LATCH1
Text Label 6800 2650 2    60   ~ 0
LATCH2
Text Label 6800 1800 2    60   ~ 0
D0_1
Text Label 6800 2750 2    60   ~ 0
D0_2
Wire Wire Line
	6800 2850 6400 2850
Wire Wire Line
	6400 2800 6400 3200
Wire Wire Line
	6800 1900 6400 1900
$Comp
L +5V #PWR09
U 1 1 54E8BF2D
P 6400 2800
F 0 "#PWR09" H 6400 2890 20  0001 C CNN
F 1 "+5V" H 6400 2890 30  0000 C CNN
F 2 "" H 6400 2800 60  0000 C CNN
F 3 "" H 6400 2800 60  0000 C CNN
	1    6400 2800
	1    0    0    -1  
$EndComp
Text Label 3900 3600 0    60   ~ 0
LATCH1
Text Label 3900 3700 0    60   ~ 0
LATCH2
$Comp
L ATMEGA328-A IC1
U 1 1 548921E2
P 2900 2900
F 0 "IC1" H 2150 4150 40  0000 L BNN
F 1 "ATMEGA328-A" H 3300 1500 40  0000 L BNN
F 2 "nesRF:TQFP-32" H 2900 2900 30  0000 C CIN
F 3 "" H 2900 2900 60  0000 C CNN
	1    2900 2900
	1    0    0    -1  
$EndComp
Text Label 3900 3150 0    60   ~ 0
CLK1
Text Label 3900 4000 0    60   ~ 0
CLK2
Text Label 3900 3050 0    60   ~ 0
D0_1
Text Label 3900 3900 0    60   ~ 0
D0_2
$Comp
L CRYSTAL X1
U 1 1 54E8C18F
P 5000 2200
F 0 "X1" H 5000 2350 60  0000 C CNN
F 1 "CRYSTAL" H 5000 2050 60  0000 C CNN
F 2 "nesRF:TSX-3225" H 5000 2200 60  0001 C CNN
F 3 "" H 5000 2200 60  0000 C CNN
	1    5000 2200
	0    1    1    0   
$EndComp
$Comp
L C C6
U 1 1 54E8C1E0
P 5200 1900
F 0 "C6" H 5200 2000 40  0000 L CNN
F 1 "22p" H 5206 1815 40  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 5238 1750 30  0001 C CNN
F 3 "" H 5200 1900 60  0000 C CNN
	1    5200 1900
	0    1    1    0   
$EndComp
$Comp
L C C7
U 1 1 54E8C207
P 5200 2500
F 0 "C7" H 5200 2600 40  0000 L CNN
F 1 "22p" H 5206 2415 40  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 5238 2350 30  0001 C CNN
F 3 "" H 5200 2500 60  0000 C CNN
	1    5200 2500
	0    1    1    0   
$EndComp
Wire Wire Line
	5400 2500 5400 1900
Wire Wire Line
	5400 1900 5650 1900
Wire Wire Line
	5650 1900 5650 2000
$Comp
L GND #PWR010
U 1 1 54E8C331
P 5650 2000
F 0 "#PWR010" H 5650 2000 30  0001 C CNN
F 1 "GND" H 5650 1930 30  0001 C CNN
F 2 "" H 5650 2000 60  0000 C CNN
F 3 "" H 5650 2000 60  0000 C CNN
	1    5650 2000
	1    0    0    -1  
$EndComp
Wire Wire Line
	3900 2500 5000 2500
Wire Wire Line
	3900 2400 4700 2400
Wire Wire Line
	4700 2400 4700 1900
Wire Wire Line
	4700 1900 5000 1900
NoConn ~ 3900 2950
$Comp
L PWR_FLAG #FLG011
U 1 1 54E8CA6F
P 6400 2850
F 0 "#FLG011" H 6400 2945 30  0001 C CNN
F 1 "PWR_FLAG" H 6400 3030 30  0000 C CNN
F 2 "" H 6400 2850 60  0000 C CNN
F 3 "" H 6400 2850 60  0000 C CNN
	1    6400 2850
	0    -1   -1   0   
$EndComp
Text Label 4250 2400 0    60   ~ 0
XTAL1
Text Label 4250 2500 0    60   ~ 0
XTAL2
NoConn ~ 3900 3800
Wire Wire Line
	6250 1500 6250 2500
Connection ~ 6250 2450
$Comp
L GND #PWR012
U 1 1 54E8D014
P 6250 2500
F 0 "#PWR012" H 6250 2500 30  0001 C CNN
F 1 "GND" H 6250 2430 30  0001 C CNN
F 2 "" H 6250 2500 60  0000 C CNN
F 3 "" H 6250 2500 60  0000 C CNN
	1    6250 2500
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG013
U 1 1 54E8D03C
P 6250 2450
F 0 "#FLG013" H 6250 2545 30  0001 C CNN
F 1 "PWR_FLAG" H 6250 2630 30  0000 C CNN
F 2 "" H 6250 2450 60  0000 C CNN
F 3 "" H 6250 2450 60  0000 C CNN
	1    6250 2450
	0    -1   -1   0   
$EndComp
Wire Wire Line
	6400 2100 7300 2100
Wire Wire Line
	7300 2100 7300 3200
Wire Wire Line
	7300 3200 6400 3200
Connection ~ 6400 2850
Wire Wire Line
	6400 1900 6400 2100
Text Label 6050 3550 2    60   ~ 0
Green
Text Label 6050 3750 2    60   ~ 0
Yellow
Text Label 6800 2950 2    60   ~ 0
D3_2
Text Label 6800 3050 2    60   ~ 0
D4_2
Text Label 3900 2750 0    60   ~ 0
D3_2
Text Label 3900 2850 0    60   ~ 0
D4_2
$EndSCHEMATC
