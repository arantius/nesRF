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
LIBS:rx-snes-cache
EELAYER 25 0
EELAYER END
$Descr User 8000 6500
encoding utf-8
Sheet 1 1
Title "nesRF Receiver (SNES)"
Date "Monday, January 26, 2015"
Rev "v3"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text Label 1250 2400 0    60   ~ 0
Clock
Text Label 1250 2750 0    60   ~ 0
Latch
Text Label 1250 3100 0    60   ~ 0
Data
$Comp
L C C1
U 1 1 54890E48
P 1850 2000
F 0 "C1" H 1850 2100 40  0000 L CNN
F 1 "0.1u" H 1856 1915 40  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 1888 1850 30  0001 C CNN
F 3 "" H 1850 2000 60  0000 C CNN
	1    1850 2000
	1    0    0    -1  
$EndComp
$Comp
L CONN_02X04 P6
U 1 1 54890EED
P 5450 950
F 0 "P6" H 5450 1200 50  0000 C CNN
F 1 "nRF" H 5450 700 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_2x04" H 5450 -250 60  0001 C CNN
F 3 "" H 5450 -250 60  0000 C CNN
	1    5450 950 
	1    0    0    -1  
$EndComp
$Comp
L CONN_02X03 P7
U 1 1 5489134F
P 6800 950
F 0 "P7" H 6800 1150 50  0000 C CNN
F 1 "ISP" H 6800 750 50  0000 C CNN
F 2 "nesRF:ISP_POGO" H 6800 -250 60  0001 C CNN
F 3 "" H 6800 -250 60  0000 C CNN
	1    6800 950 
	1    0    0    -1  
$EndComp
Text Label 4100 3250 0    60   ~ 0
~RST
$Comp
L R R1
U 1 1 54891382
P 1950 1550
F 0 "R1" V 2030 1550 40  0000 C CNN
F 1 "10k" V 1957 1551 40  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 1880 1550 30  0001 C CNN
F 3 "" H 1950 1550 30  0000 C CNN
	1    1950 1550
	1    0    0    -1  
$EndComp
Text Label 1950 1300 0    60   ~ 0
~RST
Text Label 4100 2000 0    60   ~ 0
RF_CE
Text Label 4100 1900 0    60   ~ 0
RF_CSN
Text Label 4100 2100 0    60   ~ 0
MOSI
Text Label 4100 2200 0    60   ~ 0
MISO
Text Label 4100 2300 0    60   ~ 0
SCK
Text Label 5200 900  2    60   ~ 0
MOSI
Text Label 5200 1000 2    60   ~ 0
RF_CSN
$Comp
L TCR2EF U1
U 1 1 548916E3
P 2050 850
F 0 "U1" H 2050 850 60  0000 C CNN
F 1 "TCR2EF" V 1850 850 60  0000 C CNN
F 2 "nesRF:SOT23-5" H 2050 850 60  0001 C CNN
F 3 "" H 2050 850 60  0000 C CNN
	1    2050 850 
	0    1    1    0   
$EndComp
Text Label 5700 800  0    60   ~ 0
MISO
Text Label 5700 900  0    60   ~ 0
SCK
Text Label 5700 1000 0    60   ~ 0
RF_CE
Text Label 7050 950  0    60   ~ 0
MOSI
Text Label 6550 1050 2    60   ~ 0
~RST
Text Label 6550 950  2    60   ~ 0
SCK
Text Label 6550 850  2    60   ~ 0
MISO
Text Label 4100 3600 0    60   ~ 0
Latch
Text Label 4100 3700 0    60   ~ 0
Clock
Text Label 4100 2850 0    60   ~ 0
Data
$Comp
L C C2
U 1 1 54891DF6
P 1300 900
F 0 "C2" H 1300 1000 40  0000 L CNN
F 1 "0.1u" H 1306 815 40  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 1338 750 30  0001 C CNN
F 3 "" H 1300 900 60  0000 C CNN
	1    1300 900 
	0    1    1    0   
$EndComp
$Comp
L ATMEGA328-A IC1
U 1 1 548921E2
P 3100 2900
F 0 "IC1" H 2350 4150 40  0000 L BNN
F 1 "ATMEGA328-A" H 3500 1500 40  0000 L BNN
F 2 "nesRF:TQFP-32" H 3100 2900 30  0000 C CIN
F 3 "" H 3100 2900 60  0000 C CNN
	1    3100 2900
	1    0    0    -1  
