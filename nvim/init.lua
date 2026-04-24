require("config")
require("plugins-init")
require("keymaps")
require("recent_projects").setup()

require("plugins.ui")
require("plugins.git")
require("plugins.fzf")
require("plugins.autopairs")
require("plugins.completion")
require("plugins.lsp")
require("plugins.treesitter")
require("plugins.tree")
require("autocmd")

vim.cmd.colorscheme "tokyonight"
