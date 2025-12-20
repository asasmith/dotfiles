return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "main",
		enabled = false,
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- Recommended over copilot.vim
			{ "nvim-lua/plenary.nvim" },
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		opts = {
			debug = false,
			model = "gpt-4.1", -- Can also be 'claude-3.5-sonnet' if you have access
			temperature = 0.1,
			question_header = "## User ",
			answer_header = "## Copilot ",
			error_header = "## Error ",
			auto_follow_cursor = true, -- Auto-follow cursor in chat
			show_help = true,
			window = {
				layout = "vertical", -- 'vertical', 'horizontal', 'float'
				width = 0.4, -- fractional width of parent
				height = 0.6, -- fractional height of parent
				position = "right",

				headers = {
					user = "👤 You",
					assistant = "🤖 Copilot",
					tool = "🔧 Tool",
				},

				separator = "━━",
				auto_fold = true,
			},
			auto_insert_mode = true, -- Automatically enter insert mode when opening chat
			mappings = {
				complete = {
					detail = "Use @<Tab> or /<Tab> for options.",
					insert = "<Tab>",
				},
				close = {
					normal = "q",
					insert = "<C-c>",
				},
				reset = {
					normal = "<C-l>",
					insert = "<C-l>",
				},
				submit_prompt = {
					normal = "<CR>",
					insert = "<C-s>",
				},
				accept_diff = {
					normal = "<C-y>",
					insert = "<C-y>",
				},
				yank_diff = {
					normal = "gy",
				},
				show_diff = {
					normal = "gd",
				},
				show_info = {
					normal = "gp",
				},
				show_context = {
					normal = "gs",
				},
			},
		},
		config = function(_, opts)
			local chat = require("CopilotChat")
			local select = require("CopilotChat.select")

			opts.prompts = {
				Explain = {
					prompt = "/COPILOT_EXPLAIN Write an explanation for the selected code as paragraphs of text.",
				},
				Review = {
					prompt = "/COPILOT_REVIEW Review the selected code.",
				},
				Fix = {
					prompt = "/COPILOT_GENERATE There is a problem in this code. Rewrite the code to show it with the bug fixed.",
				},
				Optimize = {
					prompt = "/COPILOT_GENERATE Optimize the selected code to improve performance and readability.",
				},
				Docs = {
					prompt = "/COPILOT_GENERATE Please add documentation comments to the selected code.",
				},
				Tests = {
					prompt = "/COPILOT_GENERATE Please generate tests for my code.",
				},
				FixDiagnostic = {
					prompt = "Please assist with the following diagnostic issue in file:",
					selection = select.diagnostics,
				},
				Commit = {
					prompt = "Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.",
					selection = select.gitdiff,
				},
				CommitStaged = {
					prompt = "Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.",
					selection = function(source)
						return select.gitdiff(source, true)
					end,
				},
			}

			chat.setup(opts)
			-- Keymaps
			vim.keymap.set("n", "<leader>cc", "<cmd>CopilotChatToggle<cr>", { desc = "Toggle Copilot Chat" })
			vim.keymap.set("n", "<leader>cx", "<cmd>CopilotChatReset<cr>", { desc = "Reset Copilot Chat" })
			vim.keymap.set("n", "<leader>cq", function()
				local input = vim.fn.input("Quick Chat: ")
				if input ~= "" then
					chat.ask(input, { selection = select.buffer })
				end
			end, { desc = "Quick chat" })
			-- Code actions
			vim.keymap.set("v", "<leader>ce", "<cmd>CopilotChatExplain<cr>", { desc = "Explain code" })
			vim.keymap.set("v", "<leader>cr", "<cmd>CopilotChatReview<cr>", { desc = "Review code" })
			vim.keymap.set("v", "<leader>cf", "<cmd>CopilotChatFix<cr>", { desc = "Fix code" })
			vim.keymap.set("v", "<leader>co", "<cmd>CopilotChatOptimize<cr>", { desc = "Optimize code" })
			vim.keymap.set("v", "<leader>cd", "<cmd>CopilotChatDocs<cr>", { desc = "Document code" })
			vim.keymap.set("v", "<leader>ct", "<cmd>CopilotChatTests<cr>", { desc = "Generate tests" })
			-- Git actions
			vim.keymap.set("n", "<leader>cm", "<cmd>CopilotChatCommit<cr>", { desc = "Generate commit message" })
			vim.keymap.set(
				"n",
				"<leader>cM",
				"<cmd>CopilotChatCommitStaged<cr>",
				{ desc = "Generate commit message (staged)" }
			)
			-- Diagnostic action
			vim.keymap.set("n", "<leader>cD", "<cmd>CopilotChatFixDiagnostic<cr>", { desc = "Fix diagnostic" })
			-- Show prompts actions
			-- vim.keymap.set("n", "<leader>cp", function()
			--     local actions = require("CopilotChat").actions
			--     require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
			-- end, { desc = "Show prompts" })
		end,
	},
	-- Avante setup
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		enabled = true,
		lazy = false,
		version = false,
		build = "make",
		opts = {
			provider = "copilot",
			-- provider = "claude", -- or "openai", "copilot"
			claude = {
			    endpoint = "https://api.anthropic.com",
			    model = "claude-sonnet-4-20250514",
			    max_tokens = 8000,
			},
            copilot = {
                model = os.getenv("COPILOT_MODEL") or "gpt-4.1", -- Default to 'gpt-4.1' if the environment variable is not set
            },
		},
		dependencies = {
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
			"zbirenbaum/copilot.lua", -- optional, for copilot provider
			{
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
					},
				},
			},
			{
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
		config = function(_, opts)
			require("avante").setup(opts)
			-- Keymaps
			vim.keymap.set("n", "<leader>aa", "<cmd>AvanteAsk<cr>", { desc = "Avante Ask" })
			vim.keymap.set("v", "<leader>ae", "<cmd>AvanteEdit<cr>", { desc = "Avante Edit" })
			vim.keymap.set("n", "<leader>at", "<cmd>AvanteToggle<cr>", { desc = "Toggle Avante" })
		end,
	},
}
