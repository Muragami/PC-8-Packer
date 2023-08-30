--[[
    PC-8 Packer.
    Pack PC-8/CP437 8-bit bitmap fonts from .ttf files (unicode or CP437 mapped)

    Jason A. Petrasko, muragami, muragami@wishray.com 2022
    MIT License: https://opensource.org/licenses/MIT
]]

io.stdout:setvbuf("no") -- let the output show in sublime text editor


fnt = require 'fnt'

usageA = "usage: <up>/<down> change font - <left>/<right> change size - <tab> change hinting"
usageB = "       <1..3> emit font to clipboard: 1 = lua, 2 = C, 3 = JSON"

local function prnt(g, txt, x, y)
    g.setColor(0.0, 0.0, 0.0, 1.0)
    g.print(txt, x, y)
    g.setColor(1.0, 1.0, 1.0, 1.0)
    g.print(txt, x + 1, y + 1)
end

function love.load()
    fnt:load("font/")
    snum = 1
    sz = 16
    hs = 4
    fnt:select(snum)
    guiFont = love.graphics.newFont("font/Mx437_Compaq_Port3.ttf", 16)
end

function love.update(dt)
end

function love.draw()
    local fname = fnt.sel or "?"
    local info = tostring(snum) .. "/" .. #fnt.list .. ": " .. fname .. " at size: " .. fnt.size .. " Hinting: " .. fnt.hinting .. " | width=" .. fnt.wid
    local g = love.graphics
    g.setFont(guiFont)
    g.setColor(0.3, 0.3, 0, 1.0)
    g.rectangle('fill', 0, 0, 1000, 40)
    g.setColor(0.5, 0, 0, 1.0)
    g.rectangle('fill', 0, 40, 1000, 20)
    
    prnt(g, usageA, 1, 1)
    
    prnt(g, usageB, 1, 21)

    prnt(g, info, 1, 41)
    
    fnt:draw(10, 71, 1.0)
end

function love.keypressed(key, scancode, isrepeat )
    if key == 'up' then
        snum = snum - 1
        if snum < 1 then snum = #fnt.list end
        fnt:select(snum)
    elseif key == 'down' then
        snum = snum + 1
        if snum > #fnt.list then snum = 1 end
        fnt:select(snum)
    elseif key == 'pagedown' then
        snum = snum + 20
        if snum > #fnt.list then snum = 1 end
        fnt:select(snum)
    elseif key == 'pageup' then
        snum = snum - 20
        if snum < 1 then snum = #fnt.index end
        fnt:select(snum)
    elseif key == 'left' then
        sz = sz - 1
        if sz < 8 then sz = 8 end
        fnt:setSize(sz)
    elseif key == 'right' then
        sz = sz + 1
        if sz > 32 then sz = 32 end
        fnt:setSize(sz)
    elseif key == 'tab' then
        hs = hs + 1
        if hs > #fnt.hopts then hs = 1 end
        fnt:setHinting(hs)
    elseif key == 'escape' then
        love.event.quit()
    elseif key == '1' then
        love.system.setClipboardText(fnt:emit('lua'))
    elseif key == '2' then
        love.system.setClipboardText(fnt:emit('C'))
    elseif key == '3' then
        love.system.setClipboardText(fnt:emit('JSON'))
    end
end
