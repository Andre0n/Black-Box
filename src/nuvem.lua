local gr = love.graphics
local nuvem = { image = { gr.newImage('assets/nuvem1.png'), gr.newImage'assets/nuvem2.png'}, im = 1 };
nuvem.draw = function( num ) gr.draw( nuvem.image[num],0, -100) end
return nuvem;
