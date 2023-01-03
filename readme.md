# PC-8 Packer

A minimal [LÖVE](https://love2d.org) application that renders the CP437 (PC-8)
characters of a unicode ttf, and allows you to pack that into a lua source
font file that draws the font (or a C language file, or a JSON data file). 
This repo includes all the fonts of the [int10h Ultimate Oldschool PC Font Pack 2.2](https://int10h.org/oldschool-pc-fonts/).
Given you have LÖVE installed on your desktop, you should be able to download and
run the PC-8 Packer.love in the repo. It is built against 11.4, but it
should work on 11.0 or better.

## Application Usage

Everything is spelled out at the top of the screen, check it out!
![pc-8](https://user-images.githubusercontent.com/38527452/149370663-f6861c29-e4ca-47ff-84f9-260abd767fa6.png)

When you have the font you want to use, press spacebar and wallah! The lua
file for that font is placed into the clipboard. Paste it into your editor, save,
and you are good to go.

## Output File Usage
Here is the quick and dirty usage of the output source code:

```lua
myFont = require 'thefontfile'

function love.draw()
    myFont:print("Hello world!",0,0)
end
```

The functions provided by the output are:

```lua
w = fnt:getWidth(str)
h = fnt:getHeight(str)
```

These return the width and height of the font character when str is nil, and if you
pass a string it calculates the total width or height (if the font was printed downward).

```lua
w, h = fnt:getDimensions(str, downward)
```

Returns the dimensions of the block that contains the output text in respect to downward flags.

```lua
fnt:setPalette(p)
p = fnt:getPalette()
```

Get access to, or set the internal palette used by print(). The font comes with a built-in 
[CGA](https://en.wikipedia.org/wiki/Color_Graphics_Adapter) compatible palette of 16 colors,
but you can do what you want and replace that. Also, you can not use the palette at all,
as you'll see in :print() below.

```lua
fnt:setFilter(min, mag, anisotropy)
min, mag, anisotropy fnt:getFilter()
```

Sets the filter applied to the texture backing this font. Proper oldschool grunge can be
had by calling :setFilter('nearest','nearest').

```lua
fnt:print(str,x,y,dontcolor,downward)
```

Draws the string or color table string (see LÖVE docs) at coords: x,y. If dontcolor is
set, ignore colors sent in the table. If downward is set, draw each character downward
instead of across. Unlike the format of the color table from LÖVE, you can also just pass
a number as a color palette entry: { 15, "some text", 4, "some other text"}. 
setPalette/getPalette let you adjust/replace the internal CGA 16 color palette as you desire.

```lua
fnt:printTexture(str,dontcolor,downward)
```

As :print() above, but returns a texture of the output instead of drawing directly. Useful
to cache often used by never changed contents, but honestly the draw overhead of the quads
from print() isn't all that high.

```lua
fnt:printChar(cv,x,y)
```

Draws the character string (1st character) or CP437 entry number (type(cv) == 'number') at
the coords: x,y. Minimalist function, should be fast and compile down in luajit given jit is
enabled.

## C output format

If you select .c output format, it creates a C language source file that can fill a
bitmap with the encoded font data, plus the font character width and height. The font
bitmap is width * 32 wide and height * 8 tall (a 32x8 matrix of 0-255 characters
starting on the top left). 

## JSON output format

If you select JSON output format, it creates a .json data file with the font name,
width, and height, plus an array of strings that make up the ascii encoded 1 bit data
for the font.

## 6-bit encoded data

The bitmap bits are encoded as 24 image bits into 4 eight bit ascii characters. The process
to decode them is very simple: subtract 48 from the ascii character value, and if that results
in -1 that means the value is 44 (catch and replace). Then you have a 6 bit value to pull
the pixel values from. Repeat over every 4 eight byte values until each line is decoded.