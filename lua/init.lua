-- Archivo: lua/init.lua

local pomodoro = require("pomodoro")
pomodoro.setup()

-- Definir el comando personalizado para iniciar el Pomodoro
vim.cmd([[command! PomodoroStart lua require('pomodoro').start_pomodoro()]])

-- Resto de tu configuración
