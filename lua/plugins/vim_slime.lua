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
            nmap <leader>cv <Plug>SlimeConfig
            ]])
        end
    },
    {
        'klafyvel/vim-slime-cells',
        requires = {{'jpalardy/vim-slime', opt=true}},
        ft = {'julia', 'python'},
        config=function ()
            vim.cmd([[
            nmap <leader>cc <Plug>SlimeCellsSendAndGoToNext
            nmap <leader>cj <Plug>SlimeCellsNext
            nmap <leader>ck <Plug>SlimeCellsPrev
            ]])
        end
    },
}
