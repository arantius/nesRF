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
$Descr USLetter 11000 8500
encoding utf-8
Sheet 1 1
Title "nesRF Receiver (SNES)"
Date "Saturday, December 20, 2014"
Rev "v1"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text Label 3200 2900 0    60   ~ 0
Clock
Text Label 3200 3250 0    60   ~ 0
Latch
Text Label 3200 3600 0    60   ~ 0
Data
$Comp
L C C1
U 1 1 54890E48
P 3800 2500
F 0 "C1" H 3800 2600 40  0000 L CNN
F 1 "0.1u" H 3806 2415 40  0000 L CNN
F 2 "SMD_Packages:SMD-0402_c" H 3838 2350 30  0001 C CNN
F 3 "" H 3800 2500 60  0000 C CNN
	1    3800 2500
	1    0    0    -1  
$EndComp
$Comp
L CONN_02X04 P6
U 1 1 54890EED
P 7400 1450
F 0 "P6" H 7400 1700 50  0000 C CNN
F 1 "nRF" H 7400 1200 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_2x04" H 7400 250 60  0001 C CNN
F 3 "" H 7400 250 60  0000 C CNN
	1    7400 1450
	1    0    0    -1  
$EndComp
Text Label 6050 3150 0    60   ~ 0
RF_IRQ
Text Label 7150 1300 2    60   ~ 0
RF_IRQ
$Comp
L CONN_02X03 P7
U 1 1 5489134F
P 7400 2250
F 0 "P7" H 7400 2450 50  0000 C CNN
F 1 "ISP" H 7400 2050 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_2x03" H 7400 1050 60  0001 C CNN
F 3 "" H 7400 1050 60  0000 C CNN
	1    7400 2250
	1    0    0    -1  
$EndComp
Text Label 6050 3750 0    60   ~ 0
~RST
$Comp
L R R1
U 1 1 54891382
P 3900 2050
F 0 "R1" V 3980 2050 40  0000 C CNN
F 1 "10k" V 3907 2051 40  0000 C CNN
F 2 "SMD_Packages:SMD-0402_r" V 3830 2050 30  0001 C CNN
F 3 "" H 3900 2050 30  0000 C CNN
	1    3900 2050
	1    0    0    -1  
$EndComp
Text Label 3900 1800 0    60   ~ 0
~RST
Text Label 6050 2500 0    60   ~ 0
RF_CE
Text Label 6050 2400 0    60   ~ 0
RF_CSN
Text Label 6050 2600 0    60   ~ 0
MOSI
Text Label 6050 2700 0    60   ~ 0
MISO
Text Label 6050 2800 0    60   ~ 0
SCK
Text Label 7150 1400 2    60   ~ 0
MOSI
$Comp
L R R2
U 1 1 54891606
P 6850 1600
F 0 "R2" V 6930 1600 40  0000 C CNN
F 1 "10k" V 6857 1601 40  0000 C CNN
F 2 "SMD_Packages:SMD-0402_r" V 6780 1600 30  0001 C CNN
F 3 "" H 6850 1600 30  0000 C CNN
	1    6850 1600
	0    1    1    0   
$EndComp
Text Label 6500 1500 2    60   ~ 0
RF_CSN
$Comp
L TCR2EF U1
U 1 1 548916E3
P 4000 1350
F 0 "U1" H 4000 1350 60  0000 C CNN
F 1 "TCR2EF" V 3800 1350 60  0000 C CNN
F 2 "SMD_Packages:SOT-23-5" H 4000 1350 60  0001 C CNN
F 3 "" H 4000 1350 60  0000 C CNN
	1    4000 1350
	0    1    1    0   
$EndComp
Text Label 5350 1250 0    60   ~ 0
2.5v
Text Label 7150 1850 2    60   ~ 0
2.5v
Text Label 7650 1300 0    60   ~ 0
MISO
Text Label 7650 1400 0    60   ~ 0
SCK
Text Label 7650 1500 0    60   ~ 0
RF_CE
Text Label 7650 2250 0    60   ~ 0
MOSI
Text Label 7150 2350 2    60   ~ 0
~RST
Text Label 7150 2250 2    60   ~ 0
SCK
Text Label 7150 2150 2    60   ~ 0
MISO
Text Label 6050 4100 0    60   ~ 0
Latch
Text Label 6050 4200 0    60   ~ 0
Clock
Text Label 6050 4300 0    60   ~ 0
Data
$Comp
L C C2
U 1 1 54891DF6
P 3250 1400
F 0 "C2" H 3250 1500 40  0000 L CNN
F 1 "1u" H 3256 1315 40  0000 L CNN
F 2 "SMD_Packages:SMD-0402_c" H 3288 1250 30  0001 C CNN
F 3 "" H 3250 1400 60  0000 C CNN
	1    3250 1400
	0    1    1    0   
