#include <stdio.h>
#include <unistd.h>
#include <signal.h>
#include <time.h>
#include "my_sig_handler.h"



void register_sig_handler ()
{
  signal(SIGINT,  my_sig_handler);
  signal(SIGTERM, my_sig_handler);
  signal(SIGUSR1, my_sig_handler);
}



void register_sig_handler_ ()
{
  register_sig_handler ();
}



void my_sig_handler (int signum)
{
  time_t now;
  time(&now);

  printf("\nInside handler function\n");

  switch (signum)
    {
    case SIGINT:
      printf("...caught SIGINT at %s", ctime(&now));
      break;

    case SIGTERM:
      printf("...caught SIGTERM at %s", ctime(&now));
      break;

    case SIGUSR1:
      printf("...caught SIGUSR1 at %s, ignoring...\n",ctime(&now));
      return;

    default:
      printf("...caught other unknown signal: %d at %s", signum, ctime(&now));
      printf("   see \"man 7 signal\" for a list of known signals\n");

      break;
    }

  // re-register default signal handler for action
  printf(" --> Restoring default handler for signal %d\n", signum);
  signal(signum, SIG_DFL);

  return;
}
