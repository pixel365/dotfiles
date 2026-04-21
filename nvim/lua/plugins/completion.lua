require("blink.cmp").setup({
    fuzzy = { implementation = "prefer_rust_with_warning" },
    signature = { enabled = true },

    keymap = {
        preset = "enter",

        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<Tab>"] = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
    },

    completion = {
        menu = { auto_show = true },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
        },
        accept = {
            resolve_timeout_ms = 1000,
        },
    },

    sources = {
        default = { "lsp", "path", "buffer" },
    },
})

