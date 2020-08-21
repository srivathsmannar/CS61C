/*********************
**  Mandelbrot fractal
** clang -Xpreprocessor -fopenmp -lomp -o Mandelbrot Mandelbrot.c
** by Dan Garcia <ddgarcia@cs.berkeley.edu>
** Modified for this class by Justin Yokota and Chenyu Shi
**********************/

#include <stdio.h>
#include <stdlib.h>
#include "ComplexNumber.h"
#include "Mandelbrot.h"
#include <sys/types.h>
#include <inttypes.h>
#include <math.h>


/*
This function returns the number of iterations before the initial point >= the threshold.
If the threshold is not exceeded after maxiters, the function returns 0.
*/
u_int64_t MandelbrotIterations(u_int64_t maxiters, ComplexNumber * point, double threshold)
{
//YOUR CODE HERE
u_int64_t iter = 1;
ComplexNumber* a = newComplexNumber(0.0, 0.0);
ComplexNumber* b = ComplexProduct(a, a);
while(iter < maxiters+1) {
    b = ComplexProduct(a, a);
    a = ComplexSum(b, point);
    if(ComplexAbs(a) >= threshold) {
        free(a);
        free(b);
        return iter;
    }
    else {
        iter = iter + 1;
    }
}
free(a);
free(b);
return 0;
}

/*
This function calculates the Mandelbrot plot and stores the result in output.
The number of pixels in the image is resolution * 2 + 1 in one row/column. It's a square image.
Scale is the the distance between center and the top pixel in one dimension.
*/
void Mandelbrot(double threshold, u_int64_t max_iterations, ComplexNumber* center, double scale, u_int64_t resolution, u_int64_t * output){
u_int64_t i;
double res = (double) resolution;
double size = pow((2.0*res + 1.0), 2.0);
double changer = scale/res;
double row = -1.0;
u_int64_t b =(2*resolution + 1);
double bb = (double) b;
for(i = 0; i < size; i++) {
    if (i % b == 0) {
        row += 1.0;
    }
    double rowcenter = res + row*bb;
    double diff = (double) (i - rowcenter);
    double re = Re(center) + (changer)*(diff);
    signed int h = resolution - row;
    double hh = (double) h;
    double im = Im(center) + (changer)*(hh);
    output[i] = MandelbrotIterations(max_iterations, newComplexNumber(re, im), threshold);
}
}


