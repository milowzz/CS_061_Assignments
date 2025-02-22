;=================================================
; Name: Anthony Olguin
; Email: aolgu015@ucr.edu
; 
; Lab: lab 8, ex 1
; Lab section: 021
; TA: Karan Bhogal
; 
;=================================================

.orig x3000

LD R6, top_stack_addr           ; load top address of stack into r6

; Test harness
;-------------------------------------------------
LD R6, LOAD_FILL_VALUE_ptr      ; load subroutine into r6
JSRR R6                         ; jump to r6 subroutine 

ADD R1, R1, #1                  ; add 1 to the value in r1
LD R6, OUTPUT_AS_DECIMAL_ptr    ; load subroutine into r6
JSRR R6                         ; jump to r6 subroutine 

HALT

; Test harness local data
;-------------------------------------------------
top_stack_addr .fill xFE00      ; top of stack

LOAD_FILL_VALUE_ptr      .FILL x3200    ; address of subroutine
OUTPUT_AS_DECIMAL_ptr   .FILL x3400     ; address of subroutine 

.end

;=================================================
; Subroutine: LOAD_FILL_VALUE_3200
; Parameter: NA
; Postcondition: Return the hard coded value
; Return Value: Hard coded value 
;=================================================

.orig x3200

; Backup registers
ST R2, backup_r2_3200    
ST R3, backup_r3_3200     
ST R4, backup_r4_3200
ST R5, backup_r5_3200
ST R6, backup_r6_3200  
ST R7, backup_r7_3200  

; Code
LD R1, Num                  ; hard coded value into r1

; Restore registers
LD R2, backup_r2_3200     
LD R3, backup_r3_3200
LD R4, backup_r4_3200 
LD R5, backup_r5_3200
LD R6, backup_r6_3200 
LD R7, backup_r7_3200

RET                         ; return from subroutine 

backup_r2_3200  .BLKW #1
backup_r3_3200  .BLKW #1
backup_r4_3200  .BLKW #1
backup_r5_3200  .BLKW #1
backup_r6_3200  .BLKW #1
backup_r7_3200  .BLKW #1

Num             .FILL #1245     ; hard coded value 

.end

;=================================================
; Subroutine: OUTPUT_AS_DECIMAL_3400
; Parameter: NA
; Postcondition: Counter
; Return Value: Counter 
;=================================================

.orig x3400

; Backup registers
ST R1, backup_r1_3400
ST R2, backup_r2_3400    
ST R3, backup_r3_3400     
ST R4, backup_r4_3400
ST R5, backup_r5_3400
ST R6, backup_r6_3400  
ST R7, backup_r7_3400  

; Code
; if r1 is positive or zero, skip the next 3, else print negative sign
    ADD R1, R1, #0              
    brzp #4               ;if r1 < 0, then output -sign, and set r1 = -r1
        NOT R1, R1        ; 2s compliment
        ADD R1, R1, #1
        LD R0, hex_2D           ; load ascii value 
        OUT                     ; output negative sign
		    
    LD R2, num_10000s           ; r2 loaded with -10000
    LD R3, num_0                ; r3 loaded with ascii value of 0
    AND R0, R0, #0              ; clear r0 to use as the counter 
		    
; subtract powers of 10 from r1 to count how many times 
_10000s_place_loop          
    ADD R1, R1, R2          ; subtract r1 by adding -100000
    BRzp #9                 ; if result is ZP then continue
        ADD R2, R2, #-1     ; undo last subtraction by decrementing r2 which holds the -10000
        NOT R2, R2          ; twos compliment to negate and make r2 positive 
        ADD R1, R1, R2      ; add back to throw amount into r1
        AND R0, R0, R0      ; clear r0 for the counter 
    BRz #2                  ; if counter is r0 counter is 0 then dont print this digit
        ADD R0, R0, R3      ; convert the counter to ACII
        OUT                 ; output the digit 
        ;ADD R0, R0, R3
    BR _1000s_place_loop_pre    ; skips to next loop
        ADD R0, R0, #1          ; increments counter to indicate loop count
    BR _10000s_place_loop       ; continues the current loop

; prepare loop to determine how many times 1000 can be subtracted from r1 
_1000s_place_loop_pre
	LD R2, num_1000s            ; load negative value of 1000 into r2 for subtraction
			
	    NOT R3, R3              ; invert r3, using twos compliment makes it -49
	    ADD R3, R3, #1          ; correct the inversion by adding 1
			
	    ADD R0, R0, R3          ; subtract 48 from 0, it now holds the twos compliment 
	BRp #2                      ; if r0 is P, branch to reset counter 
	    ADD R6, R0, #1          ; r6 is the flag, if r0 is 0 then r6 is now 1 after add
	BR #2                       ; branch to continue 
	    AND R6, R6, #0          ; reset r6 to 0
	    AND R0, R0, #0          ; reset r0 to 0

