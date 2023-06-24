-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  { 'mrjones2014/smart-splits.nvim' },
  { 'echasnovski/mini.nvim',                     version = false },
  { 'nvim-telescope/telescope-file-browser.nvim' },
  { 'cormacrelf/dark-notify' },
  { 'romgrk/barbar.nvim',                        wants = 'nvim-web-devicons' },
  {
    'akinsho/toggleterm.nvim',
    tag = 'v2.5.0',
    config = function()
      require(
        'toggleterm').setup()
    end
  },
  {
    'folke/trouble.nvim',
    requires = 'nvim-tree/nvim-web-devicons',
    config = function()
      require(
        'trouble').setup()
    end
  },
  { 'stevearc/dressing.nvim' },
  { 'ellisonleao/gruvbox.nvim' },
  { 'sainnhe/gruvbox-material' },

  {
    'pwntester/octo.nvim',
    requires = {
      'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim',
      'kyazdani42/nvim-web-devicons'
    },
    config = function() require 'octo'.setup() end
  },
  {
    'simrat39/inlay-hints.nvim',
    config = function()
      require('inlay-hints').setup()
    end
  },
  { 'simrat39/rust-tools.nvim' },
  {
    'ray-x/lsp_signature.nvim',
    config = function()
      require('lsp_signature').setup({
        floating_window = true,
        hint_prefix = '',
        max_height = 30,
        max_width = 140,
        doc_lines = 15,
        hint_enable = true,
        toggle_key = '<M-x>'
      })
    end
  },
  { 'rust-lang/rust.vim' },
  {
    'folke/lsp-colors.nvim',
    config = function()
      require('lsp-colors').setup()
    end
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('indent_blankline').setup {
        show_current_context = true,
      }
    end
  },
  { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' },
  {
    'SmiteshP/nvim-navic',
    requires = 'neovim/nvim-lspconfig',
    config = function()
      require('nvim-navic').setup {
        icons = {
          File = ' ',
          Module = ' ',
          Namespace = ' ',
          Package = ' ',
          Class = ' ',
          Method = ' ',
          Property = ' ',
          Field = ' ',
          Constructor = ' ',
          Enum = ' ',
          Interface = ' ',
          Function = ' ',
          Variable = ' ',
          Constant = ' ',
          String = ' ',
          Number = ' ',
          Boolean = ' ',
          Array = ' ',
          Object = ' ',
          Key = ' ',
          Null = ' ',
          EnumMember = ' ',
          Struct = ' ',
          Event = ' ',
          Operator = ' ',
          TypeParameter = ' '
        },

        highlight = false,
        separator = " > ",
        depth_limit = 0,
        depth_limit_indicator = "..",
        safe_output = true
      }
    end
  },
  { 'fedepujol/move.nvim' },
  { 'savq/melange-nvim' },
  {
    'brymer-meneses/grammar-guard.nvim',
    requires = {
      'neovim/nvim-lspconfig',
      'williamboman/nvim-lsp-installer'
    }
  },
  { 'mfussenegger/nvim-lint' },
  { 'debugloop/telescope-undo.nvim' },
  { 'kdheepak/lazygit.nvim' },

  { "rebelot/kanagawa.nvim" },
  {
    'lvimuser/lsp-inlayhints.nvim',
    config = function()
      require("lsp-inlayhints").setup({
        inlay_hints = {
          parameter_hints = {
            show = true,
            prefix = "<- ",
            separator = ", ",
            remove_colon_start = true,
            remove_colon_end = true,
          },
          type_hints = {
            -- type and other hints
            show = true,
            prefix = "  ",
            separator = ", ",
            remove_colon_start = true,
            remove_colon_end = true,
          },
          only_current_line = false,
          -- separator between types and parameter hints. Note that type hints are
          -- shown before parameter
          labels_separator = "  ",
          -- whether to align to the length of the longest line in the file
          max_len_align = false,
          -- padding from the left if max_len_align is true
          max_len_align_padding = 1,
          -- highlight group
          highlight = "Comment",
          -- virt_text priority
          priority = 0,
        },
        enabled_at_startup = true,
        debug_mode = false,
      })
    end
  },

}
