;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Emilio A Rivas
; Email: emilio.rivas@email.ucr.edu
; 
; Assignment name: 
; Lab section: 002
; TA: Karan
; 
; NOTE: Use R7 only for storing addresses 
; JSRR: will jump to that address and automatically save the next line's address location after where JSRR was set to R7
; RET: Make the register to go back where it came from 
;=========================================================================


.ORIG x3000			; Program begins here
;-------------
;Instructions: CODE GOES HERE
;-------------

LD R1, ARRAY_PTR
LD R0, ZERO 
LD R3, TEN

LD R6, DEC_48

LD R2, SUB_FILL_ARRAY_3200
JSRR R2
LD R1, ARRAY_PTR ; reload r1
LD R3, TEN       ; reload r3

LD R2, SUB_CONVERT_ARRAY_3400
JSRR R2
LD R1, ARRAY_PTR ; reload r1
LD R3, TEN 
AND R0, R0, #0   ; clear r0

LD R2, SUB_PRINT_ARRAY_3600   ; after doing the other subroutines
JSRR R2 ; use r2 for the next to have more registers to use 
LD R1, ARRAY_PTR ; reload r1
LD R3, TEN       ; reload r3
AND R0, R0, #0   ; clear r0



LD R1, ARRAY_PTR

HALT

ARRAY_PTR .FILL x4000
ZERO .FILL #0
TEN .FILL #10
DEC_48 .FILL #48

SUB_FILL_ARRAY_3200 .FILL x3200
SUB_CONVERT_ARRAY_3400 .FILL x3400
SUB_PRINT_ARRAY_3600 .FILL x3600
SUB_PRETTY_PRINT_ARRAY_3800 .FILL x3800

.end 


.ORIG x4000
ARRAY_1	.BLKW  #10 ; blank array of 10 locations 
.end

; SUBROUTINE ONE---------------------------------------------------------------------------------------------------
.orig x3200       ; use the starting address as part of the sub name

DO_WHILE_LOOP
               
    STR R0, R1, #0  ; stores the value from R0 into the array
    ADD R1, R1, #1  ; iterates through the array
    ADD R0, R0, #1  ; adds 1 to r0
    ADD R3, R3, #-1 ; moves on to the next iteration of the loop to repeat steps 
    BRp DO_WHILE_LOOP
END_DO_WHILE_LOOP
 

RET

.end

;SUBROUTINE TWO-----------------------------------------------------------------------------------------------------
.orig x3400       ; use the starting address as part of the sub name

DO_WHILE_LOOP2
               
    LDR R5, R1, #0  ; stores the value from R1 (start of array) address into R5
    ADD R5, R5, R6  ; adds #48 to decimal in that register
    STR R5, R1, #0  ; stores it back into the array
    ADD R1, R1, #1  ; iterates through the array

    ADD R3, R3, #-1 ; moves on to the next iteration of the loop to repeat steps 
    BRp DO_WHILE_LOOP2
END_DO_WHILE_LOOP2
 
RET

.end


;SUBROUTINE THREE-----------------------------------------------------------------------------------------------------
.orig x3600       ; use the starting address as part of the sub name

DO_WHILE_LOOP3
               
    LDR R0, R1, #0  ; stores the value from R1 (start of array) address into R0
    OUT
    
    ADD R1, R1, #1  ; iterates through the array

    ADD R3, R3, #-1 ; moves on to the next iteration of the loop to repeat steps 
    BRp DO_WHILE_LOOP3
END_DO_WHILE_LOOP3

LD R4, SUB_PRETTY_PRINT_ARRAY_3800_2nd
JSRR R4                                  ; jump to x3800

RET

SUB_PRETTY_PRINT_ARRAY_3800_2nd .FILL x3800   ;make a label in local data for x3600
.end

;SUBROUTINE FOUR -----------------------------------------------------------------------------------------------------
.orig x3800       ; use the starting address as part of the sub name

EQUAL .STRINGZ "====="
LEA R0, EQUAL
PUTS 

AND R0, R0, #0 ;reload r0 to 0

DO_WHILE_LOOP4
               
    LDR R0, R1, #0  ; stores the value from R1 (start of array) address into R0
    OUT
    
    ADD R1, R1, #1  ; iterates through the array

    ADD R3, R3, #-1 ; moves on to the next iteration of the loop to repeat steps 
    BRp DO_WHILE_LOOP4
END_DO_WHILE_LOOP4
 
RET

.end

;---------------	
;END of PROGRAM
;---------------	
.END 

