all: cdemo fdemo demo_mpi

cdemo : main.o my_sig_handler.o
	$(CC) -o $@ $^ $(CFLAGS) $(LDFLAGS)

fdemo: fmain.o my_sig_handler.o
	$(FC) -o $@ $^ $(FFLAGS) $(LDFLAGS)

my_sig_handler_mpi.o: my_sig_handler.c my_sig_handler.h
	$(CC) -c -o $@ $< -DHAVE_MPI $(CFLAGS) $(LDFLAGS)

main_mpi.o: main_mpi.cpp my_sig_handler.h
	$(CXX) -c -o $@ $< -DHAVE_MPI $(CXXFLAGS) $(LDFLAGS)

demo_mpi: main_mpi.o my_sig_handler_mpi.o
	$(CXX) -o $@ $^ $(CXXFLAGS) $(LDFLAGS)

clean:
	rm -f cdemo fdemo demo_mpi *.o *~

clobber:
	$(MAKE) clean
	rm -f hello_preempt.o* TAGS

run: preempt_gust.sh
	qsub preempt_gust.sh
