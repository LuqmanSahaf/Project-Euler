### Problem 1:
Source: https://projecteuler.net/problem=1

The problem states:
> If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
> Find the sum of all the multiples of 3 or 5 below 1000.

The easy solution to go is to keep a variable _sum_, and loop from 1 to 1000, find out whether a number is divisible by 3 or 5 and add it to the _sum_. But this is not the target of the problem. It wants you to think... :smiley:

_THINK_

The solution is simple. Follow me.

We want to find sum of all multiples of 3 or 5 below **_n_**.
```
Let,
  S = {sum of ALL x | ( x is multiple of 3 OR x is multiple of 5 ) AND x < n}
```

Now, this sum can be calculated simply summing the multiples of 3 and the multiples of 5, right? Wait...

_There are some numbers which are both multiple of 3 and 5_.
They will be counted twice. No Problem, we have:

```
S = A + B - A <intersect> B
Where,
  A = Sum of multiples of 3
  B = Sum of multiples of 5
  A <intersect> B = Sum of multiples of 3 AND 5
                  = Sum of multiples of 15
```

Subtract the sum of such numbers which come twice in the sum. _Simple_

Now, How to find the sum of multiples of 3 and 5? Consider this:

```
A = 3 + 6 + 9 + ... + (Ceil(n/3) - 1)*3
A = 3 * ( 1 + 2 + 3 + ... + (Ceil(n/3) - 1) )
```

The sum in brackets is _arithmetic sum_ of upto **_k_**, where **_k_** equals the number of multiples of 3 (or 5) below **_n_**. Same can be done for 5 and 15.
Why `(Ceil(n/3) - 1)`? Because, **_n_** might itself be multiple of **_n_**, so it will give wrong **_k_** (number of multiples _below_ **_n_**).

Here are the solutions for this problem:
- [Go](go/problem1.go)
- [Haskell](haskell/problem1.hs)