require("gitsigns").setup({
    signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
    },
    current_line_blame = false,
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local opts = { buffer = bufnr, silent = true }

        vim.keymap.set("n", "]h", function()
            if vim.wo.diff then
                vim.cmd.normal({ "]h", bang = true })
                return
            end
            gs.nav_hunk("next")
        end, opts)

        vim.keymap.set("n", "[h", function()
            if vim.wo.diff then
                vim.cmd.normal({ "[h", bang = true })
                return
            end
            gs.nav_hunk("prev")
        end, opts)

        vim.keymap.set("n", "<leader>hp", gs.preview_hunk, opts)
        vim.keymap.set("n", "<leader>hs", gs.stage_hunk, opts)
        vim.keymap.set("n", "<leader>hr", gs.reset_hunk, opts)
    end,
})
