vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
    view = {
        width = 35,
        side = "left",
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = false,
    },
    actions = {
        open_file = {
            window_picker = {
                enable = false,
            },
        },
    },
})

