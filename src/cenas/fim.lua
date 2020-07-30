fim = {}
local gr = love.graphics
local final  = require("src.final") -- > Chama a arquivo com a função.
function fim:draw()
  --> Desenha a imagem na tela.
  stencil.draw( 'outside', final.draw, 1 )-- Desenhando o objeto de acordo com parametro [1] fora, [2] dentro.
  stencil.draw( 'inside',  final.draw, 2 )
end
function fim:update(dt)
  --Cria a área do mouse.
  stencil.cir = stencil.create( stencil.area )
  stencil.area.x = mouseX
  stencil.area.y = mouseY
end
return fim;
