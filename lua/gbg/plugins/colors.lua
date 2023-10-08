return {
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
        vim.cmd('colorscheme rose-pine')
    end,
    opts = {
        disable_background = true,
    }
}
