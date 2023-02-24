local status, dap = pcall(require, "dap")
if not status then
	return
end

local status1, js = pcall(require, "dap-vscode-js")
if not status1 then
	return
end

local status2, rt = pcall(require, "rust-tools")
if not status2 then
	return
end

rt.setup({
	tools = {
		runnables = {
			use_telescope = true,
		},
		inlay_hints = {
			auto = true,
			show_parameter_hints = false,
			parameter_hints_prefix = "",
			other_hints_prefix = "",
		},
	},
	dap = {
		adapter = {
			type = "executable",
			command = "lldb-vscode-14",
			name = "lldb",
		},
	},
})

js.setup({
	node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
	debugger_path = os.getenv("HOME") .. "/.dap/js-debug-adapter", -- "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
	-- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
	adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
	-- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
	-- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
	-- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
})

dap.adapters.lldb = {
	type = "executable",
	name = "lldb",
	command = "lldb-vscode-14",
}

for _, language in ipairs({ "typescript", "javascript" }) do
	dap.configurations[language] = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			cwd = "${workspaceFolder}",
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch Program (pwa-node)",
			cwd = vim.fn.getcwd(),
			args = { "${file}" },
			sourceMaps = true,
			protocol = "inspector",
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach",
			processId = require("dap.utils").pick_process,
			cwd = "${workspaceFolder}",
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Debug Mocha Tests",
			-- trace = true, -- include debugger info
			runtimeExecutable = "node",
			runtimeArgs = {
				"./node_modules/mocha/bin/mocha.js",
			},
			rootPath = "${workspaceFolder}",
			cwd = "${workspaceFolder}",
			console = "integratedTerminal",
			internalConsoleOptions = "neverOpen",
		},
	}
end

dap.configurations.rust = {
	{
		name = "Launch Debug",
		type = "lldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/" .. "")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
		initCommand = {},
		runInTerminal = false,
	},
}

vim.fn.sign_define("DapStopped", { text = "", texthl = "DiagnosticWarn" })
vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticInfo" })
vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DiagnosticError" })
vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DiagnosticInfo" })
vim.fn.sign_define("DapLogPoint", { text = ".>", texthl = "DiagnosticInfo" })

vim.keymap.set("n", "<leader>dC", '<cmd>lua require"dap".continue()<CR>')
vim.keymap.set("n", "<leader>dn", '<cmd>lua require"dap".step_into()<CR>')
vim.keymap.set("n", "<leader>dN", '<cmd>lua require"dap".step_back()<CR>')
vim.keymap.set("n", "<leader>do", '<cmd>lua require"dap".step_over()<CR>')
vim.keymap.set("n", "<leader>dO", '<cmd>lua require"dap".step_out()<CR>')
vim.keymap.set("n", "<leader>db", '<cmd>lua require"dap".toggle_breakpoint()<CR>')

-- vim.keymap.set("n", "<leader>dsc", '<cmd>lua require"dap.ui.variables".scopes()<CR>')
-- vim.keymap.set("n", "<leader>dhh", '<cmd>lua require"dap.ui.variables".hover()<CR>')
-- vim.keymap.set("v", "<leader>dhv", '<cmd>lua require"dap.ui.variables".visual_hover()<CR>')
--
-- vim.keymap.set("n", "<leader>duh", '<cmd>lua require"dap.ui.widgets".hover()<CR>')
vim.keymap.set(
	"n",
	"<leader>dS",
	"<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>"
)

vim.keymap.set("n", "<leader>dB", '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>')
vim.keymap.set(
	"n",
	"<leader>dbl",
	'<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>'
)
vim.keymap.set("n", "<leader>dr", '<cmd>lua require"dap".repl.open()<CR>')
