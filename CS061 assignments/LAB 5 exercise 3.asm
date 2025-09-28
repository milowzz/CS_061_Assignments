;=========================================================================
; 
;=========================================================================


.ORIG x3000			; Program begins here
;-------------
;Instructions: CODE GOES HERE
;-------------


LD R6, REG_STACK  ; have another backup stack
LD R3, STACK_BASE ; base of the stack
LD R4, STACK_MAX  ; max capacity of the stack
LD R5, STACK_BASE ; THE STACK WILL BEGIN HERE "TOS" (at the base!)
AND R1, R1, #0 
GETC ; get the first number from user 
OUT  ; make sure to output it 

LD R2, SUB_STACK_PUSH ; implement this one twice 
JSRR R2

LD R0, SPACE
OUT
GETC ; get the second number from user 
OUT  ; make sure to output it 

ADD R1, R0, #0 ; save user value

LD R0, SPACE
OUT

AND R0, R0, #0
ADD R0, R1, R0

LD R2, SUB_STACK_PUSH 
JSRR R2

LD R0, PLUS 
OUT 

AND R1, R1, #0 ;restore R1
LD R2, SUB_RPN_ADDITION 
JSRR R2

LD R2, SUB_PRINT_DIGIT 
JSRR R2


HALT

SUB_RPN_ADDITION .FILL x3200
SUB_STACK_PUSH .FILL x3400
SUB_PRINT_DIGIT .FILL x3800

REG_STACK .FILL xFE00
STACK_BASE .FILL xA000  
STACK_MAX .FILL xA005
PLUS .FILL #43
SPACE .FILL #32
                  

.end

; SUBROUTINE PUSH ---------------------------------------------------------------------------------------------------
.orig x3400

;Back up registers 
ADD R6, R6, #-1
STR R7, R6, #0  ;stores address (RET) to R6 

;sub routine logic (code that does something)  
NOT R2, R5
ADD R2, R2, #1   ; Make TOS negative 
ADD R2, R4, R2   ; Check if base is equal to max or not
BRnz IF_OVERFLOW ; If the TOS is bigger or equal to the max (i.e if max - tos equals to zero or a negative integer)
ADD R5, R5, #1   ; increment TOS 
STR R0, R5, #0   ; save the user value to that address

BR IF_NOT_OVERFLOW


IF_OVERFLOW 


LEA R0, OVERFLOW
PUTS 


IF_NOT_OVERFLOW ; If its not an overflow go here!


;do the opposite of backing up to return sepearte stack to normal
LDR R7, R6, #0 
ADD R6, R6, #1


RET
OVERFLOW .STRINGZ "Overflow"
.end
;--------------------------------------------------------------------------------------------------------------------------------------



;SUBROUTINE POP -----------------------------------------------------------------------------------------------------------------------
.orig x3600

;Back up registers 
ADD R6, R6, #-1
STR R7, R6, #0  ;stores address to x3200

;sub routine logic 
NOT R2, R5
ADD R2, R2, #1   ; Make TOS negative 
ADD R2, R3, R2   ; Check if TOS is greater than the base 
BRz IF_UNDERFLOW ; If TOS is NOT greater than the base 
 
LDR R0, R5, #0   ; save the value from the stack to R0
ADD R1, R1, R0   ; assign R0 to R1
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
;--------------------------------------------------------------------------------------------------------------------------------------



; SUBROUTINE ADDITION -----------------------------------------------------------------------------------------------------------------
.orig x3200
ADD R6, R6, #-1
STR R7, R6, #0  ;stores address of MAIN


LD R2, SUB_STACK_POP 
JSRR R2 

LD R2, SUB_STACK_POP
JSRR R2 

LDR R7, R6, #0 
ADD R6, R6, #1

RET 
SUB_STACK_POP .FILL x3600

.end

;--------------------------------------------------------------------------------------------------------------------------------------

; SUBROUTINE PRINT  -----------------------------------------------------------------------------------------------------------------
.orig x3800
ADD R6, R6, #-1
STR R7, R6, #0  ;stores address of MAIN


LD R0, SPACE_pt2
OUT 
AND R0, R0, #0
LD R3, NEG_48
ADD R0, R1, R3
OUT 

LD R2, SUB_STACK_PUSH2 
JSRR R2

LDR R7, R6, #0 
ADD R6, R6, #1

RET
SUB_STACK_PUSH2 .FILL x3400
NEG_48 .FILL #-48
SPACE_pt2 .FILL #32
.end 
;--------------------------------------------------------------------------------------------------------------------------------------




;---------------	
;END of PROGRAM
;---------------	

.END 
