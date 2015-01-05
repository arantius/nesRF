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
Title "nesRF Receiver (SNES)"
Date "Sunday, January 04, 2015"
Rev "v2"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text Label 1050 2400 0    60   ~ 0
Clock
Text Label 1050 2750 0    60   ~ 0
Latch
Text Label 1050 3100 0    60   ~ 0
Data
$Comp
L C C1
U 1 1 54890E48
P 1650 2000
F 0 "C1" H 1650 2100 40  0000 L CNN
F 1 "0.1u" H 1656 1915 40  0000 L CNN
F 2 "SMD_Packages:SMD-0402_c" H 1688 1850 30  0001 C CNN
F 3 "" H 1650 2000 60  0000 C CNN
	1    1650 2000
	1    0    0    -1  
$EndComp
$Comp
L CONN_02X04 P6
U 1 1 54890EED
P 5250 950
F 0 "P6" H 5250 1200 50  0000 C CNN
F 1 "nRF" H 5250 700 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_2x04" H 5250 -250 60  0001 C CNN
F 3 "" H 5250 -250 60  0000 C CNN
	1    5250 950 
	1    0    0    -1  
$EndComp
Text Label 3900 2650 0    60   ~ 0
RF_IRQ
Text Label 5000 800  2    60   ~ 0
RF_IRQ
$Comp
L CONN_02X03 P7
U 1 1 5489134F
P 6600 950
F 0 "P7" H 6600 1150 50  0000 C CNN
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
F 2 "SMD_Packages:SMD-0402_r" V 1680 1550 30  0001 C CNN
F 3 "" H 1750 1550 30  0000 C CNN
	1    1750 1550
	1    0    0    -1  
$EndComp
Text Label 1750 1300 0    60   ~ 0
~RST
Text Label 3900 2000 0    60   ~ 0
RF_CE
Text Label 3900 1900 0    60   ~ 0
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
F 2 "SMD_Packages:SMD-0402_r" V 4630 1100 30  0001 C CNN
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
F 2 "SMD_Packages:SOT-23-5" H 1850 850 60  0001 C CNN
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
Text Label 3900 3600 0    60   ~ 0
Latch
Text Label 3900 3700 0    60   ~ 0
Clock
Text Label 3900 2950 0    60   ~ 0
Data
$Comp
L C C2
U 1 1 54891DF6
P 1100 900
F 0 "C2" H 1100 1000 40  0000 L CNN
F 1 "1u" H 1106 815 40  0000 L CNN
F 2 "SMD_Packages:SMD-0402_c" H 1138 750 30  0001 C CNN
F 3 "" H 1100 900 60  0000 C CNN
	1    1100 900 
	0    1    1    0   
$EndComp
$Comp
L ATMEGA328-A IC1
U 1 1 548921E2
P 2900 2900
F 0 "IC1" H 2150 4150 40  0000 L BNN
F 1 "ATMEGA328-A" H 3300 1500 40  0000 L BNN
F 2 "SMD_Packages:TQFP-32" H 2900 2900 30  0000 C CIN
F 3 "" H 2900 2900 60  0000 C CNN
	1    2900 2900
	1    0    0    -1  
$EndComp
$Comp
L BI_LED D1
U 1 1 548A6224
P 4700 2800
F 0 "D1" H 5000 2900 50  0000 C CNN
F 1 "BI_LED" H 5050 2700 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03" H 4700 2800 60  0001 C CNN
F 3 "" H 4700 2800 60  0000 C CNN
	1    4700 2800
	1    0    0    -1  
$EndComp
Text Label 4100 2750 0    60   ~ 0
Green
Text Label 4100 2850 0    60   ~ 0
Yellow
$Comp
L R R3
U 1 1 548A749B
P 5750 2800
F 0 "R3" V 5830 2800 40  0000 C CNN
F 1 "120" V 5757 2801 40  0000 C CNN
F 2 "SMD_Packages:SMD-0402_r" V 5680 2800 30  0001 C CNN
F 3 "" H 5750 2800 30  0000 C CNN
	1    5750 2800
	0    1    1    0   
$EndComp
Text Label 5050 2800 0    60   ~ 0
LEDCommon
NoConn ~ 2000 3250
NoConn ~ 2000 3150
NoConn ~ 2000 2400
$Comp
L C C3
U 1 1 548DB3A2
P 1850 2700
F 0 "C3" H 1850 2800 40  0000 L CNN
F 1 "0.1u" H 1856 2615 40  0000 L CNN
F 2 "SMD_Packages:SMD-0402_c" H 1888 2550 30  0001 C CNN
F 3 "" H 1850 2700 60  0000 C CNN
	1    1850 2700
	1    0    0    -1  
$EndComp
$Comp
L CONNECTOR P2
U 1 1 548DB59E
P 1050 2400
F 0 "P2" H 1400 2500 70  0000 C CNN
F 1 "Clock" H 1400 2300 70  0000 C CNN
F 2 "nesRF:Small_1x_Pad" H 1050 2400 60  0001 C CNN
F 3 "" H 1050 2400 60  0000 C CNN
	1    1050 2400
	-1   0    0    1   
