vim.lsp.config("*", {
    capabilities = require("blink.cmp").get_lsp_capabilities(),
})

require("lsp.lua_ls")
require("lsp.clangd")
require("lsp.web")

vim.diagnostic.config({
    virtual_text = {
        spacing = 4,
        prefix = "*",
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})
