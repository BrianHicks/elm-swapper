{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.Aeson
import Data.Aeson.Types
import qualified Data.ByteString.Lazy
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

data Version =
  Version String
  deriving (Show)

instance FromJSON Version where
  parseJSON = withObject "Version" (\o -> fmap Version (o .: "elm-version"))

elmVersionFromElmJson :: Maybe FilePath -> IO Version
elmVersionFromElmJson maybeElmJson =
  case maybeElmJson of
    Nothing -> pure $ Version "0.19.0"
    Just path -> do
      json <- Data.ByteString.Lazy.readFile path
      case eitherDecode json of
        Left message -> fail message
        Right version -> pure version

main :: IO ()
main = do
  elmJson <- nearestElmJson
  elmVersion <- elmVersionFromElmJson elmJson
  putStrLn (show elmVersion)
