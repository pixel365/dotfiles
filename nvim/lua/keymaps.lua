vim.g.mapleader = " "

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

local function fzf_picker(name)
    return function()
        local ok, fzf = pcall(require, "fzf-lua")
        if not ok then
            vim.notify("fzf-lua is unavailable in this session", vim.log.levels.WARN)
            return
        end

        fzf[name]()
    end
end

keymap("n", "<leader>e", "<Cmd>NvimTreeToggle<CR>", opts)
keymap("n", "<leader><leader>", fzf_picker("files"), opts)
keymap("n", "<leader>/", fzf_picker("live_grep"), opts)

local term_buf = nil
local term_win = nil

keymap("n", "<leader>t", function()
    if term_win and vim.api.nvim_win_is_valid(term_win) then
        vim.api.nvim_win_close(term_win, true)
        term_win = nil
        return
    end

    if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
        vim.cmd("botright split")
        term_win = vim.api.nvim_get_current_win()
        vim.api.nvim_win_set_buf(term_win, term_buf)
        vim.cmd("startinsert")
        return
    end

    vim.cmd("botright split | terminal")
    term_win = vim.api.nvim_get_current_win()
    term_buf = vim.api.nvim_get_current_buf()
end, opts)

keymap("t", "<Esc>", [[<C-\><C-n>]], opts)

keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap("t", "<C-h>", [[<C-\><C-n><C-w>h]], opts)
keymap("t", "<C-j>", [[<C-\><C-n><C-w>j]], opts)
keymap("t", "<C-k>", [[<C-\><C-n><C-w>k]], opts)
keymap("t", "<C-l>", [[<C-\><C-n><C-w>l]], opts)

keymap("n", "<leader>v", "<cmd>vsplit<CR>", opts)
keymap("n", "<leader>s", "<cmd>split<CR>", opts)
