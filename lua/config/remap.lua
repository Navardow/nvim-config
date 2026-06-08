local remap = vim.keymap.set
vim.g.mapleader = " "

remap("n", "<Leader>pv", vim.cmd.Ex)

-- alt-up/down. move highlighted text around
remap("v", "J", ":m '>+1<CR>gv=gv")
remap("v", "K", ":m '<-2<CR>gv=gv")

-- stabalize cursor when joining below line
remap("n", "J", "mzJ`z")

-- page up and down
remap("n", "<C-d>", "<C-d>zz")
remap("n", "<C-u>", "<C-u>zz")

-- next and previous
remap("n", "n", "nzzzv")
remap("n", "N", "Nzzzv")

-- pasting over text without losing whats in the yank buffer.
remap("x", "<leader>p", [["_dP]])

remap({ "n", "v" }, "<leader>y", [["+y]])
remap("n", "<leader>Y", [["+Y]])

-- deletes without copying to buffer, dont affect clipboard
remap({ "n", "v" }, "<leader>d", [["_d]])

-- lsp buffer format
remap("n", "<leader>f", vim.lsp.buf.format)

-- screen splitting in vim
remap("n", "<leader>|", "<cmd>vsplit<CR>");
remap("n", "<leader>-", "<cmd>split<CR>");

--navigating windows Alt + hjkl to move between splits
remap("n", "<M-h>", "<C-w>h") 
remap("n", "<M-j>", "<C-w>j")
remap("n", "<M-k>", "<C-w>k")
remap("n", "<M-l>", "<C-w>l")
