(*1*)
fun invertRGBPixel (r, g, b) = (255-r, 255-g, 255-b);
(*2*)
fun rgb2gray (r, g, b) = (3*r + 6*g + b) div 10;
(*3*)
fun gray2bw x = if x < 128 then 0 else 255;
(*4*)
fun isBrighter (r1, g1, b1) (r2, g2, b2) =
let
    val gray1 = rgb2gray (r1, g1, b1);
    val gray2 = rgb2gray (r2, g2, b2);
in
    gray1 > gray2
end;
(*5*)
fun invertImage [] = []
    | invertImage (p::ps) = invertRGBPixel p :: invertImage ps;
(*6*)
fun rgb2grayImage [] = []
    | rgb2grayImage (p::ps) = rgb2gray p :: rgb2grayImage ps;
(*7*)
fun brightest [] = (0,0,0) (* default case *)
    | brightest (p::ps) = findBrightest p ps
    and findBrightest brightest [] = brightest
    | findBrightest (r,g,b) (p::ps) =
    if isBrighter (r,g,b) p then findBrightest (r,g,b) ps
    else findBrightest p ps;
(*8*)
fun countWhite images =
let
    fun helper [] acc = acc
    | helper (image::images') acc =
    if rgb2gray (brightest image) = 255
    then helper images' (acc+1)
    else helper images' acc
in
helper images 0
end;
(*9*)
fun shrinkImage [] = []
    | shrinkImage (x::y::xs) = ((x+y) div 2) :: shrinkImage xs
    | shrinkImage _ = raise Fail "List length must be even";

