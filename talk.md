name: inverse
layout: true
class: middle, inverse

---

# Managing complexity and modular code development

## [Radovan Bast](http://bast.fr)

### [NeIC](https://neic.nordforsk.org)/ [UiT The Arctic University of Norway](https://uit.no)

Text is free to share and remix under [CC-BY-SA-4.0](https://creativecommons.org/licenses/by-sa/4.0/).

Code examples: [MIT license](http://opensource.org/licenses/mit-license.html)

Credits: [Jonas Juselius](https://github.com/juselius),
         [Roberto Di Remigio](http://totaltrash.xyz),
         [Ole Martin Bjørndalen](https://github.com/olemb)

---

layout: false

## Complexity

<img src="img/complex-machine.jpg" style="height: 500px;"/>

---

## Complexity

<img src="img/joe-paradiso-modular-synth-front.jpg" style="height: 450px;"/>

(c) Joe Paradiso

---

## Complexity

- The back side: global variables

<img src="img/joe-paradiso-modular-synth-back.jpg" style="height: 450px;"/>

(c) Joe Paradiso

---

<img src="img/development-speed.svg" style="width: 80%;"/>

---

## [The tar pit](http://shaffner.us/cs/papers/tarpit.pdf)

- Over time software tends to become harder and harder to reason about
- The code base easily becomes untidy ("I'll fix it later")
- Small changes become harder to implement
- Hacks and workarounds trump design
- Bugs start appearing in unexpected places
- More time is spent debugging than developing
- Complexity strangles development because it does not scale well

(Slide adapted from [Complexity in software development by Jonas Juselius](https://github.com/scisoft/complexity))

---

## Modular design is good

### Examples

- Lego
- Car manufacturing
- Design of your phone or laptop
- Modular composition when you order a laptop
- Success of USB
- Study programs

### Advantages

- Separation of concerns
- Composability
- Leveraging functionality

---

## Prefer loose coupling and high cohesion

- Strong coupling

![](img/strong-coupling.svg)

- Loose coupling
    - Easier to reassemble
    - Easier to understand

![](img/loose-coupling.svg)

---

## Prefer loose coupling and high cohesion

- Low cohesion: difficult to maintain, test, reuse, or even understand
    - Non-cohesive code has unnecessary dependencies
    - Swiss army knife modules

![](img/low-cohesion.svg)

- High cohesion: associated with robustness, reliability, reusability, and understandability
    - Do one thing only and do it well
    - API of cohesive code changes less over time
    - Power of the Unix command line is a set of highly cohesive tools
    - Microservices

![](img/high-cohesion.svg)

---

## Must haves 1/2

### Encapsulation

- Hide internals by language or by convention (header file in C/C++,
  public/private in Fortran, underscores in Python)
- "Python has no locked doors; it's a consenting adults language.
  If you open the door you're responsible for what you see." [R. Hettinger]
- Expose the "what", hide the "how"

### Documentation

- Separate the "what it can do" from "how is it implemented"
- Document your API
- Version your API ([semantic](http://semver.org) or [sentimental](http://sentimentalversioning.org)
  or [romantic](https://github.com/jashkenas/backbone/issues/2888#issuecomment-29076249) versioning)

---

## Must haves 2/2

### Testable on its own

- Sharpens interfaces
- Once you start testing your library you really see the coupling and cohesion
- Increases development speed

### Built on its own

- Prerequisite for testable on its own

### Own development history

- Decouple the development history
- Each unit should have its own Git history/repository

---

## Purity

- Pure functions has no notion of state: They take input values and return
  values
- Given the same input, a pure function *always* returns the same value!
  Function calls can be optimized away!
- Pure function == data!
- Purity is key to equational reasoning

<img src="img/bugbarrier.jpg" style="width: 40%;"/>

(Slide taken from [Complexity in software development by Jonas Juselius](https://github.com/scisoft/complexity))

---

## Enemy of the state

.left-column[
<img src="img/mad.jpg" style="width: 150px;"/>
]
.right-column[
### Strive for pure functions, fear the state

- Pure functions do not have side effects
- Side effects lead to bugs and increase complexity
- Pure functions are easy to
    - Test
    - Understand
    - Reuse
    - Parallelize
    - Simplify
    - Refactor
    - Optimize

### But we need to deal with state somewhere
]

---

## Equational reasoning

- We take a simple function:
  $$ f(x) = x^2 $$
- We wish to evaluate this:
  $$ y = f(a) + f(b) \times [f(c) - f(c)] $$
- We can simplify:
  $$ y = f(a) + f(b) \times 0 $$
  $$ y = f(a) $$
- Another example:
  $$ z = f(a) + f(b) + f(c) + f(d) $$
- We know we can rearrange (important for concurrency):
  $$ z = f(b) + f(d) + f(c) + f(a) $$

---

## Concurrency

- Concurrency in imperative code is very hard
- You are totally lost in the dark without a good thread checker
- In a pure, immutable world concurrency is nearly trivial!

<img src="img/floor-loom-diagram.jpg" style="width: 55%;"/>

(Slide taken from [Complexity in software development by Jonas Juselius](https://github.com/scisoft/complexity))

---

## Composition

- Build complex behavior from simple components
- We can reason about the components and the composite
- Composition is key to managing complexity
- Modularity does not imply simplicity, but is enabled by it

<img src="img/knit_vs_lego.jpg" style="width: 100%;"/>

(Slide taken from [Complexity in software development by Jonas Juselius](https://github.com/scisoft/complexity))

---

## One way to look at your code

![](img/main-inside.svg)

- The main function calls other functions

---

## Another way to look at your code

![](img/main-outside.svg)

- The main function ("program" in Fortran) is on the outside shell

---

## Recommendations

- Keep I/O on the outside and connected (examples later)
- Always read/write on the outside and pass data
- Do not read/write deep down inside the code
- Keep the inside of your code pure/stateless
- Move all the state "up" to the caller
- Keep the stateful outside shell thin
- Unit test the inside
- Regression test the shell

![](img/good-vs-bad.svg)

---

template: inverse

## Recommendations

---

## Divide and conquer

- Split the code up
- Construct your program from parts:
  - functions
  - modules
  - packages (Python) or libraries (C or or C++ or Fortran)

## Functions, functions, functions

- Build your code from functions
- Break your code down to more functions
  - if you have too many levels of indentation
  - if a function gets too long
  - if a function does more than one thing
  - if you find it hard to name a function

---

## C interface

- English is to humans what C is to programs
- C is the common language
- Basically any language can talk to a C interface
- **Do create a C interface for your code**
- Better than Fortran interface (the latter imposes compilation
  order and introduces compiler dependence)

### Core language

- Core language can be any language that can export a C API
- For single-core high-performance use C or C++ or Fortran
- With an eccentric language you risk to reduce the number of contributors

### Communicate through memory or through files?

- Through memory is more general than through files

---

## Import and export

- Import only the functionality that you need
- Import only where you need it
- Export as little functionality as possible

## Naming things

- Use meaningful names
- Indent
- Use standard naming conventions
- Python: use [PEP8](https://www.python.org/dev/peps/pep-0008/)
- Write comments in English

```
Makecodee
asytoread
```

---

template: inverse

## Quiz

### Decide which alternative you like better and discuss why

---

## Pure vs. stateful

### a) pure

```python
# function which computes the body mass index
def get_bmi(mass_kg, height_m):
    return mass_kg/(height_m**2)

# compute the body mass index
bmi = get_bmi(mass_kg=90.0, height_m=1.91))
```

### b) stateful

```python
mass_kg = 90.0
height_m = 1.91
bmi = 0.0

# function which computes the body mass index
def get_bmi():
    global bmi
    bmi = mass_kg/(height_m**2)

# compute the body mass index
get_bmi()
```

---

## Main function vs. global scope in Python

### a) main function

```python
def do_something(input):
    return something

def main():
    result = do_something(input)
    do_something_else(result)

if __name__ == '__main__':
    main()
```

### b) global scope

```python
def do_something(input):
    return something

result = do_something(input)
do_something_else(result)
```

---

## Pure vs. default in Fortran

### a) default

```fortran
function factor_and_offset(vector, factor)
    real(8), intent(in) :: vector(:)
    real(8), intent(in) :: factor
    real(8) :: factor_and_offset(size(vector))
    integer :: i

    factor_and_offset = (/(vector(i)*factor + offset, i = 1, size(vector))/)
end function
```

### b) with "pure" attribute

```fortran
pure function factor_and_offset(vector, factor)
    ! ... everything else remains unchanged
end function
```

---

## Argument vs. global

### a) "offset" passed as argument

```fortran
function factor_and_offset(vector, factor, offset)
    real(8), intent(in) :: vector(:)
    real(8), intent(in) :: factor
    real(8), intent(in) :: offset
    real(8) :: factor_and_offset(size(vector))
    integer :: i

    factor_and_offset = (/(vector(i)*factor + offset, i = 1, size(vector))/)
end function
```

### b) "offset" defined in outer scope

```fortran
function factor_and_offset(vector, factor)
    real(8), intent(in) :: vector(:)
    real(8), intent(in) :: factor
    real(8) :: factor_and_offset(size(vector))
    integer :: i

    factor_and_offset = (/(vector(i)*factor + offset, i = 1, size(vector))/)
end function
```

---

## Constructor vs. explicit vs. intrinsic in Fortran

### a) array constructor

```fortran
result = (/(vector(i)*factor + offset, i = 1, size(vector))/)
```

### b) explicit

```fortran
do i = 1, size(vector)
    result(i) = vector(i)*factor + offset
end do
```

### c) intrinsic array operation

```fortran
result = vector*factor + offset
```

---

## Implicit vs. implicit none in Fortran

### a) implicit

```fortran
b = 2.0d0
c = 3.0d0

a = b*c
```

### b) implicit none

```fortran
implicit none

real(8) :: a
real(8) :: b
real(8) :: c

b = 2.0d0
c = 3.0d0

a = b*c
```

---

## Variable reuse

### a) reuse memory

```fortran
integer, parameter :: length = 1000000
real(8) :: distances(length)

call get_distances(distances)
call do_something(distances)

! now we do not need distances anymore, we can safely reuse the array
call get_angles(distances)
call do_something_else(distances)
```

### b) allocate twice the memory

```fortran
integer, parameter :: length = 1000000
real(8) :: distances(length)
real(8) :: angles(length)

call get_distances(distances)
call do_something(distances)

call get_angles(angles)
call do_something_else(angles)
```

---

## If return

### a)

```python
if a == 5:
    return True
else:
    return False
```

### b)

```python
return (a == 5)
```

---

## Ternary operator

### a) ternary

```python
i = 1 if is_odd else 2  # python
```

```fortran
i = merge(1, 2, is_odd)  ! fortran
```

### b) explicit

```python
# python
if is_odd:
    i = 1
else:
    i = 2
```

```fortran
! fortran
if (is_odd) then
    i = 1
else
    i = 2
end if
```

---

## Implicit vs. named arguments

### a) implicit

```python
bmi = get_bmi(90.0, 1.91))
```

### b) named

```python
bmi = get_bmi(mass_kg=90.0, height_m=1.91))
```

---

## File I/O (example: Python)

### a) pass file name

```python
result = parse_input1(file_name)
```

### b) pass file handle

```python
with open(file_name, 'r') as f:
    result = parse_input2(f)
```

### c) pass data

```python
with open(file_name, 'r') as f:
    input_lines = f.readlines()
    result = parse_input3(input_lines)
```

---

## Private vs. public

### a) default is private

```fortran
module mymodule
    implicit none
    public myroutine
    private
contains
    subroutine myroutine()
    ...
    end subroutine
end module
```

### b) default is public

```fortran
module mymodule
    implicit none
contains
    subroutine myroutine()
    ...
    end subroutine
end module
```

---

## Generic vs. function import

### a) generic

```python
import somelib  # python
```

```fortran
use somelib  ! fortran
```

### b) function import

```python
from somelib import this, that
```

```fortran
use somelib, only: this, that
```

---

## Module-level vs. function-level import (Python or Fortran)

### a) module-level

```python
from somelib import somefunction

def myfunction(a, b, c):
    # use somefunction
    return something
```

### b) function-level

```python
def myfunction(a, b, c):
    from somelib import somefunction
    # use somefunction
    return something
```

---

## Intent vs. unspecified

### a) intent specified

```fortran
subroutine do_something(a, b, c, d)
    real(8), intent(in)    :: a
    logical, intent(in)    :: b
    real(8), intent(inout) :: c
    real(8), intent(out)   :: d

    ! ...
end subroutine
```

### b) intent unspecified

```fortran
subroutine do_something(a, b, c, d)
    real(8) :: a
    logical :: b
    real(8) :: d
    real(8) :: d

    ! ...
end subroutine
```

---

## Const in C++

### a) const

```cpp
int get_buffer_len(const int max_geo_order,
                   const int num_points) const;
```

### b) unspecified

```cpp
int get_buffer_len(int max_geo_order,
                   int num_points);
```

---

## Map vs. loop

### a) loop

```python
numbers = [1, 2, 3, 4, 5]
squares = []
for number in numbers:
    squares.append(number**2)
```

### b) map

```python
numbers = [1, 2, 3, 4, 5]
squares = map(lambda x: x**2, numbers)
```

---

## Filter vs. loop

### a) loop

```python
numbers = [1, 2, 3, 4, 5]
odds = []
for number in numbers:
    if number%2 == 1:
        odds.append(number)
```

### b) filter

```python
numbers = [1, 2, 3, 4, 5]
odds = filter(lambda x: x%2 == 1, numbers)
```

---

## Conditionals vs. higher-order function

### a) conditionals

```python
def apply(x, square=False, double=False):
    if square:
        return x**2
    elif double:
        return 2.0*x
    else
        # do something else

apply(2.0, square=True)
```

### b) higher-order function

```python
def apply(x, f):
    return f(x)

apply(2.0, lambda x: x**2)
```

---

### a) class

```python
class Pet:
    def __init__(self, name):
        self.name = name
        self.hunger = 0
    def go_for_a_walk(self):
        self.hunger += 1

my_cat = Pet('Tom')
my_cat.go_for_a_walk()
print(my_cat.hunger)
```

### vs. b) named tuple (in Python)

```python
from collections import namedtuple

def go_for_a_walk(pet):
    new_hunger = pet.hunger + 1
    return pet._replace(hunger=new_hunger)

Pet = namedtuple('Pet', ['name', 'hunger'])

my_cat = Pet(name='Tom', hunger=0)
my_cat = go_for_a_walk(my_cat)
print(my_cat.hunger)
```

---

## Conclusions

- Modular and well structured code is easy to test
- Entangled code is difficult to test
- Introduce testing early - it will automatically guide you towards a good code structure
