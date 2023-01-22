addr			EQU		0x20000800
asci_mem		EQU		0x20000700
;LABEL		DIRECTIVE	VALUE			COMMENT
				AREA 		main_bin_tree, READONLY, CODE
				THUMB
				EXTERN      OutStr      ; Reference external subroutine 
				EXTERN		CONVERT_HEX2DEC
				EXTERN		InChar
				EXTERN		SOLVEMFIB
				EXPORT 		__main
				
__main

start			BL 			InChar
				SUB			R1,R0,#0x30
				BL			InChar
				SUB			R2,R0,#0x30			
				MOV			R4,#10
				MLA			R1,R1,R4,R2 			;;take two digit input by InChar
				LDR			R0,=addr
				;MOV			R1,#8 ;; for easier test
				MOV			R7,R1; STORE INPUT FOR FUTURE USAGE
				SUB			R1,#1
				MOV			R2,#4;;used for multipication
				MLA			R0,R1,R2,R0		;;initialize memory address to top, later it will decreased.
				
				
loop			MOV			R10,R1			;start loop by pass R1 to R10
				BL			SOLVEMFIB
				STR			R9,[R0]			;store the result of fib(R1)
				SUB			R0,#4			;decrease memory addrres since we write back
				SUBS		R1,#1			;;decrease input and check
				BPL			loop
						
				LDR			R10,=addr		;;initialize R10 to memory address sequence is written as hex format
				
print			LDR			R4,[R10],#4		;;read the data and pass to R4 for converting decimal
				BL			CONVERT_HEX2DEC
				MOV			R2,#0x0420		;;for printing purposes
				STRH		R2,[R5]			;;for printing purposes
				LDR			R0,=asci_mem	;;for printing purposes
				BL          OutStr			
				SUBS		R7,#1			;;decrease counter and check 
				BNE			print
				
done			B			done
				
				ALIGN
				END