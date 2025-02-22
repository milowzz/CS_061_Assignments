;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Emilio A Rivas
; Email: emilio.rivas@email.ucr.edu
; 
; Assignment name: 
; Lab section: 002
; TA: Karan
;
;=========================================================================


.ORIG x3000			; Program begins here

LD R1, ARRAY
LD R6, REG_STACK
AND R5, R5, #0


LD R4, SUB_GET_STRING 
JSRR R4


HALT

;---------------	
;Data
;---------------

ARRAY .FILL xA000  
SUB_GET_STRING .FILL x3200
REG_STACK .FILL xFE00
.end


;subroutine Get_string------------------------------------
.orig x3200
LD R2, NEG_ENTER
ADD R6, R6, #-1
STR R7, R6, #0  ;stores address (RET) to R6 

DO_WHILE_LOOP_SENTINAL1 ;start of loop
AND R3, R3, #0          ; relaods r3
    GETC
    OUT
                 
    ADD R3, R0, R2 ; substract r0 - r2
    BRz END_DO_WHILE_LOOP_SENTINAL1 ; if the character was ENTER, end the loop
                    ; else we store the character 
    STR R0, R1, #0  ; saves the character to that address location
    ADD R1, R1, #1  ; iterates through the array  
    ADD R5, R5, #1  ; counts how many characters have been saved into the array
BRnzp DO_WHILE_LOOP_SENTINAL1 ; end of loop
    
    
END_DO_WHILE_LOOP_SENTINAL1 ; IF THE CHARACTER IS ENTER JUMP HERE
LD R0, NULL      ;assigns RO to null
STR R0, R1, #0   ;stores "null" R0 into array 



;do the opposite of backing up to return sepearte stack to normal
LDR R7, R6, #0 
ADD R6, R6, #1
RET 
NEG_ENTER   .FILL #-10
NULL .FILL #0
.end 

;---------------	
;END of PROGRAM
;---------------	
.END 