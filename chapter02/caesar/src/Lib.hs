module Lib where

square :: Int -> Int
square = \x -> x * x

add :: Int -> Int -> Int
add x y = x + y

type Alphabet = [Char] 
lowerAlphabet :: Alphabet
lowerAlphabet = ['a' .. 'z']

upperAlphabet :: Alphabet
upperAlphabet = ['A' .. 'Z']

digits :: Alphabet
digits = ['0' .. '9']

isUpper :: Char -> Bool
isUpper char = char `elem` upperAlphabet

isLower :: Char -> Bool
isLower char = char `elem` lowerAlphabet

isDigit :: Char -> Bool
isDigit char = char `elem` digits

isMisc :: Char -> Bool
-- isMisc char = not (isUpper char || isLower char || isDigit char)
isMisc char = char `notElem` lowerAlphabet ++ upperAlphabet ++ digits

listLength [] = 0
listLength (x:xs) = 1 + listLength xs

indexOf :: Char -> Alphabet -> Int
indexOf ch [] = undefined
indexOf ch (x : xs) = if x == ch then 0 else 1 + indexOf ch xs

-- Basic impl of (!!)
myIndex :: [a] -> Int -> a
myIndex (x:_)  0 = x
myIndex (_:xs) n
  | n > 0     = myIndex xs (n - 1)
  | otherwise = undefined
myIndex [] _     = undefined

upperRot :: Int -> Char -> Char
upperRot n ch = alphabetRot upperAlphabet n ch

lowerRot :: Int -> Char -> Char
lowerRot n ch = alphabetRot lowerAlphabet n ch

digitRot :: Int -> Char -> Char
digitRot n ch = alphabetRot digits n ch

rotChar :: Int -> Char -> Char
rotChar n ch
    | isLower ch = lowerRot n ch
    | isUpper ch = upperRot n ch
    | isDigit ch = digitRot n ch
    | otherwise = ch

alphabetRot :: Alphabet -> Int -> Char -> Char
alphabetRot alphabet n ch = 
    alphabet !! ((indexOf ch alphabet + n) `mod` length alphabet)

-- alternate caesar without map to show use of finished 
caesar' :: Int -> String -> String
caesar' n [] = []
caesar' n (x : xs) = rotChar n x : caesar n xs

-- simple impl of map
transform fun [] = []
transform fun (x : xs) = fun x : transform fun xs

caesar :: Int -> String -> String
caesar n message = map (\ch -> rotChar n ch) message

rot13 :: String -> String
rot13 message = caesar 13 message


