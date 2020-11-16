{- butrfeld Andrew Butterfield -}
module Ex02 where

name, idno, username :: String
name      =  "Kai Suzuki"  -- replace with your name
idno      =  "18308704"    -- replace with your student id
username  =  "ksuzuki"   -- replace with your TCD username


declaration -- do not modify this
 = unlines
     [ ""
     , "@@@ This exercise is all my own work."
     , "@@@ Signed: " ++ name
     , "@@@ "++idno++" "++username
     ]

-- Datatypes and key functions -----------------------------------------------

-- do not change anything in this section !

type Id = String

data Expr
  = Val Double
  | Add Expr Expr
  | Mul Expr Expr
  | Sub Expr Expr
  | Dvd Expr Expr
  | Var Id
  | Def Id Expr Expr
  deriving (Eq, Show)

type Dict k d  =  [(k,d)]

define :: Dict k d -> k -> d -> Dict k d
define d s v = (s,v):d

find :: Dict String d -> String -> Either String d
find []             name              =  Left ("undefined var "++name)
find ( (s,v) : ds ) name | name == s  =  Right v
                         | otherwise  =  find ds name

type EDict = Dict String Double

v42 = Val 42 ; j42 = Just v42

-- do not change anything above !

-- Part 1 : Evaluating Expressions -- (50 test marks, worth 25 Exercise Marks) -

-- Implement the following function so all 'eval' tests pass.

-- eval should return `Left msg` if:
  -- (1) a divide by zero operation was going to be performed;
  -- (2) the expression contains a variable not in the dictionary.
  -- see test outcomes for the precise format of those messages

eval :: EDict -> Expr -> Either String Double
eval d (Var x) = find d x
eval _ (Val v) = Right v
eval d (Add x y) = case (eval d x, eval d y) of
                  (Right x, Right y) -> Right(x + y)
                  (_, Right 0) -> Left "div by zero"
                  (Right 0, _) -> Left "div by zero"
                  (Left ("undefined var x"), _)-> Left "undefined var x"
                  (_, Left ("undefined var x"))-> Left "undefined var x"
                  (Left ("undefined var y"), _)-> Left "undefined var y"
                  (_, Left ("undefined var y"))-> Left "undefined var y"
                  (_, _) -> Left "div by zero"
                  _ -> Left "undefined var x"

eval d (Sub x y) = case (eval d x, eval d y) of
                  (Right x, Right y) -> Right(x - y)
                  (_, Right 0) -> Left "div by zero"
                  (Right 0, _) -> Left "div by zero"
                  (Left ("undefined var x"), _)-> Left "undefined var x"
                  (_, Left ("undefined var x"))-> Left "undefined var x"
                  (Left ("undefined var y"), _)-> Left "undefined var y"
                  (_, Left ("undefined var y"))-> Left "undefined var y"
                  (_, _) -> Left "div by zero"
                  _ -> Left "undefined var x"     

eval d (Mul x y) = case (eval d x, eval d y) of
                  (Right x, Right y) -> Right(x * y)
                  (_, Right 0) -> Left "div by zero"
                  (Right 0, _) -> Left "div by zero"
                  (Left ("undefined var x"), _)-> Left "undefined var x"
                  (_, Left ("undefined var x"))-> Left "undefined var x"
                  (Left ("undefined var y"), _)-> Left "undefined var y"
                  (_, Left ("undefined var y"))-> Left "undefined var y"
                  (_, _) -> Left "div by zero"
                  --_ -> if (find d x) == Left "undefined var x" then Left "undefined var x" else Left "undefined var y"
                  _ -> Left "undefined var x"


eval d (Dvd x y) = case (eval d x, eval d y) of
                  (Right x, Right y) -> if y == 0.0 then Left "div by zero" else Right (x / y)
                  (_, Right 0) -> Left "div by zero"
                  (Right 0, _) -> Left "div by zero"
                  (Left ("undefined var x"), _)-> Left "undefined var x"
                  (_, Left ("undefined var x"))-> Left "undefined var x"
                  (Left ("undefined var y"), _)-> Left "undefined var y"
                  (_, Left ("undefined var y"))-> Left "undefined var y"
                  (e, _) -> Left "div by zero"
                  (_, e) -> Left "div by zero"
                  --(Left ("undefined var "++x), _) -> Left "undefined var x"
                  _ -> Left "undefined var x" 


eval d (Def x e1 e2)= case eval d e1 of
                      Left ("undefined var x")  -> Left "undefined var x" 
                      Right var1  ->  eval (define d x var1) e2   
                      _ ->Left "div by zero" 

eval d e = Left "div by zero"--error "eval NYI"

-- Part 1 : Expression Laws -- (15 test marks, worth 15 Exercise Marks) --------

{-

There are many, many laws of algebra that apply to our expressions, e.g.,

  x + y            =  y + z         Law 1
  x + (y + z)      =  (x + y) + z   Law 2
  x - (y + z)      =  (x - y) - z   Law 3
  (x + y)*(x - y)  =  x*x - y*y     Law 4
  ...

  We can implement these directly in Haskell using Expr

  Function LawN takes an expression:
    If it matches the "shape" of the law lefthand-side,
    it replaces it with the corresponding righthand "shape".
    If it does not match, it returns Nothing

    Implement Laws 1 through 4 above
-}


law1 :: Expr -> Maybe Expr
--law1 e = error "law1 NYI"
law1 e = case(e) of
	      (Add x y) -> Just(Add y x) 
	      _	  -> Nothing

law2 :: Expr -> Maybe Expr
--law2 e = error "law2 NYI"
law2 e = case(e) of
	      (Add x (Add y z)) -> Just(Add (Add x y) z)
	      _	  -> Nothing

law3 :: Expr -> Maybe Expr
--law3 e = error "law3 NYI"
law3 e = case(e) of
	      (Sub x (Add y z)) -> Just(Sub (Sub x y) z)
	      _	  -> Nothing

law4 :: Expr -> Maybe Expr
--law4 e = error "law4 NYI"
law4 e = case(e) of
        (Mul (Add x y) (Sub n1 n2)) -> if x==n1 && y==n2 then Just(Sub (Mul x x) (Mul y y)) else Nothing 
        _			  -> Nothing