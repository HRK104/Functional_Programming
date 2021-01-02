{- butrfeld Andrew Butterfield -}
module Ex04 where

name, idno, username :: String
name      =  "Kai Suzuki"  -- replace with your name
idno      =  "18308704"    -- replace with your student id
username  =  "ksuzuki"   -- replace with your TCD username

declaration :: String
declaration -- do not modify this
 = unlines
     [ ""
     , "@@@ This exercise is all my own work."
     , "@@@ Signed: " ++ name
     , "@@@ "++idno++" "++username
     ]

-- Datatypes -------------------------------------------------------------------

-- do not change anything in this section !


-- a binary tree datatype, honestly!
data BinTree k d
  = Branch (BinTree k d) (BinTree k d) k d
  | Leaf k d
  | Empty
  deriving (Eq, Show)


-- Part 1 : Tree Insert -------------------------------

-- Implement:
ins :: Ord k => k -> d -> BinTree k d -> BinTree k d

ins k d Empty = Leaf k d
ins k d (Leaf k2 d2)
    | k == k2 = Leaf k d 
    | k < k2  = Branch (Leaf k d) Empty k2 d2
    | k > k2  = Branch Empty (Leaf k d) k2 d2

ins k d (Branch left right k2 d2)
    | k == k2 = Branch left right k d 
    | k < k2  = Branch (ins k d left) right k2 d2
    | k > k2 = Branch left (ins k d right) k2 d2
-- ins _ _ _  = error "ins NYI"

-- Part 2 : Tree Lookup -------------------------------

-- Implement:
lkp :: (Monad m, Ord k) => BinTree k d -> k -> m d

lkp Empty _ = fail "empty"

lkp (Leaf k d) lkpKey 
    | lkpKey == k = return d 
    | otherwise   = fail "key doesn't match" 

lkp (Branch left right k d) lkpKey
    | lkpKey == k = return d        
    | lkpKey < k  = lkp left lkpKey  
    | lkpKey > k = lkp right lkpKey



-- Part 3 : Tail-Recursive Statistics

{-
   It is possible to compute BOTH average and standard deviation
   in one pass along a list of data items by summing both the data
   and the square of the data.
-}
twobirdsonestone :: Double -> Double -> Int -> (Double, Double)
twobirdsonestone listsum sumofsquares len
 = (average,sqrt variance)
 where
   nd = fromInteger $ toInteger len
   average = listsum / nd
   variance = sumofsquares / nd - average * average

{-
  The following function takes a list of numbers  (Double)
  and returns a triple containing
   the length of the list (Int)
   the sum of the numbers (Double)
   the sum of the squares of the numbers (Double)

   You will need to update the definitions of init1, init2 and init3 here.
-}
getLengthAndSums :: [Double] -> (Int,Double,Double)
getLengthAndSums ds = getLASs init1 init2 init3 ds
init1 :: Int
init1 = 0
init2 :: Double
init2 = 0
init3 :: Double
init3 = 0
{-
  Implement the following tail-recursive  helper function
-}
getLASs :: Int -> Double -> Double -> [Double] -> (Int,Double,Double)
getLASs off1 off2 off3 xs = (len1, sum1, sumsqr)
  where
    len1 = length xs + off1 
    sum1 = sum xs + off2
    sumsqr = sum [x*x|x<-xs] + off3


-- Final Hint: how would you use a while loop to do this?
--   (assuming that the [Double] was an array of double)
