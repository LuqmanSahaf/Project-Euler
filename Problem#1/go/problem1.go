package main

import (
  "fmt"
  "math"
)

func main(){
  fmt.Print("The sum of multiples of 3 or 5 below 1000 is: ")
  fmt.Println(find_special_sum(1000))
}

func find_special_sum(n int) int {
  /*  The solution to problem 1 is : A + B - A<intersect>B
      where,
      A =             natural numbers multiple of 3 below n
      B =             natural numbers multiple of 5 below n
      A<intersect>B = natural numbers multiple of 3 and 5 below n
                    = natural numbers multiple of 15 below n
  */
  var x float64
  var a,b,c int
  x = float64(n)/float64(3)
  a = int(math.Ceil(x)) - 1
  x = float64(n)/float64(5)
  b = int(math.Ceil(x)) - 1
  x = float64(n)/float64(15)
  c = int(math.Ceil(x)) - 1
  return 3*arithmetic_sum(a) + 5*arithmetic_sum(b) - 15*arithmetic_sum(c)
}

func arithmetic_sum(k int) int {
  return k*(k+1)/2
}