menu = {}
--Variáveis locais de controle
local estado = 1
local gr = love.graphics
local s = 0.3--> tempo de espera pra executar a função
local x,y = 0,0
function menu:load() --> Carrega os objetos.
	images = { love.graphics.newImage("assets/c1.png"), love.graphics.newImage('assets/c2.png'),love.graphics.newImage("assets/c3.png")}
end
function menu:draw() --> Desenha na tela
	love.audio.setVolume(0.1)
	love.audio.play(tema)
	--> Confere o estado de exibição
  if estado == 1 then
		gr.draw(images[estado])
	elseif estado == 2 then
		gr.draw(images[estado])
	elseif estado == 3 then
		gr.draw(images[estado])
  elseif estado > 3 then
    estadoCena = 'f1'
		love.audio.stop(tema)
	end
end
function menu:update(dt) --> Atualiza os valores das Variáveis.
	x,y = love.mouse.getPosition()
	--> Confere se o botão do mouse foi pressionado e atualiza o estado.
  if love.mouse.isDown(2) then
		love.audio.play(click)
		estado = estado + 1
		love.timer.sleep(s)
	end
end
return menu;
