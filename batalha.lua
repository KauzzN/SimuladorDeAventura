-- batalha.lua
local Battle = {}

local utils = require("utils")

function Battle.turno(atacante, defensor)
    print("\n" .. atacante.nome .. " (" .. atacante.classe .. ") é sua vez!")

    if atacante.isPlayer then
        print("Escolha sua ação:")
        print("1 - Ataque básico")
        local i = 2
        for habNome, _ in pairs(atacante.habilidades) do
            print(i .. " - Usar habilidade: " .. habNome)
            i = i + 1
        end
        print(i .. " - Usar item")

        local escolha = tonumber(io.read())

        if escolha == 1 then
            local dano = atacante:ataqueBasico(defensor)
            print("Você causou " .. dano .. " de dano.")
        elseif escolha > 1 and escolha < i then
            local index = escolha - 1
            local habNome = nil
            local cont = 1
            for nomeH, func in pairs(atacante.habilidades) do
                if cont == index then habNome = nomeH break end
                cont = cont + 1
            end
            if habNome then
                local dano, sucesso = atacante.habilidades[habNome](atacante, defensor)
                if sucesso then
                    print("Você usou " .. habNome .. " e causou " .. dano .. " de dano!")
                else
                    print("Mana insuficiente para usar " .. habNome .. "!")
                end
            end
        elseif escolha == i then
            return "usar_item"
        else
            print("Escolha inválida. Ataque básico será usado.")
            local dano = atacante:ataqueBasico(defensor)
            print("Você causou " .. dano .. " de dano.")
        end
    else
        -- Inimigo ataque simples
        local dano = atacante:ataqueBasico(defensor)
        print(atacante.nome .. " causou " .. dano .. " de dano em " .. defensor.nome)
    end
end

function Battle.combate(jogador, inimigo, inventario)
    print("\n--- Batalha contra " .. inimigo.nome .. " iniciada! ---")

    while jogador:isVivo() and inimigo:isVivo() do
        local acao = Battle.turno(jogador, inimigo)
        if acao == "usar_item" then
            inventario:mostrarItens()
            print("Digite o número do item para usar ou 0 para cancelar:")
            local escolhaItem = tonumber(io.read())
            if escolhaItem > 0 then
                inventario:usarItem(escolhaItem, jogador)
            else
                print("Nenhum item usado.")
            end
        end

        if not inimigo:isVivo() then
            print(inimigo.nome .. " foi derrotado!")
            local expGanha = inimigo.nivel * 50
            print("Você ganhou " .. expGanha .. " pontos de experiência.")
            jogador:ganharExperiencia(expGanha)
            break
        end

        Battle.turno(inimigo, jogador)

        if not jogador:isVivo() then
            print("Você foi derrotado...")
            break
        end
    end
    print("--- Batalha encerrada ---\n")
    return jogador:isVivo()
end

return Battle
