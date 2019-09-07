module Main where

import System.Directory
import System.FilePath

nearestElmJson :: IO (Maybe FilePath)
nearestElmJson =
  getCurrentDirectory >>= nearestElmJsonHelp

nearestElmJsonHelp :: FilePath -> IO (Maybe FilePath)
nearestElmJsonHelp filepath = do
  let candidate = filepath </> "elm.json"
  exists <- doesFileExist candidate
  if exists then
    pure $ Just candidate
  else
    let next = takeDirectory filepath in

    if next == filepath then
      pure Nothing
    else
      nearestElmJsonHelp next
  
main :: IO ()
main = do
  elmJson <- nearestElmJson
  putStrLn (show elmJson)
