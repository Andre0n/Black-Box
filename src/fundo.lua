local gr = love.graphics
local fundo	= { image = { gr.newImage('assets/fundo1.png'), gr.newImage'assets/fundo2.png'}, im = 1 };
fundo.draw = function( num )	-- image to draw (1 or 2)
			gr.draw( fundo.image[num])
			end
return fundo;
