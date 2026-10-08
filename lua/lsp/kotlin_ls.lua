vim.lsp.config("kotln-lsp", {
    cmd = { "kotlin-lsp" },
    filetype = { "kotlin" },
    root_markers = { "build.gradle.kts", "build.gradle" },
});

vim.lsp.enable("kotlin-lsp");