$EndComp
$Comp
L ATMEGA328-A IC1
U 1 1 548921E2
P 5050 3400
F 0 "IC1" H 4300 4650 40  0000 L BNN
F 1 "ATMEGA328-A" H 5450 2000 40  0000 L BNN
F 2 "SMD_Packages:TQFP-32" H 5050 3400 30  0000 C CIN
F 3 "" H 5050 3400 60  0000 C CNN
	1    5050 3400
	1    0    0    -1  
$EndComp
$Comp
L BI_LED D1
U 1 1 548A6224
P 6850 3300
F 0 "D1" H 7150 3400 50  0000 C CNN
F 1 "BI_LED" H 7200 3200 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03" H 6850 3300 60  0001 C CNN
F 3 "" H 6850 3300 60  0000 C CNN
	1    6850 3300
	1    0    0    1   
$EndComp
Text Label 6250 3350 0    60   ~ 0
Green
Text Label 6250 3250 0    60   ~ 0
Yellow
$Comp
L R R3
U 1 1 548A749B
P 7900 3300
F 0 "R3" V 7980 3300 40  0000 C CNN
F 1 "120" V 7907 3301 40  0000 C CNN
F 2 "SMD_Packages:SMD-0402_r" V 7830 3300 30  0001 C CNN
F 3 "" H 7900 3300 30  0000 C CNN
	1    7900 3300
	0    1    1    0   
$EndComp
Text Label 7200 3300 0    60   ~ 0
LEDCommon
NoConn ~ 4150 3750
NoConn ~ 4150 3650
NoConn ~ 4150 2900
$Comp
L C C3
U 1 1 548DB3A2
P 4000 3200
F 0 "C3" H 4000 3300 40  0000 L CNN
F 1 "0.1u" H 4006 3115 40  0000 L CNN
F 2 "SMD_Packages:SMD-0402_c" H 4038 3050 30  0001 C CNN
F 3 "" H 4000 3200 60  0000 C CNN
	1    4000 3200
	1    0    0    -1  
$EndComp
$Comp
L CONNECTOR P2
U 1 1 548DB59E
P 3200 2900
F 0 "P2" H 3550 3000 70  0000 C CNN
F 1 "Clock" H 3550 2800 70  0000 C CNN
F 2 "nesRF:Small_1x_Pad" H 3200 2900 60  0001 C CNN
F 3 "" H 3200 2900 60  0000 C CNN
	1    3200 2900
	-1   0    0    1   
$EndComp
$Comp
L CONNECTOR P3
U 1 1 548DB66E
P 3200 3250
F 0 "P3" H 3550 3350 70  0000 C CNN
F 1 "Latch" H 3550 3150 70  0000 C CNN
F 2 "nesRF:Small_1x_Pad" H 3200 3250 60  0001 C CNN
F 3 "" H 3200 3250 60  0000 C CNN
	1    3200 3250
	-1   0    0    1   
$EndComp
$Comp
L CONNECTOR P4
U 1 1 548DB68F
P 3200 3600
F 0 "P4" H 3550 3700 70  0000 C CNN
F 1 "Data" H 3550 3500 70  0000 C CNN
F 2 "nesRF:Small_1x_Pad" H 3200 3600 60  0001 C CNN
F 3 "" H 3200 3600 60  0000 C CNN
	1    3200 3600
	-1   0    0    1   
$EndComp
$Comp
L CONNECTOR P5
U 1 1 548DB6FB
P 3200 3950
F 0 "P5" H 3550 4050 70  0000 C CNN
F 1 "GND" H 3550 3850 70  0000 C CNN
F 2 "nesRF:Small_1x_Pad" H 3200 3950 60  0001 C CNN
F 3 "" H 3200 3950 60  0000 C CNN
	1    3200 3950
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR01
U 1 1 548DB7BA
P 3200 4050
F 0 "#PWR01" H 3200 4050 30  0001 C CNN
F 1 "GND" H 3200 3980 30  0001 C CNN
F 2 "" H 3200 4050 60  0000 C CNN
F 3 "" H 3200 4050 60  0000 C CNN
	1    3200 4050
	1    0    0    -1  
