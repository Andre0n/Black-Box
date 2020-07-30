--> O Jogador <--
local gr = love.graphics
player = {  -- Vetor que contém todas as propieades do jogador.
  px = 80, py = 109, pxVel = 0, pyVel = 0, speed = 200, --> Argumentos padrões(Posição, velocidade, etc.)
  jumpsLeft = 2, --> Conta os pulos restantes do jogador.
  dJump = true, --> Verifica se pode dar duplo-pulo.
-- Os valores foram definids manualmente para controlar melhor a hitbox do jogador.
  hg = 70, --> Altura do jogador.
  wi = 50, --> Largura do jogador.
  vivo = true; --> Verifica se o player está vivo.
  andando = false
}
local image, idle, run --> Definindo Variaveis para animação.
local andando = false --> Verifica se está andando.
local esquerda = false -- > Verifica se está indo para a esquerda.
-- Variáveis para animação.
image = {gr.newImage('assets/idle.png'),
        gr.newImage('assets/andando.png'),
        pulando = {
          gr.newImage('assets/pulando1.png'),
          gr.newImage('assets/pulando2.png')}}
-- Grade de imagens do player.
local grid1 = anim8.newGrid(54, 81, image[1]:getWidth(), image[1]:getHeight()) -- Idle grid.
local grid2 = anim8.newGrid(56, 81, image[2]:getWidth(), image[2]:getHeight()) -- run grid.
idle = anim8.newAnimation(grid1('1-3',1), 0.15) --> Anima o idle
run = anim8.newAnimation(grid2('1-6',1), 0.1) --> Anima correndo.s
function player:update(dt) -- Atualiza as variáveis do Jogador.
  --Atualiza as animações.
  idle:update(dt)
  run:update(dt)
  -- Move o jogador baseado na gravidade.
  self.pyVel = self.pyVel + gravity * dt
  self.px = self.px + self.pxVel * dt
  self.py = self.py + self.pyVel * dt
  -- Move para o chão se necessário.
  if self.py + self.hg >= ground_level then
     self.mode = 'ground'
     self.pyVel = 0
     self.py = ground_level - self.hg
  end
  -- Reinicia o pulo duplo se está no chão.
  if self.mode == 'ground' then
     if self.dJump then
        self.jumpsLeft = 2
     else
        self.jumpsLeft = 1
     end
  end
  -- Muda para 'voando' se está caindo e não está no chão.
  if self.mode == 'jump' and self.pyVel > 0 then
     self.mode = 'air'
  end
  --Controles de esquerda e direita.
  if love.keyboard.isDown('a') and self.px > maxEsq and self.vivo then
      self.px = self.px - self.speed*dt
      self.andando = true;
      esquerda = true;
  elseif love.keyboard.isDown('d') and self.px  < width + 300  and self.vivo then
      self.px = self.px + self.speed*dt;
      self.andando = true;
      esquerda = false;
  else
      self.andando = false;
      esquerda = false;
  end
end
function player:draw() -- Desenha o player na tela.
  if self.mode == 'ground' then
    if self.andando and esquerda == false then
      run:draw(image[2], self.px, self.py )
    elseif self.andando and esquerda then
      run:draw(image[2], self.px, self.py,0,-1, 1, image[2]:getWidth()-270, 0) --Desenha o personagem invertido e atualiza o ponto de origem da imagem.
    else
      idle:draw(image[1], self.px, self.py)
    end
  elseif self.jumpsLeft <= 0 then
    gr.draw(image.pulando[2], self.px, self.py)
  elseif self.py > 100 then
    gr.draw(image.pulando[1], self.px, self.py)
  end
end
function player:jump() --Responsável pelo pulo do jogador.
  if self.jumpsLeft > 0 and self.mode ~= 'jump' then
     self.jumpsLeft = self.jumpsLeft - 1
     self.mode = 'jump'
     self.pyVel = -450
  end
end
function love.keypressed(key, isrepeat) -- Verifica se tecla 'w' foi pressionada.
   if key == 'w' and player.vivo then
      player:jump()
   end
end

return player; -- Retorna o player, bem como suas propiedades, para uso em outras áereas do projeto.
