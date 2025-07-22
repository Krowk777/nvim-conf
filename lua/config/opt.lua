vim.opt.number = true
vim.opt.relativenumber = true

vim.schedule(function() vim.opt.clipboard = 'unnamedplus' end)

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.breakindent = true
vim.opt.scrolloff = 6
vim.opt.shiftwidth = 2
vim.opt.tabstop = vim.opt.shiftwidth:get()
vim.opt.wrap = false

vim.opt.cursorline = true
vim.opt.showmode = false
vim.opt.signcolumn = 'yes'

vim.opt.mouse = 'a'
vim.opt.timeoutlen = 400
vim.opt.undofile = true
vim.opt.updatetime = 100
