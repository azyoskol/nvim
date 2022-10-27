local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

local user_terminals = {}

-- term_details can be either a string for just a command or
-- a complete table to provide full access to configuration when calling Terminal:new()

--- Toggle a user terminal if it exists, if not then create a new one and save it
-- @param term_details a terminal command string or a table of options for Terminal:new() (Check toggleterm.nvim documentation for table format)
local function toggle_term_cmd(term_details)
	-- if a command string is provided, create a basic table for Terminal:new() options
	if type(term_details) == "string" then
		term_details = { cmd = term_details, hidden = true }
	end
	-- use the command as the key for the table
	local term_key = term_details.cmd
	-- set the count in the term details
	if vim.v.count > 0 and term_details.count == nil then
		term_details.count = vim.v.count
		term_key = term_key .. vim.v.count
	end
	-- if terminal doesn't exist yet, create it
	if user_terminals[term_key] == nil then
		user_terminals[term_key] = require("toggleterm.terminal").Terminal:new(term_details)
	end
	-- toggle the terminal
	user_terminals[term_key]:toggle()
end

toggleterm.setup({
	size = 10,
	open_mapping = [[<F7>]],
	shading_factor = 2,
	direction = "float",
	float_opts = {
		border = "curved",
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
})

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>tl", function()
	toggle_term_cmd("lazygit")
end, opts)
vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", opts)
vim.keymap.set("n", "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", opts)
vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", opts)
vim.keymap.set("n", "<F7>", "<cmd>ToggleTerm<cr>", opts)
vim.keymap.set("t", "<F7>", "<cmd>ToggleTerm<cr>", opts)
vim.keymap.set("n", "<C-'>", "<cmd>ToggleTerm<cr>", opts)
vim.keymap.set("t", "<C-'>", "<cmd>ToggleTerm<cr>", opts)

vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>:q<cr>", opts)
