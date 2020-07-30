local gr = love.graphics
local montanha = { image = { gr.newImage('assets/montanha1.png'), gr.newImage'assets/montanha2.png'}, im = 1 };
montanha.draw = function( num ) gr.draw( montanha.image[num],0, -100) end
return montanha;
