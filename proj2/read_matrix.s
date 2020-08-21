.globl read_matrix

.text
# ==============================================================================
# FUNCTION: Allocates memory and reads in a binary file as a matrix of integers
#   If any file operation fails or doesn't read the proper number of bytes,
#   exit the program with exit code 1.
# FILE FORMAT:
#   The first 8 bytes are two 4 byte ints representing the # of rows and columns
#   in the matrix. Every 4 bytes afterwards is an element of the matrix in
#   row-major order.
# Arguments:
#   a0 is the pointer to string representing the filename
#   a1 is a pointer to an integer, we will set it to the number of rows
#   a2 is a pointer to an integer, we will set it to the number of columns
# Returns:
#   a0 is the pointer to the matrix in memory
# ==============================================================================
read_matrix:

	addi sp, sp, -36
	sw s0, 0(sp)
	sw s1, 4(sp)
	sw s2, 8(sp)
	sw s3, 12(sp)
	sw s4, 16(sp)
	sw s5, 20(sp)
	sw s6, 24(sp)
	sw s7, 28(sp)
	sw ra, 32(sp)

    # Prologue
    addi s0, a0, 0 # Pointer to filname
    addi s1, a1, 0 # Pointer to int1 (rows)
    addi s2, a2, 0 # Pointer to int2 (cols)
   

    addi a1, s0, 0
    addi a2, x0, 0
 
    #Open filname
    jal ra, fopen
   
    addi t0, x0, -1
    beq a0, t0, eof_or_error
 
    addi s3, a0, 0 # File descriptor
    
    addi a1, s3, 0 #setting file desciprtor
    addi a2, s1, 0 
    addi a3, x0, 4
    
    jal ra, fread #getting rows
    
    addi t0, x0, 4
    bne a0, t0, eof_or_error
 
   
    addi a1, s3, 0 #setting file desciprtor
    addi a2, s2, 0 
    addi a3, x0, 4
    
    jal ra, fread #getting columns
    
    addi t0, x0, 4
    bne a0, t0, eof_or_error
    
    lw t0, 0(s1) #rows
    lw t1, 0(s2) #cols


    mul s4, t0, t1 #total nums

    slli a0, s4, 2 #total number of bytes
    
    jal ra, malloc #mallocing
    
    addi s5, a0, 0 #address of matrix
    addi s6, x0, 0 #current index
	addi s7, s5, 0 #current pointer in matrix

helper: 
        addi a1, s3, 0 #setting file desciprtor
        addi a2, s7, 0 
        slli a3, s4, 2

        jal ra, fread
        
        slli t0, s4, 2
    	bne a0, t0, eof_or_error
	
exit:
    # Epilogue
    addi a0, s3, 0
    jal ra, fclose
    
    addi t0, x0, -1
    beq a0, t0, eof_or_error
    
	addi a0, s5, 0

	
	lw s0, 0(sp)
	lw s1, 4(sp)
	lw s2, 8(sp)
	lw s3, 12(sp)
	lw s4, 16(sp)
    lw s5, 20(sp)
    lw s6, 24(sp)
    lw s7, 28(sp)
    lw ra, 32(sp)
    addi sp, sp, 36
    ret

eof_or_error:
    li a1 1
    jal exit2
    
