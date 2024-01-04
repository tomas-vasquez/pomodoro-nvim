-- Archivo: lua/pomodoro.lua

local M = {}

local timer_id
local pomodoro_running = false
local pomodoro_settings = {
  work_duration = 25,                   -- Duración del trabajo en minutos
  break_duration = 5,                   -- Duración del descanso en minutos
  pomodoros_before_long_break = 4,      -- Número de pomodoros antes de un descanso largo
}

-- Función para mostrar mensajes temporales en la parte inferior de la pantalla
local function show_message(message)
  vim.api.nvim_echo({ { message, "Title" } }, true, {})
end

-- Función para iniciar un temporizador Pomodoro
local function start_pomodoro()
  pomodoro_running = true
  show_message("¡Pomodoro en marcha!")

  timer_id = vim.fn.timer_start(
    pomodoro_settings.work_duration * 60 * 1000,
    function()
      vim.fn.timer_stop(timer_id)
      show_message("¡Pomodoro completado! Descanso...")
      vim.fn.timer_start(
        pomodoro_settings.break_duration * 60 * 1000,
        function()
          pomodoro_running = false
          start_pomodoro()  -- Iniciar el próximo Pomodoro después del descanso
        end
      )
    end
  )
end

-- Función para configurar el temporizador Pomodoro
M.setup = function(settings)
  pomodoro_settings = vim.tbl_extend("force", pomodoro_settings, settings or {})
end

-- Función para iniciar el temporizador Pomodoro
M.start = function()
  start_pomodoro()
end

-- Función para obtener el estado del Pomodoro
M.get_status = function()
  return pomodoro_running
end

-- Función para detener el temporizador Pomodoro
M.stop = function()
  if pomodoro_running then
    vim.fn.timer_stop(timer_id)
    pomodoro_running = false
    show_message("Pomodoro detenido")
  else
    show_message("No hay Pomodoro en curso para detener")
  end
end

return M
