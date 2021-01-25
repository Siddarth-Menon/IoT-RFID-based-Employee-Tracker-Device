
;CodeVisionAVR C Compiler V1.24.8d Professional
;(C) Copyright 1998-2006 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type              : ATmega48
;Clock frequency        : 8.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External SRAM size     : 0
;Data Stack size        : 128 byte(s)
;Heap size              : 0 byte(s)
;Promote char to int    : No
;char is unsigned       : Yes
;8 bit enums            : No
;Word align FLASH struct: No
;Enhanced core instructions    : On
;Automatic register allocation : On

	#pragma AVRPART ADMIN PART_NAME ATmega48
	#pragma AVRPART MEMORY PROG_FLASH 4096
	#pragma AVRPART MEMORY EEPROM 256
	#pragma AVRPART MEMORY INT_SRAM SIZE 512
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x100

	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU EECR=0x1F
	.EQU EEDR=0x20
	.EQU EEARL=0x21
	.EQU EEARH=0x22
	.EQU SPSR=0x2D
	.EQU SPDR=0x2E
	.EQU SMCR=0x33
	.EQU MCUSR=0x34
	.EQU MCUCR=0x35
	.EQU WDTCSR=0x60
	.EQU UCSR0A=0xC0
	.EQU UDR0=0xC6
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
	.EQU GPIOR0=0x1E
	.EQU GPIOR1=0x2A
	.EQU GPIOR2=0x2B

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_adc_noise_red=0x02
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM
	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM
	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM
	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM
	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM
	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM
	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+@1
	ANDI R30,LOW(@2)
	STS  @0+@1,R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+@1
	ANDI R30,LOW(@2)
	STS  @0+@1,R30
	LDS  R30,@0+@1+1
	ANDI R30,HIGH(@2)
	STS  @0+@1+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+@1
	ORI  R30,LOW(@2)
	STS  @0+@1,R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+@1
	ORI  R30,LOW(@2)
	STS  @0+@1,R30
	LDS  R30,@0+@1+1
	ORI  R30,HIGH(@2)
	STS  @0+@1+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __CLRD1S
	LDI  R30,0
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+@1)
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+@1)
	LDI  R31,HIGH(@0+@1)
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	LDI  R22,BYTE3(2*@0+@1)
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+@1)
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+@2)
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+@3)
	LDI  R@1,HIGH(@2+@3)
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+@3)
	LDI  R@1,HIGH(@2*2+@3)
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+@1
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+@1
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	LDS  R22,@0+@1+2
	LDS  R23,@0+@1+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+@2
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+@3
	LDS  R@1,@2+@3+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+@1
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+@1
	LDS  R27,@0+@1+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+@1
	LDS  R27,@0+@1+1
	LDS  R24,@0+@1+2
	LDS  R25,@0+@1+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+@1,R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+@1,R30
	STS  @0+@1+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+@1,R30
	STS  @0+@1+1,R31
	STS  @0+@1+2,R22
	STS  @0+@1+3,R23
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+@1,R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+@1,R@2
	STS  @0+@1+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	RCALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	RCALL __EEPROMRDW
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	RCALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CLR  R0
	ST   Z+,R0
	ST   Z,R0
	.ENDM

	.MACRO __CLRD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CLR  R0
	ST   Z+,R0
	ST   Z+,R0
	ST   Z+,R0
	ST   Z,R0
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R@1
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

	.CSEG
	.ORG 0

	.INCLUDE "adc.vec"
	.INCLUDE "adc.inc"

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30
	OUT  MCUCR,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	WDR
	IN   R26,MCUSR
	CBR  R26,8
	OUT  MCUSR,R26
	STS  WDTCSR,R31
	STS  WDTCSR,R30

;CLEAR R2-R14
	LDI  R24,13
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(0x200)
	LDI  R25,HIGH(0x200)
	LDI  R26,LOW(0x100)
	LDI  R27,HIGH(0x100)
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;GPIOR0-GPIOR2 INITIALIZATION
	LDI  R30,__GPIOR0_INIT
	OUT  GPIOR0,R30
	LDI  R30,__GPIOR1_INIT
	OUT  GPIOR1,R30
	LDI  R30,__GPIOR2_INIT
	OUT  GPIOR2,R30

;STACK POINTER INITIALIZATION
	LDI  R30,LOW(0x2FF)
	OUT  SPL,R30
	LDI  R30,HIGH(0x2FF)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(0x180)
	LDI  R29,HIGH(0x180)

	RJMP _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x180
;       1 #include <mega48.h>
;       2  #include <lcd16x1.h> 
;       3  #include<delay.h>
;       4  #include<stdlib.h>
;       5  #include<string.h>
;       6 #define RXB8 1
;       7 #define TXB8 0
;       8 #define UPE 2
;       9 #define OVR 3
;      10 #define FE 4
;      11 #define UDRE 5
;      12 #define RXC 7
;      13 void gps(void);  
;      14 void send_cmd(void);
;      15 void latch_cmd(void);
;      16 void gprs(void);
;      17 
;      18 #define FRAMING_ERROR (1<<FE)
;      19 #define PARITY_ERROR (1<<UPE)
;      20 #define DATA_OVERRUN (1<<OVR)
;      21 #define DATA_REGISTER_EMPTY (1<<UDRE)
;      22 #define RX_COMPLETE (1<<RXC) 
;      23 unsigned int timer_count;
;      24 unsigned char i;   
;      25 unsigned char j;      
;      26 unsigned char k;
;      27 
;      28 
;      29 // USART Receiver buffer
;      30 #define RX_BUFFER_SIZE0 8
;      31 char rx_buffer0[RX_BUFFER_SIZE0];
_rx_buffer0:
	.BYTE 0x8
;      32 
;      33 #if RX_BUFFER_SIZE0<256
;      34 unsigned char rx_wr_index0,rx_rd_index0,rx_counter0;
;      35 #else
;      36 unsigned int rx_wr_index0,rx_rd_index0,rx_counter0;
;      37 #endif
;      38 
;      39 // This flag is set on USART Receiver buffer overflow
;      40 bit rx_buffer_overflow0;
;      41 
;      42 // USART Receiver interrupt service routine
;      43 interrupt [USART_RXC] void usart_rx_isr(void)
;      44 {

	.CSEG
_usart_rx_isr:
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	IN   R30,SREG
	ST   -Y,R30
;      45 char status,data;
;      46 status=UCSR0A;
	RCALL __SAVELOCR2
;	status -> R16
;	data -> R17
	LDS  R16,192
;      47 data=UDR0;
	LDS  R17,198
;      48 if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
	MOV  R30,R16
	ANDI R30,LOW(0x1C)
	BREQ PC+2
	RJMP _0x3
;      49    {
;      50    rx_buffer0[rx_wr_index0]=data;
	MOV  R26,R7
	LDI  R27,0
	SUBI R26,LOW(-_rx_buffer0)
	SBCI R27,HIGH(-_rx_buffer0)
	ST   X,R17
;      51    if (++rx_wr_index0 == RX_BUFFER_SIZE0) rx_wr_index0=0;
	INC  R7
	LDI  R30,LOW(8)
	CP   R30,R7
	BREQ PC+2
	RJMP _0x4
	CLR  R7
;      52    if (++rx_counter0 == RX_BUFFER_SIZE0)
_0x4:
	INC  R9
	LDI  R30,LOW(8)
	CP   R30,R9
	BREQ PC+2
	RJMP _0x5
;      53       {
;      54       rx_counter0=0;
	CLR  R9
;      55       rx_buffer_overflow0=1;
	SBI  0x1E,0
;      56       };
_0x5:
;      57    };
_0x3:
;      58 }
	RCALL __LOADLOCR2P
	LD   R30,Y+
	OUT  SREG,R30
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	RETI
;      59 
;      60 #ifndef _DEBUG_TERMINAL_IO_
;      61 // Get a character from the USART Receiver buffer
;      62 #define _ALTERNATE_GETCHAR_
;      63 #pragma used+
;      64 char getchar(void)
;      65 {
_getchar:
;      66 char data;
;      67 while (rx_counter0==0);
	ST   -Y,R16
;	data -> R16
_0x6:
	TST  R9
	BREQ PC+2
	RJMP _0x8
	RJMP _0x6
_0x8:
;      68 data=rx_buffer0[rx_rd_index0];
	MOV  R30,R8
	RCALL SUBOPT_0x0
	SUBI R30,LOW(-_rx_buffer0)
	SBCI R31,HIGH(-_rx_buffer0)
	LD   R16,Z
;      69 if (++rx_rd_index0 == RX_BUFFER_SIZE0) rx_rd_index0=0;
	INC  R8
	LDI  R30,LOW(8)
	CP   R30,R8
	BREQ PC+2
	RJMP _0x9
	CLR  R8
;      70 #asm("cli")
_0x9:
	cli
;      71 --rx_counter0;
	DEC  R9
;      72 #asm("sei")
	sei
;      73 return data;
	MOV  R30,R16
	LD   R16,Y+
	RET
;      74 }
;      75 #pragma used-
;      76 #endif
;      77 
;      78 // USART Transmitter buffer
;      79 #define TX_BUFFER_SIZE0 8
;      80 char tx_buffer0[TX_BUFFER_SIZE0];

	.DSEG
