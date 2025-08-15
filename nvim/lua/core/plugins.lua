require("lazy").setup({
	-- themes
	--{ "nyoom-engineering/oxocarbon.nvim" },
	{
		"projekt0n/github-nvim-theme",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("github-theme").setup({})
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	-- Configuration and abstraction layer
	{ "nvim-lua/plenary.nvim" },

	-- LSP Package manager
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },

	-- LSP:
	{ "neovim/nvim-lspconfig" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "VonHeikemen/lsp-zero.nvim" },
	{ "stevearc/conform.nvim" },

	-- tmux navigation
	{ "christoomey/vim-tmux-navigator" },

	-- Split
	{ "declancm/maximize.nvim" },

	-- completion stuff:
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-cmdline" },
	{ "hrsh7th/nvim-cmp" },
	{ "saadparwaiz1/cmp_luasnip" },

	-- Hop:
	{ "smoka7/hop.nvim" },

	-- Harpoon
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"letieu/harpoon-lualine",
		dependencies = {
			"nvim-lualine/lualine.nvim",
			{
				"ThePrimeagen/harpoon",
				branch = "harpoon2",
			},
		},
	},

	-- telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
	},

	--neo-tree
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
	},
	-- treesitter
	{ "nvim-treesitter/nvim-treesitter-textobjects" },
	{ "nvim-treesitter/nvim-treesitter" },

	-- github
	{ "f-person/git-blame.nvim" },

	-- Multiline
	{
		"mg979/vim-visual-multi",
	},

	--Mini: Plugin collection
	{ "echasnovski/mini.nvim", version = false },

	-- Trouble: Better diagnostic display (for quickfix/location list)
	{
		"folke/trouble.nvim",
		opts = {},
		cmd = "Trouble",
		keys = {
			{ "<leader>dq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
			{ "<leader>dl", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
		},
	},
})
