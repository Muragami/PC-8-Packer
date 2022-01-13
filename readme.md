# PC-8 Packer

A minimal [LÖVE](https://love2d.org) application that renders the CP437 (PC-8)
characters of a unicode ttf, and allows you to pack that into a lua source
font file that draws the font. This repo includes all the fonts of the
[int10h Ultimate Oldschool PC Font Pack 2.2](https://int10h.org/oldschool-pc-fonts/).

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