; indicate the start of the 1000s place loop 
_1000s_place_loop           
    ADD R1, R1, R2          ; subtract 1000 from r1 by adding the value to r2
    BRzp #17                ; if result is ZP increment the counter and continue 
        ADD R2, R2, #-1     ; if r1 is negative, decrement the value in r2
        NOT R2, R2          ; invert r2 to make it positive again
        ADD R1, R1, R2      ; add the positive value of r2 to r1 to undo subtraction
        AND R0, R0, R0      ; clear the counter to prepare for incrementation 
    BRz #4                  ; if r0 is 0, it means r1 is less than 1000 to begin with and nothing will be printed
        LD R3, num_0        ; reset r3 = 48  (ascii value) 
        ADD R0, R0, R3      ; convert the counter 
        OUT                 ; output the ascii value of the counter 
    BR _100s_place_loop_pre
                        
        AND R6, R6, R6
    Brp #3                
        LD R3, num_0    ;if r6 = 0, then 10000s place is not = 0 output the number. else dont print the number
        ADD R0, R0, R3
        OUT
        LD R3, num_0                ;R3 = 48
        ADD R0, R0, R3
    BR _100s_place_loop_pre
                    
        ADD R0, R0, #1
    BR _1000s_place_loop

_100s_place_loop_pre
	    LD R2, num_100s            ;r2 = -100
			
	    NOT R3, R3
	    ADD R3, R3, #1              ;R3 = -48
			
	    ADD R0, R0, R3              ;R0 = R0 - 48
	BRp #2                      
	    ADD R6, R0, #1          ;if r0 = 0, r6 = 1. if 100s place is also 0, we have to check 1000s place to decide weather to output this 0
	BR #2
	    AND R0, R0, #0              ;reset r0 to 0
	    AND R6, R6, #0              ;reset r6 to 0
			
_100s_place_loop            ;SIMULATE R1/100
        ADD R1, R1, R2          ;R1-1000
    BRzp #17                 ;if r1-100 >=0, counter +=1, 
        ADD R2, R2, #-1     ;if r1-100 <0, reset r1(r1+100)
        NOT R2, R2          
        ADD R1, R1, R2
        AND R0, R0, R0      ;get the counter
    BRz #4              ;if the counter = 0(the r1 was smaller than 1000 at the beginning of 1000s_place_loop)
        LD R3, num_0    ;reset r3 = 48   
        ADD R0, R0, R3
        OUT
    BR _10s_place_loop_pre
                        
        AND R6, R6, R6
    Brp #3                
        LD R3, num_0    ;if r6 = 0, then 1000s place is not = 0 output the number. else dont print the number
        ADD R0, R0, R3
        OUT
        LD R3, num_0                ;R3 = 48
        ADD R0, R0, R3
    BR _10s_place_loop_pre
                    
        ADD R0, R0, #1
    BR _100s_place_loop
    
_10s_place_loop_pre
	LD R2, num_10s            ;r2 = -10
			
	    LD R3, num_0    ;reset r3 = 48 
	    NOT R3, R3
	    ADD R3, R3, #1              ;R3 = -48
			
	    ADD R0, R0, R3              ;R0 = R0 - 48
	BRp #2                      
	    ADD R6, R0, #1          ;if r0 = 0, r6 = 1. if 10s place is also 0, we have to check 100s place to decide weather to output this 0
	BR #2
	    AND R0, R0, #0              ;reset r0 to 0
	    AND R6, R6, #0              ;reset r6 to 0
			
_10s_place_loop              ;SIMULATE R1/10
        ADD R1, R1, R2          ; R1-10
    BRzp #17                ;if r1-10 >=0, counter +=1, 
        ADD R2, R2, #-1     ;if r1-10 <0, reset r1(r1+10)
        NOT R2, R2          
        ADD R1, R1, R2
        AND R0, R0, R0      ;get the counter
    BRz #4              ;if the counter = 0(the r1 was smaller than 1000 at the beginning of 100s_place_loop)
        LD R3, num_0    ;reset r3 = 48   
        ADD R0, R0, R3
        OUT
    BR _1s_place_loop_pre
                        
        AND R6, R6, R6
    Brp #3                
        LD R3, num_0    ;if r6 = 0, then 100s place is not = 0 output the number. else dont print the number
        ADD R0, R0, R3
        OUT
        LD R3, num_0                ;R3 = 48
        ADD R0, R0, R3
    BR _1s_place_loop_pre
                    
        ADD R0, R0, #1
    BR _10s_place_loop
    
_1s_place_loop_pre
    ;now r1 is in range [0,9], just print it
		    
    LD R3, num_0
    ADD R0, R1, R3
	OUT

; Restore registers
LD R1, backup_r1_3400
LD R2, backup_r2_3400     
LD R3, backup_r3_3400
LD R4, backup_r4_3400 
LD R5, backup_r5_3400
LD R6, backup_r6_3400 
LD R7, backup_r7_3400
            

RET
backup_r1_3400  .BLKW #1
backup_r2_3400  .BLKW #1
backup_r3_3400  .BLKW #1
backup_r4_3400  .BLKW #1
backup_r5_3400  .BLKW #1
backup_r6_3400  .BLKW #1
backup_r7_3400  .BLKW #1

hex_2D          .FILL x2d   ;"-"
num_0           .FILL #48
num_10000s      .FILL #-10000
num_1000s       .FILL #-1000
num_100s        .FILL #-100
num_10s         .FILL #-10
num_1s          .FILL #-1

.end