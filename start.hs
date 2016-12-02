module Main where

import Control.Concurrent
import Control.Monad
import Data.Maybe
import System.IO

main = do
    c <- newEmptyMVar
    hSetBuffering stdin NoBuffering
    forkIO $ do
      key <- getChar
      putMVar c key
      putStrLn $ "\nChar:" ++ [key]
    wait c
  where wait c = do
          a <- tryTakeMVar c
          if isJust a then main
          else threadDelay 200000 >> wait c
