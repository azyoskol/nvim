local status, saga = pcall(require, "lspsaga")
if not status then
	return
end

saga.init_lsp_saga({
	server_filetype_map = {
		typescript = "typescript",
		javasctipt = "javasctipt",
	},
	finder_request_timeout = 3500,
	code_action_keys = {
		quit = "<Esc>",
		exec = "<CR>",
	},
})

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>ln", "<Cmd>Lspsaga diagnostic_jump_next<CR>", opts)
vim.keymap.set("n", "K", "<Cmd>Lspsaga hover_doc<CR>", opts)
vim.keymap.set("n", "gd", "<Cmd>Lspsaga lsp_finder<CR>", opts)
vim.keymap.set("i", "<leader>ls", "<Cmd>Lspsaga signature_help<CR>", opts)
vim.keymap.set("n", "gp", "<Cmd>Lspsaga preview_definition<CR>", opts)
vim.keymap.set("n", "<leader>lr", "<Cmd>Lspsaga rename<CR>", opts)
vim.keymap.set("n", "<leader>la", "<Cmd>Lspsaga code_action<CR>", opts)
-- vim.keymap.set("n", "<leader>tf", "<Cmd>Lspsaga open_floaterm<CR>", opts)
-- vim.keymap.set("n", "<leader>tl", "<Cmd>Lspsaga open_floaterm lazygit<CR>", opts)
-- close floaterm
-- vim.keymap.set("t", "<esc><esc>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], opts)
