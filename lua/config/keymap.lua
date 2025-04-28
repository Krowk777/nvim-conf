vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('n', '<Esc>', vim.cmd.nohlsearch,
    { desc = 'removes search highlight' })
vim.keymap.set('n', '<C-j>', vim.cmd.nohlsearch,
    { desc = 'removes search highlight' })
vim.keymap.set('t', '<C-j>', '<C-\\><C-n>', { desc = 'go back to normal mode' })
vim.keymap.set({ 'i', 'c', 'v', 's' }, '<C-j>', '<Esc>',
    { desc = 'go back to normal mode' })
vim.keymap.set('n', '<M-d>', vim.diagnostic.open_float,
    { desc = 'hover [d]diagnostic' })
vim.keymap.set('n', '<Space>', '<Nop>', { desc = 'disable space moving cursor' })
