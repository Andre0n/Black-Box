local gr = love.graphics
local flor = { image = { gr.newImage('assets/flor.png'), gr.newImage'assets/flor2.png'}, im = 1, px= 550, py = 290, wi = 54, hg = 100  };
flor.draw = function( num ) gr.draw( flor.image[num],flor.px, flor.py) end
return flor;
