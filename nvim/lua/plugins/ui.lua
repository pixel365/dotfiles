require("mason").setup({
    ui = {
        border = "rounded",
    },
})

require("bufferline").setup({
    options = {
        mode = "buffers",
        diagnostics = "nvim_lsp",
        always_show_bufferline = true,
        separator_style = "slant",
        modified_icon = "●",
        custom_filter = function(buf)
            return vim.bo[buf].buftype ~= "terminal"
        end,
        offsets = {
            {
                filetype = "NvimTree",
                text = "Files",
                text_align = "left",
                separator = true,
            },
        },
    },
})

require("lualine").setup({
    options = {
        theme = "tokyonight",
        globalstatus = true,
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
})
