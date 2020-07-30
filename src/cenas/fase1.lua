--> A Fase 1 <--
fase1 = {}
-- Variaveis gerais.
local i,cont = 0, 40 -- Variaveis contadoras.
local alpha = 0 -- Altera e gerencia opacidade
-- Objetos da fase.
local pedra = require ("src.pedra")
local flor = require ("src.flor")
local fundo = require("src.fundo")
local chao = require("src.chao")
local montanha = require("src.montanha")
local nuvem = require("src.nuvem")
local  py =  1
local timer = 1
local vol = 0.1
-- Área que forma quando o jogador colide com objetos.
stencil.area2 = {x = flor.px + 50, y = flor.py + 5 , w=180, h=180, sides=50}
stencil.cir2 = stencil.create( stencil.area2 ) --> Área do obstáculo flor
stencil.area3 = {x = pedra.px+50 , y= pedra.py+5 , w=180, h=180, sides=50}
stencil.cir3= stencil.create( stencil.area3 ) --> Área do obstáculo pedra
-- Funções padrões.
function fase1: draw() --> Desenha cena na tela.
  love.audio.play(tema)
  -- Aplica o Shack (tremer tela).
  shack:apply()
  --Desenha os objetos.
  stencil.draw( 'outside', fundo.draw, 1 )-- Desenhando o objeto de acordo com parametro [1] fora, [2] dentro.
  stencil.draw( 'inside',  fundo.draw, 2 )
  stencil.draw( 'outside', nuvem.draw, 1 )-- Desenhando o objeto de acordo com parametro [1] fora, [2] dentro.
  stencil.draw( 'inside',  nuvem.draw, 2 )
  stencil.draw( 'outside', montanha.draw, 1 )-- Desenhando o objeto de acordo com parametro [1] fora, [2] dentro.
  stencil.draw( 'inside',  montanha.draw, 2 )
  stencil.draw( 'outside', chao.draw, 1 )-- Desenhando o objeto de acordo com parametro [1] fora, [2] dentro.
  stencil.draw( 'inside',  chao.draw, 2 )
  stencil.draw( 'outside', flor.draw, 1 )-- Desenhando o objeto de acordo com parametro [1] fora, [2] dentro.
  stencil.draw( 'inside',  flor.draw, 2 )
  stencil.draw( 'outside', pedra.draw, 1 )-- Desenhando o objeto de acordo com parametro [1] fora, [2] dentro.
  stencil.draw( 'inside',  pedra.draw, 2 )
  -- Desenha o player somente se estiver vivo.
  if player.vivo then
		player:draw()
	end
  -- Ecurece a tela se o player passa da tamanho dela.
  if  player.px > width + 1 then
    love.audio.setVolume(vol)
    love.audio.pause(tema)
    gr.setColor(0,0,0, alpha)
    gr.rectangle('fill', 0,0,1280,720)
    gr.setColor(1,1,1)
  end
end
function fase1:update(dt) --> Atualiza valores das variáveis na cena.
  shack:update(dt) --> Atualiza a função de tremer a tela.
  stencil.cir = stencil.create( stencil.area )
  stencil.area.x = mouseX
  stencil.area.y = mouseY
  player:update(dt)
  --Checa Colisão com os objetos e treme a tela.
  if CkC(player.px, player.py, player.wi, player.hg, flor.px, flor.py, flor.wi,flor.hg) then
    stencil.cir2 = stencil.create(stencil.area2)
		player.vivo = false
    -- Treme a tela por aproximadamente 1 sec.
    while i < 1 do
		    shack:setShake(2)
	  		shack:setRotation(.1/5)
	  		shack:zoom(1.03)
	  		i = i +1
        love.audio.play(col)
	  end
    -- Da um delay entre a morte do personagem e seu respawn.
		if cont == 0 then
			player.vivo = true
			player.px = 10
			player.py = ground_level
			cont  =  50
			i = 0;
		else
			cont = cont - 1
		end
	end
  if CkC(player.px, player.py, player.wi, player.hg -30, pedra.px, pedra.py, pedra.wi,pedra.hg) then
    stencil.cir2 = stencil.create(stencil.area3)
		player.vivo = false
    -- Treme a tela por aproximadamente 1 sec.
    while i < 1 do
			shack:setShake(2)
	  		shack:setRotation(.1/5)
	  		shack:zoom(1.03)
	  		i = i +1
        love.audio.play(col)
	  	end
    -- Da um delay entre a morte do personagem e seu respawn.
		if cont == 0 then
			player.vivo = true
			player.px = 10
			player.py = ground_level
			cont  =  50
			i = 0;
		else
			cont = cont - 1
		end
	end
  -- Se o player passar a tela Atualiza o alpha
  if player.px >  width + 1 then
    alpha = alpha + (255/300*dt)
    --Muda de tela depois de um certo tempo.
    if alpha >= 3.00 then
      estadoCena = 'f2'
      player.px = 0 --> Seta a nova posição do jogador.
    end
  else
    alpha = 0
  end
  if player.andando and player.mode == 'ground'then
    love.audio.play(andando)
  end
  --Atualiza o volume
  if  player.px > width + 1 and vol >=0 then
    vol = vol - 1*dt
  end
end
return fase1;
