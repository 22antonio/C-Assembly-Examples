#include <stdio.h>

void CalcGrade(int);

int main(){

    int userInput;

    printf ("Enter percent number to display letter grade: ");
    scanf ("%d", &userInput);

    CalcGrade(userInput);

    return 0;
}


void CalcGrade (int userInput){

    char letterGrade;

    if (userInput <= 100 && userInput > 89){
        char letterGrade = 'A';
        printf ("%c \n", letterGrade);
    }else if (userInput <= 89 && userInput > 79 ){
        char letterGrade = 'B';
        printf ("%c \n", letterGrade);
    }else if (userInput <= 79 && userInput > 69 ){
        char letterGrade = 'C';
        printf ("%c \n", letterGrade);
    }else if (userInput <= 69 && userInput > 59 ){
        char letterGrade = 'D';
        printf ("%c \n", letterGrade);
    }else if (userInput <= 59){
        char letterGrade = 'F';
        printf ("%c \n", letterGrade);
    }else {
        printf("not a valid value! \n");
    }

}