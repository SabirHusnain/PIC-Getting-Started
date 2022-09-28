#include "P18F452.inc"
LIST P=18F452, F=INHX32, MM=OFF

    CONFIG OSC=XT
    CONFIG WDT=OFF

    ORG 0x00
    GOTO MAIN
    ORG 0x200

MAIN:
    NUM EQU D'100'

    CHK_1 EQU 0x20
    CHK_2 EQU 0x21

    SETF TRISE
    CLRF TRISB
    CLRF TRISC

Here		MOVLW NUM
    		MOVWF PORTB

    		CLRF PORTC

    		MOVLW d'225'
    		MOVWF CHK_1
    		MOVLW d'4'
    		MOVWF CHK_2

Again   	BTFSC PORTE, 1
    		BRA Here
    		BTFSS PORTE, 0
    		BRA Again
    		DECF CHK_1, F
    		BZ DEC_L
    		INCF PORTB, F
    		BC New
    		GOTO Again

New		INCF PORTC, F
    		GOTO Again

DEC_L	DECFSZ CHK_2, F
		MOVLW d'225'
		MOVWF CHK_1
    		RETURN
    		BRA Here
END