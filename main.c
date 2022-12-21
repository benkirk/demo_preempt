#include <stdio.h>
#include <unistd.h>
#include <signal.h>
#include "my_sig_handler.h"



int main() {

  signal(SIGINT,  my_sig_handler); // Register signal handler
  signal(SIGTERM, my_sig_handler); // Register signal handler
  signal(SIGUSR1, my_sig_handler); // Register signal handler

  for (int i=1;;i++){    //Infinite loop
    printf("%d : Inside main function\n",i);
    sleep(1);  // Delay for 1 second
  }
  return 0;
}
