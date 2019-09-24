" TODOファイル
command! Todo edit ~/Markdown/todo.txt

function! s:open_memo_file()"
    let l:category = input('Category: ')
    let l:title = input('Title: ')

    if l:category == ""
        let l:category = "other"
    endif

    let l:memo_dir = $HOME . '/Markdown/Memo/vim/' . l:category
    if !isdirectory(l:memo_dir)
        call mkdir(l:memo_dir, 'p')
    endif

    let l:filename = l:memo_dir . strftime('/%Y%m%d%H%M%S_') . l:title . '.txt'

    let l:template = [
                \'# Title :'. l:title,
                \'-----',
                \'Category: ' . l:category,
                \'date: ' . strftime('%Y/%m/%d %H:%M:%S'),
                \'-----',
                \'',
                \]

    " ファイル生成
    execute 'tabnew ' . l:filename
    call setline(1, l:template)
    execute '999'
    execute 'write'
endfunction

" メモを作成するコマンド
command! -nargs=0 MemoNew call s:open_memo_file()
