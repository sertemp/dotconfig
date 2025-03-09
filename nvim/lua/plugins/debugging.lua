return {
  'mfussenegger/nvim-dap',
  config = function()
    local dap = require 'dap'
    vim.keymap.set('n', '<F5>', dap.continue(), {})
    vim.keymap.set('n', '<F10>', dap.step_over(), {})
    vim.keymap.set('n', '<F11>', dap.step_into(), {})
    vim.keymap.set('n', '<Leader>B', dap.set_breakpoint(), {})
  end,
}
