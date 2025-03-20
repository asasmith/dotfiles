return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvimtools/none-ls-extras.nvim",
    },
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,
                -- null_ls.builtins.diagnostics.eslint_d,
                null_ls.builtins.formatting.prettier,
                require("none-ls.code_actions.eslint"),
                null_ls.builtins.formatting.dcm,
            },
        })

        vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
    end,
}
