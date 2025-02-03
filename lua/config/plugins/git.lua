local config = function()
    vim.keymap.set('n', '<Leader>gs', vim.cmd.Git)
end

return {
    'tpope/vim-fugitive',
    config = config
}
