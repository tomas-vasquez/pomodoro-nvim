-- Archivo: init.lua

-- ... (otras configuraciones)

-- Configuración del temporizador Pomodoro
local pomodoro = {
  work_duration = 25,      -- Duración del trabajo en minutos
  break_duration = 5,      -- Duración del descanso en minutos
  pomodoros_before_long_break = 4,  -- Número de pomodoros antes de un descanso largo
}

local timer_id
local pomodoro_running = false

-- Función para mostrar mensajes temporales en la parte inferior de la pantalla
function show_message(message)
  vim.api.nvim_echo({ { message, "Title" } }, true, {})
end

-- Función para iniciar un temporizador Pomodoro
function start_pomodoro()
  pomodoro_running = true
  show_message("¡Pomodoro en marcha!")

  timer_id = vim.fn.timer_start(
    pomodoro.work_duration * 60 * 1000,
    function()
      vim.fn.timer_stop(timer_id)
      show_message("¡Pomodoro completado! Descanso...")
      vim.fn.timer_start(
        pomodoro.break_duration * 60 * 1000,
        function()
          pomodoro_running = false
          start_pomodoro()  -- Iniciar el próximo Pomodoro después del descanso
        end
      )
    end
  )
end

-- Iniciar el primer Pomodoro
start_pomodoro()

-- Configuración de Lualine
require('lualine').setup {
  options = {
    -- ... (otras opciones)
    theme = 'your_custom_theme',  -- Ajusta esto según tu tema preferido

    -- Sección personalizada para el estado del Pomodoro
    section_separators = {'', ''},
    component_separators = {'', ''},
    sections = {
      lualine_c = {
        {
          'pomodoro_status',  -- Nombre de la función personalizada
          color = { fg = '#ffffff', bg = '#ff5f00' },  -- Ajusta colores según tu preferencia
        },
      },
    },
  },
}

-- Función personalizada para mostrar el estado del Pomodoro en Lualine
function pomodoro_status()
  if pomodoro_running then
    return 'Pomodoro en curso'
  else
    return 'No hay Pomodoro en curso'
  end
end
