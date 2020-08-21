.import read_matrix.s
.import write_matrix.s
.import matmul.s
.import dot.s
.import relu.s
.import argmax.s
.import utils.s

.globl main

.text
main:
    # =====================================
    # COMMAND LINE ARGUMENTS
    # =====================================
    # Args:
    #   a0: int argc
    #   a1: char** argv
    #
    # Usage:
    #   main.s <M0_PATH> <M1_PATH> <INPUT_PATH> <OUTPUT_PATH>

    # Exit if incorrect number of command line args
    addi t0, x0, 5
    bne t0, a0, eof_or_error




	# =====================================
    # LOAD MATRICES
    # =====================================
   #Load addresses of matrices
   addi s0, a1, 0 #Address of argv



    # Load pretrained m0
    ebreak
   addi a0, x0, 4
   jal ra, malloc
   addi s4, a0, 0
   
   addi a0, x0, 4
   jal ra, malloc
   addi s5, a0, 0
   
   addi a1, s4, 0 #Rows m0
   addi a2, s5, 0 #Columns m0
   
   lw a0, 4(s0)
   jal ra, read_matrix
   addi s1, a0, 0 #Matrix m0 


    # Load pretrained m1
    ebreak
   addi a0, x0, 4
   jal ra, malloc
   addi s6, a0, 0
   
   addi a0, x0, 4
   jal ra, malloc
   addi s7, a0, 0
    
   lw a0, 8(s0)
   addi a1, s6, 0 #Rows m1
   addi a2, s7, 0 #Columns m1
   jal ra, read_matrix
   addi s2, a0, 0 #Matrix m1

    # Load input matrix
    ebreak
   addi a0, x0, 4
   jal ra, malloc
   addi s8, a0, 0
   
   addi a0, x0, 4
   jal ra, malloc
   addi s9, a0, 0
    
   lw a0, 12(s0)
   addi a1, s8, 0 #Rows input
   addi a2, s9, 0 #Columns input
   jal ra, read_matrix
   addi s3, a0, 0 #Matrix input


    # =====================================
    # RUN LAYERS
    # =====================================
    # 1. LINEAR LAYER:    m0 * input
    # 2. NONLINEAR LAYER: ReLU(m0 * input)
    # 3. LINEAR LAYER:    m1 * ReLU(m0 * input)
	ebreak
    lw t0, 0(s4)
    lw t1, 0(s9)
    mul t2, t0, t1
    slli a0, t2, 2
    jal ra, malloc
   	addi s10, a0, 0
    
    
	addi a0, s1, 0 
	lw a1, 0(s4)
	lw a2, 0(s5)
	addi a3, s3, 0
	lw a4, 0(s8)
	lw a5, 0(s9)
  
	addi a6, s10, 0 #Linear layer
    
    jal ra, matmul
	
	addi a0, s10, 0
    lw t0, 0(s4)
    lw t1, 0(s9)
	mul a1, t0, t1
	jal ra, relu
	
    lw t0, 0(s6)
    lw t1, 0(s9)
    mul t2, t0, t1
    slli a0, t2, 2
    jal ra, malloc
   	addi s11, a0, 0
	
	addi a3, s10, 0 
	lw a4, 0(s4)
	lw a5, 0(s9)
	addi a0, s2, 0
	lw a1, 0(s6)
	lw a2, 0(s7)
	addi a6, s11, 0 #Output layer
    
    jal ra, matmul
	
	
    # =====================================
    # WRITE OUTPUT
    # =====================================
    # Write output matrix
    ebreak
    lw a0 16(s0) # Load pointer to output filename
    addi a1, s11, 0
    lw a2, 0(s6)
    lw a3, 0(s9)
	jal ra, write_matrix



    # =====================================
    # CALCULATE CLASSIFICATION/LABEL
    # =====================================
    # Call argmax
    ebreak
	addi a0, s11, 0
    lw t0, 0(s6)
    lw t1, 0(s9)
	mul a1, t0, t1
	
	jal ra, argmax



    # Print classification
    addi a1, a0, 0
    
    jal ra, print_int



    # Print newline afterwards for clarity
    li a1 '\n'
    jal print_char

    jal exit


eof_or_error:
    li a1 3
    jal exit2
