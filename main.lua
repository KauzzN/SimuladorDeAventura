os.execute("chcp 65001")
local Historia = require("historia")
local Utils = require("utils")

math.randomseed(os.time())

Utils.limparTela()
Historia.iniciar()
