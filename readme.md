# PC-8 Packer

A minimal [LÖVE](https://love2d.org) application that renders the CP437 (PC-8)
characters of a unicode ttf, and allows you to pack that into a lua source
font file that draws the font. This repo includes all the fonts of the
[int10h Ultimate Oldschool PC Font Pack 2.2](https://int10h.org/oldschool-pc-fonts/).

## Application Usage

Everything is spelled out at the top of the screen, check it out!


Here is the quick and dirty usage of the output source code:

```lua
myFont = require 'thefontfile'

function love.draw()
    myFont:print("Hello world!",0,0)
end
```

