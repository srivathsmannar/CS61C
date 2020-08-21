.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
# 	a0 is the pointer to the array
#	a1 is the # of elements in the array
# Returns:
#	None
# ==============================================================================
relu:
    # Prologue
    addi sp, sp, -8
    sw s0, 0(sp)
    sw s1, 4(sp)
    addi s0, a0, 0
    addi s1, a1, 0

loop_start:
    beq s1,x0, loop_end
    lw t0, 0(s0)
    bge t0, x0, loop_continue
    addi t0, x0, 0
    sw t0, 0(s0)
    j loop_continue 

loop_continue:
    addi s0, s0, 4
    addi s1, s1, -1
    j loop_start

loop_end:
    lw s0, 0(sp)
    lw s1, 4(sp)
    addi sp, sp, 8
    ret
