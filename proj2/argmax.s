.globl argmax

.text
# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
#	element. If there are multiple, return the one
#	with the smallest index.
# Arguments:
# 	a0 is the pointer to the start of the vector
#	a1 is the # of elements in the vector
# Returns:
#	a0 is the first index of the largest element
# =================================================================
argmax:
	addi sp, sp, -24
        sw s0, 0(sp)
        sw s1, 4(sp)
        sw s2, 8(sp)
        sw s3, 12(sp)
        sw s4, 16(sp)
        sw s5, 20(sp)
        addi s0, a0, 0
        addi s1, a1, 0
	
	lw s4, 0(s0)
        addi s3, x0, 0

	addi s0, s0, 4

        addi s2, x0, 1

loop_start:
       bge s2, s1, loop_end
       lw s5, 0(s0)
       bge s4, s5, loop_continue
       addi s4, s5, 0
       addi s3, s2, 0

loop_continue:
      addi s2, s2, 1
      addi s0, s0, 4
  	j loop_start

loop_end:
        addi a0, s3, 0
        lw s0, 0(sp)
        lw s1, 4(sp)
        lw s2, 8(sp)
        lw s3, 12(sp)
        lw s4, 16(sp)
        lw s5, 20(sp)
     addi sp, sp, 24
    # Epilogue


    ret
