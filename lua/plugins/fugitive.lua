local ns = vim.api.nvim_create_namespace("diff_view")

-- whole file as one diff: old lines (red, -) sit above the lines that replaced them (green, +)
local function show_diff(path)
    local dir = vim.fs.dirname(path)
    local out = vim.system({ "git", "-C", dir, "diff", "--no-color", "--unified=100000", "HEAD", "--", path }, { text = true }):wait().stdout or ""
    -- untracked files have no HEAD version, so diff them against an empty file
    if out == "" then
        out = vim.system({ "git", "-C", dir, "diff", "--no-color", "--no-index", "--", "/dev/null", path }, { text = true }):wait().stdout or ""
    end

    -- skip the diff header, keep each line's +/-/space prefix for the signs
    local body, in_body = {}, false
    for _, line in ipairs(vim.split(out, "\n", { trimempty = true })) do
        if in_body and not line:match("^\\") then
            table.insert(body, line)
        elseif line:match("^@@") then
            in_body = true
        end
    end
    if #body == 0 then
        vim.cmd.edit(vim.fn.fnameescape(path))
        return
    end

    vim.api.nvim_set_hl(0, "DiffOldLine", { bg = "#3f1d22" })
    vim.api.nvim_set_hl(0, "DiffNewLine", { bg = "#1c3a24" })

    local buf = vim.api.nvim_create_buf(false, true)
    local text, file_lines, file_line = {}, {}, 0
    for i, line in ipairs(body) do
        local prefix = line:sub(1, 1)
        text[i] = line:sub(2)
        if prefix ~= "-" then
            file_line = file_line + 1
        end
        -- removed lines don't exist in the file, so jump to the line after them
        file_lines[i] = prefix == "-" and file_line + 1 or file_line
    end
    for i, line in ipairs(file_lines) do
        file_lines[i] = math.min(math.max(line, 1), math.max(file_line, 1))
    end
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, text)

    -- first line of each run of changed lines, for ]c / [c
    local change_starts = {}
    for i, line in ipairs(body) do
        local prefix = line:sub(1, 1)
        if prefix == "-" then
            vim.api.nvim_buf_set_extmark(buf, ns, i - 1, 0, { line_hl_group = "DiffOldLine", sign_text = "-", sign_hl_group = "Removed" })
        elseif prefix == "+" then
            vim.api.nvim_buf_set_extmark(buf, ns, i - 1, 0, { line_hl_group = "DiffNewLine", sign_text = "+", sign_hl_group = "Added" })
        end
        if prefix ~= " " and (i == 1 or body[i - 1]:sub(1, 1) == " ") then
            table.insert(change_starts, i)
        end
    end

    vim.bo[buf].modifiable = false
    vim.bo[buf].bufhidden = "wipe"
    pcall(vim.api.nvim_buf_set_name, buf, "diff://" .. vim.fn.fnamemodify(path, ":."))
    -- syntax highlight with treesitter only, so no LSP attaches to the scratch buffer
    local lang = vim.treesitter.language.get_lang(vim.filetype.match({ filename = path }) or "")
    if lang then
        pcall(vim.treesitter.start, buf, lang)
    end

    vim.keymap.set("n", "q", "<cmd>bwipe<CR>", { buffer = buf, desc = "Close diff" })
    vim.keymap.set("n", "<CR>", function()
        local line = file_lines[vim.api.nvim_win_get_cursor(0)[1]]
        vim.cmd.edit(vim.fn.fnameescape(path))
        vim.api.nvim_win_set_cursor(0, { line, 0 })
    end, { buffer = buf, desc = "Open file at this line" })
    vim.keymap.set("n", "]c", function()
        local cur = vim.api.nvim_win_get_cursor(0)[1]
        for _, start in ipairs(change_starts) do
            if start > cur then
                vim.api.nvim_win_set_cursor(0, { start, 0 })
                return
            end
        end
    end, { buffer = buf, desc = "Next change" })
    vim.keymap.set("n", "[c", function()
        local cur = vim.api.nvim_win_get_cursor(0)[1]
        for i = #change_starts, 1, -1 do
            if change_starts[i] < cur then
                vim.api.nvim_win_set_cursor(0, { change_starts[i], 0 })
                return
            end
        end
    end, { buffer = buf, desc = "Previous change" })

    vim.api.nvim_win_set_buf(0, buf)
end

return {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gdiffsplit", "Gvdiffsplit", "Gread", "Gwrite", "Gblame" },
    keys = {
        { "<leader>s", vim.cmd.Git, desc = "Fugitive git status" },
        {
            "<leader>d",
            function()
                local actions = require("telescope.actions")
                local action_state = require("telescope.actions.state")
                require("telescope.builtin").git_status({
                    attach_mappings = function(prompt_bufnr)
                        actions.select_default:replace(function()
                            local entry = action_state.get_selected_entry()
                            if not entry then return end
                            actions.close(prompt_bufnr)
                            show_diff(entry.path)
                        end)
                        return true
                    end,
                })
            end,
            desc = "Telescope changed files diff",
        },
    },
}