_tx_buffer0:
	.BYTE 0x8
;      81 
;      82 #if TX_BUFFER_SIZE0<256
;      83 unsigned char tx_wr_index0,tx_rd_index0,tx_counter0;
;      84 #else
;      85 unsigned int tx_wr_index0,tx_rd_index0,tx_counter0;
;      86 #endif
;      87 
;      88 // USART Transmitter interrupt service routine
;      89 interrupt [USART_TXC] void usart_tx_isr(void)
;      90 {

	.CSEG
_usart_tx_isr:
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
;      91 if (tx_counter0)
	TST  R12
	BRNE PC+2
	RJMP _0xA
;      92    {
;      93    --tx_counter0;
	DEC  R12
;      94    UDR0=tx_buffer0[tx_rd_index0];
	MOV  R30,R11
	RCALL SUBOPT_0x0
	SUBI R30,LOW(-_tx_buffer0)
	SBCI R31,HIGH(-_tx_buffer0)
	LD   R30,Z
	STS  198,R30
;      95    if (++tx_rd_index0 == TX_BUFFER_SIZE0) tx_rd_index0=0;
	INC  R11
	LDI  R30,LOW(8)
	CP   R30,R11
	BREQ PC+2
	RJMP _0xB
	CLR  R11
;      96    };
_0xB:
_0xA:
;      97 }
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	RETI
;      98 
;      99 #ifndef _DEBUG_TERMINAL_IO_
;     100 // Write a character to the USART Transmitter buffer
;     101 #define _ALTERNATE_PUTCHAR_
;     102 #pragma used+
;     103 void putchar(char c)
;     104 {
_putchar:
;     105 while (tx_counter0 == TX_BUFFER_SIZE0);
;	c -> Y+0
_0xC:
	LDI  R30,LOW(8)
	CP   R30,R12
	BREQ PC+2
	RJMP _0xE
	RJMP _0xC
_0xE:
;     106 #asm("cli")
	cli
;     107 if (tx_counter0 || ((UCSR0A & DATA_REGISTER_EMPTY)==0))
	TST  R12
	BREQ PC+2
	RJMP _0x10
	LDS  R30,192
	ANDI R30,LOW(0x20)
	BRNE PC+2
	RJMP _0x10
	RJMP _0xF
_0x10:
;     108    {
;     109    tx_buffer0[tx_wr_index0]=c;
	MOV  R30,R10
	RCALL SUBOPT_0x0
	SUBI R30,LOW(-_tx_buffer0)
	SBCI R31,HIGH(-_tx_buffer0)
	LD   R26,Y
	STD  Z+0,R26
;     110    if (++tx_wr_index0 == TX_BUFFER_SIZE0) tx_wr_index0=0;
	INC  R10
	LDI  R30,LOW(8)
	CP   R30,R10
	BREQ PC+2
	RJMP _0x12
	CLR  R10
;     111    ++tx_counter0;
_0x12:
	INC  R12
;     112    }
;     113 else
	RJMP _0x13
_0xF:
;     114    UDR0=c;
	LD   R30,Y
	STS  198,R30
;     115 #asm("sei")
_0x13:
	sei
;     116 }
	ADIW R28,1
	RET
;     117 #pragma used-
;     118 #endif
;     119   //--------------------------------------------------------------------------------------------------------
;     120 //   unsigned char ME[]="$Hello my world";
;     121  #include <stdio.h>
;     122 // unsigned int count=0;
;     123 // // Timer 1 overflow interrupt service routine
;     124 // interrupt [TIM1_OVF] void timer1_ovf_isr(void)
;     125 // {
;     126 // // Reinitialize Timer 1 value
;     127 // 
;     128 // TCNT1H=0xFC;
;     129 // TCNT1L=0xEC;  
;     130 // 
;     131 // count++;
;     132 // if(count==5)
;     133 // {
;     134 //  count=0;
;     135 // // Place your code here  
;     136 // j++;
;     137 // clear_lcd();
;     138 // lcd_cmd(0x80);
;     139 // lcd_puts(ME+j);
;     140 // //delay_ms(1000);
;     141 //   
;     142 // if(j==16)
;     143 // {
;     144 // j=0;
;     145 // }
;     146 // }
;     147 // } 
;     148 //------------------------------------------------------------------------------------------------------
;     149 #define ADC_VREF_TYPE 0x00
;     150 
;     151 // Read the AD conversion result
;     152 unsigned int read_adc(unsigned char adc_input)
;     153 {
;     154 ADMUX=adc_input|ADC_VREF_TYPE;
;	adc_input -> Y+0
;     155 // Start the AD conversion
;     156 ADCSRA|=0x40;
;     157 // Wait for the AD conversion to complete
;     158 while ((ADCSRA & 0x10)==0);
;     159 ADCSRA|=0x10;
;     160 return ADCW;
;     161 }
;     162 
;     163  unsigned char data=0;      
;     164  unsigned char stop=0;  
;     165  unsigned char cmd1[]="GPGLL,";

	.DSEG
_cmd1:
	.BYTE 0x7
;     166  unsigned char cmd2[]=",N,0";     
_cmd2:
	.BYTE 0x5
;     167  unsigned char cmd3[]="A00190D446A";    
_cmd3:
	.BYTE 0xC
;     168  unsigned char cmd4[]="A0019ADCC42"; 
_cmd4:
	.BYTE 0xC
;     169  unsigned char cmd5[]="A0018BFB12C";
_cmd5:
	.BYTE 0xC
;     170  unsigned char cmd6[]="A00190A7059";  
_cmd6:
	.BYTE 0xC
;     171  unsigned char LAT[9],LOG[9];    
_LAT:
	.BYTE 0x9
_LOG:
	.BYTE 0x9
;     172  unsigned char msg4[]="ip",ip[16],ipi[]=" Reading IP wait";
_msg4:
	.BYTE 0x3
_ip:
	.BYTE 0x10
_ipi:
	.BYTE 0x11
;     173        
;     174  
;     175  unsigned char cmd7[]="Rahul";
_cmd7:
	.BYTE 0x6
;     176  unsigned char cmd8[]="Siddarth";
_cmd8:
	.BYTE 0x9
;     177  unsigned char cmd9[]="Nikhil";
_cmd9:
	.BYTE 0x7
;     178  unsigned char cmd10[]="Suresh";
_cmd10:
	.BYTE 0x7
;     179  unsigned char cmd11[]="Ramesh";
_cmd11:
	.BYTE 0x7
;     180  unsigned char cmd12[]="Swipe Ur Card";    
_cmd12:
	.BYTE 0xE
;     181   unsigned char cmd13[]="Invalid";
_cmd13:
	.BYTE 0x8
;     182 unsigned char ME1[16];
_ME1:
	.BYTE 0x10
;     183  unsigned char cmp[12];     
_cmp:
	.BYTE 0xC
;     184  unsigned char buff[25]; 
_buff:
	.BYTE 0x19
