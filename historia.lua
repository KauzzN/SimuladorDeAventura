-- historia.lua
local Personagens = require("personagens")
local Battle = require("batalha")
local Lugares = require("lugares")
local Inventario = require("inventario")
local Itens = require("itens")

local Historia = {}

function Historia.iniciar()
    print("=== Bem-vindo ao RPG de Aventura ===")
    print("Digite o nome do seu personagem:")
    local nome = io.read()

    print("Escolha a sua classe:")
    print("1 - Guerreiro")
    print("2 - Arqueiro")
    print("3 - Mago")

    local classeEscolhida = tonumber(io.read())

    local tipo = "guerreiro"
    if classeEscolhida == 1 then tipo = "guerreiro"
    elseif classeEscolhida == 2 then tipo = "arqueiro"
    elseif classeEscolhida == 3 then tipo = "mago" end

    local jogador = Personagens.criarClasse(tipo, nome)
    local inventario = Inventario:new()
    local itensIniciais = Itens.criarItens()
    inventario:addItem(itensIniciais[1]) -- Poção vida
    inventario:addItem(itensIniciais[2]) -- Poção mana

    local continua = true
    local visitouTaverna = false
    local goblinDerrotado = false

    while continua and jogador:isVivo() do
        local escolha = Lugares.vila()

        if escolha == 1 then
            Lugares.taverna()
            visitouTaverna = true

        elseif escolha == 2 then
            Lugares.floresta()
            local inimigo = Personagens.criarInimigo("goblin")
            local venceu = Battle.combate(jogador, inimigo, inventario)
            if venceu then
                goblinDerrotado = true
                print("Você encontrou uma Poção de Vida no corpo do Goblin.")
                inventario:addItem(itensIniciais[1]) -- recompensa
            else
                break
            end

        elseif escolha == 3 then
            inventario:mostrarItens()
        elseif escolha == 4 then
            continua = false
        else
            print("Opção inválida.")
        end
    end

    -- Finais múltiplos
    if visitouTaverna and goblinDerrotado then
        print("\nParabéns! Você cumpriu a missão e salvou a vila! FIM BOM.")
    elseif not visitouTaverna then
        print("\nVocê ignorou o pedido de ajuda do sábio e saiu da vila. FIM NEUTRO.")
    elseif not goblinDerrotado then
        print("\nVocê fugiu da batalha ou foi derrotado. FIM RUIM.")
    end

    print("\nObrigado por jogar!")
end

return Historia
