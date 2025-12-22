local M = {}

M.vim_diagnostics = function()
    return ""  -- Temporariamente desativa diagnósticos
end

M.git_branch = function()
    return ""
end

M.git_hunks = function()
    return ""
end

M.dap_session = function()
    return ""
end

M.vim_session = function()
    return ""
end

M.vim_macro = function()
    return ""
end

M.path_dir = function()
    return ""
end

M.path_file = function()
    return ""
end

M.vim_spell = function()
    return ""
end

M.auto_format = function()
    return ""
end

M.vim_search = function()
    return ""
end

M.vim_selection = function()
    return ""
end

vim.go.laststatus = 3

M.render = function()
    return "%f %m %= %l:%c"
end

vim.o.statusline = "%!v:lua.require'ui.statusline'.render()"

return M
