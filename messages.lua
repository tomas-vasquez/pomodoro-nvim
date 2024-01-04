local M = {}

M.show_message_1 = function()
	vim.cmd('echo "¡Pomodoro en marcha!"')
end

M.show_message_2 = function()
	require("pomodoro-nvim.sound").play_sound() -- Play sound when Pomodoro completes

	vim.cmd('echo "¡Pomodoro completado! Descanso..."')
end

return M
