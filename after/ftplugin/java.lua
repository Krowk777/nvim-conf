vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        pcall(function()
            vim.keymap.del('n', '<C-r>')
        end)
    end
})
