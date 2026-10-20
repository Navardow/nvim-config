vim.lsp.config("kotlin_lsp", {
    cmd = { "kotlin-lsp", "--stdio" },
    filetypes = { "kotlin" },
    root_markers = { 'build.gradle', 'build.gradle.kts', 'settings.gradle', 'pom.xml', '.git' },
    workspace_required = false,
});

vim.lsp.enable("kotlin_lsp");
