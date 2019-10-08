{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.Aeson
import Data.Aeson.Types
import qualified Data.ByteString.Lazy
import System.Directory
import System.FilePath
import qualified System.Info

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

elmVersionFromElmJson :: IO Version
elmVersionFromElmJson = do
  elmJson <- nearestElmJson
  case elmJson of
    Nothing -> pure $ Version "0.19.0"
    Just path -> do
      json <- Data.ByteString.Lazy.readFile path
      case eitherDecode json of
        Left message -> fail message
        Right version -> pure version

downloadURL :: String -> Either String String
downloadURL version =
  let possiblyOS =
        case System.Info.os of
          "darwin" -> Right "mac"
          "linux" -> Right "linux"
          -- TODO: what is the identifier for Windows?
          _ ->
            Left
              ("I don't know how to download binaries for the " ++
               System.Info.os ++ " operating system right now!")
      possiblyArch =
        case System.Info.arch of
          "x86_64" -> Right "64-bit"
          _ ->
            Left
              ("I don't know how to download binaries for the " ++
               System.Info.arch ++ " architecture right now!")
      downloadURLHelp :: String -> String -> String
      downloadURLHelp os arch =
        "https://github.com/elm/compiler/releases/download/" ++
        version ++ "/binary-for-" ++ os ++ "-" ++ arch ++ ".gz"
   in downloadURLHelp <$> possiblyOS <*> possiblyArch

cacheLocation :: String -> IO String
cacheLocation version =
  getXdgDirectory XdgCache ("elm-swapper" </> version </> "elm")

main :: IO ()
main = do
  (Version elmVersion) <- elmVersionFromElmJson
  binary <- cacheLocation elmVersion
  putStrLn binary
