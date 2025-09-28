
;=================================================================================
; PUT ALL YOUR CODE AFTER THE main LABEL
;=================================================================================

;---------------------------------------------------------------------------------
;  Initialize program by setting stack pointer and calling main subroutine
;---------------------------------------------------------------------------------
.ORIG x3000

; initialize the stacks
LD R6, stack_addr
LEA R1, user_string  ; this is to store the string 

; prompt to the user
LEA R0, user_prompt
PUTS

; call main subroutine
LEA R5, main
JSRR R5

;---------------------------------------------------------------------------------
; Main Subroutine
;---------------------------------------------------------------------------------
main
; get a string from the user
; * put your code here
LD R5, get_user_string_addr
JSRR R5
LEA R1, user_string    ;Reload the beginng of the string again before going to the next subroutine

; find size of input string
; * put your code here
LD R5, strlen_addr
JSRR R5
LEA R1, user_string    ;Reload the beginng of the string again before going to the next subroutine

; call palindrome method
; * put your code here
AND R2, R2, #0 ; clear R2
ADD R2, R1, R4 
ADD R2, R2, #-1 ; set R2 to the end of the string N-1 since the last part of the array is zero 

LD R5, palindrome_addr
JSRR R5

; determine of stirng is a palindrome
; * put your code here
ADD R4, R4, #0
BRn YAY_PAL

BR BOO_PAL


YAY_PAL
LEA R0, result_string
PUTS
LEA R0, final_string
PUTS
BR skip 
BOO_PAL
LEA R0, result_string
PUTS
LEA R0, not_string
PUTS
LEA R0, final_string
PUTS
skip

; print the result to the screen
; * put your code here

; decide whether or not to print "not"
; * put your code here


HALT

;---------------------------------------------------------------------------------
; Required labels/addresses
;---------------------------------------------------------------------------------

; Stack address ** DO NOT CHANGE **
stack_addr           .FILL    xFE00

; Addresses of subroutines, other than main
get_user_string_addr .FILL    x3200
strlen_addr          .FILL    x3300
palindrome_addr      .FILL	  x3400


; Reserve memory for strings in the progrtam
user_prompt          .STRINGZ "Enter a string: "
result_string        .STRINGZ "The string is "
not_string           .STRINGZ "not "
final_string         .STRINGZ	"a palindrome\n"

; Reserve memory for user input string
user_string          .BLKW	  #100

.END

;---------------------------------------------------------------------------------
; get_user_string - DO NOT FORGET TO REPLACE THIS HEADER WITH THE PROPER HEADER
; Parameters: 
; R1 - address of the array that will store the string
; R2 - Neg enter value
; Returns - nothing 
;---------------------------------------------------------------------------------
.ORIG x3200
;get_user_string
; Backup all used registers, R7 first, using proper stack discipline
ADD R6, R6, #-1
STR R7, R6, #0
ADD R6, R6, #-1
STR R3, R6, #0
ADD R6, R6, #-1
STR R5, R6, #0



LD R2, NEG_ENTER


DO_WHILE_LOOP_SENTINAL1 ;start of loop
AND R3, R3, #0          ; make r3 zero
    GETC
    OUT
                 
    ADD R3, R0, R2 ; substract r0 - r2
    BRz END_DO_WHILE_LOOP_SENTINAL1 ; if the character was ENTER, end the loop
                    ; else we store the character 
    STR R0, R1, #0  ; saves the character to that address location
    ADD R1, R1, #1  ; iterates through the array  
    ;ADD R4, R4, #1  ; counts how many characters have been saved into the array
BRnzp DO_WHILE_LOOP_SENTINAL1 ; end of loop
    
    
END_DO_WHILE_LOOP_SENTINAL1 ; IF THE CHARACTER IS ENTER JUMP HERE
LD R0, NULL      ;assigns RO to null
STR R0, R1, #0   ;stores "null" R0 into array 


; Resture all used registers, R7 last, using proper stack discipline
LDR R5, R6, #0
ADD R6, R6, #1
LDR R3, R6, #0
ADD R6, R6, #1
LDR R7, R6, #0
ADD R6, R6, #1
RET
NEG_ENTER   .FILL #-10
NULL .FILL #0

.END

;---------------------------------------------------------------------------------
; strlen - DO NOT FORGET TO REPLACE THIS HEADER WITH THE PROPER HEADER
; Parameters:
; R1 - address of the beginning of the string 
; Return - the length of the string (R4)
;---------------------------------------------------------------------------------
.ORIG x3300
; Backup all used registers, R7 first, using proper stack discipline
ADD R6, R6, #-1
STR R7, R6, #0
ADD R6, R6, #-1
STR R3, R6, #0
ADD R6, R6, #-1
STR R2, R6, #0
ADD R6, R6, #-1
STR R5, R6, #0


AND R0, R0, #0 ;make R0 to zero 
                    
STRING_SIZE
LDR R2, R1, #0      ; load the character into R2 from the address
BRz IF_ZERO         ; if its zero then end the loop
ADD R4, R4, #1      ; else add 1 to the counter (R4)
ADD R1, R1, #1      ; iterate to the next character in the string 
BR STRING_SIZE
IF_ZERO


; Resture all used registers, R7 last, using proper stack discipline
LDR R5, R6, #0
ADD R6, R6, #1
LDR R2, R6, #0
ADD R6, R6, #1
LDR R3, R6, #0
ADD R6, R6, #1
LDR R7, R6, #0
ADD R6, R6, #1
RET
.END

;---------------------------------------------------------------------------------
; palindrome - DO NOT FORGET TO REPLACE THIS HEADER WITH THE PROPER HEADER
; R1 - address of the beginning of the string
; R2 - address of the end of the string
; returns - flag whether or not it is a palindrome or not 
;---------------------------------------------------------------------------------
.ORIG x3400
palindrome ; Hint, do not change this label and use for recursive alls
; Backup all used registers, R7 first, using proper stack discipline

ADD R6, R6, #-1
STR R7, R6, #0
ADD R6, R6, #-1
STR R3, R6, #0
ADD R6, R6, #-1
STR R2, R6, #0
;ADD R6, R6, #-1
;STR R5, R6, #0
;ADD R6, R6, #-1
;STR R4, R6, #0






; CHANGE THIS PART OF THE CODE BECAUSE WHAT YOU ARE DOING HERE IS JUST SUBTRACTING NUMBERS
; TO ACCESS THE INDIVIUAL CHARACTERS, USE LDR AND THEN DO THE CHECKS 
LDR R3, R1, #0  ; (Front of the array)
LDR R0, R2, #0  ; (end of the array)

NOT R3, R3,     ;twos compliment
ADD R3, R3, #1

ADD R3, R3, R0 ; If R3 - R0 = 0 then its the same character
BRz IF_PALINDROME

BR NOT_PALINDROME

IF_PALINDROME
ADD R1, R1, #1
ADD R2, R2, #-1
ADD R4, R4, #-2
BRn FINISH

JSR palindrome


NOT_PALINDROME
AND R5, R5, #0
ADD R5, R5, #1
BR NOT_PALINDROME_SKIP

FINISH
AND R5, R5, #0

NOT_PALINDROME_SKIP




;LDR R4, R6, #0
;ADD R6, R6, #1
;LDR R5, R6, #0
;ADD R6, R6, #1
LDR R2, R6, #0
ADD R6, R6, #1
LDR R3, R6, #0
ADD R6, R6, #1
LDR R7, R6, #0
ADD R6, R6, #1
RET

; Resture all used registers, R7 last, using proper stack discipline
.END


