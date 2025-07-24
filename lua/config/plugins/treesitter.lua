local opts = {
    ensure_installed = {
        'c', 'cpp', 'c_sharp', 'lua', 'python', 'bash',
        'markdown', 'markdown_inline', 'go', 'java',
        'javascript', 'typescript', 'terraform',
        'html', 'css', 'json', 'yaml',
    },
    sync_install = false,
    auto_install = false,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = true, disable = { 'ruby' } }
}

return {
    'nvim-treesitter/nvim-treesitter',
    name = 'nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = opts
}
