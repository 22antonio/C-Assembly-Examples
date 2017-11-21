#include<stdio.h>

int fact(int n)
{
    if (n <= 0)
        return 1;
    else
        return n * fact(n - 1);
}

int main(void)
{
    int value;
    int result;

    printf("Please enter an integer value: ");
    scanf("%d", &value);

    result = fact(value);
    printf("Your factorial of %d is %d\n",value, result);

}
