local M = {}

local root_markers = {
    ".git",
    "go.mod",
    "package.json",
    "Cargo.toml",
    "composer.json",
    "pyproject.toml",
    "Makefile",
}

local function is_regular_file(path)
    return type(path) == "string"
        and path:sub(1, 1) == "/"
        and vim.fn.filereadable(path) == 1
end

local function project_root(path)
    local root = vim.fs.root(path, root_markers)
    if root then
        return root
    end

    return vim.fs.dirname(path)
end

local function recent_projects()
    local projects = {}
    local seen = {}

    for _, path in ipairs(vim.v.oldfiles or {}) do
        if is_regular_file(path) then
            local root = project_root(path)
            if root and not seen[root] then
                seen[root] = true
                table.insert(projects, root)
            end
        end
    end

    return projects
end

local function open_in_tree(root)
    local ok, api = pcall(require, "nvim-tree.api")
    if not ok then
        pcall(vim.cmd, "NvimTreeOpen " .. vim.fn.fnameescape(root))
        return
    end

    if api.tree.is_visible() then
        api.tree.change_root(root)
        api.tree.focus()
        return
    end

    api.tree.open()
    api.tree.change_root(root)
end

function M.open(root)
    if not root or root == "" then
        return
    end

    vim.cmd("cd " .. vim.fn.fnameescape(root))
    open_in_tree(root)
end

function M.pick()
    local projects = recent_projects()
    if vim.tbl_isempty(projects) then
        vim.notify("No recent projects yet", vim.log.levels.INFO)
        return
    end

    local ok, fzf = pcall(require, "fzf-lua")
    if ok then
        fzf.fzf_exec(projects, {
            prompt = "Projects> ",
            actions = {
                ["default"] = function(selected)
                    M.open(selected[1])
                end,
            },
        })
        return
    end

    vim.ui.select(projects, { prompt = "Recent projects" }, function(choice)
        M.open(choice)
    end)
end

function M.setup()
    vim.api.nvim_create_user_command("RecentProjects", M.pick, {
        desc = "Open recent project roots",
    })
end

return M