$EndComp
$Comp
L CONNECTOR P3
U 1 1 548DB66E
P 1050 2750
F 0 "P3" H 1400 2850 70  0000 C CNN
F 1 "Latch" H 1400 2650 70  0000 C CNN
F 2 "nesRF:Small_1x_Pad" H 1050 2750 60  0001 C CNN
F 3 "" H 1050 2750 60  0000 C CNN
	1    1050 2750
	-1   0    0    1   
$EndComp
$Comp
L CONNECTOR P4
U 1 1 548DB68F
P 1050 3100
F 0 "P4" H 1400 3200 70  0000 C CNN
F 1 "Data" H 1400 3000 70  0000 C CNN
F 2 "nesRF:Small_1x_Pad" H 1050 3100 60  0001 C CNN
F 3 "" H 1050 3100 60  0000 C CNN
	1    1050 3100
	-1   0    0    1   
$EndComp
$Comp
L CONNECTOR P5
U 1 1 548DB6FB
P 1050 3450
F 0 "P5" H 1400 3550 70  0000 C CNN
F 1 "GND" H 1400 3350 70  0000 C CNN
F 2 "nesRF:Small_1x_Pad" H 1050 3450 60  0001 C CNN
F 3 "" H 1050 3450 60  0000 C CNN
	1    1050 3450
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR01
U 1 1 548DB7BA
P 1050 3550
F 0 "#PWR01" H 1050 3550 30  0001 C CNN
F 1 "GND" H 1050 3480 30  0001 C CNN
F 2 "" H 1050 3550 60  0000 C CNN
F 3 "" H 1050 3550 60  0000 C CNN
	1    1050 3550
	1    0    0    -1  
$EndComp
$Comp
L CONNECTOR P1
U 1 1 548DB928
P 1050 2050
F 0 "P1" H 1400 2150 70  0000 C CNN
F 1 "+5v" H 1400 1950 70  0000 C CNN
F 2 "nesRF:Small_1x_Pad" H 1050 2050 60  0001 C CNN
F 3 "" H 1050 2050 60  0000 C CNN
	1    1050 2050
	-1   0    0    1   
$EndComp
$Comp
L +5V #PWR02
U 1 1 548DBAE0
P 1050 2050
F 0 "#PWR02" H 1050 2140 20  0001 C CNN
F 1 "+5V" H 1050 2140 30  0000 C CNN
F 2 "" H 1050 2050 60  0000 C CNN
F 3 "" H 1050 2050 60  0000 C CNN
	1    1050 2050
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR03
U 1 1 548DC139
P 1300 1050
F 0 "#PWR03" H 1300 1050 30  0001 C CNN
F 1 "GND" H 1300 980 30  0001 C CNN
F 2 "" H 1300 1050 60  0000 C CNN
F 3 "" H 1300 1050 60  0000 C CNN
	1    1300 1050
	1    0    0    -1  
$EndComp
NoConn ~ 3900 3050
NoConn ~ 3900 3150
NoConn ~ 3900 3900
NoConn ~ 3900 4000
NoConn ~ 3900 4100
$Comp
L GND #PWR04
U 1 1 548DCA3D
P 6900 1100
F 0 "#PWR04" H 6900 1100 30  0001 C CNN
F 1 "GND" H 6900 1030 30  0001 C CNN
F 2 "" H 6900 1100 60  0000 C CNN
F 3 "" H 6900 1100 60  0000 C CNN
	1    6900 1100
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR05
U 1 1 548DCABC
P 5550 1150
F 0 "#PWR05" H 5550 1150 30  0001 C CNN
F 1 "GND" H 5550 1080 30  0001 C CNN
F 2 "" H 5550 1150 60  0000 C CNN
F 3 "" H 5550 1150 60  0000 C CNN
	1    5550 1150
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR06
U 1 1 548DCCB3
P 6100 2850
F 0 "#PWR06" H 6100 2850 30  0001 C CNN
F 1 "GND" H 6100 2780 30  0001 C CNN
F 2 "" H 6100 2850 60  0000 C CNN
F 3 "" H 6100 2850 60  0000 C CNN
	1    6100 2850
	1    0    0    -1  
$EndComp
NoConn ~ 3900 1800
$Comp
L +5V #PWR07
U 1 1 548DD9EA
P 6900 800
F 0 "#PWR07" H 6900 890 20  0001 C CNN
F 1 "+5V" H 6900 890 30  0000 C CNN
F 2 "" H 6900 800 60  0000 C CNN
F 3 "" H 6900 800 60  0000 C CNN
	1    6900 800 
	1    0    0    -1  
