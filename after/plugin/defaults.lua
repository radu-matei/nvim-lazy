-- Enable relative line numbers
vim.opt.relativenumber = true

-- vim.keymap.set('n', '<leader>c', '<Cmd>BufferClose<CR> ', { desc = '[C]lose Buffer' })
vim.keymap.set('n', '<leader>q', '[[<C-w>q]] ', { desc = '[Q]uit current window' })

-- Resume latest Telescope window
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })

-- LazyGit
vim.keymap.set('n', '<leader>lg', '<Cmd>LazyGit<CR> ', { desc = '[L]azy[G]it' })

-- Toggle NvimTree
-- vim.keymap.set('n', '<leader>e', '<Cmd>Neotree toggle<CR>', { desc = 'Toggle File [E]xplorer' })

-- Close current buffer
vim.keymap.set('n', '<leader>bc', '<Cmd>bd<CR>', { desc = '[B]uffer [C]lose' })

-- Keymaps for moving between splits
vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left, { desc = 'Move to left split' })
vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down, { desc = 'Move to below split' })
vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up, { desc = 'Move to above split' })
vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right, { desc = 'Move to right split' })

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Keymaps for moving beween open buffers
vim.keymap.set('n', '<S-h>', '<Cmd>BufferLineCyclePrev<CR>', { desc = 'Move to previous buffer' })
vim.keymap.set('n', '<S-l>', '<Cmd>BufferLineCycleNext<CR>', { desc = 'Move to next buffer' })

-- Keymap for toggling the Telescope file browser
-- vim.keymap.set('n', '<leader>e', '<Cmd>Telescope file_browser<CR>', { desc = 'File [E]xplorer' })
-- open file_browser with the path of the current buffer
vim.api.nvim_set_keymap(
    "n",
    "<leader>e",
    ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
    { noremap = true }
)

-- Keymaps for Trouble
vim.keymap.set('n', '<leader>tt', '<Cmd>TroubleToggle<CR> ', { desc = '[T]oggle [T]rouble list' })

vim.keymap.set('n', '<leader>u', '<Cmd>Telescope undo<CR>', { desc = "[U]ndo tree" })

-- Map jj and jk to Escape
vim.keymap.set('i', 'jk', '<Esc>')


-- Move lines and blocks
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<A-k>', ':MoveLine(-1)<CR>', opts)
vim.keymap.set('n', '<A-j>', ':MoveLine(1)<CR>', opts)

vim.keymap.set('v', '<A-k>', ':MoveBlock(-1)<CR>', opts)
vim.keymap.set('v', '<A-j>', ':MoveBlock(1)<CR>', opts)

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        require("lint").try_lint()
    end,
})

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

require('lualine').setup {
    options = {
        icons_enabled = true,
        -- theme = 'melange',
        -- section_separators = { left = '', right = '' },
        -- component_separators = { left = '', right = '' },
        disabled_filetypes = {}
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { {
            'filename',
            file_status = true, -- displays file status (readonly status, modified status)
            path = 1            -- 0 = just filename, 1 = relative path, 2 = absolute path
        },
            'searchcount',
            'diff'
        },
        lualine_x = {
            {
                'diagnostics',
                sources = { "nvim_diagnostic" },
                symbols = {
                    error = ' ',
                    warn = ' ',
                    info = ' ',
                    hint = ' '
                }
            },
            'encoding',
            'filetype'
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { {
            'filename',
            file_status = true, -- displays file status (readonly status, modified status)
            path = 1            -- 0 = just filename, 1 = relative path, 2 = absolute path
        } },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = { 'fugitive' }
}
