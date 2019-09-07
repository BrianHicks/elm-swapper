module Main where

import System.Directory

main :: IO ()
main = do
  here <- getCurrentDirectory
  putStrLn here
