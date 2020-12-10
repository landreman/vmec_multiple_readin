program vmec_multiple_readin

  use mpi
  use parallel_vmec_module, only: PARVMEC, NS_COMM, NS_RESLTN, FinalizeSurfaceComm, FinalizeRunVmec, RUNVMEC_COMM_WORLD

  implicit none

  integer, parameter :: restart_flag = 1, readin_flag = 2, timestep_flag = 4
  integer, parameter :: output_flag = 8, cleanup_flag = 16, reset_jacdt_flag = 32
  integer :: ictrl(5)
  integer :: ierr, numsteps
  logical :: verbose = .true.
  character(len=*), parameter :: filename = "input.li383_low_res"

  call mpi_init(ierr)

  print *,"Include any arguments to run vmec between the two times the input file is read."
  
  print *,"Run 1"
  
  ierr = 0
  ictrl(1) = restart_flag + readin_flag + reset_jacdt_flag + timestep_flag + output_flag + cleanup_flag
  ictrl(2) = ierr
  ictrl(3) = 50 ! numsteps
  ictrl(4) = 0 ! ns_index
  ictrl(5) = 0 ! iseq
  PARVMEC = .true.
  NS_RESLTN = 0
  call runvmec(ictrl, filename, verbose, MPI_COMM_WORLD, "")
!  call FinalizeSurfaceComm(NS_COMM)
!  call FinalizeRunVmec(RUNVMEC_COMM_WORLD)

  print *,"Run 2:"

  PARVMEC = .true.
  NS_RESLTN = 0
  ictrl(1) = restart_flag + reset_jacdt_flag + timestep_flag + output_flag + cleanup_flag
  ictrl(2) = ierr
  ictrl(3) = 0 ! numsteps
  ictrl(4) = 0 ! ns_index
  ictrl(5) = 0 ! iseq
  if (command_argument_count() > 0) then
     ictrl(1) = ictrl(1) + readin_flag
     print *,"Including readin_flag"
  else
     print *,"NOT including readin_flag."
  end if
  call runvmec(ictrl, filename, verbose, MPI_COMM_WORLD, "")
  
  
  call mpi_finalize(ierr)

  print *,"Good bye!"
  
end program vmec_multiple_readin
