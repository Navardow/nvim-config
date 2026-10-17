vim.lsp.config("basedpyright", {
    cmd = { "basedpyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "pyrightconfig.json", ".git" },
    settings = {
        basedpyright = {
            analysis = {
                diagnosticMode = "openFilesOnly",
                typeCheckingMode = "standard",
                diagnosticSeverityOverrides = {
                    reportCallIssue = "error",
                    reportUnreachable = "warning",
                    reportUnusedImport = "warning",
                    reportUnusedCoroutine = "error",
                },
            },
        },
    },
})

vim.lsp.enable("basedpyright")
