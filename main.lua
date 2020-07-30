-- Importando bibliotecas
shack = require("lib.shack") --> Efeito de tremida de tela.
stencil = require("lib.stencil") --> Arquivo que contém dados da função love.graphics.stencil.
anim8 = require ("lib.anim8") --> Biblioteca de animação.
-- Importando fontes
require("src.player") --> Chama o player.
require ("src.cenas.menu") --> Chama o menu.
require ("src.cenas.fase1")  --> Chama a fase1.
require ("src.cenas.fase2")  --> Chama a fase2.
require("src.cenas.fim") --> Chama o final.
maxEsq = 0 --> Variável global com a função de controlar o máximo valor no eixo x.
mouseX, mouseY = love.mouse.getX(),love.mouse.getY() --> Obtém a posição do mouse.
-- Constantes gerais
width, height = love.graphics.getDimensions()
gravity = 900 -- Controla a gravidade no game
ground_level = 380 -- Nível geral do game
gr = love.graphics -- Simplifica a função graphics.
estadoCena = "menu" -- Gerencia os estados do game.
love.mouse.setVisible(false) --> Oculta o mouse.
love.mouse.setGrabbed(true) --> Mantém dentro da janela.
--> Carrega o icone.
ico = love.image.newImageData('assets/ico.png')
love.window.setIcon(ico)
-- Funções padrões.
function CkC(x1,y1,w1,h1, x2,y2,w2,h2) --> Checa colisão.
	return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end
function love.load() -- Carrega dados e arquivos para o game.
  gr.setDefaultFilter("nearest", "nearest")
	-- Área que revela, sendo passada para a função stencil.
  stencil.area	= {x = 0, y=0, w=65, h=65, sides=50}
	stencil.cir	= stencil.create(stencil.area) --> Área do mouse,
	--Chama os áudios do jogo.
	tema = love.audio.newSource('assets/sounds/theme.mp3', 'static') --> Música tema
	click = love.audio.newSource('assets/sounds/click.mp3', 'static') --> Som  de click.
	col = love.audio.newSource('assets/sounds/colider.wav', 'static') --> Som de colisão.
	andando = love.audio.newSource('assets/sounds/walking.mp3', 'static') --> Som de andando.
	sino = love.audio.newSource('assets/sounds/warning.mp3', 'static') --> Som de sino.
	-- Estados do jogo.
  if estadoCena == 'menu' then
    menu:load()
  end
  if estadoCena == 'f1' then
    fase1:load()
  end
	if estadoCena == 'f2' then
    fase2:load()
  end
	if estadoCena == 'fim' then
		fim:load()
	end
end
function love.draw()  -- Desenha na tela.
  if estadoCena == 'menu' then
    menu:draw()
  end
  if estadoCena == 'f1' then
    fase1:draw()
  end
	if estadoCena == 'f2' then
    fase2:draw()
  end
	if estadoCena == 'fim' then
    fim:draw()
  end
end
function love.update(dt)  -- Atualiza variáveis ao longo do tempo.
	mouseX, mouseY = love.mouse.getX(),love.mouse.getY() --> Atualiza a posição do mouse.
		-- Estados do jogo.
  if estadoCena == 'menu' then
    menu:update(dt)
	end
  if estadoCena == 'f1' then
    fase1:update(dt)
  end
	if estadoCena == 'f2' then
    fase2:update(dt)
  end
	if estadoCena == 'fim' then
    fim:update(dt)
  end
	-- Certifica que se apertar esc sai do game.
  if love.keyboard.isDown('escape') then
    love.event.quit()
  end
end
