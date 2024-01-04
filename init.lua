-- Archivo: ~/.config/nvim/lua/myplugin/init.lua

local pomodoro = require("pomodoro-nvim.pomodoro")

pomodoro.setup = function()
	vim.cmd('command! PomodoroStart :lua require("pomodoro-nvim.pomodoro").start()')
end

return pomodoro
