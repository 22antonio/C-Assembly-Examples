#include <stdlib.h>
#include <stdio.h>

int fib (int n)
{
  if (n==0) return 0;
  if (n==1) return 1;
  else return fib(n-1) + fib(n-2);
}

int main(int userInput)
{
  printf("Please enter the number of the fib sequence:");
  scanf("%d", &userInput);

  int result = fib(userInput);

  printf("%d\n", result);
  return 0;
}