$EndComp
$Comp
L C C4
U 1 1 548DEAAE
P 1550 1550
F 0 "C4" H 1550 1650 40  0000 L CNN
F 1 "0.1u" H 1556 1465 40  0000 L CNN
F 2 "SMD_Packages:SMD-0402_c" H 1588 1400 30  0001 C CNN
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
F 2 "SMD_Packages:SMD-0402_c" H 2738 800 30  0001 C CNN
F 3 "" H 2700 950 60  0000 C CNN
	1    2700 950 
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR08
U 1 1 548FBB31
P 2700 1250
F 0 "#PWR08" H 2700 1250 30  0001 C CNN
F 1 "GND" H 2700 1180 30  0001 C CNN
F 2 "" H 2700 1250 60  0000 C CNN
F 3 "" H 2700 1250 60  0000 C CNN
	1    2700 1250
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X01 P8
U 1 1 5495E84E
P 4700 3400
F 0 "P8" H 4700 3500 50  0000 C CNN
F 1 "RX" V 4800 3400 50  0000 C CNN
F 2 "nesRF:Small_1x_Pad" H 4700 3400 60  0001 C CNN
F 3 "" H 4700 3400 60  0000 C CNN
	1    4700 3400
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X01 P9
U 1 1 5495E867
P 5100 3500
F 0 "P9" H 5100 3600 50  0000 C CNN
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
$Comp
L PWR_FLAG #FLG09
U 1 1 549B2491
P 1250 2050
F 0 "#FLG09" H 1250 2145 30  0001 C CNN
F 1 "PWR_FLAG" H 1250 2230 30  0000 C CNN
F 2 "" H 1250 2050 60  0000 C CNN
F 3 "" H 1250 2050 60  0000 C CNN
	1    1250 2050
	-1   0    0    1   
$EndComp
$Comp
L PWR_FLAG #FLG010
U 1 1 549B24CE
P 1250 3450
F 0 "#FLG010" H 1250 3545 30  0001 C CNN
F 1 "PWR_FLAG" H 1250 3630 30  0000 C CNN
F 2 "" H 1250 3450 60  0000 C CNN
F 3 "" H 1250 3450 60  0000 C CNN
	1    1250 3450
	1    0    0    -1  
$EndComp
$Comp
L CRYSTAL X1
U 1 1 54A98B41
P 5300 2200
F 0 "X1" H 5300 2350 60  0000 C CNN
F 1 "CRYSTAL" H 5300 2050 60  0000 C CNN
F 2 "nesRF:TSX-3225" H 5300 2200 60  0001 C CNN
F 3 "" H 5300 2200 60  0000 C CNN
	1    5300 2200
	0    -1   -1   0   
$EndComp
Wire Wire Line
	6900 850  6900 800 
Wire Wire Line
	6850 850  6900 850 
Wire Wire Line
	6100 2500 6100 2850
Wire Wire Line
	6000 2800 6100 2800
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
	1250 1250 1250 2050
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
	1850 2500 1850 1800
Wire Wire Line
	2000 1800 2000 2100
Wire Wire Line
	2000 3900 2000 4100
Wire Wire Line
	5050 2800 5500 2800
Wire Wire Line
	4400 2850 4400 2900
Wire Wire Line
	3900 2850 4400 2850
Wire Wire Line
	4400 2750 4400 2700
Wire Wire Line
	3900 2750 4400 2750
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
	1650 2200 1650 4000
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
Wire Wire Line
	1250 2050 1050 2050
Wire Wire Line
	1050 3450 1050 3550
Wire Wire Line
	1050 3450 1650 3450
Connection ~ 1650 3450
Connection ~ 1050 3450
Connection ~ 1250 1800
Connection ~ 2700 750 
Connection ~ 1250 3450
Wire Wire Line
	3900 2500 5300 2500
Wire Wire Line
	3900 2400 5050 2400
Wire Wire Line
	5050 1900 5300 1900
$Comp
L C C7
U 1 1 54A98DBE
P 5500 2500
F 0 "C7" H 5500 2600 40  0000 L CNN
F 1 "22p" H 5506 2415 40  0000 L CNN
F 2 "SMD_Packages:SMD-0402_c" H 5538 2350 30  0001 C CNN
F 3 "" H 5500 2500 60  0000 C CNN
	1    5500 2500
	0    1    1    0   
$EndComp
Wire Wire Line
	5050 2400 5050 1900
$Comp
L C C6
U 1 1 54A99077
P 5500 1900
F 0 "C6" H 5500 2000 40  0000 L CNN
F 1 "22p" H 5506 1815 40  0000 L CNN
F 2 "SMD_Packages:SMD-0402_c" H 5538 1750 30  0001 C CNN
F 3 "" H 5500 1900 60  0000 C CNN
	1    5500 1900
	0    1    1    0   
$EndComp
Wire Wire Line
	5700 1900 5700 2500
Wire Wire Line
	5700 2500 6100 2500
Connection ~ 6100 2800
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
Text Label 4650 2400 0    60   ~ 0
XTAL1
Text Label 4650 2500 0    60   ~ 0
XTAL2
NoConn ~ 3900 3800
Text Label 2700 750  0    60   ~ 0
2.5v
$EndSCHEMATC
