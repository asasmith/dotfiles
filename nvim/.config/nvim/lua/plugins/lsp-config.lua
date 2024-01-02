return {
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        opts = {
            auto_install = true,
        },
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")

            lspconfig.tsserver.setup({
                capabilites = capabilities,
            })

            lspconfig.html.setup({
                capabilites = capabilities,
            })

            lspconfig.lua_ls.setup({
                capabilites = capabilities,
            })

            lspconfig.go_pls.setup({
                capabilites = capabilities,
            })

			vim.keymap.set("n", "gd", function()
				vim.lsp.buf.definition()
			end, opts)
			vim.keymap.set("n", "K", function()
				vim.lsp.buf.hover()
			end, opts)
			vim.keymap.set("n", "<leader>vws", function()
				vim.lsp.buf.workspace_symbol()
			end, opts)
			vim.keymap.set("n", "<leader>vd", function()
				vim.diagnostic.open_float()
			end, opts)
			vim.keymap.set("n", "[d", function()
				vim.diagnostic.goto_next()
			end, opts)
			vim.keymap.set("n", "]d", function()
				vim.diagnostic.goto_prev()
			end, opts)
			vim.keymap.set("n", "<leader>vca", function()
				vim.lsp.buf.code_action()
			end, opts)
			vim.keymap.set("n", "<leader>vrr", function()
				vim.lsp.buf.references()
			end, opts)
			vim.keymap.set("n", "<leader>vrn", function()
				vim.lsp.buf.rename()
			end, opts)
			vim.keymap.set("i", "<C-h>", function()
				vim.lsp.buf.signature_help()
			end, opts)
        end,
    },
}
-- return {
-- 	{
-- 		"williamboman/mason.nvim",
-- 		config = function()
-- 			require("mason").setup()
-- 		end,
-- 	},
-- 	-- {
-- 	-- 	"VonHeikemen/lsp-zero.nvim",
-- 	-- 	branch = "v3.x",
-- 	-- 	config = function()
-- 	-- 		local lsp_zero = require("lsp-zero")
--             -- lsp_zero.extend_lspconfig()

-- 	-- 		lsp_zero.on_attach(function(client, bufnr)
-- 	-- 			-- see :help lsp-zero-keybindings
-- 	-- 			-- to learn the available actions
-- 	-- 			lsp_zero.default_keymaps({ buffer = bufnr })
-- 	-- 		end)

-- 	-- 		-- lsp_zero.format_on_save({
-- 	-- 		-- 	format_opts = {
-- 	-- 		-- 		async = false,
-- 	-- 		-- 		timeout_ms = 10000,
-- 	-- 		-- 	},
-- 	-- 		-- 	servers = {
-- 	-- 		-- 		["tsserver"] = { "javascript", "typescript" },
-- 	-- 		-- 	},
-- 	-- 		-- })
-- 	-- 	end,
-- 	-- },
-- 	{
-- 		"williamboman/mason-lspconfig.nvim",
-- 		config = function()
-- 			require("mason-lspconfig").setup({
-- 				ensure_installed = {
-- 					"eslint",
-- 					"gopls",
-- 					"lua_ls",
-- 					"tsserver",
-- 				},
-- 			})
-- 		end,
-- 	},
-- 	{
-- 		"neovim/nvim-lspconfig",
-- 		config = function()
--             local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- 			local lspconfig = require("lspconfig")

-- 			lspconfig.lua_ls.setup({
--                 capabilities = capabilities
--             })

-- 			lspconfig.tsserver.setup({
--                 capabilities = capabilities
--             })

--             lspconfig.go_pls.setup({
--                 capabilities = capabilities
--             })

-- 			vim.keymap.set("n", "gd", function()
-- 				vim.lsp.buf.definition()
-- 			end, opts)
-- 			vim.keymap.set("n", "K", function()
-- 				vim.lsp.buf.hover()
-- 			end, opts)
-- 			vim.keymap.set("n", "<leader>vws", function()
-- 				vim.lsp.buf.workspace_symbol()
-- 			end, opts)
-- 			vim.keymap.set("n", "<leader>vd", function()
-- 				vim.diagnostic.open_float()
-- 			end, opts)
-- 			vim.keymap.set("n", "[d", function()
-- 				vim.diagnostic.goto_next()
-- 			end, opts)
-- 			vim.keymap.set("n", "]d", function()
-- 				vim.diagnostic.goto_prev()
-- 			end, opts)
-- 			vim.keymap.set("n", "<leader>vca", function()
-- 				vim.lsp.buf.code_action()
-- 			end, opts)
-- 			vim.keymap.set("n", "<leader>vrr", function()
-- 				vim.lsp.buf.references()
-- 			end, opts)
-- 			vim.keymap.set("n", "<leader>vrn", function()
-- 				vim.lsp.buf.rename()
-- 			end, opts)
-- 			vim.keymap.set("i", "<C-h>", function()
-- 				vim.lsp.buf.signature_help()
-- 			end, opts)
-- 		end,
-- 	},
-- 	-- { "hrsh7th/cmp-nvim-lsp" },
-- 	-- { "hrsh7th/nvim-cmp" },
-- 	-- { "L3MON4D3/LuaSnip" },
-- }
