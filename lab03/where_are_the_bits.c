// where_are_the_bits.c ... determine bit-field order
// COMP1521 Lab 03 Exercise
// Written by ...

#include <stdio.h>
#include <stdlib.h>

struct _bit_fields {
   unsigned int a : 4,
                b : 8,
                c : 20;
};
union all {
	struct _bit_fields bits;
	int nums;
};
	
int main(void) {
   union all x;
   x.bits.a = 0;
   x.bits.b = 0;
   x.bits.c = 0;
   
   x.bits.c++;
   if(x.nums <= 100) {
   	printf("Is left to right\n");
   	printf("%d\n",x.nums);
   }
   
   else{
    printf("Is right to left\n");
    printf("%d\n",x.nums);
   }
   x.bits.c--;
   
   
   return 0;
}
