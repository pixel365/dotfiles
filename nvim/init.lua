require("config")
require("plugins-init")
require("keymaps")

require("plugins.ui")
require("plugins.git")
require("plugins.fzf")
require("plugins.completion")
require("plugins.lsp")
require("plugins.treesitter")
require("plugins.tree")
require("autocmd")

vim.cmd.colorscheme "tokyonight"
