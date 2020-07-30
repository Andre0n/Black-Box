--> A árvore.
local gr = love.graphics
local arvore = { image = { gr.newImage('assets/arvore1.png'), gr.newImage'assets/arvore2.png'}, im = 1, px= 300, py = 160, wi = 200, hg = 200 };
arvore.draw = function( num ) gr.draw( arvore.image[num],arvore.px, arvore.py) end
return arvore;
