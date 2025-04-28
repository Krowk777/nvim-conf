local is_support_format = function(client)
    if not client then return false end
    return client:supports_method('textDocument/formatting') or
        client.name == 'jdtls' or
        client.name == 'omnisharp'
end

local handle_lsp_attach = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then return end

    -- don't override the default redo keymap
    pcall(function()
        vim.keymap.del('n', '<C-r>')
    end)
    local group = vim.api.nvim_create_augroup('autoformat', { clear = false })
    if is_support_format(client) then
        vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = args.buf,
            callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
            end,
            group = group
        })
    end
end

local handle_lsp_detach = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then return end

    local group = vim.api.nvim_create_augroup('autoformat', { clear = false })
    vim.api.nvim_clear_autocmds({ group = group, buffer = args.buf })
end

local get_omnisharp_setup_config = function(capabilities)
    return {
        capabilities = capabilities,
        cmd = { "omnisharp" },
        settings = {
            FormattingOptions = {
                EnableEditorConfigSupport = true,
                OrganizeImports = true,
            },
            MsBuild = {
                LoadProjectsOnDemand = nil,
            },
            RoslynExtensionsOptions = {
                EnableAnalyzersSupport = true,
                EnableImportCompletion = true,
                AnalyzeOpenDocumentsOnly = nil,
            },
            Sdk = {
                IncludePrereleases = true,
            },
        },
    }
end

local set_keymaps = function()
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', 'gr', builtin.lsp_references,
        { desc = '[g]oto lsp [r]eferences' })
    vim.keymap.set('n', 'gd', builtin.lsp_definitions,
        { desc = '[g]oto [d]efinition' })
    vim.keymap.set('n', 'gi', builtin.lsp_implementations,
        { desc = '[g]oto [i]mplementation' })
    vim.keymap.set('n', 'gT', vim.lsp.buf.type_definition,
        { desc = '[g]oto [T]ype definition' })
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
        handlers = {
            function(server_name)
                local server = require('lspconfig')[server_name] or {}
                local capabilities = require('blink.cmp').get_lsp_capabilities()
                if server_name == 'omnisharp' then
                    local config = get_omnisharp_setup_config(capabilities)
                    server.setup(config)
                else
                    server.setup({ capabilities = capabilities })
                end
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
            end,
        },
        automatic_installation = {},
        ensure_installed = {}
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
