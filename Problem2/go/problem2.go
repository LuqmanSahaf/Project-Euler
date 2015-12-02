package main

import (
  matrix "github.com/skelterjohn/go.matrix"
  "fmt"
  "math"
)

var relation = []float64{4,1,1,0}
var relation_mat = matrix.MakeDenseMatrix(relation, 2,2)
var initial_seq_values = []float64{8,2}
var init_mat = matrix.MakeDenseMatrix(initial_seq_values, 2,1)
var dict = make(map[float64]*matrix.DenseMatrix,0)
var pow = []float64{1,  -1}

/*************************************************************************
function calculate_even_fib_until:

Input: limit Integer

Output:
Computes the Even_Fibanacci_Series elements F(n) and F(n+1) where:
    F(n) < limit
    F(n+1) >= limit

> Even_Fibanacci_Series:
  It is the series formed by even elements of Fibonacci Series:
                2, 8, 34, 144, 610, ...
  It has a recurrence relation which be derived easily:
  |4, 1|  * | F(n) | = |F(n+1)|
  |1, 0|    |F(n-1)|   | F(n) |
  
Method:
Taking benefit of this recurrence relation, we use the matrix {4,1;1,0}
to exponentiate the matrix and calculate the power for which F(n) is
smaller than limit and F(n+1) is greater than limit. The latter part 
is tricky. First we exponentiate the matrix: 1, 2, 4, 8, 16 ... until 
a matrix appears for which F(n) is greater than the limit. Then we 
BINARY search in between the two powers after we get F(n) < limit and 
F(2*n) > limit.

Note: There are two modes of this function, in first mode the power m
of the matrix is exponentiated uptil m < limit and 2*m > limit. In 
second mode, it binary searches the matrix which gives the correct 
elements F(n) and F(n+1).

Complexity:
The complexity of this method is O(log n). Which is lesser than the 
linear search method which has a complexity of O(n).
*************************************************************************/

func calculate_even_fib_until(limit int64) (m []float64) {
  if limit <= 2 {         // base case: This cannot be determined by the recurrence relation
    m = []float64{2,0}
    return
  } 
  done := false
  var a,b,c *matrix.DenseMatrix
  a = relation_mat              // a holds older b before multiplication
  b = relation_mat              // b holds result of matrix multiplication
  c = relation_mat              // c holds matrix that is to be multiplied in current iteration
  dict[float64(1)] = relation_mat
  
  for !done {
    a = b
    b,_ = b.TimesDense(c)
    t, _ := b.TimesDense(init_mat)    // calculate resultant vector for a certain power of a matrix
    if t.ColCopy(0)[1] < float64(limit) {
      if pow[1] == -1 {     // pow[1] = -1 means we are exponentiating the matrix (first mode).
        pow[0] = 2*pow[0]
        c = b
        dict[pow[0]] = b
      } else {
        pow[0] = math.Ceil((pow[1] + pow[0])/float64(2))
        c = dict[math.Ceil((pow[1] - pow[0])/float64(2))]
      }
    } else {
      if pow[1] == -1 {
        pow[1] = pow[0]
        pow[0] = pow[0]/2
        dict[pow[1]] = b
        if pow[1] - pow[0] < 2 {
          c = dict[float64(1)]
        } else {
          c = dict[math.Ceil((pow[1] - pow[0])/float64(2))]
        }
        b = a
      } else {
        pow[1] = math.Ceil((pow[1] + pow[0])/float64(2))
        c = dict[math.Ceil((pow[1] - pow[0])/float64(2))]
        b = a
      }
    }
    t, _ = b.TimesDense(init_mat)
    if pow[1] != -1 && t.ColCopy(0)[1] < float64(limit) && t.ColCopy(0)[0] >= float64(limit) {
      done = true
      m = t.ColCopy(0)
    }
  }
  return
}

func find_sum(x int64) int64 {
  pow = []float64{1,  -1}                         // pow[1] = -1 means that we are in the process of exponentiation,
                                                  // otherwise, binary search
  f := calculate_even_fib_until(x)
  return int64(f[0] + f[1] - float64(2))/int64(4)
}

func main(){
  fmt.Println(find_sum(4000000))
}