-- Enable relative line numbers
vim.opt.relativenumber = true

-- Resume latest Telescope window
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })

-- Toggle NvimTree
vim.keymap.set('n', '<leader>e', '<Cmd>Neotree toggle<CR>', { desc = 'Toggle File [E]xplorer' })

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
            path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
        },
            'searchcount',
            'diff'
        },
        lualine_x = {
            { 'diagnostics', sources = { "nvim_diagnostic" }, symbols = { error = ' ', warn = ' ', info = ' ',
                hint = ' ' } },
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
            path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
        } },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = { 'fugitive' }
}


-- -- Enable Comment.nvim
-- require('Comment').setup()

-- -- Gitsigns
-- -- See `:help gitsigns.txt`
-- require('gitsigns').setup()

-- -- [[ Configure Telescope ]]
-- -- See `:help telescope` and `:help telescope.setup()`
-- require('telescope').setup {
--     defaults = {
--         vimgrep_arguments = {
--             'rg',
--             '--color=never',
--             '--no-heading',
--             '--with-filename',
--             '--line-number',
--             '--column',
--             '--smart-case'
--         },
--         selection_caret = "» ",
--         entry_prefix = "  ",
--         initial_mode = "insert",
--         sorting_strategy = "ascending",
--         layout_strategy = "vertical",
--         file_ignore_patterns = {},
--         color_devicons = true,
--         use_less = true,
--         set_env = { ['COLORTERM'] = 'truecolor' },
--     },
--     pickers = {
--         buffers = {
--             sort_lastused = true,
--             -- theme = "dropdown",
--             theme = "ivy",
--             layout_config = { height = 10 },
--             previewer = false,
--             mappings = {
--                 i = { ["<c-d>"] = require("telescope.actions").delete_buffer },
--                 n = { ["<c-d>"] = require("telescope.actions").delete_buffer }
--             }
--         },
--         find_files = {
--             theme = "ivy",
--             layout_config = { height = 10 },
--             previewer = false
--         },
--         oldfiles = {
--             sort_lastused = true,
--             theme = "ivy",
--             layout_config = { height = 10 },
--             previewer = false
--         },
--         command_history = {
--             sort_lastused = true,
--             theme = "ivy",
--             layout_config = { height = 10 },
--             previewer = false
--         },
--         current_buffer_fuzzy_find = {
--             previewer = false
--         }
--     }
-- }

-- -- Enable telescope fzf native, if installed
-- pcall(require('telescope').load_extension, 'fzf')
-- -- To get telescope-file-browser loaded and working with telescope,
-- -- you need to call load_extension, somewhere after setup function:
-- require("telescope").load_extension "file_browser"
-- require("telescope").load_extension("undo")

-- -- See `:help telescope.builtin`
-- vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
-- --vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
-- vim.keymap.set('n', '<leader>/', function()
--     -- You can pass additional configuration to telescope to change theme, layout, etc.
--     require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
--         winblend = 10,
--         previewer = false,
--     })
-- end, { desc = '[/] Fuzzily search in current buffer]' })

-- vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
-- vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
-- vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
-- vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
-- vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
-- vim.keymap.set('n', '<leader>sj', require('telescope.builtin').jumplist, { desc = '[S]earch [J]umplist' })

-- -- [[ Configure Treesitter ]]
-- -- See `:help nvim-treesitter`
-- require('nvim-treesitter.configs').setup {
--     -- Add languages to be installed here that you want installed for treesitter
--     ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'typescript', 'help', 'vim' },

--     highlight = { enable = true },
--     indent = { enable = true, disable = { 'python' } },
--     incremental_selection = {
--         enable = true,
--         keymaps = {
--             init_selection = '<c-space>',
--             node_incremental = '<c-space>',
--             scope_incremental = '<c-s>',
--             node_decremental = '<c-backspace>',
--         },
--     },
--     textobjects = {
--         select = {
--             enable = true,
--             lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
--             keymaps = {
--                 -- You can use the capture groups defined in textobjects.scm
--                 ['aa'] = '@parameter.outer',
--                 ['ia'] = '@parameter.inner',
--                 ['af'] = '@function.outer',
--                 ['if'] = '@function.inner',
--                 ['ac'] = '@class.outer',
--                 ['ic'] = '@class.inner',
--             },
--         },
--         move = {
--             enable = true,
--             set_jumps = true, -- whether to set jumps in the jumplist
--             goto_next_start = {
--                 [']m'] = '@function.outer',
--                 [']]'] = '@class.outer',
--             },
--             goto_next_end = {
--                 [']M'] = '@function.outer',
--                 [']['] = '@class.outer',
--             },
--             goto_previous_start = {
--                 ['[m'] = '@function.outer',
--                 ['[['] = '@class.outer',
--             },
--             goto_previous_end = {
--                 ['[M'] = '@function.outer',
--                 ['[]'] = '@class.outer',
--             },
--         },
--         swap = {
--             enable = false,
--             swap_next = {
--                 ['<leader>a'] = '@parameter.inner',
--             },
--             swap_previous = {
--                 ['<leader>A'] = '@parameter.inner',
--             },
--         },
--     },
-- }

-- -- Diagnostic keymaps
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
-- --vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
