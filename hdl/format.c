    /*
     * C program to illustrate how a file stored on the disk is read
     */
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#define INPUTS 18
#define OUTPUTS 8
     
    void main(int argc, char** argv)
    {
        FILE *fptr;
        char ch;
        int counter = 0;
        int i;
     
        if(argc < 2) {
            printf("No file to open\n");
            exit(-1);
        }
        /*  open the file for reading */
        fptr = fopen(argv[1], "r");
        if (fptr == NULL)
        {
            printf("Cannot open file \n");
            exit(-1);
        }
        ch = fgetc(fptr);
        for(i = 0; i< INPUTS; i++) {
          printf("I%d,",i);
        }
        printf(",");
        for(i = 0; i< OUTPUTS; i++) {
          printf("O%d",i);
          if(i!= (OUTPUTS - 1))
            printf(",");
        }
        printf("\n");
        while (!feof(fptr))
        {
          for(i = 0; i< INPUTS; i++) {
            printf("%c,",(counter & ((int)pow(2,i)) ? '1' : '0'));
          }
          printf(",");
          for(i = 0; i< OUTPUTS; i++) {
            printf("%c",(ch & ((int)pow(2,i)) ? '1' : '0'));
            if(i!= (OUTPUTS - 1))
              printf(",");
          }
          printf("\n");
            //printf ("%4.4x, %2.2x\n", counter++, (unsigned char)ch);
          counter++;
          ch = fgetc(fptr);
        }
        fclose(fptr);
    }