$EndComp
$Comp
L BI_LED D1
U 1 1 548A6224
P 4900 2750
F 0 "D1" H 5200 2850 50  0000 C CNN
F 1 "BI_LED" H 5250 2650 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03" H 4900 2750 60  0001 C CNN
F 3 "" H 4900 2750 60  0000 C CNN
	1    4900 2750
	1    0    0    1   
$EndComp
Text Label 4300 2650 0    60   ~ 0
Green
Text Label 4300 2750 0    60   ~ 0
Yellow
$Comp
L R R3
U 1 1 548A749B
P 5700 3000
F 0 "R3" V 5780 3000 40  0000 C CNN
F 1 "180" V 5707 3001 40  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 5630 3000 30  0001 C CNN
F 3 "" H 5700 3000 30  0000 C CNN
	1    5700 3000
	1    0    0    -1  
$EndComp
Text Label 5250 2750 0    60   ~ 0
LEDCommon
NoConn ~ 2200 3250
NoConn ~ 2200 3150
NoConn ~ 2200 2400
$Comp
L C C3
U 1 1 548DB3A2
P 2050 2700
F 0 "C3" H 2050 2800 40  0000 L CNN
F 1 "0.1u" H 2056 2615 40  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 2088 2550 30  0001 C CNN
F 3 "" H 2050 2700 60  0000 C CNN
	1    2050 2700
	1    0    0    -1  
$EndComp
$Comp
L CONNECTOR P2
U 1 1 548DB59E
P 1250 2400
F 0 "P2" H 1600 2500 70  0000 C CNN
F 1 "Clock (Yel)" H 1600 2300 70  0000 C CNN
F 2 "nesRF:Small_1x_Pad" H 1250 2400 60  0001 C CNN
F 3 "" H 1250 2400 60  0000 C CNN
	1    1250 2400
	-1   0    0    1   
$EndComp
$Comp
L CONNECTOR P3
U 1 1 548DB66E
P 1250 2750
F 0 "P3" H 1600 2850 70  0000 C CNN
F 1 "Latch (Org)" H 1600 2650 70  0000 C CNN
F 2 "nesRF:Small_1x_Pad" H 1250 2750 60  0001 C CNN
F 3 "" H 1250 2750 60  0000 C CNN
	1    1250 2750
	-1   0    0    1   
$EndComp
$Comp
L CONNECTOR P4
U 1 1 548DB68F
P 1250 3100
F 0 "P4" H 1600 3200 70  0000 C CNN
F 1 "Data (Red)" H 1600 3000 70  0000 C CNN
F 2 "nesRF:Small_1x_Pad" H 1250 3100 60  0001 C CNN
F 3 "" H 1250 3100 60  0000 C CNN
	1    1250 3100
	-1   0    0    1   
$EndComp
$Comp
L CONNECTOR P5
U 1 1 548DB6FB
P 1250 3450
F 0 "P5" H 1600 3550 70  0000 C CNN
F 1 "GND (Brn)" H 1600 3350 70  0000 C CNN
F 2 "nesRF:Small_1x_Pad" H 1250 3450 60  0001 C CNN
F 3 "" H 1250 3450 60  0000 C CNN
	1    1250 3450
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR01
U 1 1 548DB7BA
P 1250 3550
F 0 "#PWR01" H 1250 3550 30  0001 C CNN
F 1 "GND" H 1250 3480 30  0001 C CNN
F 2 "" H 1250 3550 60  0000 C CNN
F 3 "" H 1250 3550 60  0000 C CNN
	1    1250 3550
	1    0    0    -1  
$EndComp
$Comp
L CONNECTOR P1
U 1 1 548DB928
P 1250 2050
F 0 "P1" H 1600 2150 70  0000 C CNN
F 1 "+5v (Wht)" H 1600 1950 70  0000 C CNN
F 2 "nesRF:Small_1x_Pad" H 1250 2050 60  0001 C CNN
F 3 "" H 1250 2050 60  0000 C CNN
	1    1250 2050
	-1   0    0    1   
