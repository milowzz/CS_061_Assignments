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
;-------------
;Instructions: CODE GOES HERE
;------------- 


LD R6, REG_STACK ; separate stack used for backing up and restoring registers
;Load value stack
LD R3, STACK_BASE 
LD R4, STACK_MAX  
LD R5, STACK_BASE ; THE STACK WILL BEGIN HERE "TOS" (at the base!)
LD R1, DEC_EIGHT

ADD R5, R5, #1
STR R1, R5, #0

LD R2, SUB_3200
JSRR R2

LD R2, SUB_3200
JSRR R2
LD R2, SUB_3200
JSRR R2
LD R2, SUB_3200
JSRR R2

HALT

SUB_3200 .FILL x3200
REG_STACK .FILL xFE00
STACK_BASE .FILL xA000  
STACK_MID .FILL xA003
STACK_MAX .FILL xA005
DEC_EIGHT .FILL #49   ;value that is going to be stored into the stack

.end

; SUBROUTINE ONE---------------------------------------------------------------------------------------------------
.orig x3200

;Back up registers 
ADD R6, R6, #-1
STR R7, R6, #0  ;stores address to return to main at the top

;sub routine logic (code that does something)
NOT R2, R5
ADD R2, R2, #1   ; Make TOS negative 
ADD R2, R3, R2   ; Check if TOS is greater than the base 
BRz IF_UNDERFLOW ; If TOS is NOT greater than the base 
 
LDR R0, R5, #0   ; save the value from the stack to R0
OUT
ADD R5, R5, #-1  ; decrement the stack

BR IF_NOT_UNDERFLOW


IF_UNDERFLOW 


LEA R0, UNDERFLOW
PUTS 


; BR END_PUSH
IF_NOT_UNDERFLOW ; If its GREATER jump here!


;do the opposite of backing up to return sepearte stack to normal
LDR R7, R6, #0 
ADD R6, R6, #1


RET
UNDERFLOW .STRINGZ "Underflow"
.end





;---------------	
;END of PROGRAM
;---------------	
.END 