;     185  void main(void) 
;     186       
;     187 {

	.CSEG
_main:
;     188 // Declare your local variables here
;     189 //unsigned char AR[]="hello welcome to mesoln";
;     190 //unsigned char n3[]="Lcd Testing";
;     191 // Crystal Oscillator division factor: 1
;     192 #pragma optsize-
;     193 CLKPR=0x80;
	LDI  R30,LOW(128)
	STS  97,R30
;     194 CLKPR=0x00;
	LDI  R30,LOW(0)
	STS  97,R30
;     195 #ifdef _OPTIMIZE_SIZE_
;     196 #pragma optsize+
;     197 #endif
;     198 
;     199 // Input/Output Ports initialization
;     200 // Port B initialization
;     201 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
;     202 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
;     203 PORTB=0x00;
	OUT  0x5,R30
;     204 DDRB=0x07;
	LDI  R30,LOW(7)
	OUT  0x4,R30
;     205 
;     206 // Port C initialization
;     207 // Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
;     208 // State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
;     209 PORTC=0x00;
	LDI  R30,LOW(0)
	OUT  0x8,R30
;     210 DDRC=0x33;
	LDI  R30,LOW(51)
	OUT  0x7,R30
;     211 
;     212 // Port D initialization
;     213 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
;     214 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
;     215 // PORTD=0x00;
;     216 // DDRD=0xf0;
;     217 PORTD=0x04;
	LDI  R30,LOW(4)
	OUT  0xB,R30
;     218 DDRD=0xF4;
	LDI  R30,LOW(244)
	OUT  0xA,R30
;     219 
;     220 
;     221 
;     222 // Timer/Counter 2 initialization
;     223 // Clock source: System Clock
;     224 // Clock value: Timer 2 Stopped
;     225 // Mode: Normal top=FFh
;     226 // OC2A output: Disconnected
;     227 // OC2B output: Disconnected
;     228 ASSR=0x00;
	LDI  R30,LOW(0)
	STS  182,R30
;     229 TCCR2A=0x00;
	STS  176,R30
;     230 TCCR2B=0x00;
	STS  177,R30
;     231 TCNT2=0x00;
	STS  178,R30
;     232 OCR2A=0x00;
	STS  179,R30
;     233 OCR2B=0x00;
	STS  180,R30
;     234 
;     235 // External Interrupt(s) initialization
;     236 // INT0: Off
;     237 // INT1: Off
;     238 // Interrupt on any change on pins PCINT0-7: Off
;     239 // Interrupt on any change on pins PCINT8-14: Off
;     240 // Interrupt on any change on pins PCINT16-23: Off
;     241 EICRA=0x00;
	STS  105,R30
;     242 EIMSK=0x00;
	OUT  0x1D,R30
;     243 PCICR=0x00;
	STS  104,R30
;     244 
;     245 
;     246 
;     247 // USART initialization
;     248 // Communication Parameters: 8 Data, 1 Stop, No Parity
;     249 // USART Receiver: On
;     250 // USART Transmitter: On
;     251 // USART0 Mode: Asynchronous
;     252 // USART Baud rate: 9600
;     253 UCSR0A=0x00;
	STS  192,R30
;     254 UCSR0B=0xD8;
	LDI  R30,LOW(216)
	STS  193,R30
;     255 UCSR0C=0x06;
	LDI  R30,LOW(6)
	STS  194,R30
;     256 UBRR0H=0x00;
	LDI  R30,LOW(0)
	STS  197,R30
;     257 UBRR0L=0x33;
	LDI  R30,LOW(51)
	STS  196,R30
;     258 
;     259 // // Timer/Counter 1 initialization
;     260 // // Clock source: System Clock
;     261 // // Clock value: 7.813 kHz
;     262 // // Mode: Normal top=FFFFh
;     263 // // OC1A output: Discon.
;     264 // // OC1B output: Discon.
;     265 // // Noise Canceler: Off
;     266 // // Input Capture on Falling Edge
;     267 // // Timer 1 Overflow Interrupt: On
;     268 // // Input Capture Interrupt: Off
;     269 // // Compare A Match Interrupt: Off
;     270 // // Compare B Match Interrupt: Off
;     271 // TCCR1A=0x00;
;     272 // TCCR1B=0x05;
;     273 // TCNT1H=0xFC;
;     274 // TCNT1L=0xEC;
;     275 // ICR1H=0x00;
;     276 // ICR1L=0x00;
;     277 // OCR1AH=0x00;
;     278 // OCR1AL=0x00;
;     279 // OCR1BH=0x00;
;     280 // OCR1BL=0x00;
;     281 
;     282 
;     283 
;     284 
;     285 // Analog Comparator initialization
;     286 // Analog Comparator: Off
;     287 // Analog Comparator Input Capture by Timer/Counter 1: Off        
;     288    
;     289 //------------------------------------------------------------------------------------------------------------
;     290 //----------------------------------------------------------------------------------------------------------
;     291 
;     292 ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x30,R30
;     293 ADCSRB=0x00;
	LDI  R30,LOW(0)
	STS  123,R30
;     294 //delay_ms(5000);     
;     295 #asm("sei")
	sei
;     296 //delay_ms(5000);
;     297   
;     298   PORTC.5=1;  
	SBI  0x8,5
;     299   PORTC.4=1;  
	SBI  0x8,4
;     300   
;     301 // printf("at \r"); 
;     302 // printf("at+cmgf=1\r");
;     303 // delay_ms(1000);
;     304 clear_lcd();
	RCALL SUBOPT_0x1
;     305 lcd_init();
;     306 lcd_cmd(0x80);
;     307 lcd_puts(cmd12);
	RCALL SUBOPT_0x2
;     308 delay_ms(5000);
	RCALL SUBOPT_0x3
;     309 clear_lcd();       
	RCALL _clear_lcd
;     310 
;     311 while(1)
_0x17:
;     312 {
;     313 lcd_cmd(0x80);
	RCALL SUBOPT_0x4
;     314 lcd_puts(cmd12);   
	RCALL SUBOPT_0x2
;     315 
;     316   PORTC.5=1;  
	SBI  0x8,5
;     317   PORTC.4=1;
	SBI  0x8,4
;     318   
;     319  if(rx_counter0>0)
	LDI  R30,LOW(0)
	CP   R30,R9
	BRLO PC+2
	RJMP _0x1A
;     320  {
;     321   while(getchar()!='3');
_0x1B:
	RCALL _getchar
	CPI  R30,LOW(0x33)
	BRNE PC+2
	RJMP _0x1D
	RJMP _0x1B
_0x1D:
;     322    
;     323  for(i=0;i<11;i++)
	CLR  R4
_0x1F:
	LDI  R30,LOW(11)
	CP   R4,R30
	BRLO PC+2
	RJMP _0x20
;     324   {   
;     325  cmp[i]=getchar();
	RCALL SUBOPT_0x5
	PUSH R31
	PUSH R30
	RCALL _getchar
	POP  R26
	POP  R27
	ST   X,R30
;     326  putchar(cmp[i]);
	RCALL SUBOPT_0x5
	RCALL SUBOPT_0x6
	RCALL _putchar
;     327  }
_0x1E:
	INC  R4
	RJMP _0x1F
_0x20:
;     328  cmp[11]='\0'; 
	LDI  R30,LOW(0)
	__PUTB1MN _cmp,11
;     329    //puts(cmp);   
;     330 
;     331    
;     332 //-----------------------------   
;     333   if(strcmp(cmp, cmd3)==0)
	RCALL SUBOPT_0x7
	LDI  R30,LOW(_cmd3)
	LDI  R31,HIGH(_cmd3)
	RCALL SUBOPT_0x8
	RCALL SUBOPT_0x9
	BREQ PC+2
	RJMP _0x21
;     334  { 
;     335 // puts(cmp); 
;     336 // printf("at \r"); 
;     337 // printf("at+cmgf=1\r");
;     338 // delay_ms(1000);
;     339 // printf("at+cfun=1\r");
;     340 // delay_ms(1000);
;     341 // printf("at+cmgs=");
;     342 // putchar('"'); 
;     343 // printf("9242838716");
;     344 // putchar('"');
;     345 // delay_ms(300);
;     346 // printf("\r");    
;     347 
;     348 clear_lcd();
	RCALL SUBOPT_0x1
;     349 lcd_init();
;     350 lcd_cmd(0x80);
;     351 lcd_puts(cmd7);
	LDI  R30,LOW(_cmd7)
	LDI  R31,HIGH(_cmd7)
	RCALL SUBOPT_0xA
;     352 delay_ms(1000);  
;     353 
;     354 gps();   
;     355 
;     356 
;     357 
;     358 } 
;     359 
;     360 // putchar(0x1a); 
;     361 // delay_ms(300);
;     362     
;     363 
;     364 //------------------------------
;     365 else
	RJMP _0x22
_0x21:
;     366   if(strcmp(cmp, cmd4)==0)
	RCALL SUBOPT_0x7
	LDI  R30,LOW(_cmd4)
	LDI  R31,HIGH(_cmd4)
	RCALL SUBOPT_0xB
	BREQ PC+2
	RJMP _0x23
;     367  {
;     368 //  printf("at \r"); 
;     369 // printf("at+cmgf=1\r");
;     370 // delay_ms(1000);
;     371 // printf("at+cfun=1\r");
;     372 // delay_ms(1000);
;     373 // printf("at+cmgs=");
;     374 // putchar('"'); 
;     375 // printf("9242838716");
;     376 // putchar('"');
;     377 // delay_ms(300);
;     378 // printf("\r");   
;     379 
;     380 
;     381 clear_lcd();
	RCALL SUBOPT_0x1
;     382 lcd_init();
;     383 lcd_cmd(0x80);
;     384 lcd_puts(cmd8);
	LDI  R30,LOW(_cmd8)
	LDI  R31,HIGH(_cmd8)
	RCALL SUBOPT_0xA
;     385 delay_ms(1000);    
;     386 
;     387 gps();  
;     388 
;     389 
;     390 
;     391 }       
;     392 
;     393 
;     394 // putchar(0x1a); 
;     395 // delay_ms(300);
;     396  
;     397  
;     398  //--------------------------------------- 
;     399  else
	RJMP _0x24
_0x23:
;     400   if(strcmp(cmp, cmd5)==0)
	RCALL SUBOPT_0x7
	LDI  R30,LOW(_cmd5)
	LDI  R31,HIGH(_cmd5)
	RCALL SUBOPT_0xB
	BREQ PC+2
	RJMP _0x25
;     401  {
;     402 // printf("at \r"); 
;     403 // printf("at+cmgf=1\r");
;     404 // delay_ms(1000);
;     405 // printf("at+cfun=1\r");
;     406 // delay_ms(1000);
;     407 // printf("at+cmgs=");
;     408 // putchar('"'); 
;     409 // printf("9242838716");
;     410 // putchar('"');
;     411 // delay_ms(300);
;     412 // printf("\r");     
;     413 
;     414 clear_lcd();
	RCALL SUBOPT_0x1
;     415 lcd_init();
;     416 lcd_cmd(0x80);
;     417 lcd_puts(cmd9);
	LDI  R30,LOW(_cmd9)
	LDI  R31,HIGH(_cmd9)
	RCALL SUBOPT_0xA
;     418 delay_ms(1000); 
;     419 
;     420 gps();     
;     421 
;     422 
;     423 
;     424 }  
;     425 
;     426 
;     427 
;     428 // putchar(0x1a); 
;     429 // delay_ms(300);
;     430     
;     431  //--------------------------------------     
;     432  else
	RJMP _0x26
_0x25:
;     433  if(strcmp(cmp, cmd6)==0)
	RCALL SUBOPT_0x7
	LDI  R30,LOW(_cmd6)
	LDI  R31,HIGH(_cmd6)
	RCALL SUBOPT_0xB
	BREQ PC+2
	RJMP _0x27
;     434  {
;     435 // printf("at \r"); 
;     436 // printf("at+cmgf=1\r");
;     437 // delay_ms(1000);
;     438 // printf("at+cfun=1\r");
;     439 // delay_ms(1000);
;     440 // printf("at+cmgs=");
;     441 // putchar('"'); 
;     442 // printf("9242838716");
;     443 // putchar('"');
;     444 // delay_ms(300);
;     445 // printf("\r"); 
;     446 
;     447 clear_lcd();
	RCALL SUBOPT_0x1
;     448 lcd_init();
;     449 lcd_cmd(0x80);
;     450 lcd_puts(cmd10);
	LDI  R30,LOW(_cmd10)
	LDI  R31,HIGH(_cmd10)
	RCALL SUBOPT_0xA
;     451 delay_ms(1000);    
;     452 
;     453 gps();     
;     454 
;     455 
;     456 
;     457 }  
;     458  
;     459 // putchar(0x1a); 
;     460 // delay_ms(300);
;     461   
;     462 //-------------- 
;     463  else
	RJMP _0x28
_0x27:
;     464  {
;     465 
;     466 clear_lcd();
	RCALL SUBOPT_0x1
;     467 lcd_init();
;     468 lcd_cmd(0x80);
;     469 lcd_puts(cmd13);
	LDI  R30,LOW(_cmd13)
	LDI  R31,HIGH(_cmd13)
	RCALL SUBOPT_0x8
	RCALL _lcd_puts
;     470 delay_ms(1000);
	RCALL SUBOPT_0xC
;     471  } 
_0x28:
_0x26:
_0x24:
_0x22:
;     472  }
;     473  };
_0x1A:
	RJMP _0x17
_0x19:
;     474 
;     475 }    
_0x29:
	RJMP _0x29
