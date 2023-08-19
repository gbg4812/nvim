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

