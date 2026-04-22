vim.g.mapleader = " "

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

local function toggle_git_blame()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.bo[buf].filetype == "fugitiveblame" then
            vim.api.nvim_win_close(win, true)
            return
        end
    end

    vim.cmd("Git blame")
end

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

local function duplicate_line()
    local line = vim.api.nvim_get_current_line()
    local row = vim.api.nvim_win_get_cursor(0)[1]

    vim.api.nvim_buf_set_lines(0, row, row, false, { line })
    vim.api.nvim_win_set_cursor(0, { row + 1, 0 })
end

keymap("n", "<leader>e", "<Cmd>NvimTreeToggle<CR>", opts)
keymap("n", "<leader><leader>", fzf_picker("files"), opts)
keymap("n", "<leader>/", fzf_picker("live_grep"), opts)
keymap("n", "<leader>b", fzf_picker("buffers"), opts)
keymap("n", "<leader>.", fzf_picker("oldfiles"), opts)
keymap("n", "<leader>,", fzf_picker("resume"), opts)
keymap("n", "<leader>ss", fzf_picker("lsp_document_symbols"), opts)
keymap("n", "<leader>sS", fzf_picker("lsp_workspace_symbols"), opts)
keymap("n", "<leader>xx", fzf_picker("diagnostics_workspace"), opts)
keymap("n", "<leader>gb", toggle_git_blame, opts)
keymap("n", "<A-d>", duplicate_line, opts)
keymap("n", "<A-j>", "<Cmd>move .+1<CR>==", opts)
keymap("n", "<A-k>", "<Cmd>move .-2<CR>==", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv=gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv=gv", opts)

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
