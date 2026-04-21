local ag = vim.api.nvim_create_augroup

vim.filetype.add({
    filename = {
        ["nginx.conf"] = "nginx",
    },
    pattern = {
        [".*/nginx/.*%.conf"] = "nginx",
        [".*/sites%-available/.*"] = "nginx",
        [".*/sites%-enabled/.*"] = "nginx",
        [".*%.nginx%.conf"] = "nginx",
    },
})

local highlight_group = ag('YankHighlight', { clear = true })
local indent_group = ag("LocalIndent", { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({ timeout = 170 })
    end,
    group = highlight_group,
})

vim.api.nvim_create_autocmd("FileType", {
    group = indent_group,
    pattern = { "lua" },
    callback = function()
        vim.bo.tabstop = 2
        vim.bo.softtabstop = 2
        vim.bo.shiftwidth = 2
    end,
})

local group = vim.api.nvim_create_augroup("LspFormatting", {})

vim.api.nvim_create_autocmd("BufWritePre", {
    group = group,
    pattern = "*.go",
    callback = function(args)
        local clients = vim.lsp.get_clients({ bufnr = args.buf, name = "gopls" })
        if #clients == 0 then
            return
        end

        vim.lsp.buf.code_action({
            context = { only = { "source.organizeImports" }, diagnostics = {} },
            apply = true,
            filter = function(client)
                return client.name == "gopls"
            end,
        })
        vim.lsp.buf.format({
            bufnr = args.buf,
            async = false,
            filter = function(client)
                return client.name == "gopls"
            end,
        })
    end,
})

vim.api.nvim_create_user_command("CheckLangTools", function()
    local required = {
        "bash-language-server",
        "docker-langserver",
        "gopls",
        "intelephense",
        "lua-language-server",
        "nginx-language-server",
        "pyright-langserver",
        "rust-analyzer",
        "sqls",
        "tsc",
        "typescript-language-server",
        "vscode-css-language-server",
        "vscode-html-language-server",
        "vscode-json-language-server",
        "yaml-language-server",
    }

    local missing = {}
    for _, bin in ipairs(required) do
        if vim.fn.executable(bin) ~= 1 then
            table.insert(missing, bin)
        end
    end

    if #missing == 0 then
        vim.notify("All configured language tools are available", vim.log.levels.INFO)
        return
    end

    vim.notify(
        "Missing language tools: " .. table.concat(missing, ", "),
        vim.log.levels.WARN
    )
end, { desc = "Check that configured language server binaries are installed" })