;     476 
;     477 void gps(void)
;     478 {
_gps:
;     479 delay_ms(300);
	RCALL SUBOPT_0xD
;     480 
;     481 PORTC.5=0; 
	CBI  0x8,5
;     482 PORTC.4=1;  
	SBI  0x8,4
;     483 
;     484 delay_ms(300);  
	RCALL SUBOPT_0xD
;     485 
;     486 while(stop!=1)
_0x2A:
	LDI  R30,LOW(1)
	CP   R30,R14
	BRNE PC+2
	RJMP _0x2C
;     487 {
;     488 if(rx_counter0>0)      
	LDI  R30,LOW(0)
	CP   R30,R9
	BRLO PC+2
	RJMP _0x2D
;     489  {
;     490  while(getchar()!='$');
_0x2E:
	RCALL _getchar
	CPI  R30,LOW(0x24)
	BRNE PC+2
	RJMP _0x30
	RJMP _0x2E
_0x30:
;     491  {
;     492 for(i=0;i<6;i++)
	CLR  R4
_0x32:
	LDI  R30,LOW(6)
	CP   R4,R30
	BRLO PC+2
	RJMP _0x33
;     493 {   
;     494  cmp[i]=getchar();
	RCALL SUBOPT_0x5
	PUSH R31
	PUSH R30
	RCALL _getchar
	POP  R26
	POP  R27
	ST   X,R30
;     495  }
_0x31:
	INC  R4
	RJMP _0x32
_0x33:
;     496  cmp[6]='\0'; 
	LDI  R30,LOW(0)
	__PUTB1MN _cmp,6
;     497 }
;     498   if (strcmp(cmp, cmd1)==0)   
	RCALL SUBOPT_0x7
	LDI  R30,LOW(_cmd1)
	LDI  R31,HIGH(_cmd1)
	RCALL SUBOPT_0xB
	BREQ PC+2
	RJMP _0x34
;     499   { 
;     500   stop=0;   
	CLR  R14
;     501   for(j=0;j<24;j++)
	CLR  R5
_0x36:
	LDI  R30,LOW(24)
	CP   R5,R30
	BRLO PC+2
	RJMP _0x37
;     502   {
;     503   buff[j]=getchar();
	RCALL SUBOPT_0xE
	PUSH R31
	PUSH R30
	RCALL _getchar
	POP  R26
	POP  R27
	ST   X,R30
;     504   }  
_0x35:
	INC  R5
	RJMP _0x36
_0x37:
;     505   buff[24]='\0';     
	LDI  R30,LOW(0)
	__PUTB1MN _buff,24
;     506 
;     507 delay_ms(300); 
	RCALL SUBOPT_0xD
;     508 printf("at \r"); 
	__POINTW1FN _0,138
	RCALL SUBOPT_0xF
;     509 printf("at+cmgf=1\r");
	__POINTW1FN _0,143
	RCALL SUBOPT_0xF
;     510 delay_ms(1000);
	RCALL SUBOPT_0xC
;     511 printf("at+cfun=1\r");
	__POINTW1FN _0,154
	RCALL SUBOPT_0xF
;     512 delay_ms(1000);
	RCALL SUBOPT_0xC
;     513 printf("at+cmgs=");
	__POINTW1FN _0,165
	RCALL SUBOPT_0xF
;     514 putchar('"'); 
	LDI  R30,LOW(34)
	RCALL SUBOPT_0x10
;     515 printf("9242838716");
	__POINTW1FN _0,174
	RCALL SUBOPT_0xF
;     516 putchar('"');
	LDI  R30,LOW(34)
	RCALL SUBOPT_0x10
;     517 delay_ms(800);
	LDI  R30,LOW(800)
	LDI  R31,HIGH(800)
	RCALL SUBOPT_0x11
;     518 printf("\r"); 
	RCALL SUBOPT_0x12
;     519 delay_ms(300); 
	RCALL SUBOPT_0xD
;     520 printf("@LT");
	__POINTW1FN _0,185
	RCALL SUBOPT_0xF
;     521 clear_lcd();
	RCALL _clear_lcd
;     522 //lcd_init();
;     523 lcd_cmd(0x80);
	RCALL SUBOPT_0x4
;     524 for(j=0;j<9;j++)
	CLR  R5
_0x39:
	LDI  R30,LOW(9)
	CP   R5,R30
	BRLO PC+2
	RJMP _0x3A
;     525 {  
;     526   LOG[j]=buff[j];
	MOV  R26,R5
	LDI  R27,0
	SUBI R26,LOW(-_LOG)
	SBCI R27,HIGH(-_LOG)
	RCALL SUBOPT_0xE
	LD   R30,Z
	ST   X,R30
;     527   lcd_data(buff[j],0);
	RCALL SUBOPT_0xE
	RCALL SUBOPT_0x6
	LDI  R30,LOW(0)
	RCALL SUBOPT_0x13
;     528   putchar(buff[j]);
	RCALL SUBOPT_0xE
	RCALL SUBOPT_0x6
	RCALL _putchar
;     529 //delay_ms(1000);
;     530 } 
_0x38:
	INC  R5
	RJMP _0x39
_0x3A:
;     531 //LAT[9]='/0';
;     532 
;     533 //lcd_puts(LAT);
;     534 printf("LG");  
	__POINTW1FN _0,189
	RCALL SUBOPT_0xF
;     535 
;     536 lcd_cmd(0xC0);
	LDI  R30,LOW(192)
	RCALL SUBOPT_0x14
;     537 
;     538 for(j=14;j<23;j++)
	LDI  R30,LOW(14)
	MOV  R5,R30
_0x3C:
	LDI  R30,LOW(23)
	CP   R5,R30
	BRLO PC+2
	RJMP _0x3D
;     539 {   
;     540 //lcd_init();
;     541   putchar(buff[j]);
	RCALL SUBOPT_0xE
	RCALL SUBOPT_0x6
	RCALL _putchar
;     542   lcd_data(buff[j],0);
	RCALL SUBOPT_0xE
	RCALL SUBOPT_0x6
	LDI  R30,LOW(0)
	RCALL SUBOPT_0x13
;     543 LOG[14-j]=buff[j];
	LDI  R30,LOW(14)
	SUB  R30,R5
	RCALL SUBOPT_0x0
	SUBI R30,LOW(-_LOG)
	SBCI R31,HIGH(-_LOG)
	MOVW R26,R30
	RCALL SUBOPT_0xE
	LD   R30,Z
	ST   X,R30
;     544 } 
_0x3B:
	INC  R5
	RJMP _0x3C
_0x3D:
;     545 
;     546 
;     547 
;     548 //LOG[9]='/0';
;     549 //lcd_cmd(0xC0);
;     550 //lcd_puts(LOG);
;     551 delay_ms(1000);
	RCALL SUBOPT_0xC
;     552 putchar(0x1a); 
	LDI  R30,LOW(26)
	RCALL SUBOPT_0x10
;     553 //delay_ms(8000); 
;     554 
;     555 //delay_ms(1000);     
;     556 delay_ms(20000); 
	LDI  R30,LOW(20000)
	LDI  R31,HIGH(20000)
	RCALL SUBOPT_0x11
;     557   gprs(); 
	RCALL _gprs
;     558   delay_ms(5000); 
	RCALL SUBOPT_0x3
;     559   send_cmd();
	RCALL _send_cmd
;     560   printf("@LT");
	__POINTW1FN _0,185
	RCALL SUBOPT_0xF
;     561 clear_lcd();
	RCALL _clear_lcd
;     562 //lcd_init();
;     563 //lcd_cmd(0x80);
;     564 for(j=0;j<9;j++)
	CLR  R5
_0x3F:
	LDI  R30,LOW(9)
	CP   R5,R30
	BRLO PC+2
	RJMP _0x40
;     565 {  
;     566   //LOG[j]=buff[j];
;     567   //lcd_data(buff[j],0);
;     568   putchar(buff[j]);
	RCALL SUBOPT_0xE
	RCALL SUBOPT_0x6
	RCALL _putchar
;     569 //delay_ms(1000);
;     570 } 
_0x3E:
	INC  R5
	RJMP _0x3F
_0x40:
;     571 //LAT[9]='/0';
;     572 
;     573 //lcd_puts(LAT);
;     574 printf("LG");  
	__POINTW1FN _0,189
	RCALL SUBOPT_0xF
;     575 
;     576 //lcd_cmd(0xC0);
;     577 
;     578 for(j=14;j<23;j++)
	LDI  R30,LOW(14)
	MOV  R5,R30
_0x42:
	LDI  R30,LOW(23)
	CP   R5,R30
	BRLO PC+2
	RJMP _0x43
;     579 {   
;     580 //lcd_init();
;     581   putchar(buff[j]);
	RCALL SUBOPT_0xE
	RCALL SUBOPT_0x6
	RCALL _putchar
;     582   //lcd_data(buff[j],0);
;     583 //LOG[14-j]=buff[j];
;     584 }
_0x41:
	INC  R5
	RJMP _0x42
_0x43:
;     585 latch_cmd();
	RCALL _latch_cmd
;     586 delay_ms(5000);
	RCALL SUBOPT_0x3
;     587 clear_lcd();
	RCALL _clear_lcd
;     588 
;     589 }
;     590 }    
_0x34:
;     591 }
_0x2D:
	RJMP _0x2A
_0x2C:
;     592 }   
	RET
