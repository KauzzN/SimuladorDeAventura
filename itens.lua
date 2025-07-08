-- itens.lua
local Itens = {}

local Item = {}
Item.__index = Item

function Item:new(nome, tipo, efeito, valor)
    local obj = {
        nome = nome or "Item",
        tipo = tipo or "consumivel", -- consumivel, arma, armadura, etc
        efeito = efeito or function(player) end,
        valor = valor or 0
    }
    setmetatable(obj, self)
    return obj
end

-- Exemplos de itens
function Itens.criarItens()
    local itens = {}

    -- Poção de vida
    table.insert(itens, Item:new("Poção de Vida", "consumivel", function(player)
        local cura = 50
        player.vida = math.min(player.vida + cura, player.vidaMax)
        print("Você recuperou " .. cura .. " de vida!")
    end, 50))

    -- Poção de mana
    table.insert(itens, Item:new("Poção de Mana", "consumivel", function(player)
        local manaRecuperada = 40
        player.mana = math.min(player.mana + manaRecuperada, player.manaMax)
        print("Você recuperou " .. manaRecuperada .. " de mana!")
    end, 40))

    -- Espada simples (aumenta força temporariamente)
    table.insert(itens, Item:new("Espada Simples", "arma", function(player)
        player.forca = player.forca + 5
        print("Sua força aumentou em 5 enquanto estiver com a espada!")
    end, 100))

    return itens
end

return Itens
