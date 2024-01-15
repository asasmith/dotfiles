return {
    "mfussenegger/nvim-dap",
    dependencies = {
        -- "mfussenegger/nvim-dap-python",
        "rcarriga/nvim-dap-ui",
        "leoluz/nvim-dap-go",
        -- "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
        local dap, dapui = require("dap"), require("dapui")

        require("dap-go").setup()
        require("dapui").setup()

        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end

        vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, {})
        vim.keymap.set("n", "<leader>dc", dap.continue, {})
    end,
}
