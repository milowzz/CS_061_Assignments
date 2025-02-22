
;-----------------------
.orig x3000             ;x3000 stands for the address in memory, this is where the program will begin
LD R1, DEC_0  
LD R2, DEC_12
LD R3, DEC_6


Loop_multiply ;FOR LOOP 
ADD R1, R1, R2 ; r1(0) + r2(12) = r1
ADD R3, R3, #-1 ;r3(6) - 1 = r3
BRp Loop_multiply 





 HALT                  
 ;----------------
 ;Local data
 ;----------------
 DEC_2 .FILL #2
 DEC_NEG_ONE .FILL #-1
 DEC_0  .FILL #0       
 DEC_12 .FILL #12     
 DEC_6  .FILL #6
 
.END

