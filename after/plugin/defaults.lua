-- Enable relative line numbers
vim.opt.relativenumber = true

-- vim.keymap.set('n', '<leader>c', '<Cmd>BufferClose<CR> ', { desc = '[C]lose Buffer' })
vim.keymap.set('n', '<leader>q', '[[<C-w>q]] ', { desc = '[Q]uit current window' })

-- Resume latest Telescope window
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })

-- LazyGit
vim.keymap.set('n', '<leader>lg', '<Cmd>LazyGit<CR> ', { desc = '[L]azy[G]it' })

-- Toggle NvimTree
vim.keymap.set('n', '<leader>e', '<Cmd>Neotree toggle<CR>', { desc = 'Toggle File [E]xplorer' })

-- Close current buffer
vim.keymap.set('n', '<leader>bc', '<Cmd>BufferClose<CR>', { desc = '[B]uffer [C]lose' })

-- Keymaps for moving between splits
vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left, { desc = 'Move to left split' })
vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down, { desc = 'Move to below split' })
vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up, { desc = 'Move to above split' })
vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right, { desc = 'Move to right split' })

-- Keymaps for moving beween open buffers
vim.keymap.set('n', '<S-h>', '<Cmd>BufferPrevious<CR>', { desc = 'Move to previous buffer' })
vim.keymap.set('n', '<S-l>', '<Cmd>BufferNext<CR>', { desc = 'Move to next buffer' })

-- Keymap for toggling the Telescope file browser
vim.keymap.set('n', '<leader>se', '<Cmd>Telescope file_browser<CR>', { desc = '[S]earch [F]ile [E]xplorer' })

-- Keymaps for ToggleTerm
vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], { desc = 'Enter terminal normal mode' })
vim.keymap.set('t', 'jk', [[<C-\><C-n>]], { desc = 'Enter terminal normal mode' })

-- Keymaps for Trouble
vim.keymap.set('n', '<leader>tt', '<Cmd>TroubleToggle<CR> ', { desc = '[T]oggle [T]rouble list' })

vim.keymap.set('n', '<leader>c', '<Cmd>BufferClose<CR> ', { desc = '[C]lose Buffer' })

vim.keymap.set('n', '<leader>tf', '<Cmd>ToggleTerm direction=float<CR> ',
    { desc = 'Open [T]erminal in [F]loating split' })
vim.keymap.set('n', '<leader>tv', '<Cmd>ToggleTerm size=80 direction=vertical<CR> ',
    { desc = 'Open [T]erminal in [V]ertical split' })
vim.keymap.set('n', '<leader>th', '<Cmd>ToggleTerm size=10 direction=horizontal<CR> ',
    { desc = 'Open [T]erminal in [H]orizontal split' })

vim.keymap.set('n', '<leader>q', '[[<C-w>q]] ', { desc = '[Q]uit current window' })

vim.keymap.set('n', '<leader>u', '<Cmd>UndotreeToggle<CR>', { desc = "[U]ndo tree" })

-- Map jj and jk to Escape
vim.keymap.set('i', 'jk', '<Esc>')


-- Move lines and blocks
local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<A-k>', ':MoveLine(-1)<CR>', opts)
vim.keymap.set('n', '<A-j>', ':MoveLine(1)<CR>', opts)

vim.keymap.set('v', '<A-k>', ':MoveBlock(-1)<CR>', opts)
vim.keymap.set('v', '<A-j>', ':MoveBlock(1)<CR>', opts)


-- vim.keymap.set('n', '<leader>y', '[["+y]]', { desc = '[Y]ank to system clipboard' })
-- vim.keymap.set('n', '<leader>p', '[["+p]]', { desc = '[P]ast from system clipboard' })

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        require("lint").try_lint()
    end,
})

-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- -- disable netrw at the very start of your init.lua (strongly advised)
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

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



-- Set lualine as statusline
-- See `:help lualine.txt`
require('lualine').setup {
    options = {
        icons_enabled = true,
        -- theme = 'melange',
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
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
