-- personagens.lua
local Personagens = {}

local Personagem = {}
Personagem.__index = Personagem

function Personagem:new(nome, classe, nivel, vidaMax, manaMax, forca, agilidade, inteligencia)
    local obj = {
        nome = nome or "Herói",
        classe = classe or "Guerreiro",
        nivel = nivel or 1,
        vidaMax = vidaMax or 100,
        vida = vidaMax or 100,
        manaMax = manaMax or 30,
        mana = manaMax or 30,
        forca = forca or 10,
        agilidade = agilidade or 5,
        inteligencia = inteligencia or 5,
        experiencia = 0,
        experienciaParaProximoNivel = 100,
        habilidades = {}, -- tabela de funções ou habilidades especiais
        isPlayer = false,
    }
    setmetatable(obj, self)
    return obj
end

function Personagem:isVivo()
    return self.vida > 0
end

function Personagem:receberDano(dano)
    self.vida = self.vida - dano
    if self.vida < 0 then self.vida = 0 end
end

function Personagem:usarMana(custo)
    if self.mana >= custo then
        self.mana = self.mana - custo
        return true
    else
        return false
    end
end

function Personagem:ganharExperiencia(exp)
    self.experiencia = self.experiencia + exp
    while self.experiencia >= self.experienciaParaProximoNivel do
        self.experiencia = self.experiencia - self.experienciaParaProximoNivel
        self:nivelar()
    end
end

function Personagem:nivelar()
    self.nivel = self.nivel + 1
    self.vidaMax = self.vidaMax + 20
    self.vida = self.vidaMax
    self.manaMax = self.manaMax + 10
    self.mana = self.manaMax
    self.forca = self.forca + 3
    self.agilidade = self.agilidade + 2
    self.inteligencia = self.inteligencia + 2
    self.experienciaParaProximoNivel = math.floor(self.experienciaParaProximoNivel * 1.5)
    print("\nParabéns! Você subiu para o nível " .. self.nivel .. "!\n")
end

-- Ataque básico
function Personagem:ataqueBasico(inimigo)
    local dano = self.forca + math.random(0, 5)
    inimigo:receberDano(dano)
    return dano
end

-- Definição das classes pré-definidas com habilidades
function Personagens.criarClasse(tipo, nome)
    local p = nil

    if tipo == "guerreiro" then
        p = Personagem:new(nome, "Guerreiro", 1, 130, 20, 18, 8, 4)
        p.habilidades = {
            -- Golpe forte: dano maior, custa mana
            GolpeForte = function(self, inimigo)
                local custoMana = 8
                if self:usarMana(custoMana) then
                    local dano = self.forca * 2 + math.random(5, 10)
                    inimigo:receberDano(dano)
                    return dano, true
                else
                    return 0, false
                end
            end
        }
    elseif tipo == "arqueiro" then
        p = Personagem:new(nome, "Arqueiro", 1, 100, 30, 14, 16, 6)
        p.habilidades = {
            FlechaMortal = function(self, inimigo)
                local custoMana = 10
                if self:usarMana(custoMana) then
                    local dano = self.agilidade * 3 + math.random(5, 10)
                    inimigo:receberDano(dano)
                    return dano, true
                else
                    return 0, false
                end
            end
        }
    elseif tipo == "mago" then
        p = Personagem:new(nome, "Mago", 1, 90, 80, 6, 8, 20)
        p.habilidades = {
            BolaDeFogo = function(self, inimigo)
                local custoMana = 15
                if self:usarMana(custoMana) then
                    local dano = self.inteligencia * 4 + math.random(10, 15)
                    inimigo:receberDano(dano)
                    return dano, true
                else
                    return 0, false
                end
            end
        }
    else
        p = Personagem:new(nome, "Aventureiro", 1, 100, 30, 10, 10, 10)
        p.habilidades = {}
    end

    p.isPlayer = true
    return p
end

-- Criar inimigos básicos (exemplo)
function Personagens.criarInimigo(tipo)
    if tipo == "goblin" then
        return Personagem:new("Goblin", "Inimigo", 1, 80, 0, 12, 8, 2)
    elseif tipo == "lobo" then
        return Personagem:new("Lobo Selvagem", "Inimigo", 1, 100, 0, 14, 12, 2)
    elseif tipo == "bruxo" then
        return Personagem:new("Bruxo Sombrio", "Inimigo", 2, 110, 40, 10, 10, 15)
    else
        return Personagem:new("Monstro", "Inimigo", 1, 70, 0, 10, 8, 5)
    end
end

return Personagens
