local gr = love.graphics
local chao = { image = { gr.newImage('assets/chao.png'), gr.newImage'assets/chao2.png'}, im = 1 };
chao.draw = function( num ) gr.draw( chao.image[num],0, 0) end
return chao;
