function! GitBash()
    :CdCurrent
    " 日本語Windowsの場合`ja`が設定されるので、入力ロケールに合わせたUTF-8に設定しなおす
    let l:env = {
                \ 'LANG': systemlist('"C:/Program Files/Git/usr/bin/locale.exe" -iU')[0],
                \ }

    " remote連携のための設定
    if has('clientserver')
        call extend(l:env, {
                    \ 'GVIM': $VIMRUNTIME,
                    \ 'VIM_SERVERNAME': v:servername,
                    \ })
    endif

    " term_startでgit for windowsのbashを実行する
    call term_start(['C:/Program Files/Git/bin/bash.exe', '-l'], {
                \ 'term_name': 'Git',
                \ 'term_finish': 'close',
                \ 'env': l:env,
                \ })

endfunction

nnoremap <Leader>tg :<C-u>call GitBash()<CR>
