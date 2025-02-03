local config = function()
  require('catppuccin').setup({
    flavour = 'macchiato',
    transparent_background = true,
    integrations = {
      blink_cmp = true,
      dap = true,
      dap_ui = true,
      gitsigns = true,
      harpoon = true,
      indent_blankline = {
        enabled = true,
        scope_color = 'flamingo',
        colored_indent_levels = false,
      },
      mason = true,
      mini = {
        enabled = true,
        indentscope_color = 'flamingo',
      },
      telescope = {
        enabled = true,
      }
    }
  })
  vim.cmd.colorscheme('catppuccin')
end

return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = config
}
