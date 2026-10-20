# nvim config

Personal Neovim config using [lazy.nvim](https://github.com/folke/lazy.nvim) and Neovim's built-in LSP (`vim.lsp.config` / `vim.lsp.enable`). Tracks Neovim **nightly** (0.12+).

## Layout

```
init.lua              entry point; also sets textwidth=80 for markdown
lua/config/set.lua    editor options
lua/config/remap.lua  core keymaps (leader = <Space>)
lua/config/lazy.lua   bootstraps lazy.nvim, imports lua/plugins/, loads lua/lsp/
lua/plugins/          one file per plugin spec
lua/lsp/              one file per language server
```

## Plugins

| Plugin | Purpose |
| --- | --- |
| zenbones.nvim (+ lush.nvim) | `neobones` colorscheme, transparent background |
| telescope.nvim (+ fzf-native, plenary) | fuzzy finding |
| vim-fugitive | git status window |
| blink.cmp (+ friendly-snippets) | completion (1.x, prebuilt Rust fuzzy matcher) |
| conform.nvim | formatting, format-on-save |
| trouble.nvim | diagnostics and symbols lists |
| tree-sitter-manager.nvim | treesitter parsers (needs the `tree-sitter` CLI) |
| fidget.nvim | LSP progress |
| autoclose.nvim | auto-close brackets and quotes |

## Language servers

Install these yourself; they are not managed by Mason.

| Language | Server |
| --- | --- |
| Lua | `lua-language-server` |
| C / C++ | `clangd` |
| JS / TS | `vtsls` |
| CSS / SCSS / Less | `vscode-css-language-server` |
| Python | `basedpyright` |
| Markdown | `marksman` |
| Kotlin | `kotlin-lsp` |

## Formatters (conform)

| Filetype | Formatter |
| --- | --- |
| Lua | `stylua` |
| JS / TS / CSS / SCSS / Less | `prettierd`, falling back to `prettier` |
| Markdown | `prettier` |
| C / C++ | `clang-format` |
| Python | `ruff_fix`, `ruff_format` |

Formats on save; anything else falls back to LSP formatting.

## Keymaps

Leader is `<Space>`.

### Files and search (Telescope)

| Keys | Action |
| --- | --- |
| `<leader>pf` | find files (including hidden and ignored) |
| `<leader>pg` | live grep |
| `<leader>pb` | buffers |
| `<leader>ph` | help tags |
| `<leader>pv` | file explorer (netrw) |

### Git

| Keys | Action |
| --- | --- |
| `<leader>s` | fugitive status |
| `<leader>d` | pick a changed file, open a one-pane diff against `HEAD` |

In the `<leader>d` picker, `<Tab>` stages and unstages, and `<CR>` opens the diff. The diff shows the whole file in one pane: removed lines are red with `-` signs and sit above the green `+` lines that replaced them. Untracked files show as all green `+` lines. In the diff, `]c` / `[c` jump between changes, `<CR>` opens the real file at that line, and `q` closes it.

### Editing

| Keys | Mode | Action |
| --- | --- | --- |
| `J` / `K` | visual | move selection down / up |
| `J` | normal | join lines, keep cursor in place |
| `<leader>p` | visual | paste over selection without losing the yank |
| `<leader>y` | normal, visual | yank to system clipboard |
| `<leader>Y` | normal | yank whole line to system clipboard |
| `<leader>D` | normal, visual | delete without yanking |
| `<leader>f` | normal, visual | format buffer (or selection) |

### Navigation and windows

| Keys | Action |
| --- | --- |
| `<C-d>` / `<C-u>` | half-page down / up, centered |
| `n` / `N` | next / previous match, centered |
| `<leader>\|` / `<leader>-` | vertical / horizontal split |
| `<M-h/j/k/l>` | move between splits |

### Diagnostics (Trouble)

| Keys | Action |
| --- | --- |
| `<leader>td` | all diagnostics |
| `<leader>tb` | buffer diagnostics |
| `<leader>ts` | symbols |

## Notes

- `lazy-lock.json` is gitignored.
- Plugins are cloned over HTTPS. If your global git config rewrites `https://github.com/` to SSH, `:Lazy sync` needs a working GitHub SSH key or agent.
