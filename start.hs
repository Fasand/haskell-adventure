module Main where

-- Concurrency for keypresses, listening for events
-- Source: http://rosettacode.org/wiki/Keyboard_input/Keypress_check#Haskell
import Control.Concurrent
import Control.Monad
import Data.Maybe
import System.IO
import System.Console.Terminal.Size

-- Custom library functions, canvas handling, text generating
import Adventure.Canvas
import Adventure.Text

main = do
    c <- newEmptyMVar
    hSetBuffering stdin NoBuffering

    -- Get Terminal size
    s <- size
    let (w, h) = (\(Just x) -> (width x, height x)) s
    --putStrLn (show w ++ " " ++ show h)

    forkIO $ do
      key <- getChar
      putMVar c key
      case key of
        'w' -> draw $ generateFullCanvas w h ('˄', True)
        'a' -> draw $ generateFullCanvas w h ('˂', True)
        's' -> draw $ generateFullCanvas w h ('˅', True)
        'd' -> draw $ generateFullCanvas w h ('˃', True)
        _   -> draw $ generateFullCanvas w h (key, True)
      -- putStrLn $ "\nChar:" ++ [key] -- left for debugging purposes

    -- Start listening for keys
    wait c
  -- !! Need a way to preserve state !! --
  -- !! when a key is pressed, original canvas must be saved !! --
  where wait c = do
          a <- tryTakeMVar c                -- has a key been assigned?
          if isJust a then main             -- yes: do main (should be changed)
          else threadDelay 200000 >> wait c -- no:  try again in timeout

-- Draw the canvas onto the terminal window
-- print every row of the canvas
-- -- take just the char from each pixel
draw :: Canvas -> IO ()
draw = mapM_ (putStrLn . map fst)
