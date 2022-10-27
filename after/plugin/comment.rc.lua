local status, comment = pcall(require, "Comment")
if not status then
	return
end

comment.setup({})

vim.keymap.set("n", "<leader>/", function()
	require("Comment.api").toggle.linewise.current()
end)
vim.keymap.set("v", "<leader>/", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>")
