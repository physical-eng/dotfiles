augroup GitvSetting
    au!
    autocmd FileType gitv call s:my_gitv_settings()
augroup END


"Gitv上でハッシュを取得する
function! GitvGetCurrentHash()
    return matchstr(getline('.'), '\[\zs.\{7\}\ze\]$')
endfunction

function! s:my_gitv_settings()
    " ここに設定を書く
    setlocal iskeyword+=/,-,.
    nnoremap <silent><buffer> C :<C-u>Git checkout <C-r><C-w><CR>

    nnoremap <buffer> <Space>r :<C-u>Git rebase -i <C-r>=GitvGetCurrentHash()<CR><Space>
    nnoremap <buffer> <Space>rb :<C-u>Git rebase -i <C-r>=GitvGetCurrentHash()<CR>
    nnoremap <buffer> <Space>R :<C-u>Git revert <C-r>=GitvGetCurrentHash()<CR><CR>
    nnoremap <buffer> <Space>p :<C-u>Git cherry-pick <C-r>=GitvGetCurrentHash()<CR><CR>
    nnoremap <buffer> <Space>rh :<C-u>Git reset --hard <C-r>=GitvGetCurrentHash()<CR> 
endfunction
