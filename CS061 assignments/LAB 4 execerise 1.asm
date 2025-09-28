;=========================================================================
;
;
; NOTE: Use R7 only for storing addresses 
; JSRR: will jump to that address and automatically save the next line's address location after where JSRR was set to R7
; RET: Make the register to go back where it came from 
;=========================================================================


.ORIG x3000			; Program begins here
;-------------
;Instructions: CODE GOES HERE
;-------------

LD R1, ARRAY_PTR
LD R0, ZERO 
LD R3, TEN

LD R2, SUB_FILL_ARRAY_3200
JSRR R2
LD R1, ARRAY_PTR



HALT

ARRAY_PTR .FILL x4000
ZERO .FILL #0
TEN .FILL #10
SUB_FILL_ARRAY_3200 .FILL x3200


.end 


.ORIG x4000
ARRAY_1	.BLKW  #10 ; blank array of 10 locations 
.end
;Have pointer (label for subroutine here) (include .end)

;=======================================================================
; Subroutine: SUB_intelligent_name_goes_here_3200
; Parameter: (R1): [start of the array (address of array)]
; Postcondition: [it will store values from 0 to 9]
; Return Value: [nothing is returned for this case]
;=======================================================================

.orig x3200       ; use the starting address as part of the sub name

DO_WHILE_LOOP
               
    STR R0, R1, #0  ; stores the value from R0 into the array
    ADD R1, R1, #1  ; iterates through the array
    ADD R0, R0, #1  ; adds 1 to r0
    ADD R3, R3, #-1 ; moves on to the next iteration of the loop to repeat steps 
    BRp DO_WHILE_LOOP
END_DO_WHILE_LOOP
 

RET

.end

;---------------	
;END of PROGRAM
;---------------	

.END 
