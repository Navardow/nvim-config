return {
    'nvim-telescope/telescope.nvim', version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- optional but recommended
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function() 
        local builtin = require('telescope.builtin')
        local remap = vim.keymap.set 
        -- Literally goated mappings
        remap('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })
        remap('n', '<leader>pg', builtin.live_grep, { desc = 'Telescope live grep' })
        remap('n', '<leader>pb', builtin.buffers, { desc = 'Telescope buffers' })
        remap('n', '<leader>ph', builtin.help_tags, { desc = 'Telescope help tags' })
    end
}
