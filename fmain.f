      program main
      implicit none
      integer :: i

      i = 1
      do while (.true.)
         print *, i, ": Inside main function"
         call sleep(1)          ! 1 sec.
         i = i+1
      end do
      end program main
