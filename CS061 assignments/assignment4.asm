;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Emilio A Rivas 
; Email: emilio.rivas@email.ucr.edu
; 
; Assignment name: Assignment 4
; Lab section: 002 
; TA: Karan
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=================================================================================
;THE BINARY REPRESENTATION OF THE USER-ENTERED DECIMAL NUMBER MUST BE STORED IN R4
;=================================================================================

.ORIG x3000		
;-------------
;Instructions
;-------------

;THIS IS THE VERY BEGINNING
INITIALCHAR
AND R4, R4, x0
LD R1, NEG_PLUS
LD R7, DEC_FIVE ; COUNTER   
AND R2, R2, #0  ; SET R2 AS POSTIVE FLAG 
;CLEAR ALL REGISTERS AND RESET THEM

LD R0, introPromptPtr 
PUTS
LD R0, hex_newline
OUT

GETC
OUT
;+
    ;CHECK IF ITS A "PLUS"
    ADD R1, R0, R1
    BRz POSITIVE


;-
    ; CHECK IF ITS A "MINUS"
    LD R1, NEG_MINUS
    ADD R1, R0, R1
    BRz NEGATIVE
    
    ;SET ONE REGISTER TO BE A NEGATIVE FLAG
    ;GO TO EVERYOTHER
    
    LD R1, newline
    ADD R1, R0, R1
    BRz ENDPROGRAM
    
    BR OTHERWISE
    ENDPROGRAM
    HALT            ;NEWLINE = END PROG
    

;IF NONE OF THESE: JUMP TO INPUT VALIDATION
NEGATIVE
ADD R2, R2, #1  ; IF ITS NEGATIVE MAKE R2 "1" FOR FLAG 
POSITIVE   
GETC 
OUT
BR INPUT_VALIDATION

EVERYOTHER_CHARACTER  ;BEFORE WE MOVE ON THE NEXT NUMBER CHECK IT FIRST WITH INPUT_VALIDATION
                      ; THIS PREVENTS FROM OUTPUTTING A + OR -
GETC
OUT
INPUT_VALIDATION
OTHERWISE 

LD R1, newline
ADD R1, R0, R1
BRz ENDPROG ;if its an enter, IMMEDIATELY END PROGRAM


    ;48 = 0
    ;57 = 9
    
; < 48, not a NUMBER (BRn)
    ;IF NOT A NUMBER, RESTART PROGRAM FROM THE INITIAL CHARACTER
    LD R1, NEG_48
    ADD R1, R0, R1
    BRn IF_INPUT_LESS_THAN_ZERO
    
; > 57 NOT A NUMBER (BRp)
    LD R1, NEG_DEC_9
    ADD R1, R0, R1
    BRp IF_INPUT_GREATER_THAN_NINE
    ;IF NOT A NUMBER, RESTART PROGRAM FROM THE INITIAL CHARACTER
    
    
;IF THERE IS NO ERROR, SAVE VALUE TO R4 & GO TO MATH
    
    BR MATH

;IF ERROR, BR ERROR

    IF_INPUT_LESS_THAN_ZERO
    IF_INPUT_GREATER_THAN_NINE
    BR ERROR

;YOU CAN DO MATH
    MATH
LD R1, NEG_48
ADD R0, R0, R1 ;MAKE ASCII INTO ACTUAL NUMBER 
;ADD R4, R4, R0 ; ASSIGN NUMBER TO R4
LD R1, DEC_10
    
  
    ADD R5, R4, R4 ; TIMES 2
    ADD R3, R5, R5 ; TIMES 4
    ADD R6, R3, R3 ; TIMES 8
    ADD R4, R5, R6 ; TIMES 10
    
    
    ADD R4, R4, R0 ;R4*10 + NUM(R0)





;SUBTRACT FROM COUNTER (WHICH STARTS AS 5)
ADD R7, R7, #-1
BRZ END_PROGRAM
BR EVERYOTHER_CHARACTER




    

ERROR
LD R0, hex_newline
OUT

LD R0, errorMessagePtr
PUTS
BR INITIALCHAR ; IF AN INVALID CHAR IS INPUTTED, OUTPUT ERROR MESSAGE AND RESTART FROM TNE BEGINNING




END_PROGRAM


;IF YOUR NEG FLAG/REGISTER IS 1, DO 2'S COMPLEMENT ON R4
ADD R2, R2, #0
BRp DO_COMPLEMENT

BR NO_COMPLEMENT


DO_COMPLEMENT
NOT R4, R4
ADD R4, R4, #1

BR END_NEG_FIVE

NO_COMPLEMENT

;OUTPUT NEWLINE
LD R0, hex_newline
OUT



ENDPROG
ADD R2, R2, #0
BRp DO_COMPLEMENT_2

BR NO_COMPLEMENT_2

DO_COMPLEMENT_2
NOT R4, R4
ADD R4, R4, #1

NO_COMPLEMENT_2
END_NEG_FIVE

HALT



;---------------	
; Program Data
;---------------

introPromptPtr  .FILL xB000
errorMessagePtr .FILL xB200

NEG_DEC_10      .FILL #-10
DEC_10          .FILL #10
NEG_DEC_9       .FILL #-57
NEG_PLUS        .FILL #-43
NEG_MINUS       .FILL #-45
DEC_FIVE        .FILL #5
NEG_48          .FILL #-48

hex_newline     .FILL x0A
newline         .FILL #-10
.END

;------------
; Remote data
;------------
.ORIG xB000	 ; intro prompt
.STRINGZ	 "Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"

.END					
					
.ORIG xB200	 ; error message
.STRINGZ	 "ERROR: invalid input\n"

;---------------
; END of PROGRAM
;---------------
.END

;-------------------
; PURPOSE of PROGRAM
;-------------------
; Convert a sequence of up to 5 user-entered ascii numeric digits into a 16-bit two's complement binary representation of the number.
; if the input sequence is less than 5 digits, it will be user-terminated with a newline (ENTER).
; Otherwise, the program will emit its own newline after 5 input digits.
; The program must end with a *single* newline, entered either by the user (< 5 digits), or by the program (5 digits)
; Input validation is performed on the individual characters as they are input, but not on the magnitude of the number.