;     593 
;     594 
;     595 void send_cmd(void)
;     596 {  
_send_cmd:
;     597  printf("AT\r");
	__POINTW1FN _0,192
	RCALL SUBOPT_0xF
;     598   delay_ms(100);
	RCALL SUBOPT_0x15
;     599   printf("AT+CMGF=1\r");
	__POINTW1FN _0,196
	RCALL SUBOPT_0xF
;     600   delay_ms(100);
	RCALL SUBOPT_0x15
;     601  printf("AT+CIPSEND");
	__POINTW1FN _0,207
	RCALL SUBOPT_0xF
;     602  //delay_ms(1000); 
;     603  printf("\r"); 
	RCALL SUBOPT_0x12
;     604  delay_ms(1000); 
	RCALL SUBOPT_0xC
;     605 }  
	RET
;     606  
;     607 void latch_cmd(void)
;     608 {
_latch_cmd:
;     609  delay_ms(1000);
	RCALL SUBOPT_0xC
;     610  putchar(0x1A);  
	LDI  R30,LOW(26)
	RCALL SUBOPT_0x10
;     611  delay_ms(3000);
	LDI  R30,LOW(3000)
	LDI  R31,HIGH(3000)
	RCALL SUBOPT_0x11
;     612 //  printf("AT\r");
;     613 //   delay_ms(1000);
;     614 //   printf("AT+CMGF=1\r");
;     615 //   delay_ms(1000); 
;     616 }
	RET
;     617              
;     618 
;     619 void gprs(void) 
;     620 {  
_gprs:
;     621 delay_ms(300);       
	RCALL SUBOPT_0xD
;     622 PORTC.5=0; 
	CBI  0x8,5
;     623 PORTC.4=0;   
	CBI  0x8,4
;     624 delay_ms(300);      
	RCALL SUBOPT_0xD
;     625 
;     626  clear_lcd();
	RCALL _clear_lcd
;     627  lcd_cmd(0x80);
	RCALL SUBOPT_0x4
;     628  lcd_puts(ipi);
	LDI  R30,LOW(_ipi)
	LDI  R31,HIGH(_ipi)
	RCALL SUBOPT_0x8
	RCALL _lcd_puts
;     629  delay_ms(300);
	RCALL SUBOPT_0xD
;     630  printf("AT"); 
	__POINTW1FN _0,218
	RCALL SUBOPT_0xF
;     631  delay_ms(1000);
	RCALL SUBOPT_0xC
;     632  printf("\r");   
	RCALL SUBOPT_0x12
;     633  printf("AT+CMGF=1"); 
	__POINTW1FN _0,221
	RCALL SUBOPT_0xF
;     634  delay_ms(1000);
	RCALL SUBOPT_0xC
;     635  printf("\r");
	RCALL SUBOPT_0x12
;     636  delay_ms(1000);
	RCALL SUBOPT_0xC
;     637  printf("AT+CIPSERVER=1,1234"); 
	__POINTW1FN _0,231
	RCALL SUBOPT_0xF
;     638  delay_ms(1000);
	RCALL SUBOPT_0xC
;     639  printf("\n\r");
	__POINTW1FN _0,251
	RCALL SUBOPT_0xF
;     640  while(getchar()!='K'); 
_0x44:
	RCALL _getchar
	CPI  R30,LOW(0x4B)
	BRNE PC+2
	RJMP _0x46
	RJMP _0x44
_0x46:
;     641  while(getchar()!='K'); 
_0x47:
	RCALL _getchar
	CPI  R30,LOW(0x4B)
	BRNE PC+2
	RJMP _0x49
	RJMP _0x47
_0x49:
;     642  delay_ms(300); 
	RCALL SUBOPT_0xD
;     643  printf("at+cifsr");  
	__POINTW1FN _0,254
	RCALL SUBOPT_0xF
;     644  delay_ms(1000);
	RCALL SUBOPT_0xC
;     645  printf("\r");
	RCALL SUBOPT_0x12
;     646  while(getchar()!=0x0A); 
_0x4A:
	RCALL _getchar
	CPI  R30,LOW(0xA)
	BRNE PC+2
	RJMP _0x4C
	RJMP _0x4A
_0x4C:
;     647  clear_lcd();  
	RCALL _clear_lcd
;     648  lcd_cmd(0x80);
	RCALL SUBOPT_0x4
;     649  for(i=0;i<16;i++)
	CLR  R4
_0x4E:
	LDI  R30,LOW(16)
	CP   R4,R30
	BRLO PC+2
	RJMP _0x4F
;     650  {
;     651   ip[i]=getchar();     
	RCALL SUBOPT_0x16
	PUSH R31
	PUSH R30
	RCALL _getchar
	POP  R26
	POP  R27
	ST   X,R30
;     652   lcd_data(ip[i],1);
	RCALL SUBOPT_0x16
	RCALL SUBOPT_0x6
	LDI  R30,LOW(1)
	RCALL SUBOPT_0x13
;     653 //   if(ip[i]==0x0D) 
;     654 //  { 
;     655 //   rlt();
;     656 //   for(i=0;i<16;i++)
;     657 //  {
;     658 //   putchar(ip[i]);
;     659 //  }
;     660 //  printf("\r");
;     661 //   rlt1(); 
;     662 //   delay_ms(1000);
;     663 //   break;
;     664 //  } 
;     665  }  
_0x4D:
	INC  R4
	RJMP _0x4E
_0x4F:
;     666 }
	RET
