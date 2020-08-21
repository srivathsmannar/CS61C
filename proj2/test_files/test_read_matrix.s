.import ../read_matrix.s
.import ../utils.s

.data
file_path: .asciiz "./file.bin"

.text
main:
    # Read matrix into memory
    addi sp, sp, -8
    sw s0, 0(sp)
    sw s1, 4(sp)
    addi a0, x0, 4

    jal ra, malloc
    addi s0, a0, 0

    addi a0, x0, 4
    jal ra, malloc
    addi s1, a0, 0
    

    la a0, file_path
    
    addi a1, s0, 0
    addi a2, s1, 0
 
    jal ra, read_matrix	
    lw a1, 0(s0)
    lw a2, 0(s1)


    # Print out elements of matrix
    jal ra, print_int_array


	lw s0, 0(sp)
    lw s1, 4(sp)
    addi sp, sp, 8
    
    # Terminate the program
    addi a0, x0, 10
    

    ecall
