-- inventario.lua
local Inventario = {}

function Inventario:new()
    local obj = {
        itens = {}
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function Inventario:addItem(item)
    table.insert(self.itens, item)
    print("Item " .. item.nome .. " adicionado ao inventário.")
end

function Inventario:mostrarItens()
    if #self.itens == 0 then
        print("Inventário vazio.")
    else
        print("Inventário:")
        for i, item in ipairs(self.itens) do
            print(i .. ". " .. item.nome .. " (" .. item.tipo .. ")")
        end
    end
end

function Inventario:usarItem(index, jogador)
    local item = self.itens[index]
    if item then
        if item.tipo == "consumivel" then
            item.efeito(jogador)
            table.remove(self.itens, index)
        else
            print("Este item não é consumível para usar diretamente.")
        end
    else
        print("Item inválido.")
    end
end

return Inventario
