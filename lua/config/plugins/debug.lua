local dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' }

local config = function()
  local dap = require('dap')

  dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = 'executable',
    command = 'OpenDebugAD7'
  }
  dap.configurations.c = {
    {
      name = 'Launch file',
      type = 'cppdbg',
      request = 'launch',
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/',
          'file')
      end,
      cwd = '${workspaceFolder}',
      stopAtEntry = false,
      setupCommands = {
        {
          text = '-enable-pretty-printing',
          description = 'enable pretty printing',
          ignoreFailues = false
        }
      }
    },
  }
  dap.configurations.cpp = dap.configurations.c
  vim.keymap.set('n', '<F5>', dap.continue,
    { desc = 'debug continue' })
  vim.keymap.set('n', '<C-F5>', dap.close,
    { desc = 'debug stop' })
  vim.keymap.set('n', '<Leader>db', dap.toggle_breakpoint,
    { desc = '[d]ebug toggle [b]reakpoint' })
  vim.keymap.set('n', '<F10>', dap.step_over,
    { desc = 'step over' })
  vim.keymap.set('n', '<F11>', dap.step_into,
    { desc = 'step into' })
  vim.keymap.set('n', '<S-F10>', dap.step_out,
    { desc = 'step out' })

  local dapui = require('dapui')
  dapui.setup()
  vim.keymap.set('n', '<Leader>di', dapui.toggle,
    { desc = 'toggle [d]ebug [i]nterface' })
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
end

return {
  'rcarriga/nvim-dap-ui',
  dependencies = dependencies,
  config = config
}
