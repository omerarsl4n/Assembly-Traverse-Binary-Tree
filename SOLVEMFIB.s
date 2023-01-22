
;LABEL		DIRECTIVE	VALUE			COMMENT
				AREA 		fibo_bin_tree, READONLY, CODE
				THUMB
				EXTERN		__main
				EXPORT 		SOLVEMFIB
				ALIGN
					
SOLVEMFIB 		PROC
				CMP		R0,#2	; CHECK stop situation for recursion, i.e reaching leaf node
				BCC		exitcase
				PUSH	{LR}	; store LR and F(n) for the next calls, in the binary tree you can think curr_Node is stored and left will be called.
				PUSH	{R0}
				SUB		R0,#1
				BL		SOLVEMFIB	;; call F(n-1), in  binary tree left_tree called
				POP		{R5}		;;R5 holds latest stack return value, i.e latest return
				POP		{R0}		;;R0 hold current_node
				SUB		R0,#2		;;for calling F(n-2) subtract 2, u can think right tree call
				PUSH	{R5}		;;store back R5, it will used in the next calls. It is popped just for taking R0 actually
				BL 		SOLVEMFIB	;; call F(n-2), right tree
				POP		{R5}		;; now F(n-1) and F(n-2) concluded their routines, so start calculation
				POP		{R6}		;; since every F(n) calls F(n-1) and F(n-2), we popped 2 values from stack
				MOV		R2,R6		;; In my case F(n) = F(n-1) + 2*F(n-2), R6 holds F(n-1)
				ADD		R2,R2,R5,LSL #1	;; R5 holds F(n-2)
				POP		{LR}
				PUSH	{R2}
				BX 		LR		;;go for the above trees or calculations, when the root node is reached end of operation.
				
exitcase		MOV		R1,#1	; stop condition F(0) = F(1) = 1; in the binary tree the corresponds to leaf data
				PUSH	{R1}	; the result pushed to stack, the main func will be used this value by popping from the stack
				BX 		LR		; go back
				ENDP
				
				ALIGN
				END

				