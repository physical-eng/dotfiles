if has('win64')
    set pythonthreedll=$VIM/python3/python37.dll
    let $PATH = $VIM . "\\python3;" . $VIM . "\\python3\\Scripts;" . $PATH
    let $PYTHONPATH = $VIM . "\\python3\\Lib\\site-packages;" . $VIM . "\\python3\\"
    let g:python3_host_prog = $VIM . "\\python3\\python.exe"
endif

