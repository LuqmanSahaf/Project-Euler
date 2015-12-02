
arithmeticSum :: Integer -> Integer
arithmeticSum x =  x*(x+1) `div` 2

sumOfMultiplesBelow :: Integer -> Integer -> Integer
x `sumOfMultiplesBelow` y = x * ( arithmeticSum $ ceiling $ fromIntegral(y)/fromIntegral(x)-1 )

solve :: Integer -> Integer
solve x
 | x <= 0 = 0
 | otherwise =
      let a = 3 `sumOfMultiplesBelow` x
          b = 5 `sumOfMultiplesBelow` x
          c = 15 `sumOfMultiplesBelow` x
      in  a + b - c
      -- where,
      -- a = multiples of 3 below x
      -- b = multiples of 5 below x
      -- c = multiples of 3 OR 5 (15) below x
main = do
  putStrLn "Enter a Natural Number:"
  a <- readLn :: IO Integer
  print (solve a)