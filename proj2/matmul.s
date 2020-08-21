.globl matmul
.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
# 	d = matmul(m0, m1)
#   If the dimensions don't match, exit with exit code 2
# Arguments:
# 	a0 is the pointer to the start of m0
#	a1 is the # of rows (height) of m0
#	a2 is the # of columns (width) of m0
#	a3 is the pointer to the start of m1
# 	a4 is the # of rows (height) of m1
#	a5 is the # of columns (width) of m1
#	a6 is the pointer to the the start of d
# Returns:
#	None, sets d = matmul(m0, m1)
# =======================================================
matmul:

    # Error if mismatched dimensions
    bne a2, a4, mismatched_dimensions

    # Prologue
    addi sp, sp, -40
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw s3, 12(sp)
    sw s4, 16(sp)
    sw s5, 20(sp)
    sw s6, 24(sp)
    sw s7, 28(sp)
    sw s8, 32(sp)
    sw ra, 36(sp)

    addi s0, a0, 0 #Pointer to matrix 1
    addi s1, a3, 0 #Pointer to matrix 2
    addi s2, x0, 0 # Row index
    addi s3, a1, 0 # total rows
    addi s4, x0, 0 # current column
	 
    
    addi s5, a6, 0 # Pointer to d
    addi s6, s1, 0 # Pointer to beginning of matrix 2
    addi s7, a2, 0 #number of columns1/row2
    addi s8, a5, 0 #always number of col2



outer_loop_start_1:
    bge s2, s3, outer_loop_end_1

inner_loop_start_1:
    bge s4, s8, inner_loop_end_1
    ebreak
    addi a2, s7, 0
    addi a0, s0, 0
    addi a1, s1, 0
    addi a3, x0, 1
    addi a4, s8, 0
    jal ra, dot
    ebreak
    sw a0, 0(s5)
    addi s5, s5, 4
    addi s4, s4, 1
    addi s1, s1, 4
    j inner_loop_start_1

inner_loop_end_1:
    addi s4, x0, 0
    addi s2, s2, 1
    addi s1, s6, 0
    slli t0, a2, 2
    add s0, s0, t0
    j outer_loop_start_1

outer_loop_end_1:
    # Epilogue   
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw s3, 12(sp)
    lw s4, 16(sp)
    lw s5, 20(sp)
    lw s6, 24(sp)
    lw s7, 28(sp)
    lw s8, 32(sp)
    lw ra, 36(sp)
    addi sp, sp, 40
    ret


mismatched_dimensions:
    li a1 2
    jal exit2
    
    