;     667  #include <mega48.h> 
;     668   #include <delay.h>         
;     669 //#include <prototype.h> 
;     670 #include <lcd16x1.h> 
;     671 #include <stdlib.h>
;     672 #include <stdio.h>  
;     673 //#include<prototype.h>     
;     674 //#define INT0_PIN PIND.2         //int0 pin PD.2
;     675 //#define INT1_PIN PIND.3         //int1 pin PD.3
;     676 
;     677 #define RS PORTB.0
;     678 #define RW PORTB.1    //lcd defines
;     679 #define EN PORTB.2  
;     680                         
;     681          
;     682 
;     683 //function to clear the lcd & start from first row first column onwards       
;     684 void clear_lcd(void)
;     685 {
_clear_lcd:
;     686        lcd_cmd(0x01);
	LDI  R30,LOW(1)
	RCALL SUBOPT_0x14
;     687        //lcd_cmd(0x80);   //clear screen n start from fist line first column
;     688        lcd_cmd(0x06);     //incremental cursor
	LDI  R30,LOW(6)
	RCALL SUBOPT_0x14
;     689 }
	RET
;     690 
;     691 //lcd initialization function for 4 datalines    
;     692  void lcd_init(void)
;     693  {
_lcd_init:
;     694         delay_ms(15);               //startup delay
	LDI  R30,LOW(15)
	LDI  R31,HIGH(15)
	RCALL SUBOPT_0x11
;     695                   lcd_cmd(0x03);
	LDI  R30,LOW(3)
	RCALL SUBOPT_0x14
;     696         delay_ms(5);     
	LDI  R30,LOW(5)
	LDI  R31,HIGH(5)
	RCALL SUBOPT_0x11
;     697                   lcd_cmd(0x03);
	LDI  R30,LOW(3)
	RCALL SUBOPT_0x14
;     698         delay_us(160);     
	RCALL SUBOPT_0x17
;     699                   lcd_cmd(0x03);
	LDI  R30,LOW(3)
	RCALL SUBOPT_0x14
;     700         delay_us(160);            
	RCALL SUBOPT_0x17
;     701                   lcd_cmd(0x02);
	LDI  R30,LOW(2)
	RCALL SUBOPT_0x14
;     702        delay_us(160);  
	RCALL SUBOPT_0x17
;     703                   lcd_cmd(0x28);         //4 bit data , 5*7, 2 line..   //the abouve cmds are necessary
	LDI  R30,LOW(40)
	RCALL SUBOPT_0x14
;     704        delay_ms(100);                    
	RCALL SUBOPT_0x15
;     705                   lcd_cmd(0x60);         // set CGRAM addr
	LDI  R30,LOW(96)
	RCALL SUBOPT_0x14
;     706        delay_ms(100);           
	RCALL SUBOPT_0x15
;     707          lcd_cmd(0x0C); 
	LDI  R30,LOW(12)
	RCALL SUBOPT_0x14
;     708        delay_ms(1);                          
	RCALL SUBOPT_0x18
;     709                   lcd_cmd(0x06);       //increment cursor no shift
	LDI  R30,LOW(6)
	RCALL SUBOPT_0x14
;     710        delay_ms(1);           
	RCALL SUBOPT_0x18
;     711                   lcd_cmd(0x90);       // 1st column 1st char
	LDI  R30,LOW(144)
	RCALL SUBOPT_0x14
;     712         delay_ms(1);                                        
	RCALL SUBOPT_0x18
;     713                   lcd_cmd(0x01);       //clear lcd
	LDI  R30,LOW(1)
	RCALL SUBOPT_0x14
;     714         delay_ms(2);                              
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	RCALL SUBOPT_0x11
;     715   }
	RET
;     716   //to send lcd commands
;     717 void lcd_cmd(unsigned char inst)
;     718 {
_lcd_cmd:
;     719 
;     720        unsigned char lsb=0,msb=0;
;     721         lsb=inst&0x0F;        //split msb n lsb nibbles
	RCALL __SAVELOCR2
;	inst -> Y+2
;	lsb -> R16
;	msb -> R17
	LDI  R16,0
	LDI  R17,0
	LDD  R30,Y+2
	ANDI R30,LOW(0xF)
	MOV  R16,R30
;     722         msb=inst>>4; 
	LDD  R30,Y+2
	SWAP R30
	ANDI R30,0xF
	MOV  R17,R30
;     723         msb&=0x0F;   
	ANDI R17,LOW(15)
;     724         lsb=lsb&0X0F;
	ANDI R16,LOW(15)
;     725         msb=msb<<4;
	SWAP R17
	ANDI R17,0xF0
;     726         lsb=lsb<<4;
	SWAP R16
	ANDI R16,0xF0
;     727         delay_us(500);            //busy check duration       500
	__DELAY_USW 1000
;     728         RS=0;
	CBI  0x5,0
;     729         RW=0;    
	RCALL SUBOPT_0x19
;     730         EN=1;     
;     731         PORTD&=0x0F; 
;     732         PORTD|=msb; 
;     733         delay_us(5);         //6 nops       changed from 10u to 5u
;     734         EN=0;
;     735         delay_us(5);         //6 nops
;     736         EN=1;
;     737         PORTD&=0x0F;        //sending lsb now       
;     738         PORTD|=lsb; 
;     739         delay_us(5);         //6 nops
;     740         EN=0;
;     741      }   
	RCALL __LOADLOCR2
	ADIW R28,3
	RET
;     742                
;     743 //function to send data to lcd
;     744  void lcd_data(unsigned char data1,unsigned char type)
;     745  {      
_lcd_data:
;     746       unsigned char lsbc,msbc,temp,a; 
;     747       type=a;
	RCALL __SAVELOCR4
;	data1 -> Y+5
;	type -> Y+4
;	lsbc -> R16
;	msbc -> R17
;	temp -> R18
;	a -> R19
	STD  Y+4,R19
;     748       temp=0;lsbc=0;msbc=0;
	LDI  R18,LOW(0)
	LDI  R16,LOW(0)
	LDI  R17,LOW(0)
;     749       msbc=data1&0xF0;      //msb n lsb split
	LDD  R30,Y+5
	ANDI R30,LOW(0xF0)
	MOV  R17,R30
;     750       lsbc=data1<<4;
	LDD  R30,Y+5
	SWAP R30
	ANDI R30,0xF0
	MOV  R16,R30
;     751       delay_us(600);            //busy check duration       prev 600
	__DELAY_USW 1200
;     752       RS=1;
	SBI  0x5,0
;     753       RW=0;     
	RCALL SUBOPT_0x19
;     754       EN=1;
;     755       PORTD&=0x0F; 
;     756       PORTD|=msbc;         // this being moved to the lsbbits of port instead of msb...
;     757       delay_us(5);        
;     758       EN=0 ;                   
;     759       delay_us(5);        
;     760       EN=1;
;     761       PORTD&=0x0F;
;     762       PORTD|=lsbc;        
;     763       delay_us(5);        
;     764       EN=0;     
;     765 } 
	RCALL __LOADLOCR4
	ADIW R28,6
	RET
;     766             
;     767  
;     768 //function to put string onto lcd     
;     769 void lcd_puts(unsigned char *str)
;     770 {
_lcd_puts:
;     771   while(*str !='\0') 
;	*str -> Y+0
_0x50:
	LD   R26,Y
	LDD  R27,Y+1
	LD   R30,X
	CPI  R30,0
	BRNE PC+2
	RJMP _0x52
;     772          {
;     773            lcd_data(*str,1);
	RCALL SUBOPT_0x1A
	LD   R30,X
	ST   -Y,R30
	LDI  R30,LOW(1)
	RCALL SUBOPT_0x13
;     774              *str++;
	RCALL SUBOPT_0x1A
	LD   R30,X+
	ST   Y,R26
	STD  Y+1,R27
;     775           }
	RJMP _0x50
_0x52:
;     776 }
	ADIW R28,2
	RET
;     777 
;     778 
;     779 
;     780 
;     781 //function to convert int to ascii for dispaly on lcd / serial port          
;     782 //  //calculate the ascii values to be displayed on lcd  3 digit int to 3 digit ascii
;     783 // void cal_ascii(unsigned int value)   
;     784 // { 
;     785 //        unsigned char lb,mb,mmlb;
;     786 //        mmlb=(((unsigned char)(value/100))|0x30);
;     787 //        mb=(unsigned char)(value/10);  
;     788 //        mb=(((unsigned char)(mb%10))|0x30);
;     789 //        lb=(((unsigned char)(value%10))|0x30);
;     790 //       
;     791 //       if(value>99){ lcd_data(mmlb,1);lcd_data(mb,1);lcd_data(lb,1); }
;     792 //       else if (value >9){lcd_data(mb,1);lcd_data(lb,1); }
;     793 //       else 
;     794 //       {   
;     795 //       lcd_data(0x30,1);
;     796 //       lcd_data(lb,1); 
;     797 //       }
;     798 // }                       
;     799 
;     800 

