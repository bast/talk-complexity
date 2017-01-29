program example

    implicit none

    integer, parameter :: length = 4
    real(8), parameter :: offset = 10.0d0
    real(8) :: vector(length)

    vector = (/1.0d0, 2.0d0, 3.0d0, 4.0d0/)
    print *, factor_and_offset(vector, 1.5d0)

contains

    pure function factor_and_offset(vector, factor)
        real(8), intent(in) :: vector(:)
        real(8), intent(in) :: factor
        real(8) :: factor_and_offset(size(vector))
        integer :: i

        factor_and_offset = (/(vector(i)*factor + offset, i = 1, size(vector))/)
    end function

end program
