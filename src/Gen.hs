module Gen where

import System.Environment -- getEnv
import Data.List.Split -- splitOn
import System.IO
import System.Process

main :: IO ()
main = do
  -- Environment Setting
  env <- getEnv "HOME"
  let localPath = "/.local/lib/HTEPS/"
      path      = env ++ localPath
  
  (_, Just hout, _, _) <- createProcess (proc "bash" ["-c", "bash wordinstall.sh"]){ std_out = CreatePipe }
  installMessage <- hGetContents hout
  putStrLn "> Update Words..."
  putStrLn installMessage

  -- ReadFile
  putStrLn "What level do you like memorize? (0 ~ 20)"
  level <- getLine
  words <- readFile (path ++ "Word/word" ++ level ++ ".txt")
  means <- readFile (path ++ "Mean/mean" ++ level ++ ".txt")
  putStrLn "What kind of test do you like? 1:Words, 2:Means"
  test <- getLine
  case reads test :: [(Integer, String)] of
    [(1, _)] -> iterateList (wordProcess words, wordProcess means)
    [(2, _)] -> iterateList (wordProcess means, wordProcess words)
    _        -> putStrLn "Invalid Input"

-- Type Aliases
type TGem   = String
type TWord  = String
type TWords = [String]

-- Word Process
wordGen :: TGem -> TWords
wordGen gem = filter (/= "") $ splitOn "\n" gem

trim :: TGem -> TWord
trim gem = reverse $ dropWhile (== ' ') $ reverse $ dropWhile (== ' ') gem

wordProcess :: TGem -> TWords
wordProcess gem = map trim (wordGen gem)

-- Iteration IO
iterateList :: (TWords, TWords) -> IO ()
iterateList (x:y, a:b)
  | y /= [] = do
    putStrLn ("> " ++ x)
    line <- getLine
    putStrLn a
    putStrLn ""
    iterateList (y, b)
  | otherwise = do
    putStrLn ("> " ++ x)
    line <- getLine
    putStrLn a
    putStrLn ""
    putStrLn "------Finish------"
