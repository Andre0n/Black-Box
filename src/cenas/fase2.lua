--> A Fase 2 <--
fase2 = {}
-- Variaveis gerais.
local i,cont = 0, 40 -- Variaveis contadoras.
local alpha = 0 -- Altera e gerencia opacidade
local naoTocou = true --
-- Objetos da fase.
local pedraf2 = require ("src.pedraf2")
local fundo = require("src.fundo")
local chao2 = require("src.chao2")
local fantasma = require("src.fantasma")
local arvore = require("src.arvore")
local nuvem  = require("src.nuvem")
-- Área que forma quando o jogador colide com objetos.
stencil.area4 = {x = fantasma.px+70, y = fantasma.py+15, w=180, h=180, sides=50}
stencil.cir4 = stencil.create( stencil.area4 ) --> Área do obstáculo pedra
stencil.area5 = {x = pedraf2.px+50, y= pedraf2.py+5, w=180, h=180, sides=50}
stencil.cir5= stencil.create( stencil.area5 ) --> Área do obstáculo fantasma
-- Definindo Variaveis para a fase.
player.px = 0
-- Funções padrões.
function fase2:draw()
  love.audio.setVolume(0.1)
  love.audio.play(tema)
  -- Aplica o Shack (tremer tela).
  shack:apply()
    --Desenha os objetos.
  stencil.draw( 'outside', fundo.draw, 1 )-- Desenhando o objeto de acordo com parametro [1] fora, [2] dentro.
  stencil.draw( 'inside',  fundo.draw, 2 )
  stencil.draw( 'outside', nuvem.draw, 1 )-- Desenhando o objeto de acordo com parametro [1] fora, [2] dentro.
  stencil.draw( 'inside',  nuvem.draw, 2 )
  stencil.draw( 'outside', arvore.draw, 1 )-- Desenhando o objeto de acordo com parametro [1] fora, [2] dentro.
  stencil.draw( 'inside',  arvore.draw, 2 )
  stencil.draw( 'outside', chao2.draw, 1 )-- Desenhando o objeto de acordo com parametro [1] fora, [2] dentro.
  stencil.draw( 'inside',  chao2.draw, 2 )
  stencil.draw( 'outside', pedraf2.draw, 1 )-- Desenhando o objeto de acordo com parametro [1] fora, [2] dentro.
  stencil.draw( 'inside',  pedraf2.draw, 2 )
  stencil.draw( 'outside', fantasma.draw, 1 )-- Desenhando o objeto de acordo com parametro [1] fora, [2] dentro.
  stencil.draw( 'inside',  fantasma.draw, 2 )
  if player.vivo then
	   player:draw()
  end
  -- Ecurece a tela se o player passa da tamanho dela.
  if  player.px > width + 1 then
    gr.setColor(0,0,0, alpha)
    gr.rectangle('fill', 0,0,1280,720)
    gr.setColor(1,1,1)
  end
end
function fase2:update(dt)
    shack:update(dt) --> Atualiza a função de tremer a tela.
    -- Atualiza o nível da fase.
    if player.px > 400 then -- Compara a posição com a posição que o nível diminui.
      ground_level = 630 --> Atualiza o ground_level.
      player.mode =  'air' --> Muda o estado para voando.
      maxEsq = 415--> Define o máximo de pixel que pode andar para a esquerda.
    else
      maxEsq = 0 --> Mantém o máximo de pixel que pode andar para a esquerda.
      ground_level = 380 --> Mantém o nível padrão.
    end
    player:update(dt) --> Chama o update do jogador.
    --Cria a área do mouse.
    stencil.cir = stencil.create( stencil.area )
    stencil.area.x = mouseX
    stencil.area.y = mouseY
    --Checa Colisão com os objetos e treme a tela.
    if CkC(player.px, player.py, player.wi, player.hg, pedraf2.px, pedraf2.py, pedraf2.wi, pedraf2.hg) then
      stencil.cir5 = stencil.create(stencil.area5)
  		player.vivo = false
      -- Treme a tela por aproximadamente 1 sec.
      while i < 1 do
          love.audio.play(col)
  		    shack:setShake(2)
  	  		shack:setRotation(.1/5)
  	  		shack:zoom(1.03)
  	  		i = i +1
  	  end
      -- Da um delay entre a morte do personagem e seu respawn.
  		if cont == 0 then
  			player.vivo = true
  			player.px = 0
  			player.py = ground_level
  			cont  =  50
  			i = 0;
  		else
  			cont = cont - 1
  		end
  	end
    if CkC(player.px, player.py, player.wi, player.hg -30, fantasma.px, fantasma.py, fantasma.wi,fantasma.hg) then
      stencil.cir4 = stencil.create(stencil.area4)
  		player.vivo = false
      -- Treme a tela por aproximadamente 1 sec.
      while i < 1 do
        love.audio.play(col)
  			shack:setShake(2)
  	  		shack:setRotation(.1/5)
  	  		shack:zoom(1.03)
  	  		i = i +1
  	  	end
      -- Da um delay entre a morte do personagem e seu respawn.
  		if cont == 0 then
  			player.vivo = true
  			player.px = 0
  			player.py = ground_level
  			cont  =  50
  			i = 0;
  		else
  			cont = cont - 1
  		end
  	end
    -- Se o player passar a tela Atualiza o alpha.
    if player.px >  width + 1 then
      alpha = alpha + (255/300*dt)
      --Muda de tela depois de um certo tempo.
      if alpha >= 2.00 then
        estadoCena = 'fim'
      end
    else
      alpha = 0
    end
    -- Reproduz audio enquanto anda.
    if player.andando and player.mode == 'ground'then
      love.audio.play(andando)
    end
    --> Checa se o mouse está em cima do fantasma.
    if mouseX >= fantasma.px and mouseY <= fantasma.px + fantasma.wi and naoTocou then
      if mouseY >= fantasma.py and mouseY < fantasma.py + fantasma.hg then
        love.audio.play(sino)
        naoTocou = false
      end
    end
end
return fase2;
