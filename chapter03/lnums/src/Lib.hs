module Lib
  ( NumberedLine,
    NumberedLines,
    isEmpty,
    isNotEmpty,
    numberLines,
    numberAllLines,
    numberNonEmptyLines,
    numberAndIncrementNonEmptyLines,
    prettyNumberedLines,
    PadMode (..),
    pad,
    padLeft,
    padRight,
  )
where

import Data.Char

type NumberedLine = (Maybe Int, String)

type NumberedLines = [NumberedLine]

isEmpty :: String -> Bool
isEmpty str =
  null str
    || all (\s -> not (isPrint s) || isSeparator s) str

isNotEmpty :: String -> Bool
isNotEmpty str = not (isEmpty str)

numberLines :: (String -> Bool) -> (String -> Bool) -> [String] -> NumberedLines
numberLines shouldIncr shouldNumber text =
  let go :: Int -> [String] -> NumberedLines
      go _ [] = []
      go counter (x : xs) =
        let mNumbering = if shouldNumber x then Just counter else Nothing
            newCounter = if shouldIncr x then counter + 1 else counter
         in (mNumbering, x) : go newCounter xs
   in go 1 text

numberAllLines :: [String] -> NumberedLines
numberAllLines = numberLines (const True) (const True)

numberNonEmptyLines :: [String] -> NumberedLines
numberNonEmptyLines = numberLines (const True) isNotEmpty

numberAndIncrementNonEmptyLines :: [String] -> NumberedLines
numberAndIncrementNonEmptyLines = numberLines isNotEmpty isNotEmpty

prettyNumberedLines :: PadMode -> NumberedLines -> [String]
prettyNumberedLines mode lineNums =
  let (numbers, text) = unzip lineNums
      numberStrings = map (maybe "" show) numbers -- this is like list.map { it ?: ""}
      maxLength = maximum (map length numberStrings)
      paddedNumbers = map (pad mode maxLength) numberStrings
   in zipWith (\n l -> n ++ " " ++ l) paddedNumbers text

data PadMode = PadLeft | PadRight

pad :: PadMode -> Int -> String -> String
pad mode n str =
  let diff = n - length str
      padding = replicate diff ' '
   in case mode of
        PadLeft -> padding ++ str
        PadRight -> str ++ padding

padLeft :: Int -> String -> String
padLeft = pad PadLeft

padRight :: Int -> String -> String
padRight = pad PadRight