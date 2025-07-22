local handle_lsp_attach = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then return end

    -- don't override the default redo keymap
    pcall(function()
        vim.keymap.del('n', '<C-r>')
    end)

    local group = vim.api.nvim_create_augroup('autoformat', { clear = false })
    vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = args.buf,
        callback = function()
            pcall(function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
            end)
        end,
        group = group
    })
end

local handle_lsp_detach = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then return end

    local group = vim.api.nvim_create_augroup('autoformat', { clear = false })
    vim.api.nvim_clear_autocmds({ group = group, buffer = args.buf })
end

local set_keymaps = function()
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', 'gr', builtin.lsp_references,
        { desc = '[g]oto lsp [r]eferences' })
    vim.keymap.set('n', 'gd', builtin.lsp_definitions,
        { desc = '[g]oto [d]efinition' })
    vim.keymap.set('n', 'gi', builtin.lsp_implementations,
        { desc = '[g]oto [i]mplementation' })
    vim.keymap.set({ 'n', 'i' }, '<M-k>', vim.lsp.buf.signature_help,
        { desc = 'show signature' })
    vim.keymap.set('n', '<Leader>ss',
        builtin.lsp_document_symbols,
        { desc = '[s]earch document [s]ymbols' })
    vim.keymap.set('n', '<Leader>s;',
        builtin.lsp_workspace_symbols,
        { desc = '[s]earch all symbols' })
    vim.keymap.set('n', '<Leader>sw',
        builtin.lsp_dynamic_workspace_symbols,
        { desc = '[s]earch workplace symbols' })
    vim.keymap.set('n', '<C-r>', vim.lsp.buf.rename, { desc = '[r]ename' })
    vim.keymap.set({ 'n', 'x' }, '<Leader>ca', vim.lsp.buf.code_action,
        { desc = '[c]ode [a]ction' })
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration,
        { desc = '[g]oto [D]eclaration' })
    vim.keymap.set('n', 'rn', vim.lsp.buf.rename,
        { desc = '[r]e[n]ame symbol' })
end

local config = function()
    require('mason').setup()
    require('mason-lspconfig').setup({
        automatic_enable = true,
        ensure_installed = {
            'clangd', 'gopls', 'jdtls', 'lua_ls',
            'omnisharp', 'terraformls', 'pyright', 'ts_ls', 'jsonls',
            'html', 'cssls',
        },
    })
    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach',
            { clear = true }),
        callback = handle_lsp_attach,
    })
    vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('lsp-detach',
            { clear = true }),
        callback = handle_lsp_detach,
    })
    set_keymaps()
end

local dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'saghen/blink.cmp',
    {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = {
                { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
            },
        },
    },
    'nvim-telescope/telescope.nvim'
}

return {
    'neovim/nvim-lspconfig',
    name = 'nvim-lspconfig',
    dependencies = dependencies,
    config = config
}
