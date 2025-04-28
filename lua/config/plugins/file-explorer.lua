vim.keymap.set('n', '-', '<cmd>Oil<CR>', { desc = 'go to file explorer' })
return {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
}
