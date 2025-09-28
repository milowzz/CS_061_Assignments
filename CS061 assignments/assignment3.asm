;=========================================================================

;=========================================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------
LD R6, Value_ptr		; R6 <-- pointer to value to be displayed as binary
LDR R1, R6, #0			; R1 <-- value to be displayed as binary (loads value into register from memory address)
 
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------



LD R2, DEC_16
LD R4, DEC_FOUR
LD R5, DEC_FOUR    

LOOP_ITERATE_16



ADD R1, R1, #0    ; Do this so the branch has something to check
BRn ELSE_IF_NEG   ;if its negative or zero

LD R0, HEX_ZERO    ; Load R0 with zero and output it with OUT
OUT


BR SKIP_LOOP

ELSE_IF_NEG ;if its negative or , JUMP HERE!
LD R0, HEX_ONE
OUT

SKIP_LOOP
ADD R1, R1, R1  ; left shift number 


ADD R4, R4, #-1     ;counter should be already set to four
BRz IF_ZERO          

BR SKIP_LOOP2       ;if its not zero (binary number hasnt made a packet yet)

IF_ZERO             ; there will be two BR (branches to check these two conditions)

ADD R5, R5, #-1       
BRz IF_THREE        ; look at line 72
                    ; other wise continue here 
LD R4, DEC_FOUR     ; reloads R4 with deciaml four because we want to know when the next packet is 
LD R0, space        
OUT
 
SKIP_LOOP2          ; IF packet has not been made JUMP HERE 
 

IF_THREE  ;if its three JUMP HERE!




ADD R2, R2, #-1
BRp LOOP_ITERATE_16 ; while R2 is positive it'll continue 
                    ; to run until it hits zero

LD R0, newline
OUT 


HALT


;---------------	
;Data
;---------------
Value_ptr	.FILL xCA01	; The address where value to be displayed is stored
DEC_16 .FILL #16        ; decimal 16 will be used to iterate the loop
HEX_ONE     .FILL X31   ;hexadecimal for the character 1
HEX_ZERO    .FILL X30   ; heaxdecimal for character 0
newline .FILL x0A
space   .FILL x20
DEC_FOUR .FILL #4


.END

.ORIG xCA01					; Remote data
Value .FILL xABCD; <----!!!NUMBER TO BE DISPLAYED AS BINARY!!! Note: label is redundant.

;---------------	
;END of PROGRAM
;---------------	
.END

