local fnt = { name = 'font/Mx437_ACM_VGA_8x14.ttf', height = 16, width = 8, 
	bit_encoding = 'BASE64', bit_data = {
	'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',
	} }
local w, h = 32 * (fnt.width+1), 8 * fnt.height
if math.fmod(w,24) > 0 then w = (math.floor(w/24) + 1) * 24 end
local id = love.image.newImageData(w, h)
local x, y, lpos, bpos, tpixel, ppos = 0, 0, 1, 1, w*h, 0
local cstr = love.data.decode('string', 'base64', fnt.bit_data[lpos])
local cend = cstr:len()

while (ppos < tpixel) do
    local v = cstr:byte(bpos,bpos)
    for i = 0, 7, 1 do
        if bit.band(v, bit.lshift(1, i)) > 0 then id:setPixel(x, y, 1.0, 1.0, 1.0, 1.0) end
        x = x + 1
        if x == w then
            x = 0
            y = y + 1
        end
    end
    ppos = ppos + 8
    bpos = bpos + 1
    if bpos > cend then
        lpos = lpos + 1
        if lpos <= #fnt.bit_data then 
            cstr = love.data.decode('string', 'base64', fnt.bit_data[lpos])
            cend = cstr:len()
        end
        bpos = 1
    end
end

fnt.img = love.graphics.newImage(id)
-- the 16 color CGA palette is built in (but can be altered or replaced)
fnt.palette = { {0.0, 0.0, 0.0, 1.0 }, { 0.0, 0.0, 0.66, 1.0 }, { 0.0, 0.66, 0.0, 1.0 }, { 0.0, 0.66, 0.66, 1.0 },
                { 0.66, 0.0, 0.0, 1.0 }, { 0.66, 0.0, 0.66, 1.0 }, { 0.66, 0.33, 0.0, 1.0 }, { 0.66, 0.66, 0.66, 1.0 },
                { 0.33, 0.33, 0.33, 1.0 }, { 0.33, 0.33, 1.0, 1.0 }, { 0.33, 1.0, 0.33, 1.0 }, { 0.33, 1.0, 1.0, 1.0 },
                { 1.0, 0.33, 0.33, 1.0 }, { 1.0, 0.33, 1.0, 1.0 }, { 1.0, 1.0, 0.33, 1.0 }, { 1.0, 1.0, 1.0, 1.0 } }
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
