;=========================================================================
;
;=========================================================================


.ORIG x3000			; Program begins here

LD R1, ARRAY
LD R6, REG_STACK
AND R5, R5, #0


LD R4, SUB_GET_STRING 
JSRR R4



LD R4, SUB_IS_PALINDROME
LD R1, ARRAY
JSRR R4
LD R1, ARRAY

ADD R4, R4, #0
BRz YAY_PALINDROME ; if r4 is zero

BR BOO_PALINDROME 

YAY_PALINDROME ; if R4 is zero JUMP HERE!
LEA R0, PROMPT
PUTS
LD R0, ARRAY
PUTS
LEA R0, YAY
PUTS

BR YAY_2   ; This is to avoid boo palindrome

BOO_PALINDROME
LEA R0, PROMPT
PUTS
LD R0, ARRAY
PUTS
LEA R0, BOO
PUTS

YAY_2




HALT

;---------------	
;Data
;---------------

ARRAY .FILL xA000 
REG_STACK .FILL xFE00
SUB_GET_STRING .FILL x3200
SUB_IS_PALINDROME .FILL x3400
PROMPT  .STRINGZ "The string "
BOO     .STRINGZ " IS NOT a palindrome"
YAY     .STRINGZ " IS a palindrome"


.end


;subroutine Get_string-----------------------------------------------------------------------------------------------------------------
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

;subroutine Palindrome -----------------------------------------------------------------------------------------------------------------
;Parameters are
;R1 START OF THE ARRAY
;R5 SIZE OF THE ARRAY
; R4 is NOT a parameter RETURN VALUE
.orig x3400
ADD R6, R6, #-1 ; save registers 
STR R7, R6, #0  ; Stores address of main
ADD R6, R6, #-1 ; 
STR R5, R6, #0  ; stores the size of the string 
ADD R6, R6, #-1 ;  
STR R1, R6, #0  ; Stores start of the array

LD R4, SUB_TO_UPPER
JSRR R4

LDR R1, R6, #0 
ADD R6, R6, #1

AND R2, R2, #0 
ADD R2, R5, R2 ; Make R2 the size of the array 
ADD R2, R2, #-1 ; N-1 (end of the array)
ADD R7, R1, R2  ; START OF THE ARRAY + OFFSET = OPPOSITE END OF THE ARRAY
;Loop
GO_TO_TOP_OF_LOOP



; CHANGE THIS PART OF THE CODE BECAUSE WHAT YOU ARE DOING HERE IS JUST SUBTRACTING NUMBERS
; TO ACCESS THE INDIVIUAL CHARACTERS, USE LDR AND THEN DO THE CHECKS 
LDR R3, R1, #0  ; Array + 1 (Front of the array)
LDR R4, R7, #0  ; Array + offset (end of the array)

NOT R3, R3,     ;twos compliment
ADD R3, R3, #1

ADD R3, R3, R4 ; If R3 - R0 = 0 then its the same character
BRz IF_PALINDROME

BR NOT_PALINDROME

IF_PALINDROME
ADD R1, R1, #1
ADD R7, R7, #-1
ADD R5, R5, #-2
BRn FINISH

BR GO_TO_TOP_OF_LOOP


NOT_PALINDROME
AND R4, R4, #0
ADD R4, R4, #1
BR NOT_PALINDROME_SKIP

FINISH
AND R4, R4, #0

NOT_PALINDROME_SKIP


;do the opposite of backing up to return sepearte stack to normal
LDR R5, R6, #0 
ADD R6, R6, #1
LDR R7, R6, #0 
ADD R6, R6, #1

RET

SUB_TO_UPPER .FILL x3600

.end

;subroutine TO_UPPER---------------------------------------------------------------------------------------------------------------------
.orig x3600
ADD R6, R6, #-1 ; save registers 
STR R7, R6, #0  ;stores address (RET) to R6
ADD R6, R6, #-1 ; save registers 
STR R5, R6, #0 
LD R3, BIT 

LOOP_KEEP_GOING
LDR R2, R1, #0
ADD R2, R2, #0
BRz WHILE_LOOP

AND R2, R2, R3
STR R2, R1, #0

ADD R1, R1, #1

BR LOOP_KEEP_GOING

WHILE_LOOP

LDR R5, R6, #0 
ADD R6, R6, #1
LDR R7, R6, #0 
ADD R6, R6, #1
RET 
BIT .FILL x005F
.end

;---------------	
;END of PROGRAM
;---------------	

.END 
