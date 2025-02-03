local config = function()
  require('mini.ai').setup({ n_lines = 500 })
  require('mini.surround').setup()
end

return {
  'echasnovski/mini.nvim',
  config = config
}
