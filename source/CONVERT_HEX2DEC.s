decimal_mem  	EQU		0x20000400
asci_mem		EQU		0x20000700
	
			AREA 	subrout, READONLY, CODE
            THUMB
			EXTERN      __main      ; Reference external subroutine 
            EXPORT 		CONVERT_HEX2DEC
			ALIGN
				
CONVERT_HEX2DEC		PROC
			MOV32	R3,#1000000000	;since the number at most 4 byte
			LDR		R1,=decimal_mem
			MOV		R2,#10  ; at most 10 decimal digit counter
			MOV		R6,#10	;;R2 is used for divisor to divide 10 in each check
loop1		CMP		R4,R3	;R4 holds the number which will be converted
			BHS		do		;bigger or same go do	
			UDIV	R3,R6	;else divide R3 by 10
			MOV		R0,#0	;since it is lower we should write 0
			STRB	R0,[R1],#1	;write 0 to decimal_address
			SUBS	R2,#1		;decrease digit
			BEQ 	cont		;if all digit converted go to cont for decimal to asci conversion
			B		loop1		;else loop
			
do			UDIV 	R0,R4,R3	;divide R4 by R3 will give corresponding digit in a decimal form 
			STRB	R0,[R1],#1
			MLS		R4,R0,R3,R4	; subtract division, ex: if num is 123 and, we're checking the 1, this section subtract 100 from the number
			UDIV	R3,R6		; update R3
			SUBS	R2,#1		; check next digit if exist
			BNE		loop1
			
cont		MOV		R2,#10		;start to convert decimal ones to ascii format, reset counter for this reason
			LDR		R1,=decimal_mem
			MOV		R0,#0		;FLAG that show whether there are zeros beginning of the number, because we do not want to print them
			LDR		R5,=asci_mem
			
loop2		LDRB	R3,[R1],#1	;load first digit
			CMP		R0,#0		;check flag
			BEQ 	check
			SUBS	R2,#1
			BEQ		endprog
			B 		asci
			
check		CMP		R3,R0
			MOVNE	R0,#1	;;if the digit is not 0,then flag is 1
			BNE		asci
			SUBS	R2,#1
			BNE		loop2
			BEQ		endprog
			
asci		SUB 	R6,R3,#0X30	;asci maping
			STRB	R6,[R5],#1
			B loop2

endprog		MOV		R1,#0x30	;for edge case write "0"
			CMP		R0,#0
			STRBEQ	R1,[R5]		;asci_mem holds the converted numbers in the asci format. Ex: hex number 0x68 = (104)d
			BX		LR			;asci mem hold 0x31 0x30 0x34 to print easily from the UART channel
			
			ENDP
			ALIGN
			END	