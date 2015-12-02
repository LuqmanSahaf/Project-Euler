import math.ceil

object Problem1 {
  def arithmetic_sum(x: Int) : Int = x*(x+1)/2

  def special_sum(n: Int): Int = {
    var a: Int = ceil(n/3.toFloat).toInt - 1
    var b: Int = ceil(n/5.toFloat).toInt - 1
    var c: Int = ceil(n/15.toFloat).toInt - 1
    3*arithmetic_sum(a) + 5*arithmetic_sum(b) - 15*arithmetic_sum(c)
  }
  
  def main (args: Array[String]) = {
      println("The sum of multiples of 3 or 5 below 1000 is: " + special_sum(1000))
  }
}