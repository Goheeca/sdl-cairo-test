module Main where

import SDL
import Linear.V2 (V2(..))
import SDL.Cairo
import SDL.Cairo.Canvas
import SDL.Cairo.Image.Render
import Codec.Picture
import qualified Data.Text as T

main :: IO ()
main = do
  initializeAll
  window <- createWindow (T.pack "SDL2 Cairo Canvas") defaultWindow
  renderer <- createRenderer window (-1) defaultRenderer
  texture <- createCairoTexture' renderer window
  withCanvas texture $ do
    background $ gray 102
    -- location A
  readImg <- readPng "pic.png"
  case readImg of
	Left err -> putStrLn $ show err
	Right (ImageRGBA8 img) -> do drawImg texture (V2 50 50) img -- location B
                                     copy renderer texture Nothing Nothing
  present renderer
  delay 5000