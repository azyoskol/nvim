local keymap = vim.keymap

vim.g.mapleader = " "

keymap.set("n", "x", '"_x')

--Save file
keymap.set("n", "<leader>w", ":w<CR>")

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- New tab
keymap.set("n", "te", ":tabedit")
-- Split window
keymap.set("n", "ss", ":split<Return><C-w>w")
keymap.set("n", "sv", ":vsplit<Return><C-w>w")
-- Move window
keymap.set("n", "<Space>", "<C-w>w")

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- Stay in indent mode
keymap.set("n", "<", "<gv")
keymap.set("n", ">", ">gv")

keymap.set("", "<C-h>", "<C-w>h")
keymap.set("", "<C-j>", "<C-w>j")
keymap.set("", "<C-k>", "<C-w>k")
keymap.set("", "<C-l>", "<C-w>l")
