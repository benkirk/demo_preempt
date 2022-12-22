      program main
      implicit none
      external register_sig_handler
      integer :: i

      call register_sig_handler()

      i = 1
      do while (.true.)
         print *, i, ": Inside main function"
         call sleep(1)          ! 1 sec.
         i = i+1
      end do
      end program main
