--> Pedra exclusiva para a fase2.
local gr = love.graphics
local pedraf2 = { image = { gr.newImage('assets/pedra.png'), gr.newImage'assets/pedra2.png'}, im = 1, px= 400, py = 540, wi = 50, hg = 50  };
pedraf2.draw = function( num ) gr.draw( pedraf2.image[num],pedraf2.px, pedraf2.py) end
return pedraf2;
