.import ../write_matrix.s
.import ../utils.s

.data
m0: .word 1, 2, 3, 4, 5, 6, 7, 8, 9 # MAKE CHANGES HERE
file_path: .asciiz "test_output.bin"

.text
main:
    # Write the matrix to a file
    addi sp, sp, -8
    sw s0, 0(sp)
    sw s1, 4(sp)
        

    la a0, file_path
    
    la a1, m0
   
    
    addi a2, x0, 3
    addi a3, x0, 3
 
    jal ra, write_matrix	
    
    # Exit the program
    addi a0 x0 10
    ecall
