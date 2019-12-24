"if !&compatible
"  set nocompatible
"endif
"
"let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
set noshellslash
let g:vimproc#download_windows_dll = 1
let s:cache_home = expand('~/.vim')
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
let &runtimepath = &runtimepath . "," . s:dein_repo_dir

" プラグインリストを収めた TOML ファイル
" 予め TOML ファイル（後述）を用意しておく
let g:rc_dir    = expand('~/.dotfiles/vim/dein')
let s:toml      = g:rc_dir . '/base.toml'
let s:lazy_toml = g:rc_dir . '/lazy.toml'
let s:my_toml   = g:rc_dir . '/my_plugin.toml'

function! DeinIsInstalled()
    return isdirectory(s:dein_repo_dir)
endfunction

function! s:ReloadTOML()
    if dein#load_state(s:dein_dir)
        call dein#begin(s:dein_dir)

"        call dein#add('Shougo/vimproc.vim', {'build': 'make'})
        " TOML を読み込み、キャッシュしておく
        call dein#load_toml(s:toml)
        call dein#load_toml(s:lazy_toml, {'lazy': 1})
"        call dein#load_toml(s:my_toml)

        " 設定終了
        call dein#end()
        call dein#save_state()
    endif
endfunction
"Deinによるプラグイン設定 {{{1
function! s:InstallPlugins()
    augroup MyAutoCmd
        au!
    augroup END


    call s:ReloadTOML()

endfunction "}}}

" 不足プラグインの自動インストール "{{{1
function! ReloadPlugins()
    "if has('vim_starting') && dein#check_install()
    call s:ReloadTOML()
    if dein#check_install()
        set noshellslash
        call dein#install()
        set shellslash
    endif
    augroup DeinStarter
        au!
        "        autocmd VimEnter * call dein#call_hook('post_source')
    augroup END
endfunction "}}}

" deinがインストールされていない場合、dein自体のインストール関数を定義
" とりあえずプラグイン無しでVimを動かしたいときにdeinに待たされないように手動としている
if !DeinIsInstalled()
    echo "dein.vim is not installed. If you want, run \":call InstallDein()\"."
    function! InstallDein() "{{{1
        set noshellslash
        echo "Installing dein..."
        echo 'git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir)
        call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
        set shellslash
    endfunction
else
    call s:InstallPlugins()
"    call ReloadPlugins()
endif

