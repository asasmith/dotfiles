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

            vim.lsp.config("ts_ls", {
                capabilities = capabilities,
                filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
                init_options = {
                    plugins = {
                        {
                            name = "@vue/typescript-plugin",
                            location = vim.fn.stdpath("data")
                                .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
                            languages = { "vue" },
                        },
                    },
                },
            })

            vim.lsp.config("vue_ls", {
                capabilities = capabilities,
                on_init = function(client)
                    client.handlers["tsserver/request"] = function(_, result, context)
                        local ts_clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = "ts_ls" })
                        if #ts_clients == 0 then
                            vim.notify("Could not find `ts_ls` client, `vue_ls` will not work.", vim.log.levels.ERROR)
                            return
                        end
                        local ts_client = ts_clients[1]
                        local param = unpack(result)
                        local id, command, payload = unpack(param)
                        ts_client:exec_cmd({
                            title = "vue_request_forward",
                            command = "typescript.tsserverRequest",
                            arguments = { command, payload },
                        }, { bufnr = context.bufnr }, function(_, r)
                            local response_data = { { id, r and r.body } }
                            ---@diagnostic disable-next-line: param-type-mismatch
                            client:notify("tsserver/response", response_data)
                        end)
                    end
                end,
            })

            vim.lsp.config("html", { capabilities = capabilities })
            vim.lsp.config("tailwindcss", { capabilities = capabilities })
            vim.lsp.config("lua_ls", { capabilities = capabilities })
            vim.lsp.config("gopls", { capabilities = capabilities })
            -- vim.lsp.config("dartls", { capabilities = capabilities })

            vim.lsp.enable({
                "ts_ls",
                "vue_ls",
                "html",
                "tailwindcss",
                "lua_ls",
                "gopls",
                -- "dartls"
            })

            vim.keymap.set("n", "gd", vim.lsp.buf.definition)
            vim.keymap.set("n", "K", vim.lsp.buf.hover)
            vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol)
            vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float)
            vim.keymap.set("n", "[d", vim.diagnostic.goto_next)
            vim.keymap.set("n", "]d", vim.diagnostic.goto_prev)
            vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action)
            vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references)
            vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename)
            vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help)
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