$EndComp
$Comp
L +5V #PWR02
U 1 1 548DBAE0
P 1250 2050
F 0 "#PWR02" H 1250 2140 20  0001 C CNN
F 1 "+5V" H 1250 2140 30  0000 C CNN
F 2 "" H 1250 2050 60  0000 C CNN
F 3 "" H 1250 2050 60  0000 C CNN
	1    1250 2050
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR03
U 1 1 548DC139
P 1500 1050
F 0 "#PWR03" H 1500 1050 30  0001 C CNN
F 1 "GND" H 1500 980 30  0001 C CNN
F 2 "" H 1500 1050 60  0000 C CNN
F 3 "" H 1500 1050 60  0000 C CNN
	1    1500 1050
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR04
U 1 1 548DCA3D
P 7100 1100
F 0 "#PWR04" H 7100 1100 30  0001 C CNN
F 1 "GND" H 7100 1030 30  0001 C CNN
F 2 "" H 7100 1100 60  0000 C CNN
F 3 "" H 7100 1100 60  0000 C CNN
	1    7100 1100
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR05
U 1 1 548DCABC
P 5750 1150
F 0 "#PWR05" H 5750 1150 30  0001 C CNN
F 1 "GND" H 5750 1080 30  0001 C CNN
F 2 "" H 5750 1150 60  0000 C CNN
F 3 "" H 5750 1150 60  0000 C CNN
	1    5750 1150
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR06
U 1 1 548DCCB3
P 5700 3300
F 0 "#PWR06" H 5700 3300 30  0001 C CNN
F 1 "GND" H 5700 3230 30  0001 C CNN
F 2 "" H 5700 3300 60  0000 C CNN
F 3 "" H 5700 3300 60  0000 C CNN
	1    5700 3300
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR07
U 1 1 548DD9EA
P 7100 800
F 0 "#PWR07" H 7100 890 20  0001 C CNN
F 1 "+5V" H 7100 890 30  0000 C CNN
F 2 "" H 7100 800 60  0000 C CNN
F 3 "" H 7100 800 60  0000 C CNN
	1    7100 800 
	1    0    0    -1  
$EndComp
$Comp
L C C5
U 1 1 548FB6E3
P 2900 950
F 0 "C5" H 2900 1050 40  0000 L CNN
F 1 "1u" H 2906 865 40  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 2938 800 30  0001 C CNN
F 3 "" H 2900 950 60  0000 C CNN
	1    2900 950 
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR08
U 1 1 548FBB31
P 2900 1250
F 0 "#PWR08" H 2900 1250 30  0001 C CNN
F 1 "GND" H 2900 1180 30  0001 C CNN
F 2 "" H 2900 1250 60  0000 C CNN
F 3 "" H 2900 1250 60  0000 C CNN
	1    2900 1250
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X01 P8
U 1 1 5495E84E
P 4900 3400
F 0 "P8" H 4900 3500 50  0000 C CNN
F 1 "RX" V 5000 3400 50  0000 C CNN
F 2 "nesRF:Small_1x_Pad" H 4900 3400 60  0001 C CNN
F 3 "" H 4900 3400 60  0000 C CNN
	1    4900 3400
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X01 P9
U 1 1 5495E867
P 5300 3500
F 0 "P9" H 5300 3600 50  0000 C CNN
F 1 "TX" V 5400 3500 50  0000 C CNN
F 2 "nesRF:Small_1x_Pad" H 5300 3500 60  0001 C CNN
F 3 "" H 5300 3500 60  0000 C CNN
	1    5300 3500
	1    0    0    -1  
$EndComp
Text Label 4100 3400 0    60   ~ 0
SER_RX
Text Label 4100 3500 0    60   ~ 0
SER_TX
$Comp
L PWR_FLAG #FLG09
U 1 1 549B2491
P 1450 2050
F 0 "#FLG09" H 1450 2145 30  0001 C CNN
F 1 "PWR_FLAG" H 1450 2230 30  0000 C CNN
F 2 "" H 1450 2050 60  0000 C CNN
F 3 "" H 1450 2050 60  0000 C CNN
	1    1450 2050
	-1   0    0    1   
$EndComp
$Comp
L PWR_FLAG #FLG010
U 1 1 549B24CE
P 1450 3450
F 0 "#FLG010" H 1450 3545 30  0001 C CNN
F 1 "PWR_FLAG" H 1450 3630 30  0000 C CNN
F 2 "" H 1450 3450 60  0000 C CNN
F 3 "" H 1450 3450 60  0000 C CNN
	1    1450 3450
	1    0    0    -1  
$EndComp
Text Label 2900 750  0    60   ~ 0
2.5v
$Comp
L CRYSTAL X1
U 1 1 55270266
P 5400 2200
F 0 "X1" H 5400 2350 60  0000 C CNN
F 1 "CRYSTAL" H 5400 2050 60  0000 C CNN
F 2 "nesRF:TSX-3225" H 5400 2200 60  0001 C CNN
F 3 "" H 5400 2200 60  0000 C CNN
	1    5400 2200
	0    -1   -1   0   
