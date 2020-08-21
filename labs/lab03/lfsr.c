#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include "lfsr.h"

void lfsr_calculate(uint16_t *reg) {
unsigned  bitfive = (*reg>>5)&1;
unsigned bitthree = (*reg>>3)&1;
unsigned bittwo = (*reg>>2)&1;
unsigned bitzero = (*reg>>0)&1;
int v = bitfive^(bitthree^(bittwo^bitzero));
*reg = *reg >> 1;
*reg = (v << 15) | (*reg & (~(1 << 15)));
}

