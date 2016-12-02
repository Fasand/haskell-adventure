module Adventure.Canvas
    (emptyCanvas, merge, sameDimensions) where


--              (char, passable)
type Pixel  = (Char, Bool)
type Canvas = [[Pixel]]

emptyCanvas :: Int -> Int -> Canvas
emptyCanvas w h = replicate h $ replicate w (' ', True)

uniform :: Canvas -> Bool
uniform c = all (== length (head c)) $ map length c

sameDimensions :: Canvas -> Canvas -> Bool
sameDimensions c k = (length c == length k) && (uniform c && uniform k) && (length (head c) == length (head k))

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
