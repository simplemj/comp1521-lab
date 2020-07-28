// Copy input to output
// COMP1521 18s1

#include <stdlib.h>
#include <stdio.h>

void copy(FILE *, FILE *);

int main(int argc, char *argv[]) {
		
	if(argc == 1) {
	copy(stdin,stdout);
	}
	else {
		int i = 1;
		while(i < argc) {
			FILE *fp = fopen(argv[i],"r");
			if(fp == NULL) {
				printf("Can't read %s\n",argv[i]);
			}
			else {
				copy(fp,stdout);
				fclose(fp);
			}
			i++;
		}
	}
	
	return EXIT_SUCCESS;
}

// Copy contents of input to output, char-by-char
// Assumes both files open in appropriate mode

void copy(FILE *input, FILE *output) {
	char str[BUFSIZ];

	while(fgets(str,BUFSIZ,input) != NULL) 
		fputs(str,output);
}