__put_G5:
	RCALL SUBOPT_0x1A
	RCALL __GETW1P
	SBIW R30,0
	BRNE PC+2
	RJMP _0x53
	RCALL SUBOPT_0x1A
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	SBIW R30,1
	LDD  R26,Y+2
	STD  Z+0,R26
	RJMP _0x54
_0x53:
	LDD  R30,Y+2
	RCALL SUBOPT_0x10
_0x54:
	ADIW R28,3
	RET
__print_G5:
	SBIW R28,6
	RCALL __SAVELOCR6
	LDI  R16,0
_0x55:
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	ADIW R30,1
	STD  Y+16,R30
	STD  Y+16+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R19,R30
	CPI  R30,0
	BRNE PC+2
	RJMP _0x57
	MOV  R30,R16
	CPI  R30,0
	BREQ PC+2
	RJMP _0x5B
	CPI  R19,37
	BREQ PC+2
	RJMP _0x5C
	LDI  R16,LOW(1)
	RJMP _0x5D
_0x5C:
	RCALL SUBOPT_0x1B
_0x5D:
	RJMP _0x5A
_0x5B:
	CPI  R30,LOW(0x1)
	BREQ PC+2
	RJMP _0x5E
	CPI  R19,37
	BREQ PC+2
	RJMP _0x5F
	RCALL SUBOPT_0x1B
	LDI  R16,LOW(0)
	RJMP _0x5A
_0x5F:
	LDI  R16,LOW(2)
	LDI  R21,LOW(0)
	LDI  R17,LOW(0)
	CPI  R19,45
	BREQ PC+2
	RJMP _0x60
	LDI  R17,LOW(1)
	RJMP _0x5A
_0x60:
	CPI  R19,43
	BREQ PC+2
	RJMP _0x61
	LDI  R21,LOW(43)
	RJMP _0x5A
_0x61:
	CPI  R19,32
	BREQ PC+2
	RJMP _0x62
	LDI  R21,LOW(32)
	RJMP _0x5A
_0x62:
	RJMP _0x63
_0x5E:
	CPI  R30,LOW(0x2)
	BREQ PC+2
	RJMP _0x64
_0x63:
	LDI  R20,LOW(0)
	LDI  R16,LOW(3)
	CPI  R19,48
	BREQ PC+2
	RJMP _0x65
	ORI  R17,LOW(128)
	RJMP _0x5A
_0x65:
	RJMP _0x66
_0x64:
	CPI  R30,LOW(0x3)
	BREQ PC+2
	RJMP _0x5A
_0x66:
	CPI  R19,48
	BRSH PC+2
	RJMP _0x69
	CPI  R19,58
	BRLO PC+2
	RJMP _0x69
	RJMP _0x6A
_0x69:
	RJMP _0x68
_0x6A:
	MOV  R26,R20
	LDI  R30,LOW(10)
	MUL  R30,R26
	MOVW R30,R0
	MOV  R20,R30
	MOV  R30,R19
	SUBI R30,LOW(48)
	ADD  R20,R30
	RJMP _0x5A
_0x68:
	MOV  R30,R19
	CPI  R30,LOW(0x63)
	BREQ PC+2
	RJMP _0x6E
	RCALL SUBOPT_0x1C
	LD   R30,X
	RCALL SUBOPT_0x1D
	RJMP _0x6F
	RJMP _0x70
_0x6E:
	CPI  R30,LOW(0x73)
	BREQ PC+2
	RJMP _0x71
_0x70:
	RCALL SUBOPT_0x1C
	RCALL SUBOPT_0x1E
	RCALL _strlen
	MOV  R16,R30
	RJMP _0x72
	RJMP _0x73
_0x71:
	CPI  R30,LOW(0x70)
	BREQ PC+2
	RJMP _0x74
_0x73:
	RCALL SUBOPT_0x1C
	RCALL SUBOPT_0x1E
	RCALL _strlenf
	MOV  R16,R30
	ORI  R17,LOW(8)
_0x72:
	ORI  R17,LOW(2)
	ANDI R17,LOW(127)
	LDI  R18,LOW(0)
	RJMP _0x75
	RJMP _0x76
_0x74:
	CPI  R30,LOW(0x64)
	BREQ PC+2
	RJMP _0x77
_0x76:
	RJMP _0x78
_0x77:
	CPI  R30,LOW(0x69)
	BREQ PC+2
	RJMP _0x79
_0x78:
	ORI  R17,LOW(4)
	RJMP _0x7A
_0x79:
	CPI  R30,LOW(0x75)
	BREQ PC+2
	RJMP _0x7B
_0x7A:
	LDI  R30,LOW(_tbl10_G5*2)
	LDI  R31,HIGH(_tbl10_G5*2)
	RCALL SUBOPT_0x1F
	LDI  R16,LOW(5)
	RJMP _0x7C
	RJMP _0x7D
_0x7B:
	CPI  R30,LOW(0x58)
	BREQ PC+2
	RJMP _0x7E
_0x7D:
	ORI  R17,LOW(8)
	RJMP _0x7F
_0x7E:
	CPI  R30,LOW(0x78)
	BREQ PC+2
	RJMP _0xB0
_0x7F:
	LDI  R30,LOW(_tbl16_G5*2)
	LDI  R31,HIGH(_tbl16_G5*2)
	RCALL SUBOPT_0x1F
	LDI  R16,LOW(4)
_0x7C:
	SBRS R17,2
	RJMP _0x81
	RCALL SUBOPT_0x1C
	RCALL __GETW1P
	RCALL SUBOPT_0x20
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	SBIW R26,0
	BRLT PC+2
	RJMP _0x82
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	RCALL __ANEGW1
	RCALL SUBOPT_0x20
	LDI  R21,LOW(45)
_0x82:
	CPI  R21,0
	BRNE PC+2
	RJMP _0x83
	SUBI R16,-LOW(1)
	RJMP _0x84
_0x83:
	ANDI R17,LOW(251)
_0x84:
	RJMP _0x85
_0x81:
	RCALL SUBOPT_0x1C
	RCALL __GETW1P
	RCALL SUBOPT_0x20
_0x85:
_0x75:
	SBRC R17,0
	RJMP _0x86
_0x87:
	CP   R16,R20
	BRLO PC+2
	RJMP _0x89
	SBRS R17,7
	RJMP _0x8A
	SBRS R17,2
	RJMP _0x8B
	ANDI R17,LOW(251)
	MOV  R19,R21
	SUBI R16,LOW(1)
	RJMP _0x8C
_0x8B:
	LDI  R19,LOW(48)
_0x8C:
	RJMP _0x8D
_0x8A:
	LDI  R19,LOW(32)
_0x8D:
	RCALL SUBOPT_0x1B
	SUBI R20,LOW(1)
	RJMP _0x87
_0x89:
_0x86:
	MOV  R18,R16
	SBRS R17,1
	RJMP _0x8E
_0x8F:
	CPI  R18,0
	BRNE PC+2
	RJMP _0x91
	SBRS R17,3
	RJMP _0x92
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,1
	RCALL SUBOPT_0x1F
	SBIW R30,1
	LPM  R30,Z
	RCALL SUBOPT_0x1D
	RJMP _0x93
_0x92:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R30,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
	RCALL SUBOPT_0x1D
_0x93:
	CPI  R20,0
	BRNE PC+2
	RJMP _0x94
	SUBI R20,LOW(1)
_0x94:
	SUBI R18,LOW(1)
	RJMP _0x8F
_0x91:
	RJMP _0x95
_0x8E:
_0x97:
	LDI  R19,LOW(48)
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,2
	RCALL SUBOPT_0x1F
	SBIW R30,2
	RCALL __GETW1PF
	STD  Y+8,R30
	STD  Y+8+1,R31
_0x99:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CP   R26,R30
	CPC  R27,R31
	BRSH PC+2
	RJMP _0x9B
	SUBI R19,-LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	SUB  R30,R26
	SBC  R31,R27
	RCALL SUBOPT_0x20
	RJMP _0x99
_0x9B:
	CPI  R19,58
	BRSH PC+2
	RJMP _0x9C
	SBRS R17,3
	RJMP _0x9D
	SUBI R19,-LOW(7)
	RJMP _0x9E
_0x9D:
	SUBI R19,-LOW(39)
_0x9E:
_0x9C:
	SBRS R17,4
	RJMP _0x9F
	RJMP _0xA0
_0x9F:
	CPI  R19,49
	BRLO PC+2
	RJMP _0xA2
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE PC+2
	RJMP _0xA2
	RJMP _0xA1
