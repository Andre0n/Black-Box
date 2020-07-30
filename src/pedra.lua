local gr = love.graphics
local pedra = { image = { gr.newImage('assets/pedra.png'), gr.newImage'assets/pedra2.png'}, im = 1, px= 760, py = 290, wi = 50, hg = 50  };
pedra.draw = function( num ) gr.draw( pedra.image[num],pedra.px, pedra.py) end
return pedra;
