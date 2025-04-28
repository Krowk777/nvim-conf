local dependencies = {
    'rafamadriz/friendly-snippets',
}

local opts = {
    keymap = { preset = 'default' },
    appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
    },
    signature = { enabled = true },
    sources = {
        default = { "lsp", "path", "snippets", "buffer", "lazydev" },
        providers = {
            lsp = { fallbacks = { "lazydev" } },
            lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
        },
    }
}

return {
    'saghen/blink.cmp',
    dependencies = dependencies,
    version = 'v0.*',
    opts = opts
}