$EndComp
$Comp
L CONNECTOR P1
U 1 1 548DB928
P 3200 2550
F 0 "P1" H 3550 2650 70  0000 C CNN
F 1 "+5v" H 3550 2450 70  0000 C CNN
F 2 "nesRF:Small_1x_Pad" H 3200 2550 60  0001 C CNN
F 3 "" H 3200 2550 60  0000 C CNN
	1    3200 2550
	-1   0    0    1   
$EndComp
$Comp
L +5V #PWR02
U 1 1 548DBAE0
P 3200 2550
F 0 "#PWR02" H 3200 2640 20  0001 C CNN
F 1 "+5V" H 3200 2640 30  0000 C CNN
F 2 "" H 3200 2550 60  0000 C CNN
F 3 "" H 3200 2550 60  0000 C CNN
	1    3200 2550
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR03
U 1 1 548DC139
P 3450 1550
F 0 "#PWR03" H 3450 1550 30  0001 C CNN
F 1 "GND" H 3450 1480 30  0001 C CNN
F 2 "" H 3450 1550 60  0000 C CNN
F 3 "" H 3450 1550 60  0000 C CNN
	1    3450 1550
	1    0    0    -1  
$EndComp
NoConn ~ 6050 3450
NoConn ~ 6050 3550
NoConn ~ 6050 3650
NoConn ~ 6050 4400
NoConn ~ 6050 4500
NoConn ~ 6050 4600
$Comp
L GND #PWR04
U 1 1 548DCA3D
P 7700 2400
F 0 "#PWR04" H 7700 2400 30  0001 C CNN
F 1 "GND" H 7700 2330 30  0001 C CNN
F 2 "" H 7700 2400 60  0000 C CNN
F 3 "" H 7700 2400 60  0000 C CNN
	1    7700 2400
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR05
U 1 1 548DCABC
P 7700 1650
F 0 "#PWR05" H 7700 1650 30  0001 C CNN
F 1 "GND" H 7700 1580 30  0001 C CNN
F 2 "" H 7700 1650 60  0000 C CNN
F 3 "" H 7700 1650 60  0000 C CNN
	1    7700 1650
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR06
U 1 1 548DCCB3
P 8250 3350
F 0 "#PWR06" H 8250 3350 30  0001 C CNN
F 1 "GND" H 8250 3280 30  0001 C CNN
F 2 "" H 8250 3350 60  0000 C CNN
F 3 "" H 8250 3350 60  0000 C CNN
	1    8250 3350
	1    0    0    -1  
$EndComp
NoConn ~ 6050 3000
NoConn ~ 6050 2900
NoConn ~ 6050 2300
$Comp
L +5V #PWR07
U 1 1 548DD9EA
P 7700 2100
F 0 "#PWR07" H 7700 2190 20  0001 C CNN
F 1 "+5V" H 7700 2190 30  0000 C CNN
F 2 "" H 7700 2100 60  0000 C CNN
F 3 "" H 7700 2100 60  0000 C CNN
	1    7700 2100
	1    0    0    -1  
$EndComp
Wire Wire Line
	7700 2150 7700 2100
Wire Wire Line
	7650 2150 7700 2150
Wire Wire Line
	8250 3300 8250 3350
Wire Wire Line
	8150 3300 8250 3300
Wire Wire Line
	7700 1600 7700 1650
Wire Wire Line
	7650 1600 7700 1600
Wire Wire Line
	7700 2350 7700 2400
Wire Wire Line
	7650 2350 7700 2350
Connection ~ 3450 1400
Wire Wire Line
	3450 1350 3550 1350
Connection ~ 3400 1750
Wire Wire Line
	3400 1750 3400 2550
Wire Wire Line
	3050 1750 3550 1750
Wire Wire Line
	3550 1750 3550 1450
Wire Wire Line
	3450 1350 3450 1550
Connection ~ 4000 4500
Wire Wire Line
	4000 3400 4000 4500
Connection ~ 4000 2300
Wire Wire Line
	4000 3000 4000 2300
Wire Wire Line
	4150 2300 4150 2600
Wire Wire Line
	4150 4400 4150 4600
Wire Wire Line
	7200 3300 7650 3300
Wire Wire Line
	6550 3350 6550 3400
Wire Wire Line
	6050 3350 6550 3350
Wire Wire Line
	6550 3250 6550 3200
