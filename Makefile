all: cdemo fdemo

cdemo : main.o my_sig_handler.o
	$(CC) -o $@ $^ $(CFLAGS) $(LDFLAGS)

fdemo: fmain.o my_sig_handler.o
	$(FC) -o $@ $^ $(FFLAGS) $(LDFLAGS)

clean:
	rm -f cdemo fdemo *.o *~
