--> O final.
local gr = love.graphics
local final = { image = { gr.newImage('assets/final.png'), gr.newImage'assets/final2.png'}, im = 1, px= 0, py = 0};
final.draw = function( num ) gr.draw( final.image[num],final.px, final.py) end
return final;
