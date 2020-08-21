/*********************
**  Complex Numbers
**  This file contains a few functions that will be useful when performing computations with complex numbers
**  It is advised that you work on this part first.
**********************/

#include "ComplexNumber.h"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>


typedef struct ComplexNumber
{
	double real;
	double imaginary;
}ComplexNumber;

//Returns a pointer to a new Complex Number with the given real and imaginary components
ComplexNumber* newComplexNumber(double real_component, double imaginary_component)
{
    //YOUR CODE HERE
    ComplexNumber *x;
    x = (ComplexNumber*)malloc(sizeof(ComplexNumber));
    x->real = real_component;
    x->imaginary = imaginary_component;
	return x;
}

//Returns a pointer to a new Complex Number equal to a*b
ComplexNumber* ComplexProduct(ComplexNumber* a, ComplexNumber* b)
{
    //YOUR CODE HERE
	return newComplexNumber(a->real*b->real - a->imaginary*b->imaginary, 
		a->real*b->imaginary + a->imaginary*b->real);
}

//Returns a pointer to a new Complex Number equal to a+b
ComplexNumber* ComplexSum(ComplexNumber* a, ComplexNumber* b)
{
    //YOUR CODE HERE
	return newComplexNumber(a->real + b->real, a->imaginary + b->imaginary);
}

//Returns the absolute value of Complex Number a
double ComplexAbs(ComplexNumber* a)
{
    //YOUR CODE HERE
	return sqrt(a->real*a->real + a->imaginary*a->imaginary);
}

void freeComplexNumber(ComplexNumber* a)
{
	free(a);
}

double Re(ComplexNumber* a)
{
	//YOUR CODE HERE
	return a->real;
}
double Im(ComplexNumber* a)
{
	//YOUR CODE HERE
	return a->imaginary;
}


