local status, spider = pcall(require, "spider")
if (not status) then return end

spider.setup({
	skipInsignificantPunctuation = true
})

-- Keymaps
-- vim.keymap.set({"n", "o", "x"}, "w", function() require("spider").motion("w") end, { desc = "Spider-w" })
-- vim.keymap.set({"n", "o", "x"}, "e", function() require("spider").motion("e") end, { desc = "Spider-e" })
-- vim.keymap.set({"n", "o", "x"}, "b", function() require("spider").motion("b") end, { desc = "Spider-b" })
-- vim.keymap.set({"n", "o", "x"}, "ge", function() require("spider").motion("ge") end, { desc = "Spider-ge" })
