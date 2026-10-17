vim.lsp.config("kotln_lsp", {
    cmd = { "kotlin-lsp", "--stdio" },
    filetype = { "kotlin" },
    root_markers = { 'build.gradle', 'build.gradle.kts', 'settings.gradle', 'pom.xml', '.git' },
    workspace_required = false,
});

vim.lsp.enable("kotlin_lsp");
