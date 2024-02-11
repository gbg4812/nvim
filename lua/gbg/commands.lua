local startLiveServer = function(data)
    local path = data.args

    local files = { "html", "js", "ts", }

    for i, value in pairs(files) do
        local index = string.find(path, value, -string.len(value), true)

        if index then
            local command = "live-server " .. "--browser=firefox " .. data.args
            local file = io.popen(command)
            if file then
                local result = file:read("*l")
                print(result)
            end
            return
        end
    end
    print("The file type is not in the list")
end

vim.api.nvim_create_user_command("LSStart", startLiveServer, { nargs = 1, complete = "buffer" })

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        local opts = { buffer = ev.buff, desc = "lsp keymap" }

        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    end,
})
