{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.Aeson.Types
import System.Directory
import System.FilePath

nearestElmJson :: IO (Maybe FilePath)
nearestElmJson = getCurrentDirectory >>= nearestElmJsonHelp

nearestElmJsonHelp :: FilePath -> IO (Maybe FilePath)
nearestElmJsonHelp filepath = do
  let candidate = filepath </> "elm.json"
  exists <- doesFileExist candidate
  if exists
    then pure $ Just candidate
    else let next = takeDirectory filepath
          in if next == filepath
               then pure Nothing
               else nearestElmJsonHelp next

versionDecoder :: Value -> Parser String
versionDecoder = withObject "elm-version" (\o -> o .: "elm-version")

main :: IO ()
main = do
  elmJson <- nearestElmJson
  putStrLn (show elmJson)
