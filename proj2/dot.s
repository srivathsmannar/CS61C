.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 is the pointer to the start of v0
#   a1 is the pointer to the start of v1
#   a2 is the length of the vectors
#   a3 is the stride of v0
#   a4 is the stride of v1
# Returns:
#   a0 is the dot product of v0 and v1
# =======================================================
dot:

    # Prologue
    addi sp, sp, -28
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw s3, 12(sp)
    sw s4, 16(sp)
    sw s5, 20(sp)
    sw s6, 24(sp)
   
    addi s0, a0, 0 #Address v0 
    addi s1, a1, 0 #address v1
    addi s2, x0, 0 #Sum
    addi s3, x0, 0 #Count
    addi s4, a2, 0 #Length
    addi s5, a3, 0 #Stride1
    addi s6, a4, 0 #Stride2
    


loop_start:
    bge s3, s4, loop_end
    lw t0, 0(s0)
    lw t1, 0(s1)
    mul t2, t0, t1
    add s2, s2, t2
    addi s3, s3, 1
    slli t0, s5, 2
    slli t1, s6, 2
    add s0, s0, t0
    add s1, s1, t1
    j loop_start

loop_end:
    addi a0, s2, 0

    # Epilogue
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw s3, 12(sp)
    lw s4, 16(sp)
    lw s5, 20(sp)
    lw s6, 24(sp)
    addi sp, sp, 28
    
    ret
