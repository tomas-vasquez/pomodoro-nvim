-- Archivo: lua/sound.lua

local M = {}

-- Función para reproducir un sonido
M.play_sound = function()
	local script_dir = debug.getinfo(1, "S").source:sub(2):match("(.*/)")
	if script_dir then
		script_dir = vim.fn.fnameescape(script_dir)
	else
		script_dir = vim.fn.getcwd()
	end

	local sound_file = script_dir .. "bell.wav"
	-- Insert code here to play the desired sound
	-- Example for Linux using paplay:
	vim.cmd("!paplay " .. vim.fn.fnameescape(sound_file) .. " &")
end

return M
