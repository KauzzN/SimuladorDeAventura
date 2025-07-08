-- utils.lua
local Utils = {}

function Utils.limparTela()
    if package.config:sub(1,1) == "\\" then
        os.execute("cls")
    else
        os.execute("clear")
    end
end

return Utils
