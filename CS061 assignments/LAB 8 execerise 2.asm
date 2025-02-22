;=================================================
; Name: Emilio Rivas 
; Email: eriva023@ucr.edu
; 
; Lab: lab 8, ex 2
; Lab section: 
; TA: 
; 
;=================================================

.orig x3000

LD R6, top_stack_addr

; Test harness
;-------------------------------------------------
LEA R0, prompt
    puts
    GETC
    OUT

    ADD R2, R0, #0      ;R2 = INPUT CHAR.
			
LD R1, PARITY_CHECK_3600_ptr
    JSRR R1             ;R1 = NUM OF 1'S 
			
LEA R0, end_prompt_1
    PUTS
ADD R0, R2, #0
    OUT
LEA R0, end_prompt_2
    PUTS
LD R2, HEX_30
ADD R0, R1, R2
	OUT

HALT

; Test harness local data
;-------------------------------------------------
top_stack_addr .fill xFE00

prompt          .stringz "Enter the character: \n"
end_prompt_1    .stringz "\nThe number of 1's in '"
end_prompt_2    .stringz "' is: "
HEX_30          .FILL x30
;--------------------
;subroutines_address
;--------------------
PARITY_CHECK_3600_ptr      .FILL x3600

.end

;=================================================
; Subroutine: PARITY_CHECK_3600
; Parameter: // Fixme
; Postcondition: // Fixme
; Return Value (R3): // Fixme
;=================================================

.orig x3600

; Backup registers
ST R0, backup_r0_3600
ST R2, backup_r2_3600 
ST R3, backup_r3_3600     
ST R4, backup_r4_3600
ST R5, backup_r5_3600
ST R6, backup_r6_3600  
ST R7, backup_r7_3600 

; Code
LD R3, num_16           ; r3 = 16
AND R1, R1, #0          ; USE R1 AS COUNTER
		    
check_loop
    AND R3, R3, R3      ; checks if its zero
	BRnz end_sub        ; By the time 3 hits zero, R1 will have the number of ones counted
		        
	ADD R3, R3, #-1     ; 16-x
    AND R0, R0, R0      ; check if ro is negative after the left shift 
	BRzp #1             ; If its negative then add one to R1
	    ADD R1, R1, #1
	ADD R0, R0, R0      ; Left shifting r0 once it becomes negative (i.e the leading number is one WE ADD ONE TO R1)
	BR check_loop       
			            
end_sub                 

; Restore registers
LD R0, backup_r0_3600  
LD R2, backup_r2_3600     
LD R3, backup_r3_3600 
LD R4, backup_r4_3600 
LD R5, backup_r5_3600 
LD R6, backup_r6_3600 
LD R7, backup_r7_3600 

RET
; local data
backup_r0_3600   
backup_r2_3600   .BLKW #1
backup_r3_3600   .BLKW #1
backup_r4_3600   .BLKW #1
backup_r5_3600   .BLKW #1
backup_r6_3600   .BLKW #1
backup_r7_3600   .BLKW #1

num_16          .FILL #16

.end

; exer 3 algorithm
; Initialize a register to hold the count of shifts (since we want to shift by one bit, this count will be set to 1).
; Clear a register to use it as a mask to check the least significant bit of the input value.
; Set the lsb of the mask register to 1.
; Shift the input value left by one bit.
; Check the lsb of the shifted value.
; If the lsb is 1, subtract the mask from the shifted value to clear the lsb.
; Rotate the bits to the right by decrementing the shift count and repeating steps 4-6 until the count is zero.
; The result of the operation will be in the input register, which now contains the value logically right-shifted by one bit.



