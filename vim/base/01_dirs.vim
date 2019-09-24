if has('win32')
    let s:basedir=expand("$TEMP/vim")

    if !isdirectory(s:basedir)
        call mkdir(s:basedir)
    endif

    let &directory=s:basedir
endif

if has('persistent_undo')
    let s:basedir=expand("~/.vim/undo")
    if !isdirectory(s:basedir)
        call mkdir(s:basedir)
    endif
    let &undodir=s:basedir
    set undofile
endif

let s:basedir=expand("~/.vim/viminfo/")
if !isdirectory(s:basedir)
    call mkdir(s:basedir)
endif
let &viminfo= &viminfo.",n".expand(s:basedir)."viminfo"

let s:basedir=expand("~/.vim/backup/")
if !isdirectory(s:basedir)
    call mkdir(s:basedir)
endif
let &backupdir=expand(s:basedir)
