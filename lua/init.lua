-- Archivo: lua/init.lua

local pomodoro = require("pomodoro")
pomodoro.setup()

-- Definir el comando personalizado para iniciar el Pomodoro
vim.cmd([[command! PomodoroStart lua require('pomodoro').start()]])

-- Resto de tu configuración
