--[[
    PC-8 Packer.
    Pack PC-8/CP437 8-bit bitmap fonts from .ttf files (unicode or CP437 mapped)

    Jason A. Petrasko, muragami, muragami@wishray.com 2022
    MIT License: https://opensource.org/licenses/MIT
]]

require 'pc-8'

local fnt = { list = {}, index = {}, hopts = { 'normal', 'light', 'mono', 'none' }, 
        size = 16, hinting = 'none', dir = "/", wid = 8, cp437_native = true }


local function starts_with(str, start)
   return str:sub(1, #start) == start
end

local function ends_with(str, ending)
   return ending == "" or str:sub(-#ending) == ending
end

fnt.load = function(self,dir)
    local files = love.filesystem.getDirectoryItems(dir)
    for k, file in ipairs(files) do
        if ends_with(file,".ttf") then
            self.list[k] = dir .. file
            self.index[file] = dir .. file
        end
    end
    self.dir = dir
end

fnt.build = function(self)
    self.font = love.graphics.newFont(self.sel, self.size, self.hinting)
    -- figure the max width
    local mwid = 0
    for i = 1, 256,1 do
        local w = self.font:getWidth(pc8_to_utf8(i-1))
        if w > mwid then mwid = w end
    end
    self.wid = mwid
end

fnt.select = function(self,x)
    local sel
    if type(x) == 'number' then
        sel = self.list[x]
    else
        sel = self.index[x]
    end
    if sel and self.sel ~= sel then
        self.sel = sel
        self:build()
    end
end

fnt.setSize = function(self,x)
    self.size = x
    self:build()
end

fnt.setHinting = function(self,x)
    if type(x) == 'number' then
        self.hinting = self.hopts[x]
    else
        self.hinting = x
    end
    self:build()
end

fnt.draw = function(self,dx,dy,scale)
    local s = scale or 1.0
    local g = love.graphics

    if not self.font then return end

    g.setFont(self.font)

    local i = 0
    for y = 1, 8, 1 do
        local ddx = dx
        local ddy = dy + ((y-1) * (self.size) * s)
        for x = 1, 32, 1 do
            love.graphics.print(pc8_to_utf8(i), ddx, ddy, 0, s, s)
            i = i + 1
            ddx = ddx + ((self.wid+1) * s)
        end
    end
end

-- emit a lua file for this font!
fnt.emit = function(self)
    -- make sure we are in mono mode
    self:setHinting(3)
    -- first draw to a canvas so we can get the texture later
    local w = 32 * (self.wid+1)
    local h = 8 * self.size
    if math.fmod(w,24) > 0 then w = (math.floor(w/24) + 1) * 24 end -- make sure we are 24 pixel aligned for our encoding below!
    local c = love.graphics.newCanvas(w, h)
    love.graphics.setCanvas(c)
    self:draw(0,0,1.0)
    love.graphics.setCanvas()
    local id = c:newImageData()
    id:encode('png','test.png')

    local t = {}
    local l = {}
    local function ti(str) table.insert(t,str) end
    ti("local fnt = { name = '" .. self.sel .. "', height = " .. tostring(self.size) .. ", width = " .. tostring(self.wid) .. ", \n")
    ti("\tbit = {\n")
    local pos = 0
    local bpos = 1
    local v = 0
    for y=1, h, 1 do
        for x=1, w, 1 do
            local pr, pg, pb, pa = id:getPixel(x-1, y-1)
            if pa > 0.9 then
                v = v + bit.lshift(1,pos)
            end
            pos = pos + 1
            if pos == 6 then
                if v + 48 == 0x5C then 
                    l[bpos] = string.char(0x2F)
                else 
                    l[bpos] = string.char(v + 48)
                end
                pos = 0
                v = 0
                bpos = bpos + 1
                if bpos == 121 then
                    ti("\t'" .. table.concat(l) .. "',\n")
                    bpos = 1
                    l = {}
                end
            end
        end
    end
    if bpos > 1 then ti("\t'" .. table.concat(l) .. "',\n") end
    ti("\t} }\n")
    ti([[
local w, h = 32 * (fnt.width+1), 8 * fnt.height
if math.fmod(w,24) > 0 then w = (math.floor(w/24) + 1) * 24 end
local id = love.image.newImageData(w, h)
local x, y, lpos, bpos, tpixel, ppos = 0, 0, 1, 1, w*h, 0
local cstr = fnt.bit[lpos]
local cend = cstr:len()

while (ppos < tpixel) do
    local v = cstr:byte(bpos,bpos)
    if v == 0x2F then v = 0x5C end
    v = v - 48
    for i = 1, 6, 1 do
        if bit.band(v,bit.lshift(1,i-1)) > 0 then id:setPixel(x, y, 1.0, 1.0, 1.0, 1.0) end
        x = x + 1
        if x == w then
            x = 0
            y = y + 1
        end
    end
    ppos = ppos + 6
    bpos = bpos + 1
    if bpos > cend then
        lpos = lpos + 1
        if lpos < #fnt.bit then 
            cstr = fnt.bit[lpos]
            cend = cstr:len()
        end
        bpos = 1
    end
end

fnt.img = love.graphics.newImage(id)
-- the 16 color CGA palette is built in (but can be altered or replaced)
fnt.palette = { {0.0, 0.0, 0.0, 1.0 }, { 0.0, 0.0, 0.5, 1.0 }, { 0.0, 0.5, 0.0, 1.0 }, { 0.0, 0.5, 0.5, 1.0 },
                { 0.5, 0.0, 0.0, 1.0 }, { 0.5, 0.0, 0.5, 1.0 }, { 0.5, 0.5, 0.0, 1.0 }, { 0.75, 0.75, 0.75, 1.0 },
                { 0.5, 0.5, 0.5, 1.0 }, { 0.0, 0.0, 1.0, 1.0 }, { 0.0, 1.0, 0.0, 1.0 }, { 0.0, 1.0, 1.0, 1.0 },
                { 1.0, 0.0, 0.0, 1.0 }, { 1.0, 0.0, 1.0, 1.0 }, { 1.0, 1.0, 0.0, 1.0 }, { 1.0, 1.0, 1.0, 1.0 } }
fnt.quad = {}
-- done, so make us quads for each character
local fw, fh = fnt.width, fnt.height
local i = 0
for y=1, 8, 1 do
    for x = 1, 32, 1 do
        fnt.quad[i] = love.graphics.newQuad((fw+1) * (x-1), fh * (y-1), fw, fh, w, h )
        i = i + 1
    end
end

function fnt:getHeight(str) if str then return self.height * str:len() else return self.height end end
function fnt:getWidth(str) if str then return self.width * str:len() else return self.width end end
function fnt:getDimensions(str, downward)
    local w, h, cc
    if type(str) == 'table' then
        cc = 0
        for i = 1, #str, 2 do
            cc = cc + str[i+1]:len()
        end
    else
        cc = str:len()
    end
    if downward then
        h = cc * self.height
        w = self.width
    else
        h = self.height
        w = cc * self.width
    end
    return w, h
end

function fnt:setPalette(p) self.palette = p end
function fnt:getPalette() return self.palette end

function fnt:setFilter(min, mag, anisotropy) self.img:setFilter(min, mag, anisotropy) end
function fnt:getFilter() return self.img:getFilter() end

function fnt:print(str,x,y,dontcolor,downward)
    if type(str) == 'table' then
        if dontcolor then
            local e, i = #str, 1
            while (i < e) do
                self:print(str[i+1],x,y,nil,downward)
                if downward then
                    y = y + (self.height * str[i+1]:len())
                else
                    x = x + (self.width * str[i+1]:len())
                end
                i = i + 2
            end
        else
            local e, i = #str, 1
            while (i < e) do
                if type(str[i]) == 'number' then
                    love.graphics.setColor(self.palette[str[i]+1])
                else
                    love.graphics.setColor(str[i])
                end
                self:print(str[i+1],x,y,nil,downward)
                if downward then
                    y = y + (self.height * str[i+1]:len())
                else
                    x = x + (self.width * str[i+1]:len())
                end
                i = i + 2
            end
        end
    else
        if downward then
            for i = 1, #str do
                local c = str:byte(i,i)
                love.graphics.draw(self.img, self.quad[c], x, y)
                y = y + self.height
            end
        else
            for i = 1, #str do
                local c = str:byte(i,i)
                love.graphics.draw(self.img, self.quad[c], x, y)
                x = x + self.width
            end
        end
    end
end

function fnt:printTexture(str,dontcolor,downward)
    local w, h, cc
    if type(str) == 'table' then
        cc = 0
        for i = 1, #str, 2 do
            cc = cc + str[i+1]:len()
        end
    else
        cc = str:len()
    end
    if downward then
        h = cc * self.height
        w = self.width
    else
        h = self.height
        w = cc * self.width
    end
    local c = love.graphics.newCanvas(w, h)
    love.graphics.setCanvas(c)
    self:print(str,0,0,dontcolor,downward)
    love.graphics.setCanvas()
    return c
end

function fnt:printChar(cv,x,y)
    if type(cv) == 'string' then
        love.graphics.draw(self.img, self.quad[cv:byte(1,1)], x, y)
    else
        love.graphics.draw(self.img, self.quad[bit.band(cv,0xFF)], x, y)
    end
end

return fnt
]])
    return table.concat(t)
end

return fnt

