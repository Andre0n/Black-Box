local gr = love.graphics
local chao2 = { image = {gr.newImage'assets/chao_f2.png', gr.newImage'assets/chao2_f2.png'}, im = 1 };
chao2.draw = function( num ) gr.draw( chao2.image[num],0, 0) end
return chao2;
