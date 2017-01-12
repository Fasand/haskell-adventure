
-- Creates a canvas of 1/3 trees (with spaces), 1/3 "road", and some more trees
-- requires terminal-size and constants w, h (width, height)
mapM_ (\y -> putStrLn $ (take (w `div` 3) (cycle ['\127794',' '])) ++ " " ++ (take (w `div` 3 -1) (cycle ['.','\''])) ++ (take (w `div` 3) (cycle ['\127794',' ']))) [2..h]

-- Symbols
\127794 - Tree (🌲 )
\11596  - Fancy hashtag (ⵌ)
\9608   - Full block (█)
\9679   - Black circle (●)
\11044  - Large black circle (⬤ )
\128308 - Large red circle (🔴 )
\128309 - Large blue circle (🔵 )
something
