module Adventure.Canvas
    (Canvas, merge, generateBackground, generateFullCanvas) where

--              (char, passable)
type Pixel  = (Char, Bool)
type Canvas = [[Pixel]]

generateFullCanvas :: Int -> Int -> Pixel -> Canvas
generateFullCanvas w h p = replicate h $ replicate w p

emptyCanvas :: Int -> Int -> Canvas
emptyCanvas w h = generateFullCanvas w h (' ', True)

uniform :: Canvas -> Bool
uniform c = all (== length (head c)) $ map length c

sameDimensions :: Canvas -> Canvas -> Bool
sameDimensions c k = (length c == length k) && (uniform c && uniform k) && (length (head c) == length (head k))

generateBackground :: Int -> Int -> Canvas
generateBackground w h = generateFullCanvas w h ('\127794', False)

-- Merge two canvases
-- top onto bottom (replace anything non-space)
merge :: Canvas -> Canvas -> Canvas
merge top bottom
  | sameDimensions top bottom =
    [
      [ if t /= ' ' then (t, p1) else (b, p2)
          | i <- [0..(length (head bottom) -1)],
          let (t, p1) = (top !! r) !! i, let (b, p2) = (bottom !! r) !! i]
      | r <- [0..(length bottom - 1)]
    ]
  | otherwise = error "Canvases must be of the same size"
