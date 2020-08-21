.globl write_matrix

.text
# ==============================================================================
# FUNCTION: Writes a matrix of integers into a binary file
#   If any file operation fails or doesn't write the proper number of bytes,
#   exit the program with exit code 1.
# FILE FORMAT:
#   The first 8 bytes of the file will be two 4 byte ints representing the
#   numbers of rows and columns respectively. Every 4 bytes thereafter is an
#   element of the matrix in row-major order.
# Arguments:
#   a0 is the pointer to string representing the filename
#   a1 is the pointer to the start of the matrix in memory
#   a2 is the number of rows in the matrix
#   a3 is the number of columns in the matrix
# Returns:
#   None
# ==============================================================================
write_matrix:

    # Prologue
    addi sp, sp, -24
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw s3, 12(sp)
    sw s4, 16(sp)
    sw ra, 20(sp)
    
    
	addi s0, a0, 0 # Pointer to filname
    addi s1, a2, 0 # Pointer to int1 (rows)
    addi s2, a3, 0 # Pointer to int2 (cols)
    addi s3, a1, 0 # Pointer to matrix
    
    
    addi a0, x0, 4
    jal ra, malloc
    addi t0, a0, 0
	sw s1, 0(t0)
	addi s1, t0, 0
	
	addi a0, x0, 4
    jal ra, malloc
    addi t0, a0, 0
	sw s2, 0(t0)
	addi s2, t0, 0
    
  
    addi a1, s0, 0
    addi a2, x0, 1
    
    jal ra, fopen
    
    addi t0, x0, -1
    beq t0, a0, eof_or_error
    
    addi s4, a0, 0 # File desciprtor
    
    addi a1, s4, 0
    addi a2, s1, 0
    addi a3, x0, 1
    addi a4, x0, 4
    
    jal ra, fwrite
    
    addi t0, x0, 1
    bne t0, a0, eof_or_error
    
	addi a1, s4, 0
    addi a2, s2, 0
    addi a3, x0, 1
    addi a4, x0, 4
    
    jal ra, fwrite
    
    addi t0, x0, 1
    bne t0, a0, eof_or_error

	lw t0, 0(s1)
	lw t1, 0(s2)
	
	addi a1, s4, 0
    addi a2, s3, 0
    mul a3, t0, t1
    addi a4, x0, 4
   

	jal ra, fwrite
	
	lw t0, 0(s1)
	lw t1, 0(s2)
	mul t2, t0, t1
    bne t2, a0, eof_or_error
	
	addi a1, s4, 0
	
	jal ra, fclose

	addi t0, x0, -1
    beq t0, a0, eof_or_error


    # Epilogue
        
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw s3, 12(sp)
    lw s4, 16(sp)
    lw ra, 20(sp)
    addi sp, sp, 24


    ret

eof_or_error:
    li a1 1
    jal exit2
    
