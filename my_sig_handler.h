#ifndef MY_SIG_HANDLER_H
#define MY_SIG_HANDLER_H

int  checkpoint_requested ();
void done_checkpoint ();
void register_sig_handler ();
void my_sig_handler (int signum);

#endif // #define MY_SIG_HANDLER_H
