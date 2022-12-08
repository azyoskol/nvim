local status, null_ls = pcall(require, "null-ls")
if not status then
	return
end

null_ls.setup({
	sources = {
		null_ls.builtins.code_actions.shellcheck,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.isort,
		null_ls.builtins.formatting.prettierd.with({ extra_filetypes = { "rmd" } }),
		null_ls.builtins.formatting.shfmt,
		null_ls.builtins.formatting.eslint_d,
		null_ls.builtins.diagnostics.cue_fmt,
		null_ls.builtins.diagnostics.shellcheck,
		null_ls.builtins.diagnostics.eslint_d.with({
			diagnostics_format = "[eslint] #{m}\n(#{c})",
		}),
	},
	on_attach = function(client, bufnr)
		if client.server_capabilities.document_formatting then
			vim.api.nvim_create_autocmd("BufWritePre", {
				desc = "Auto format before save",
				buffer = bufnr,
				pattern = "<buffer>",
				callback = function()
					vim.lsp.buf.formatting_sync()
				end,
			})
		end
	end,
})
