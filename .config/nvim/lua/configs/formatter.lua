local fmt_status, formatter = pcall(require, "formatter")
if not fmt_status then
    return
end

formatter.setup({
    logging = true,
    filetype = {
        javascript = { require("formatter.filetypes.javascript").prettier },
        typescript = { require("formatter.filetypes.typescript").prettier },
        lua = { require("formatter.filetypes.lua").stylua },
        python = { require("formatter.filetypes.python").black },
    },
})

-- Optional: auto-format on save
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        vim.cmd("FormatWrite")
    end,
})
