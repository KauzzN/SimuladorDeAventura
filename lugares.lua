-- lugares.lua
local Lugares = {}

function Lugares.vila()
    print("\nVocê está na Vila Tranquila, um lugar cheio de vida e pessoas amigáveis.")
    print("O que deseja fazer?")
    print("1 - Visitar a taverna")
    print("2 - Ir para a floresta")
    print("3 - Checar inventário")
    print("4 - Sair da vila (seguir viagem)")

    local escolha = tonumber(io.read())
    return escolha
end

function Lugares.taverna()
    print("\nVocê entrou na taverna. Um velho sábio se aproxima e lhe fala sobre uma missão.")
    print("Ele pede para que você derrote o Goblin que vem aterrorizando a vila.")
end

function Lugares.floresta()
    print("\nVocê adentra a floresta densa. O ambiente é escuro e assustador.")
    print("De repente, um inimigo aparece!")
end

return Lugares
