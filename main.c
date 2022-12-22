#include <stdio.h>
#include <unistd.h>
#include <signal.h>
#include "my_sig_handler.h"



int main ()
{
  register_sig_handler();

  for (int i=1;;i++)
    {
      printf("%d : Inside main function\n",i);
      sleep(5);
    }
  return 0;
}
