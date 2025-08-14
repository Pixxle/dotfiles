require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-u>"] = false,
				["<C-d>"] = false,
			},
		},
		file_ignore_patterns = { "node_modules/.*", ".git" },
	},
	pickers = {
		find_files = {
			theme = "ivy",
		},
		live_grep = {
			theme = "ivy",
		},
		grep_string = {
			theme = "ivy",
		},
		diagnostics = {
			theme = "ivy",
			initial_mode = "normal",
			wrap_results = true,
		},
		lsp_references = {
			theme = "ivy",
			initial_mode = "normal",
		},
		lsp_document_symbols = {
			theme = "ivy",
		},
	},
	extensions = {
		fzf = {},
	},
})

require("telescope").load_extension("fzf")

vim.keymap.set("n", "<leader>b", function()
	local opts = require("telescope.themes").get_dropdown()
	require("telescope.builtin").buffers(opts)
end)

vim.keymap.set("n", "<leader><space>", require("telescope.builtin").find_files)

vim.keymap.set("n", "<leader>x", require("telescope.builtin").current_buffer_fuzzy_find)
vim.keymap.set("n", "<leader>a", require("telescope.builtin").live_grep)
vim.keymap.set("n", "<leader>s", [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], { silent = true }) -- grep in current buffer

-- Telescope LSP get definition
vim.keymap.set("n", "<leader>h", require("telescope.builtin").lsp_type_definitions)
vim.keymap.set("n", "<leader>H", require("telescope.builtin").lsp_document_symbols)

-- Search my config files
vim.keymap.set("n", "<leader>ep", function()
	local opts = require("telescope.builtin").find_files({
		prompt_title = "Find config files",
		cwd = "~/.config/nvim",
	})
end)

-- Telescope diagnostics (FZF-style popup)
vim.keymap.set("n", "<leader>dt", function()
	require("telescope.builtin").diagnostics({
		bufnr = nil, -- all buffers
	})
end, { desc = "All Diagnostics (Telescope)" })

vim.keymap.set("n", "<leader>db", function()
	require("telescope.builtin").diagnostics({
		bufnr = 0, -- current buffer only
	})
end, { desc = "Buffer Diagnostics (Telescope)" })

-- Quick diagnostic popup for current line
vim.keymap.set("n", "<leader>dd", function()
	local line_diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })
	if #line_diagnostics > 0 then
		-- If there are diagnostics on current line, show telescope picker with just those
		require("telescope.builtin").diagnostics({
			bufnr = 0,
			line_width = "full",
		})
	end
end, { desc = "Show Diagnostics (Current Line)" })
