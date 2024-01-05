-- install without yarn or npm
return {
    "iamcco/markdown-preview.nvim",
    build = function() vim.fn["mkdp#util#install"]() end,
    config = function()
        -- if set to 1 will refresh only when saving or leaving from insert mode
        vim.g.mkdp_refresh_slow = 0


        -- preview options
        vim.g.mkdp_preview_options = {
            sync_scroll_type = 'middle'
        }
    end
}
