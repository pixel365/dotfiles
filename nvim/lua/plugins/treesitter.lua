local parsers = {
    "bash",
    "css",
    "dockerfile",
    "go",
    "html",
    "javascript",
    "json",
    "lua",
    "markdown",
    "markdown_inline",
    "nginx",
    "php",
    "phpdoc",
    "python",
    "rust",
    "scss",
    "sql",
    "tsx",
    "typescript",
    "yaml",
}

vim.api.nvim_create_user_command("TSInstallPreferred", function()
    require("nvim-treesitter").install(parsers, { summary = true })
end, { desc = "Install the preferred Tree-sitter parsers for this config" })

vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "css",
        "dockerfile",
        "go",
        "html",
        "javascript",
        "javascriptreact",
        "json",
        "jsonc",
        "lua",
        "markdown",
        "nginx",
        "php",
        "python",
        "rust",
        "scss",
        "sh",
        "sql",
        "typescript",
        "typescriptreact",
        "yaml",
        "yaml.docker-compose",
        "yaml.gitlab",
        "yaml.helm-values",
    },
    callback = function()
        pcall(vim.treesitter.start)
    end,
})
