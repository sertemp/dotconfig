return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'leoluz/nvim-dap-go',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    require('dapui').setup()
    require('dap-go').setup()
    local default_config = {
      delve = {
        path = 'dlv',
        initialize_timeout_sec = 20,
        port = '${port}',
        args = {},
        build_flags = '',
        -- Automatically handle the issue on delve Windows versions < 1.24.0
        -- where delve needs to be run in attched mode or it will fail (actually crashes).
        detached = vim.fn.has 'win32' == 0,
        output_mode = 'remote',
      },
      tests = {
        verbose = false,
      },
    }

    --dap configuration for wc
    require('dap').configurations.go = {
      {
        name = 'Launch wc',
        type = 'go',
        request = 'launch',
        program = '${file}',
        outputMode = default_config.delve.output_mode,
        env = {
          DATABASE_FOLDER = '/mnt/disk2/data/wc.db',
        },
      },
    }

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Move focus to the left window' })
    vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Move focus to the left window' })
    vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Move focus to the left window' })
    vim.keymap.set('n', '<Leader>B', dap.set_breakpoint, { desc = 'Move focus to the left window' })
  end,
}
