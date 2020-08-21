addi s0 x0 -9
bne s0 s0 never_reach
never_reach:
  addi s0, s0, 1
  beq s0 x0 endd
  bne s0 x0 end
end:
  addi a0 a0 1
  bne s0 x0 never_reach
endd:
	addi x9 x0 3