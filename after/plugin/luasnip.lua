local ls = require("luasnip")
local types = require("luasnip.util.types")
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local i = ls.insert_node
local t = ls.text_node


-- Configure luasnip

ls.config.set_config {
    -- This allows you to go into the last snippet.
    history = true,

    -- This are the events that will trigger changes in the snippet.
    updateevents = "TextChanged, TextChangedI",

    -- auto snippets:
    enable_autosnippets = false,

}

-- set keymaps
-- expand or next blank <c-k>
vim.keymap.set({ "i", "s" }, "<c-k>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, { silent = true })

-- previous blank <c-j>
vim.keymap.set({ "i", "s" }, "<c-j>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { silent = true })


-- cycles list of options <c-l>
vim.keymap.set("i", "<c-l>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end)

-- resuource snippets file
vim.keymap.set('n', "<leader><leader>s", "<cmd>source /home/gbg4812/.config/nvim/after/plugin/luasnip.lua<CR>")


-- create snippets
-- note taking snippets
ls.add_snippets("markdown", {
    s("mat", fmta("$$\n<>\n$$", { i(1, "default") })),
    s("\\f", fmta("\\frac{<>}{<>}", { i(1, "numer"), i(2, "denom") })),
    s("\\s", fmta("\\sum_{<>}^{<>}", { i(1, "i=m"), i(2, "n") })),
    s("a", t("$\\alpha$")),
    s("b", t("$\\beta$")),
    s("delta", t("$\\delta$")),
}
)

ls.add_snippets("lua", {
    s("req", fmt("local {} = require('{}')", { i(1, "default"), rep(1) })),
}
)

