#include <stdio.h>
#include <unistd.h>
#include <signal.h>
#include "my_sig_handler.h"

void my_sig_handler(int signum){
  printf("\nInside handler function\n");


  switch (signum)
    {
    case SIGINT:
      printf("...caught SIGINT...\n");
      break;

    case SIGTERM:
      printf("...caught SIGTERM...\n");
      break;

    case SIGUSR1:
      printf("...caught SIGUSR1, ignoring...\n");
      return;

    default:
      printf("...caught other unknown signal: %d ...\n", signum);
      printf("   see \"man 7 signal\" for a list of known signals\n");

      break;
    }

  // re-register default signal handler for action
  printf(" --> Restoring default handler for signal %d\n", signum);
  signal(signum, SIG_DFL);

  return;
}
