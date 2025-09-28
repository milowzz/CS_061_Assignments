
;=========================================================================

;=========================================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------

;----------------------------------------------
;output prompt
;----------------------------------------------	

LEA R0, intro	; get starting address of prompt string
PUTS			; output string


;-------------------------------
;INSERT YOUR CODE here
;--------------------------------
LD R2, -DEC_48   ; loads -48 to R2
LD R5, POS_48  ; Load #48 into R5
;LD R0, newline  ; loads the newline into R0
;OUT             ; outputs the newline (IMPORTANT: OUT only prints whatever is inside of R0)

GETC            ; Waits for the user to put a number in and saves it to R0
OUT             ; Outputs the first number


ADD R3, R0, R2  ; Adds ASCII value of R0(49) + (-48) = 1 and assigns it to R3 FIRST NUMBER 
LD R0, newline  ; loads the newline into R0
OUT             ; outputs R0


GETC            ; Get the second number from the user 
OUT             ; Outputs the second number

ADD R4, R0, R2  ; Adds the ASCII value of R0(50)+(-48) = 2 and assigns it to R4 SECOND NUMBER 
LD R0, newline  ; loads the newline into R1
OUT 

AND R0, R0, #0 ; clears R0 
LD R0, zero    ; loads in 0 into R0
ADD R0, R0, R3 ; Add zero (R0) to R3
OUT            ; outputs R0

LD R0, SPACE   ; outputs space
OUT


LD R0, NEG    ; Loads the ASCII code for "-"  
OUT           ; outputs "-"

LD R0, SPACE  ; outputs space 
OUT


AND R0, R0, #0 ; clears R0 
LD R0, zero    ; loads in 0 into R0
ADD R0, R0, R4 ; Add zero (R0) to R4
OUT            ; outputs R0

 
LD R0, SPACE   ; outputs space
OUT


LD R0, EQ      ; outputs "="
OUT


LD R0, SPACE   ; outputs space
OUT

; find negative of the two's complement number in R4 SECOND NUMBER 
NOT R4, R4
ADD R4, R4, #1

AND R0, R0, #0 ; clears R0 
LD R0, zero    ; loads in 0 into R0
ADD R0, R3, R4 ; R3 - R4 => R0

; LAST STEP ------------------------------------------------------------------------------------------------------
BRzp negative 
; IF NEGATIVE DO ALL THIS
; take the 2s compliment

 NOT R0, R0
 ADD R0, R0, #1
 ADD R1, R0, R5; add 48 to R0 and store it into R1 

 LD R0, NEG     ; loads in "-" into R0 
 OUT            ; output "-"
  
 
 LD R0, zero    ; loads 0 into R0
 ADD R0, R1, #0 ; assign r1 to r0
 OUT            ; output r0
 LD R0, newline  ; newline 
 OUT 
 HALT
  negative 


ADD R0, R0, R5 ; Offset by 48 to positive result 
OUT            ; output R0

LD R0, newline  ; newline 
OUT 


HALT  ; stop execution of program
             
;------	
;Data
;------
; String to prompt user. Note: already includes terminating newline!
intro 	.STRINGZ	"ENTER two numbers (i.e '0'....'9')\n" 		; prompt string - use with LEA, followed by PUTS.
newline .FILL x0A	; newline character - use with LD followed by OUT
-DEC_48 .FILL #-48  ;
POS_48  .FILL #48
zero .FILL x30
NEG .FILL  x2D      ; ASCII code of "-"
EQ  .FILL  x3D      ; ASCII code of "="    
SPACE .FILL #32     ; ASCII code of [space]
;---------------	
;END of PROGRAM
;---------------	

.END
