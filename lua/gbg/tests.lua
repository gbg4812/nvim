-- local var = "guillem"
--
--
-- if var == "guillem" or "anna" or "marius" then
--     print(string.format("hello %s",var))
-- else
--     print("i don't trust you")
-- end

-- local selection = { vim.api.nvim_buf_get_mark(0, "<")[1] - 1, vim.api.nvim_buf_get_mark(0, ">")[1] }
-- 
-- local selected_lines = vim.api.nvim_buf_get_lines(0, selection[1], selection[#selection], false)
-- 
-- table.insert(selected_lines, 1, [[--[[]])
-- table.insert(selected_lines, "]]--")
-- 
-- vim.api.nvim_buf_set_lines(0, selection[1], selection[#selection], false, selected_lines)
