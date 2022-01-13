# PC-8 Packer

A minimal [LÖVE](https://love2d.org) application that renders the CP437 (PC-8)
characters of a unicode ttf, and allows you to pack that into a lua source
font file that draws the font. Here is the quick and dirty usage of the output
source code:

```lua
myFont = require 'thefontfile'

function love.draw()
    myFont:print("Hello world!",0,0)
end
```



