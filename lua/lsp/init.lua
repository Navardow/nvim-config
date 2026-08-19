local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities = vim.tbl_deep_extend(
    'force',
    capabilities,
    require('blink.cmp').get_lsp_capabilities({}, false)
)

capabilities = vim.tbl_deep_extend('force', capabilities, {
    textDocument = {
        foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true
        }
    }
})

vim.lsp.ocnfig("*", {
    capabilities - capabilities,
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
