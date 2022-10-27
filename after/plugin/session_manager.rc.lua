local status, sessionManager = pcall(require, "session_manager")
if not status then
	return
end

sessionManager.setup({
	autosave_last_session = true,
})

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>Sl", "<cmd>SessionManager! load_last_session<cr>", opts)
vim.keymap.set("n", "<leader>Ss", "<cmd>SessionManager! save_current_session<cr>", opts)
vim.keymap.set("n", "<leader>Sd", "<cmd>SessionManager! delete_session<cr>", opts)
vim.keymap.set("n", "<leader>Sf", "<cmd>SessionManager! load_session<cr>", opts)
vim.keymap.set("n", "<leader>S.", "<cmd>SessionManager! load_current_dir_session<cr>", opts)