_0xA2:
	ORI  R17,LOW(16)
	RJMP _0xA4
_0xA1:
	CP   R20,R18
	BRSH PC+2
	RJMP _0xA6
	SBRC R17,0
	RJMP _0xA6
	RJMP _0xA7
_0xA6:
	RJMP _0xA5
_0xA7:
	LDI  R19,LOW(32)
	SBRS R17,7
	RJMP _0xA8
	LDI  R19,LOW(48)
	ORI  R17,LOW(16)
_0xA4:
	SBRS R17,2
	RJMP _0xA9
	ANDI R17,LOW(251)
	ST   -Y,R21
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	RCALL SUBOPT_0x8
	RCALL __put_G5
	CPI  R20,0
	BRNE PC+2
	RJMP _0xAA
	SUBI R20,LOW(1)
_0xAA:
_0xA9:
_0xA8:
_0xA0:
	RCALL SUBOPT_0x1B
	CPI  R20,0
	BRNE PC+2
	RJMP _0xAB
	SUBI R20,LOW(1)
_0xAB:
_0xA5:
	SUBI R18,LOW(1)
_0x96:
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,2
	BRSH PC+2
	RJMP _0x98
	RJMP _0x97
_0x98:
_0x95:
	SBRS R17,0
	RJMP _0xAC
_0xAD:
	CPI  R20,0
	BRNE PC+2
	RJMP _0xAF
	SUBI R20,LOW(1)
	LDI  R30,LOW(32)
	RCALL SUBOPT_0x1D
	RJMP _0xAD
_0xAF:
_0xAC:
_0xB0:
_0x6F:
	LDI  R16,LOW(0)
_0x6D:
_0x5A:
	RJMP _0x55
_0x57:
	RCALL __LOADLOCR6
	ADIW R28,18
	RET
_printf:
	PUSH R15
	MOV  R15,R24
	SBIW R28,2
	RCALL __SAVELOCR2
	MOVW R26,R28
	RCALL __ADDW2R15
	MOVW R16,R26
	LDI  R30,0
	STD  Y+2,R30
	STD  Y+2+1,R30
	MOVW R26,R28
	ADIW R26,4
	RCALL __ADDW2R15
	RCALL __GETW1P
	RCALL SUBOPT_0x8
	ST   -Y,R17
	ST   -Y,R16
	MOVW R30,R28
	ADIW R30,6
	RCALL SUBOPT_0x8
	RCALL __print_G5
	RCALL __LOADLOCR2
	ADIW R28,4
	POP  R15
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 18 TIMES, CODE SIZE REDUCTION:32 WORDS
SUBOPT_0x0:
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x1:
	RCALL _clear_lcd
	RCALL _lcd_init
	LDI  R30,LOW(128)
	ST   -Y,R30
	RJMP _lcd_cmd

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x2:
	LDI  R30,LOW(_cmd12)
	LDI  R31,HIGH(_cmd12)
	ST   -Y,R31
	ST   -Y,R30
	RJMP _lcd_puts

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x3:
	LDI  R30,LOW(5000)
	LDI  R31,HIGH(5000)
	ST   -Y,R31
	ST   -Y,R30
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x4:
	LDI  R30,LOW(128)
	ST   -Y,R30
	RJMP _lcd_cmd

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x5:
	MOV  R30,R4
	RCALL SUBOPT_0x0
	SUBI R30,LOW(-_cmp)
	SBCI R31,HIGH(-_cmp)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x6:
	LD   R30,Z
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x7:
	LDI  R30,LOW(_cmp)
	LDI  R31,HIGH(_cmp)
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 82 TIMES, CODE SIZE REDUCTION:79 WORDS
SUBOPT_0x8:
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x9:
	RCALL _strcmp
	CPI  R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:16 WORDS
SUBOPT_0xA:
	RCALL SUBOPT_0x8
	RCALL _lcd_puts
	LDI  R30,LOW(1000)
	LDI  R31,HIGH(1000)
	RCALL SUBOPT_0x8
	RCALL _delay_ms
	RJMP _gps

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xB:
	RCALL SUBOPT_0x8
	RJMP SUBOPT_0x9

;OPTIMIZER ADDED SUBROUTINE, CALLED 11 TIMES, CODE SIZE REDUCTION:28 WORDS
SUBOPT_0xC:
	LDI  R30,LOW(1000)
	LDI  R31,HIGH(1000)
	RCALL SUBOPT_0x8
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:19 WORDS
SUBOPT_0xD:
	LDI  R30,LOW(300)
	LDI  R31,HIGH(300)
	RCALL SUBOPT_0x8
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:22 WORDS
SUBOPT_0xE:
	MOV  R30,R5
	RCALL SUBOPT_0x0
	SUBI R30,LOW(-_buff)
	SBCI R31,HIGH(-_buff)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 22 TIMES, CODE SIZE REDUCTION:61 WORDS
SUBOPT_0xF:
	RCALL SUBOPT_0x8
	LDI  R24,0
	RCALL _printf
	ADIW R28,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x10:
	ST   -Y,R30
	RJMP _putchar

;OPTIMIZER ADDED SUBROUTINE, CALLED 13 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x11:
	RCALL SUBOPT_0x8
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x12:
	__POINTW1FN _0,141
	RJMP SUBOPT_0xF

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x13:
	ST   -Y,R30
	RJMP _lcd_data

;OPTIMIZER ADDED SUBROUTINE, CALLED 13 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x14:
	ST   -Y,R30
	RJMP _lcd_cmd

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x15:
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	RJMP SUBOPT_0x11

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x16:
	MOV  R30,R4
	RCALL SUBOPT_0x0
	SUBI R30,LOW(-_ip)
	SBCI R31,HIGH(-_ip)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x17:
	__DELAY_USW 320
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x18:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	RJMP SUBOPT_0x11

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:23 WORDS
SUBOPT_0x19:
	CBI  0x5,1
	SBI  0x5,2
	IN   R30,0xB
	ANDI R30,LOW(0xF)
	OUT  0xB,R30
	IN   R30,0xB
	OR   R30,R17
	OUT  0xB,R30
	__DELAY_USB 13
	CBI  0x5,2
	__DELAY_USB 13
	SBI  0x5,2
	IN   R30,0xB
	ANDI R30,LOW(0xF)
	OUT  0xB,R30
	IN   R30,0xB
	OR   R30,R16
	OUT  0xB,R30
	__DELAY_USB 13
	CBI  0x5,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1A:
	LD   R26,Y
	LDD  R27,Y+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x1B:
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	RCALL SUBOPT_0x8
	RJMP __put_G5

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x1C:
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	SBIW R26,4
	STD  Y+14,R26
	STD  Y+14+1,R27
	ADIW R26,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x1D:
	ST   -Y,R30
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	RCALL SUBOPT_0x8
	RJMP __put_G5

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1E:
	RCALL __GETW1P
	STD  Y+6,R30
	STD  Y+6+1,R31
	RJMP SUBOPT_0x8

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1F:
	STD  Y+6,R30
	STD  Y+6+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x20:
	STD  Y+10,R30
	STD  Y+10+1,R31
	RET

_strcmp:
	ld   r30,y+
	ld   r31,y+
	ld   r26,y+
	ld   r27,y+
__strcmp0:
	ld   r22,x+
	ld   r23,z+
	cp   r22,r23
	brne __strcmp1
	tst  r22
	brne __strcmp0
__strcmp3:
	clr  r30
	ret
__strcmp1:
	sub  r22,r23
	breq __strcmp3
	ldi  r30,1
	brcc __strcmp2
	subi r30,2
__strcmp2:
	ret

_strlen:
	ld   r26,y+
	ld   r27,y+
	clr  r30
	clr  r31
__strlen0:
	ld   r22,x+
	tst  r22
	breq __strlen1
	adiw r30,1
	rjmp __strlen0
__strlen1:
	ret

_strlenf:
	clr  r26
	clr  r27
	ld   r30,y+
	ld   r31,y+
__strlenf0:
	lpm  r0,z+
	tst  r0
	breq __strlenf1
	adiw r26,1
	rjmp __strlenf0
__strlenf1:
	movw r30,r26
	ret

_delay_ms:
	ld   r30,y+
	ld   r31,y+
	adiw r30,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x7D0
	wdr
	sbiw r30,1
	brne __delay_ms0
__delay_ms1:
	ret

__ADDW2R15:
	CLR  R0
	ADD  R26,R15
	ADC  R27,R0
	RET

__ANEGW1:
	COM  R30
	COM  R31
	ADIW R30,1
	RET

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__GETW1PF:
	LPM  R0,Z+
	LPM  R31,Z
	MOV  R30,R0
	RET

__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

__LOADLOCR2P:
	LD   R16,Y+
	LD   R17,Y+
	RET

;END OF CODE MARKER
__END_OF_CODE:
