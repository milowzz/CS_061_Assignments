;=================================================
; Name: Emilio Rivas 
; Email: eriva023@ucr.edu 
; 
; Lab: lab 8, ex 1
; Lab section: 002
; TA: Karan
; 
;=================================================

.orig x3000

LD R6, top_stack_addr

LD R1, LOAD_FILL_VALUE_3200
JSRR R1

ADD R2, R2, #1 ; Add one to the number

ADD R3, R3, #0 ; this will the counter 
AND R0, R0, #0 ; clear R0 (this will be used to print out the numbers)

LD R1, OUTPUT_AS_DECIMAL_3400
JSRR R1

; Test harness
;-------------------------------------------------

HALT

; Test harness local data
;-------------------------------------------------
top_stack_addr .fill xFE00
LOAD_FILL_VALUE_3200 .fill x3200
OUTPUT_AS_DECIMAL_3400 .fill x3400

.end

;=================================================
; Subroutine: LOAD_FILL_VALUE_3200
; Parameter: // none 
; Postcondition: // none
; Return Value: // hard coded value in R2
;=================================================

.orig x3200
; Backup registers
ADD R6, R6, #-1
STR R7, R6, #0
ADD R6, R6, #-1
STR R5, R6, #0
ADD R6, R6, #-1
STR R4, R6, #0
ADD R6, R6, #-1
STR R3, R6, #0
ADD R6, R6, #-1
STR R1, R6, #0
ADD R6, R6, #-1
STR R0, R6, #0

; Code
LD R2, NUM
;test 150
;test 12346
; Restore registers
LDR R0, R6, #0
ADD R6, R6, #1
LDR R1, R6, #0
ADD R6, R6, #1
LDR R3, R6, #0
ADD R6, R6, #1
LDR R4, R6, #0
ADD R6, R6, #1
LDR R5, R6, #0
ADD R6, R6, #1
LDR R7, R6, #0
ADD R6, R6, #1

RET
NUM .fill #-3001

.end

;=================================================
; Subroutine: OUTPUT_AS_DECIMAL_3400
; Parameters: // R2 (hard coded value), other registers used to subtract, R3 counter, and R0
; Postcondition: // ADD one to R2 
; Return Value: // print out decimal value 
;=================================================

.orig x3400
; Backup registers
ADD R6, R6, #-1
STR R7, R6, #0
ADD R6, R6, #-1
STR R5, R6, #0
ADD R6, R6, #-1
STR R4, R6, #0
ADD R6, R6, #-1
STR R3, R6, #0
ADD R6, R6, #-1
STR R1, R6, #0
ADD R6, R6, #-1
STR R0, R6, #0
; Code

LD R4, NEG_TEN_K
ADD R2, R2, #0 ;Check if number is negative
BRn IF_NEG

BR NOT_NEG

IF_NEG
LD R0, IS_NEG
OUT 
ADD R2, R2, #-1
NOT R2, R2

NOT_NEG

; TEN THOUSAND-------------------------------------------------------------------------------------------------------------------------
AND R0, R0, #0 ;clear r0 again 

continue
ADD R2, R4, R2 ; substract by -10000
BRn IF_NEG2

ADD R3, R3, #1  ; COUNTER
BR continue 

IF_NEG2 ;stop the loop 
ADD R4, R4, #-1     ; recover the last value of r2 before it became negative 
NOT R4, R4
ADD R2, R4, R2
LD R4, DEC_48   
;ADD R3, R3, #0
;BRz IF_zero        ; If its zero, do not print out the character 
ADD R0, R3, R4     ; add 48
OUT                ; print the character 


; ONE THOUSAND-------------------------------------------------------------------------------------------------------------------------

;IF_zero


LD R4, NEG_ONE_K
AND R3, R3, #0 ;clear r0 again 

continue2
ADD R2, R4, R2 ; substract by -1000
BRn IF_NEG3

ADD R3, R3, #1
BR continue2

IF_NEG3 ;stop the loop 
ADD R4, R4, #-1     ; recover the last value of r2 before it became negative 
NOT R4, R4
ADD R2, R4, R2
LD R4, DEC_48
;ADD R0, R0, #0
;BRz IF_zero2
ADD R0, R3, R4     ; add 48
OUT                ; print the character 

; ONE HUNDRED -------------------------------------------------------------------------------------------------------------------------
;IF_zero2
LD R4, NEG_ONE_HUNDRED
AND R3, R3, #0 ;clear r3 again 

continue3
ADD R2, R4, R2 ; substract by -100
BRn IF_NEG4

ADD R3, R3, #1
BR continue3

IF_NEG4 ;stop the loop 
ADD R4, R4, #-1     ; recover the last value of r2 before it became negative 
NOT R4, R4
ADD R2, R4, R2
LD R4, DEC_48 
;ADD R3, R3, #0  ;if the counter is zero, move on to the next numbers place and dont print anything out
;BRz IF_zero3
ADD R0, R3, R4     ; add 48
OUT                ; print the character 


; TEN -------------------------------------------------------------------------------------------------------------------------
;IF_zero3

LD R4, NEG_TEN
AND R3, R3, #0 ;clear r3 again 

continue4
ADD R2, R4, R2 ; substract by -10
BRn IF_NEG5

ADD R3, R3, #1
BR continue4

IF_NEG5 ;stop the loop 
ADD R4, R4, #-1     ; recover the last value of r2 before it became negative 
NOT R4, R4
ADD R2, R4, R2
LD R4, DEC_48   
;ADD R3, R3, #0
;BRz IF_zero4
ADD R0, R3, R4     ; add 48
OUT                ; print the character 



; ONE ---------------------------------------------------------------------------------------------------------------------------------
;IF_zero4
AND R0, R0, #0 ;clear r0 again 

ADD R0, R2, R4
OUT





; Restore registers
LDR R0, R6, #0
ADD R6, R6, #1
LDR R1, R6, #0
ADD R6, R6, #1
LDR R3, R6, #0
ADD R6, R6, #1
LDR R4, R6, #0
ADD R6, R6, #1
LDR R5, R6, #0
ADD R6, R6, #1
LDR R7, R6, #0
ADD R6, R6, #1

RET
NEG_TEN_K .FILL #-10000
NEG_ONE_K .FILL #-1000
NEG_ONE_HUNDRED .FILL #-100
NEG_TEN .FILL #-10
IS_NEG .FILL x2D
DEC_48 .FILL #48
.end