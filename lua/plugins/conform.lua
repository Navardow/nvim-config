return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            -- Customize or remove this keymap to your liking
            "<leader>f",
            function()
                require("conform").format({ async = true })
            end,
            mode = "",
            desc = "Format buffer",
        },
    },
    -- This will provide type hinting with LuaLS
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
        -- Define your formatters
        formatters_by_ft = {
            lua        = { "stylua" },
            javascript = { "prettierd", "prettier", stop_after_first = true },
            typescript = { "prettierd", "prettier", stop_after_first = true },
            css        = { "prettierd", "prettier", stop_after_first = true },
            scss       = { "prettierd", "prettier", stop_after_first = true },
            less       = { "prettierd", "prettier", stop_after_first = true },
            c          = { "clang-format" },
            cpp        = { "clang-format" },
            markdown   = { "prettier" },
            python     = { "ruff_fix", "ruff_format" }
        },
        -- Set default options
        default_format_opts = {
            lsp_format = "fallback",
        },
        -- Set up format-on-save
        format_on_save = { timeout_ms = 500 },
        -- Customize formatters
        formatters = {
            shfmt = {
                append_args = { "-i", "2" },
            },
            -- 4-space indent unless the project has its own prettier config
            prettierd = {
                env = { PRETTIERD_DEFAULT_CONFIG = vim.fn.stdpath("config") .. "/.prettierrc.json" },
            },
            prettier = {
                prepend_args = { "--tab-width", "4", "--config-precedence", "prefer-file" },
            },
        },
    },
    init = function()
        -- If you want the formatexpr, here is the place to set it
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}