Wire Wire Line
	6050 3250 6550 3250
Connection ~ 4150 2400
Connection ~ 4150 4500
Connection ~ 3050 1400
Wire Wire Line
	3050 1250 3050 1750
Wire Wire Line
	7150 1600 7150 1850
Wire Wire Line
	3050 1250 3550 1250
Connection ~ 6600 1500
Wire Wire Line
	6600 1600 6600 1500
Wire Wire Line
	6500 1500 7150 1500
Wire Wire Line
	7150 1600 7100 1600
Connection ~ 3900 2300
Connection ~ 3800 2300
Wire Wire Line
	3800 2700 3800 4500
Wire Wire Line
	3800 4500 4150 4500
Wire Wire Line
	3400 2300 4150 2300
$Comp
L C C4
U 1 1 548DEAAE
P 3600 4350
F 0 "C4" H 3600 4450 40  0000 L CNN
F 1 "0.1u" H 3606 4265 40  0000 L CNN
F 2 "SMD_Packages:SMD-0402_c" H 3638 4200 30  0001 C CNN
F 3 "" H 3600 4350 60  0000 C CNN
	1    3600 4350
	0    1    1    0   
$EndComp
Text Label 3400 4350 2    60   ~ 0
~RST
Connection ~ 3800 4350
$Comp
L C C5
U 1 1 548FB6E3
P 4850 1450
F 0 "C5" H 4850 1550 40  0000 L CNN
F 1 "1u" H 4856 1365 40  0000 L CNN
F 2 "SMD_Packages:SMD-0402_c" H 4888 1300 30  0001 C CNN
F 3 "" H 4850 1450 60  0000 C CNN
	1    4850 1450
	-1   0    0    1   
$EndComp
Wire Wire Line
	4450 1250 5350 1250
Wire Wire Line
	4850 1650 4850 1750
$Comp
L GND #PWR08
U 1 1 548FBB31
P 4850 1750
F 0 "#PWR08" H 4850 1750 30  0001 C CNN
F 1 "GND" H 4850 1680 30  0001 C CNN
F 2 "" H 4850 1750 60  0000 C CNN
F 3 "" H 4850 1750 60  0000 C CNN
	1    4850 1750
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X01 P8
U 1 1 5495E84E
P 6850 3900
F 0 "P8" H 6850 4000 50  0000 C CNN
F 1 "RX" V 6950 3900 50  0000 C CNN
F 2 "" H 6850 3900 60  0000 C CNN
F 3 "" H 6850 3900 60  0000 C CNN
	1    6850 3900
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X01 P9
U 1 1 5495E867
P 7250 4000
F 0 "P9" H 7250 4100 50  0000 C CNN
F 1 "TX" V 7350 4000 50  0000 C CNN
F 2 "" H 7250 4000 60  0000 C CNN
F 3 "" H 7250 4000 60  0000 C CNN
	1    7250 4000
	1    0    0    -1  
$EndComp
Wire Wire Line
	6050 4000 7050 4000
Wire Wire Line
	6050 3900 6650 3900
Text Label 6050 3900 0    60   ~ 0
SER_RX
Text Label 6050 4000 0    60   ~ 0
SER_TX
Wire Wire Line
	3400 2550 3200 2550
Wire Wire Line
	3200 3950 3200 4050
Wire Wire Line
	3200 3950 3800 3950
Connection ~ 3800 3950
Connection ~ 3200 3950
Connection ~ 3400 2300
Connection ~ 4850 1250
$Comp
L PWR_FLAG #FLG09
U 1 1 549B2491
P 3400 2550
F 0 "#FLG09" H 3400 2645 30  0001 C CNN
F 1 "PWR_FLAG" H 3400 2730 30  0000 C CNN
F 2 "" H 3400 2550 60  0000 C CNN
F 3 "" H 3400 2550 60  0000 C CNN
	1    3400 2550
	-1   0    0    1   
$EndComp
$Comp
L PWR_FLAG #FLG010
U 1 1 549B24CE
P 3400 3950
F 0 "#FLG010" H 3400 4045 30  0001 C CNN
F 1 "PWR_FLAG" H 3400 4130 30  0000 C CNN
F 2 "" H 3400 3950 60  0000 C CNN
F 3 "" H 3400 3950 60  0000 C CNN
	1    3400 3950
	1    0    0    -1  
$EndComp
Connection ~ 3400 3950
$EndSCHEMATC
