local status, sessionManager = pcall(require, "session_manager")
if not status then
	return
end

sessionManager.setup({
	autosave_last_session = true,
})

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>sl", "<cmd>SessionManager! load_last_session<cr>", opts)
vim.keymap.set("n", "<leader>ss", "<cmd>SessionManager! save_current_session<cr>", opts)
vim.keymap.set("n", "<leader>sd", "<cmd>SessionManager! delete_session<cr>", opts)
vim.keymap.set("n", "<leader>sf", "<cmd>SessionManager! load_session<cr>", opts)
vim.keymap.set("n", "<leader>s.", "<cmd>SessionManager! load_current_dir_session<cr>", opts)
