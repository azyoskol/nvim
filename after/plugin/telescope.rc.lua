local status, telescope = pcall(require, "telescope")
if not status then
	return
end
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

local function telescope_buffer_dir()
	return vim.fn.expand("%:p:h")
end

local fb_actions = telescope.extensions.file_browser.actions

telescope.setup({
	defaults = {
		prompt_prefix = " ",
		selection_caret = "❯ ",
		path_display = { "truncate" },
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.55,
				results_width = 0.8,
			},
			vertical = {
				mirror = false,
			},
			width = 0.87,
			height = 0.80,
			preview_cutoff = 120,
		},

		mappings = {
			n = {
				["q"] = actions.close,
			},
		},
	},
	extensions = {
		file_browser = {
			theme = "dropdown",
			-- disables netrw and use telescope-file-browser in its place
			hijack_netrw = true,
			mappings = {
				-- your custom insert mode mappings
				["i"] = {
					["<C-t>"] = actions.select_tab,
					["<C-.>"] = fb_actions.change_cwd,
					["<C-w>"] = function()
						vim.cmd("normal vbd")
					end,
				},
				["n"] = {
					-- your custom normal mode mappings
					["N"] = fb_actions.create,
					["h"] = fb_actions.goto_parent_dir,
					["."] = fb_actions.change_cwd,
					["/"] = function()
						vim.cmd("startinsert")
					end,
					["t"] = actions.select_tab,
				},
			},
		},
		project = {},
	},
})

telescope.load_extension("file_browser")

vim.keymap.set("n", "<leader>ff", function()
	builtin.find_files({
		no_ignore = false,
		hidden = true,
	})
end)
vim.keymap.set("n", "<leader>fw", function()
	builtin.live_grep()
end)
vim.keymap.set("n", "<leader>fb", function()
	builtin.buffers()
end)
vim.keymap.set("n", "<leader>ft", function()
	builtin.help_tags()
end)
vim.keymap.set("n", "<leader><leader>", function()
	builtin.resume()
end)
vim.keymap.set("n", "<leader>fd", function()
	builtin.diagnostics()
end)
vim.keymap.set("n", "<leader>e", function()
	telescope.extensions.file_browser.file_browser({
		path = "%:p:h",
		cwd = telescope_buffer_dir(),
		respect_gitignore = false,
		hidden = true,
		grouped = true,
		previewer = false,
		initial_mode = "normal",
		layout_config = { height = 40 },
	})
end)

vim.keymap.set("n", "<leader>fp", function()
	telescope.extensions.project.project({
		theme = "dropdown",
	})
end)
vim.keymap.set("n", "<leader>lm", function()
	telescope.extensions.flutter.commands()
end)
vim.keymap.set("n", "<leader>lmv", function()
	telescope.extensions.flutter.fvm()
end)