$EndComp
$Comp
L C C7
U 1 1 5527061D
P 5800 2500
F 0 "C7" H 5800 2600 40  0000 L CNN
F 1 "22p" H 5806 2415 40  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 5838 2350 30  0001 C CNN
F 3 "" H 5800 2500 60  0000 C CNN
	1    5800 2500
	0    1    1    0   
$EndComp
$Comp
L C C6
U 1 1 55270662
P 5800 1900
F 0 "C6" H 5800 2000 40  0000 L CNN
F 1 "22p" H 5806 1815 40  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 5838 1750 30  0001 C CNN
F 3 "" H 5800 1900 60  0000 C CNN
	1    5800 1900
	0    1    1    0   
$EndComp
$Comp
L GND #PWR011
U 1 1 55270950
P 6000 2600
F 0 "#PWR011" H 6000 2600 30  0001 C CNN
F 1 "GND" H 6000 2530 30  0001 C CNN
F 2 "" H 6000 2600 60  0000 C CNN
F 3 "" H 6000 2600 60  0000 C CNN
	1    6000 2600
	1    0    0    -1  
$EndComp
Text Label 4300 2400 0    60   ~ 0
XTAL1
Text Label 4300 2500 0    60   ~ 0
XTAL2
NoConn ~ 4100 2950
NoConn ~ 4100 3050
NoConn ~ 4100 3150
NoConn ~ 4100 3800
NoConn ~ 4100 3900
NoConn ~ 4100 4000
NoConn ~ 4100 4100
Text Label 4100 1800 0    60   ~ 0
RF_IRQ
Text Label 5200 800  2    60   ~ 0
RF_IRQ
Wire Wire Line
	7100 850  7100 800 
Wire Wire Line
	7050 850  7100 850 
Wire Wire Line
	5750 1100 5750 1150
Wire Wire Line
	5700 1100 5750 1100
Wire Wire Line
	7100 1050 7100 1100
Wire Wire Line
	7050 1050 7100 1050
Connection ~ 1500 900 
Wire Wire Line
	1500 850  1600 850 
Connection ~ 1450 1250
Wire Wire Line
	1450 1250 1450 2050
Wire Wire Line
	1100 1250 1600 1250
Wire Wire Line
	1600 1250 1600 950 
Wire Wire Line
	1500 850  1500 1050
Connection ~ 2050 4000
Wire Wire Line
	2050 2900 2050 4000
Connection ~ 2050 1800
Wire Wire Line
	2050 1800 2050 2500
Wire Wire Line
	2200 1800 2200 2100
Wire Wire Line
	2200 3900 2200 4100
Wire Wire Line
	5250 2750 5700 2750
Wire Wire Line
	4100 2750 4600 2750
Wire Wire Line
	4100 2650 4600 2650
Connection ~ 2200 1900
Connection ~ 2200 4000
Connection ~ 1100 900 
Wire Wire Line
	1100 750  1100 1250
Wire Wire Line
	5200 1100 5200 1350
Wire Wire Line
	1100 750  1600 750 
Connection ~ 1950 1800
Connection ~ 1850 1800
Wire Wire Line
	1850 2200 1850 4000
Wire Wire Line
	1850 4000 2200 4000
Wire Wire Line
	1450 1800 2200 1800
Wire Wire Line
	2500 750  3400 750 
Wire Wire Line
	2900 1150 2900 1250
Wire Wire Line
	4100 3500 5100 3500
Wire Wire Line
	4100 3400 4700 3400
Wire Wire Line
	1450 2050 1250 2050
Wire Wire Line
	1250 3450 1250 3550
Wire Wire Line
	1250 3450 1850 3450
Connection ~ 1850 3450
Connection ~ 1250 3450
Connection ~ 1450 1800
Connection ~ 2900 750 
Connection ~ 1450 3450
Wire Wire Line
	5200 1350 3400 1350
Wire Wire Line
	3400 1350 3400 750 
Wire Wire Line
	4100 2400 5100 2400
Wire Wire Line
	5100 2400 5100 1900
Wire Wire Line
	5100 1900 5600 1900
Wire Wire Line
	4100 2500 5600 2500
Wire Wire Line
	6000 1900 6000 2600
Connection ~ 6000 2500
Connection ~ 5400 1900
Connection ~ 5400 2500
Wire Wire Line
	4600 2750 4600 2850
Wire Wire Line
	5700 3300 5700 3250
$EndSCHEMATC
