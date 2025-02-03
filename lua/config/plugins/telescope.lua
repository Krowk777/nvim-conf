local find_files = function(dir)
  local builtin = require('telescope.builtin')
  builtin.find_files({ cwd = dir })
end

local config = function()
  require('telescope').setup({
    pickers = {
      lsp_references = {
        theme = 'ivy'
      }
    },
    extensions = {
      fzf = {}
    }
  })
  require('telescope').load_extension('fzf')

  local builtin = require('telescope.builtin')

  vim.keymap.set('n', '<Leader>s.', builtin.oldfiles,
    { desc = '[s]earch recent files' }
  )
  vim.keymap.set('n', '<Leader>sc',
    function() find_files(vim.fn.stdpath('config')) end,
    { desc = '[s]earch [c]onfig' }
  )
  vim.keymap.set('n', '<Leader>sd', builtin.diagnostics,
    { desc = '[s]earch [d]iagnostics' }
  )
  vim.keymap.set('n', '<Leader>sf', builtin.find_files,
    { desc = '[s]earch [f]iles' })
  vim.keymap.set('n', '<Leader>sg', builtin.live_grep,
    { desc = '[s]earch by [g]rep' }
  )
  vim.keymap.set('n', '<Leader>sr',
    function() find_files(vim.fn.expand('%:p:h')) end,
    { desc = '[s]earch [r]elative files' }
  )
end

local dependencies = {
  'nvim-lua/plenary.nvim',
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
  },
}

return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = dependencies,
  config = config,
}
