;=========================================================================
;
;=========================================================================


.ORIG x3000			; Program begins here

LD R6, REG_STACK  ; have another backup stack
LD R3, ENTER

LD R2, SUB_GET_STRING
JSRR R2






HALT

;---------------	
;Local Data 
;---------------
SUB_GET_STRING .FILL x3200
NEG_ENTER .FILL #-10
REG_STACK .FILL xFE00
.end

;SUBROUTINE_GET_STRING------------------------------------------------------------------------------------------------------------------
.orig x3200
LD R1, ARRAY_PTR
;Back up registers 
ADD R6, R6, #-1
STR R7, R6, #0  ;stores address (RET) to R6 


DO_WHILE_LOOP_SENTINAL1  ;start of loop

    GETC            ; asks user for character
    OUT             ; outputs the character
     
    
    ADD R4, R0, R3  ; check if user input was "enter" 
    BRz END_DO_WHILE_LOOP_SENTINAL1 ; if the character was enter, end the loop
    STR R0, R1, #0                  ; else we PUSH the character into the array 
    ADD R1, R1, #1                  ; iterate through the array
      
   
BRnzp DO_WHILE_LOOP_SENTINAL1 ; End of the loop

END_DO_WHILE_LOOP_SENTINAL1 ; IF THE CHARACTER IS ZERO JUMP HERE
LD R0, NULL     ;Loads ro with null
STR R0, R1, #0  ; puts it at the end of the array



;do the opposite of backing up to return sepearte stack to normal
LDR R7, R6, #0 
ADD R6, R6, #1


RET
ARRAY_PTR .FILL xA000
NULL      .FILL #0
.end
----------------------------------------------------------------------------------------------------------------------------------------

;---------------	
;END of PROGRAM
;---------------	

.END 
