if has('win64')
    set pythonthreedll=$VIM/vimfile/python3/python37.dll
    let $PATH = $VIM . "\\vimfile\\python3;" . $VIM . "\\vimfile\\python3\\Scripts;" . $PATH
    let $PYTHONPATH = $VIM . "\\vimfile\\python3\\Lib\\site-packages;" . $VIM . "\\vimfile\\python3\\"
    let g:python3_host_prog = $VIM . "\\vimfile\\python3\\python.exe"
endif

