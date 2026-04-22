local lsp = vim.lsp
local capabilities = require("blink.cmp").get_lsp_capabilities()
local lua_ls_config = dofile(vim.fs.joinpath(vim.fn.stdpath("config"), "lsp", "lua.lua"))

vim.diagnostic.config({
    severity_sort = true,
    float = {
        border = "rounded",
        source = "if_many",
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    virtual_text = {
        spacing = 2,
        source = "if_many",
    },
})

local on_attach = function(_, bufnr)
    local opts = { buffer = bufnr, silent = true }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gi", function()
        local ok, fzf = pcall(require, "fzf-lua")
        if ok then
            fzf.lsp_implementations()
            return
        end

        vim.lsp.buf.implementation()
    end, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>fo", function()
        vim.lsp.buf.format({ bufnr = bufnr, async = false })
    end, opts)
    vim.keymap.set("n", "<leader>ds", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
end

local function with_fallback_root(markers)
    return function(bufnr, on_dir)
        on_dir(vim.fs.root(bufnr, markers) or vim.fn.getcwd())
    end
end

local function with_common(server_name, config)
    local base = vim.deepcopy(lsp.config[server_name] or {})
    local base_on_attach = base.on_attach
    local extra_on_attach = config and config.on_attach
    local extra_capabilities = config and config.capabilities or {}
    local merged = vim.tbl_deep_extend("force", base, config or {})

    merged.capabilities = vim.tbl_deep_extend(
        "force",
        {},
        base.capabilities or {},
        capabilities,
        extra_capabilities
    )
    merged.on_attach = function(client, bufnr)
        if base_on_attach then
            base_on_attach(client, bufnr)
        end
        if extra_on_attach then
            extra_on_attach(client, bufnr)
        end
        on_attach(client, bufnr)
    end

    return merged
end

lsp.config("gopls", with_common("gopls", {
    root_markers = { "go.work", "go.mod", ".git" },
    settings = {
        gopls = {
            completeUnimported = true,
            gofumpt = true,
        },
    }
}))

lsp.config("pyright", with_common("pyright"))

lsp.config("bashls", with_common("bashls"))

lsp.config("rust_analyzer", with_common("rust_analyzer"))

lsp.config("lua_ls", with_common("lua_ls", lua_ls_config))
lsp.config("dockerls", with_common("dockerls", {
    root_dir = with_fallback_root({ "Dockerfile", ".git" }),
}))
lsp.config("nginx_language_server", with_common("nginx_language_server", {
    root_dir = with_fallback_root({ "nginx.conf", ".git" }),
}))
lsp.config("sqls", with_common("sqls", {
    root_dir = with_fallback_root({ "config.yml", ".git" }),
}))
lsp.config("intelephense", with_common("intelephense", {
    root_dir = with_fallback_root({ "composer.json", ".git" }),
}))
lsp.config("ts_ls", with_common("ts_ls"))
lsp.config("html", with_common("html", {
    root_dir = with_fallback_root({ "package.json", ".git" }),
}))
lsp.config("cssls", with_common("cssls", {
    root_dir = with_fallback_root({ "package.json", ".git" }),
}))
lsp.config("jsonls", with_common("jsonls", {
    root_dir = with_fallback_root({ ".git" }),
}))
lsp.config("yamlls", with_common("yamlls", {
    root_dir = with_fallback_root({ ".git" }),
}))

lsp.enable("gopls")
lsp.enable("pyright")
lsp.enable("bashls")
lsp.enable("rust_analyzer")
lsp.enable("lua_ls")
lsp.enable("dockerls")
lsp.enable("nginx_language_server")
lsp.enable("sqls")
lsp.enable("intelephense")
lsp.enable("ts_ls")
lsp.enable("html")
lsp.enable("cssls")
lsp.enable("jsonls")
lsp.enable("yamlls")
