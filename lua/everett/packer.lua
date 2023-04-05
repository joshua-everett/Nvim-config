-- auto install packer if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
  return
end

-- add list of plugins to install
return packer.startup(function(use)

  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- colorscheme
  use({
    'rose-pine/neovim',
    as = 'rose-pine',
    config = function()
      vim.cmd('colorscheme rose-pine')
    end
  })

  use("christoomey/vim-tmux-navigator") -- tmux & split window navigation 

  -- essential plugins
  use('ThePrimeagen/harpoon')
  use('mbbill/undotree')
  use("tpope/vim-surround") -- add, delete, change surroundings (it's awesome)
  use("vim-scripts/ReplaceWithRegister") -- replace with register contents using motion (gr + motion)
  use {'numToStr/Comment.nvim'}  -- commenting with gc
  use("lukas-reineke/indent-blankline.nvim") -- Indent Blankline 

  use("nvim-tree/nvim-tree.lua")  -- file explorer
  use("nvim-tree/nvim-web-devicons") -- vs-code like icons

  -- fuzzy finding w/telescope
  use({
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  })

  -- treesitter configuration
  use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
  use('nvim-treesitter/playground')

  -- auto closing
  use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
  use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags 


  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},
      {'jose-elias-alvarez/null-ls.nvim'},
      {'MunifTanjim/prettier.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},

      -- snippets
      {'L3MON4D3/LuaSnip'},
      {'saadparwaiz1/cmp_luasnip'},
      -- Snippet Collection (Optional)
      {'rafamadriz/friendly-snippets'},
      {'mattn/emmet-vim'},
      {'digitaltoad/vim-pug'},

    }
  }

    -- toggle window 
    use {"akinsho/toggleterm.nvim", tag = 'v2.*', config = function()
    require("toggleterm").setup()
    end}

    -- zen mode
    use("folke/zen-mode.nvim")

    -- color highlighter
    use('NvChad/nvim-colorizer.lua')

    -- git integration
    use('tpope/vim-fugitive')
    use('jesseduffield/lazygit')



    if packer_bootstrap then
        require('packer').sync()
    end
end)
