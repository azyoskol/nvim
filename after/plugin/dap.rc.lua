local status, dap = pcall(require, "dap")
if not status then
	return
end

-- dap.adapters.python = {
-- 	type = "executable",
-- 	command = "/usr/bin/python",
-- 	args = { "-m", "debugpy.adapter" },
-- }
-- dap.configurations.python = {
-- 	{
-- 		type = "python",
-- 		request = "launch",
-- 		name = "Launch file",
-- 	},
-- }

dap.adapters.lldb = {
	type = "executable",
	command = "/home/linuxbrew/.linuxbrew/bin/lldb-vscode", -- adjust as needed
	name = "lldb",
}

dap.adapters.node2 = {
	type = "executable",
	command = "node",
	args = { os.getenv("HOME") .. "/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js" },
}

dap.configurations.javascript = {
	{
		name = "Launch",
		type = "node2",
		request = "launch",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		console = "integratedTerminal",
	},
	{
		-- For this to work you need to make sure the node process is started with the `--inspect` flag.
		name = "Attach to process",
		type = "node2",
		request = "attach",
		processId = require("dap.utils").pick_process,
	},
}

dap.configurations.rust = {
	{
		name = "Launch lldb",
		type = "lldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},

		-- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
		--
		--    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
		--
		-- Otherwise you might get the following error:
		--
		--    Error on launch: Failed to attach to the target process
		--
		-- But you should be aware of the implications:
		-- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
		-- runInTerminal = false,
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
