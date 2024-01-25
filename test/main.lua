
function love.load()
	fnt = require 'test_fnt'
end

function love.draw()
	fnt:print("Hello World!", 10, 10)
end