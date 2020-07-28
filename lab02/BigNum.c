#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include <string.h>
#include <ctype.h>
#include "BigNum.h"

// Initialise a BigNum to N bytes, all zero
void initBigNum(BigNum *n, int Nbytes)
{  
    // make sure Nbytes is non zero 
    assert(Nbytes != 0);
    // set Nbytes
    n->nbytes = Nbytes;
    // mallloc bytes array
    n->bytes = (Byte *)malloc(Nbytes*sizeof(Byte));
    // check malloc is sucessful
    assert(n->bytes != NULL); 
   
    // set array to 0
    int i = 0;
    for (i = 0;i< n->nbytes;i++){
        n->bytes[i] = '0';
    }
   
    return;
}

// Add two BigNums and store result in a third BigNum
void addBigNums(BigNum n, BigNum m, BigNum *res)
{
    //check size 
    int size = 0;  
    if ((n.nbytes - m.nbytes) >= 0) 
    {
        size = n.nbytes;   
    }
    else 
    {
        size = m.nbytes;    
    }
   
    //reset nbytes and arr bytes
    if(res->nbytes < size + 1)   // incase overflow 
    {
        res->nbytes = size + 1;
        free(res->bytes); 
        res->bytes = (Byte *)malloc((size + 1)*sizeof(Byte)); 
        // set array to 0
        int i = 0;  // index i
        for (i = 0;i < (size + 1);i++)
        {
            res->bytes[i] = '0';
        }
    }
   
    // add Bignum
    int curr = 0;       // index current position
    //int overflow = 0;   //index of overflow
    int carryout = 0;    //carry out value
   
    for (curr = 0;curr <= size;curr++)
    {   
        //case of no overflow at the end
        if(curr == size && carryout == 0)
        {
            // if good let's have a break
            break;
        }
        //case of overflow
        else if(curr == size && carryout != 0)
        {
            //carryout next to the most significant bit
            res->bytes[size] = '1';
            break; 
        }
        
        //adding part
        //current position in both 2 NO.s length
        if(curr < n.nbytes && curr < m.nbytes)
        {
            //check buffer
            int buffer = (n.bytes[curr] - '0') + (m.bytes[curr] - '0') + carryout;
            //more than 10 then up one in overflow
            if(buffer >= 10)
            {
                char carrybit = ((buffer - 10) + '0'); 
                res->bytes[curr] = carrybit; 
                carryout = 1;
            }
            else
            {
                res->bytes[curr] =(char)(buffer + '0'); 
                carryout = 0;
            }
        }
        // current position only in one of 2 No.s length
        else
        {
            // the part of one of bignum is longer 
            if(n.nbytes > m.nbytes)
            {
                res->bytes[curr] = n.bytes[curr]; 
            }
            else
            {
                res->bytes[curr] = m.bytes[curr];
            }
        }
        
    }
   
   
    return;
}

// Set the value of a BigNum from a string of digits
// Returns 1 if it *was* a string of digits, 0 otherwise
int scanBigNum(char *s, BigNum *n)
{  
    assert(s != NULL);
    assert(n != NULL); 
   
    //record the position of start of digit and end of digit from string s
    int startposition = 0; 
    int endposition = 0;             
   
    int curr = 0; 
    char buffer = s[curr];            // use char buffer to hold each one char from sting s
    int checkdigit = 0;               // checkdigit value 0 for not digit : 1 for is digit 
   
   
    //loop check digit through string s from argv 
    while(buffer != '\0')
    {
        //digitcheck and record 
        if(checkdigit)
        {   
            // record where is not digit
            if(!(buffer >= '0' && buffer <= '9')){
                endposition = curr - 1;
                break;
            }     
        }
        else{
            //is a digit?
            if(buffer >= '0' && buffer <= '9'){
                //record where it starts  
                startposition = curr;
                //update checkdigit 
                checkdigit = 1;
            }
        }
        //check next char from string s
        curr++; 
        buffer = s[curr]; 
    }
   
    if(checkdigit == 0) 
    {
        return 0; 
    }
   
    //this step is assuming that string s is contiguous sequence of digits
    if(buffer == '\0') 
    {
        endposition = curr - 1;
    }
   
    //set all digits
    curr = 0; 
    //check if the array is big enough to hold all digits 
    if(n->nbytes < (endposition - startposition + 1)){
        //reallocate
        free(n->bytes);
        n->bytes = (Byte *)malloc((endposition - startposition + 1) * sizeof(Byte));     
        n->nbytes = endposition - startposition + 1;
    }
   
    // copy string s to arry bytes of BigNum 
    int i = 0;  //index
   
    for(i = endposition;i >= startposition; i--)
    {
        n->bytes[curr] = s[i];  
        //printf("%d",n->nbytes); 
        curr++; 
    }
    //printf("\n");
   
    return 1;
}
// Display a BigNum in decimal format
void showBigNum(BigNum n)
{
    assert(n.nbytes > 0);
    //set current position index
    int curr = n.nbytes - 1;
   
    //check leading zero 
    int check_0 = 0;
   
    //print loop
    while (curr >= 0)
    {
        //check leading zero 
        if(check_0)
        {
            printf("%c",n.bytes[curr]);
            curr--;
        }
        else
        {
            if(n.bytes[curr] != '0') 
            {
                check_0 = 1; 
                continue;
            }
            curr--;
        } 
    }
   
    return;
}

