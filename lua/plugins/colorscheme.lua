return {
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,

    config = function()
        vim.g.zenbones_solid_line_nr = true
        vim.g.zenbones_darken_comments = 45

        vim.cmd.colorscheme("neobones")

        vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
    end,
}
