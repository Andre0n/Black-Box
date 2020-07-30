local gr = love.graphics
local fantasma = { image = { gr.newImage('assets/fantasma1.png'), gr.newImage'assets/fantasma2.png'}, im = 1, px= 750, py = 480, wi = 90, hg = 130  };
fantasma.draw = function( num ) gr.draw( fantasma.image[num],fantasma.px, fantasma.py) end
return fantasma;
