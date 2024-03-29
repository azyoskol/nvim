local status, packer = pcall(require, "packer")
if not status then
	print("Packer is not installed")
	return
end

vim.cmd([[packadd packer.nvim]])

packer.startup(function(use)
	use("wbthomason/packer.nvim")
	use("numToStr/Comment.nvim")
	use("Shatur/neovim-session-manager")
	use("eddyekofo94/gruvbox-flat.nvim")
	use("nvim-lualine/lualine.nvim") -- Statusline
	use("nvim-lua/plenary.nvim") -- Common utilities
	use("onsails/lspkind-nvim") -- vscode-like pictograms
  use({
      "jcdickinson/http.nvim",
      run = "cargo build --workspace --release"
  })
	use("hrsh7th/cmp-buffer") -- nvim-cmp source for buffer words
	use("hrsh7th/cmp-path") -- nvim-cmp source for path words
	use("hrsh7th/cmp-nvim-lsp") -- nvim-cmp source for neovim's built-in LSP
	use("hrsh7th/nvim-cmp") -- Completion
	use("neovim/nvim-lspconfig") -- LSP
	use("jose-elias-alvarez/null-ls.nvim") -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
	use({ "akinsho/toggleterm.nvim", tag = "*" })
	use("lukas-reineke/indent-blankline.nvim")
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("glepnir/lspsaga.nvim") -- LSP UIs
	use("L3MON4D3/LuaSnip")
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
	})
	use("kyazdani42/nvim-web-devicons") -- File icons
	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-file-browser.nvim")
	use("nvim-telescope/telescope-project.nvim")
	use("windwp/nvim-autopairs")
	use("windwp/nvim-ts-autotag")
	use("norcalli/nvim-colorizer.lua")
	use("folke/zen-mode.nvim")
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})
	use({ "akinsho/nvim-bufferline.lua", tag = "v3.*" })
  use({ "chrisgrieser/nvim-spider" })
  -- Codeium
  use({
    "jcdickinson/codeium.nvim",
    requires = {
        "jcdickinson/http.nvim",
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
    }
  })
	-- use 'github/copilot.vim'
	use("lewis6991/gitsigns.nvim")
	use("dinhhuy258/git.nvim") -- For git blame & browse
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
	-- Flutter
	use({
		"akinsho/flutter-tools.nvim",
		requires = { "nvim-lua/plenary.nvim" },
	})
	use({ "mxsdev/nvim-dap-vscode-js", requires = { "mfussenegger/nvim-dap" } })
	-- Rust crates
	use("simrat39/rust-tools.nvim")
  use("jamestthompson3/nvim-remote-containers")
  use("andweeb/presence.nvim")
end)
