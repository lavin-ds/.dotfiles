local lint_status, lint = pcall(require, "lint")
if not lint_status then
	return
end

-- Set up linters per filetype
lint.linters_by_ft = {
	javascript = { "eslint_d" },
	typescript = { "eslint_d" },
	lua = { "luacheck" },
	python = { "flake8" },
}

-- Auto-lint on save
vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave", "TextChanged" }, {
	callback = function()
		lint.try_lint()
	end,
})
