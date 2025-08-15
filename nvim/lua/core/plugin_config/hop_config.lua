local hop = require("hop")
hop.setup()

vim.keymap.set("n", "<leader>fw", "<cmd>HopWord<CR>")
vim.keymap.set("n", "<leader>fa", "<cmd>HopAnywhere<CR>")
vim.keymap.set("n", "<leader>fc", "<cmd>HopChar1<CR>")
vim.keymap.set("n", "<leader>fl", "<cmd>HopLineStart<CR>")
vim.keymap.set("n", "<leader>fr", "<cmd>HopPattern<CR>")
vim.keymap.set("n", "<leader>fy", "<cmd>HopYankChar1<CR>")
vim.keymap.set("n", "<leader>fp", "<cmd>HopPasteChar1<CR>")
vim.keymap.set("n", "<leader>fs", "<cmd>HopCamelCase<CR>")

-- Function to get two positions using HopChar1
local function get_two_positions()
	local positions = {}
	vim.cmd("silent! HopChar1")
	positions[1] = vim.api.nvim_win_get_cursor(0)
	vim.cmd("silent! HopChar1")
	positions[2] = vim.api.nvim_win_get_cursor(0)

	-- Sort positions to ensure correct order
	local start_pos = positions[1]
	local end_pos = positions[2]

	if start_pos[1] > end_pos[1] or (start_pos[1] == end_pos[1] and start_pos[2] > end_pos[2]) then
		start_pos, end_pos = end_pos, start_pos
	end

	return start_pos, end_pos
end

-- Delete between two characters using hop
vim.keymap.set("n", "<leader>fd", function()
	local start_pos, end_pos = get_two_positions()

	-- Get text between positions and copy to register
	local lines = vim.api.nvim_buf_get_text(0, start_pos[1] - 1, start_pos[2], end_pos[1] - 1, end_pos[2], {})
	vim.fn.setreg('"', table.concat(lines, "\n"))

	-- Delete text between positions
	vim.api.nvim_buf_set_text(0, start_pos[1] - 1, start_pos[2], end_pos[1] - 1, end_pos[2], { "" })
end)

-- Visually select between two characters using hop
vim.keymap.set("n", "<leader>fv", function()
	local start_pos, end_pos = get_two_positions()

	-- Move to start position and enter visual mode
	vim.api.nvim_win_set_cursor(0, start_pos)
	vim.cmd("normal! v")

	-- Move to end position to complete selection
	vim.api.nvim_win_set_cursor(0, { end_pos[1], end_pos[2] - 1 })
end)
