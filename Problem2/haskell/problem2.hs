
import qualified Data.Matrix as Matrix
import qualified Data.Map as Map
import Data.Maybe

relation_mat = Matrix.fromList 2 2 [4,1,1,0]
init_mat = Matrix.fromList 2 1 [8,2]

-------------------------------------------------------
-- compute_vector calculates the calculates a vector,
-- given a relation matrix 'x' by multiplying it with
-- 'init_mat' [8,2]. This function is to compute nth
-- element of the even fibonacci series.
-------------------------------------------------------
compute_vector :: Matrix.Matrix Integer -> [Integer]
compute_vector x = Matrix.toList(x * init_mat)


--------------------------------------------------------------------
-- exponentiate_until:
-- Input:
--    -> limit  Integer
--    -> pow    Integer
--    -> y      Matrix.Matrix Integer
--    -> z      Map Integer (Matrix Integer)
-- y is the last computed relation matrix
-- z is a dictionary in which all the computed powers of initial 
-- matrix are stored and accessed from. pow shows to which power
-- we have exponentiated. It is used as key in z. Value in a pair in
-- z is a matrix of Integer(s), which is computed by exponentiating,
-- with the previous matrix 'y' from the dictionary.
-- Output:
-- It recursively exponentiates the intial matrix until a value in 
-- the series is reached which: fn > limit
--------------------------------------------------------------------

exponentiate_until ::  Integer -> Integer -> Matrix.Matrix Integer -> Map.Map (Integer) (Matrix.Matrix Integer) -> Map.Map (Integer) (Matrix.Matrix Integer)
exponentiate_until limit pow y z
  | fn > limit = z3
  | otherwise = exponentiate_until limit p2 y2 z2
  where y2 = y*y
        fn = last(compute_vector(y2))
        p2 = 2*pow
        z2 = Map.insert pow y z
        z3 = Map.insert p2 y2 z2
--------------------------------------------------------------------



--------------------------------------------------------------------
-- binary_search gets the value for which
--    >> f(n) < limit && f(n+1) >= limit
-- by searching between two powers provided in array 'pow'.
-- It also computes new powers of matrices between exponentiated 
-- powers in the 'dict'.
--------------------------------------------------------------------

binary_search :: [Integer] -> Map.Map (Integer) (Matrix.Matrix Integer) -> Integer -> [Integer]
binary_search pow dict limit
  | (last f_n < limit && head f_n >= limit) = f_n
  | (last f_nhalf < limit) = binary_search [p+p_half, p2] new_dict limit
  | otherwise = binary_search [p, p+p_half] new_dict limit
  where p = head pow
        p2 = last pow
        m_n = snd $ Map.elemAt (fromJust $ Map.lookupIndex p dict) dict
        f_2n = compute_vector $ snd $ Map.elemAt (fromJust $ Map.lookupIndex p2 dict) dict
        f_n = compute_vector $ m_n
        p_half = toInteger $ ceiling $ fromIntegral (p2-p)/2
        m_nhalf = m_n * (snd $ Map.elemAt (fromJust $ Map.lookupIndex p_half dict) dict)
        f_nhalf = compute_vector $ m_nhalf
        new_dict = Map.insert (p + p_half) m_nhalf dict
--------------------------------------------------------------------



--------------------------------------------------------------------
-- find_sum_even_fibonacci calculates sum of even fibonacci values
-- which are less than 'limit'. It first exponentiates and then 
-- binary searches between f(m) and f(2m), such that f(n) < limit 
-- and f(n+1) >= limit and m < n <= 2m.
--------------------------------------------------------------------
find_sum_even_fibonacci :: Integer -> Integer
find_sum_even_fibonacci limit
  | limit <= 2 = 0
  | otherwise = s
  where new_dict = Map.empty :: Map.Map (Integer) (Matrix.Matrix Integer)
        dict = exponentiate_until limit 1 relation_mat new_dict
        max_power = fst $ Map.findMax dict
        max_power_by_2 = toInteger $ ceiling $ fromIntegral max_power/2
        fn_and_fn_plus_1 = binary_search [max_power_by_2, max_power] dict limit
        s = toInteger $ ceiling $ fromIntegral (sum(fn_and_fn_plus_1)- 2)/4
--------------------------------------------------------------------


  
main = do
  let limit = 4000000
  putStrLn $ show $ find_sum_even_fibonacci limit