return {
    {
        "jpalardy/vim-slime",
        config = function()
            vim.cmd([[
            let g:slime_target = "tmux"
            let g:slime_cell_delimiter = "# %%"
            let g:slime_default_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": ":.2"}
            let g:slime_dont_ask_default = 1
            let g:slime_bracketed_paste = 1
            let g:slime_no_mappings = 1
            nmap <c-c>v <Plug>SlimeConfig
            ]])
        end
    },
    {
        'klafyvel/vim-slime-cells',
        requires = {{'jpalardy/vim-slime', opt=true}},
        ft = {'julia', 'python'},
        config=function ()
            vim.cmd([[
    nmap <c-c><c-c> <Plug>SlimeCellsSendAndGoToNext
    nmap <c-c><c-Down> <Plug>SlimeCellsNext
    nmap <c-c><c-Up> <Plug>SlimeCellsPrev
    ]])
        end
    },
}
