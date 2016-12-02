module Main where

import Control.Concurrent
import Control.Monad
import Data.Maybe
import System.IO
import System.Console.Terminal.Size

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
      putStrLn $ "\nChar:" ++ [key]
    wait c
  where wait c = do
          a <- tryTakeMVar c
          if isJust a then main
          else threadDelay 200000 >> wait c
