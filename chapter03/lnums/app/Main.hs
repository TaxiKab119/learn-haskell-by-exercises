module Main where

import Data.Char
import Data.Maybe (fromMaybe)
import System.Environment

printHelpText :: String -> IO ()
printHelpText msg = do
    putStrLn (msg ++ "\n")
    progName <- getProgName
    putStrLn ("Usage: " ++ progName ++ " <filename>")


-- data Maybe a = Just a | Nothing

parseArguments :: [String] -> Maybe FilePath
parseArguments [filePath] = (Just filePath)
parseArguments _ = Nothing

-- fromMaybe already exists in Data.Maybe module
-- fromMaybe :: a -> Maybe a -> a
-- fromMaybe _ (Just v) = v
-- fromMaybe v Nothing = v

indexOf :: Char -> String -> Maybe Int
indexOf _ [] = Nothing
indexOf ch (x:xs)
  | ch == x   = Just 0
  | otherwise = case indexOf ch xs of
                  Just i  -> Just (i + 1)
                  Nothing -> Nothing



greet :: Maybe String -> String
-- fromMaybe :: a -> Maybe a -> a
greet name = "Hello, " ++ fromMaybe "stranger!" name

describeScore :: Maybe Int -> String
describeScore = maybe "No score available" (\n -> "Score: " ++ show n)

safeSubtract10 :: Maybe Int -> Int
safeSubtract10 = maybe 0 (\x -> x - 10)

-- ghci> cleanList [Just 1, Just 2, Nothing, Just 4]
-- [1,2,-1,4]
cleanList :: [Maybe Int] -> [Int]
cleanList = map (fromMaybe (-1))

main :: IO ()
main = do
    cliArgs <- getArgs
    let mFilePath = parseArguments cliArgs
    -- maybe :: b -> (a -> b) -> Maybe a -> b
    maybe
        (printHelpText "Missing filename")
        (\filePath -> putStrLn filePath)
        mFilePath

interactiveLines :: Int -> IO ()
interactiveLines counter = do 
    line <- getLine
    if null line
        then return()
        else do
            putStrLn (show counter ++ ". " ++ line)
            interactiveLines (counter + 1)
