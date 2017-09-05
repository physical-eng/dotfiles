if !&compatible
  set nocompatible
endif

"let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:cache_home = expand('~/.vim')
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
let &runtimepath = &runtimepath . "," . s:dein_repo_dir

function! DeinIsInstalled()
    return isdirectory(s:dein_repo_dir)
endfunction

"Deinによるプラグイン設定 {{{1
function! InstallPlugins()
    augroup MyAutoCmd
        au!
    augroup END

    if dein#load_state(s:dein_dir)
        call dein#begin(s:dein_dir)

        " プラグインリストを収めた TOML ファイル
        " 予め TOML ファイル（後述）を用意しておく
        let g:rc_dir    = expand('~/.dotfiles/vim/dein')
        let s:toml      = g:rc_dir . '/dein.toml'
        let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

        " TOML を読み込み、キャッシュしておく
        call dein#load_toml(s:toml)
        call dein#load_toml(s:lazy_toml, {'lazy': 1})

        " 設定終了
        call dein#end()
        call dein#save_state()
    endif

        " 不足プラグインの自動インストール
        if has('vim_starting') && dein#check_install()
            call dein#install()
        endif


    augroup DeinStarter
        au!
        autocmd VimEnter * call dein#call_hook('post_source')
    augroup END

endfunction "}}}

" deinがインストールされていない場合、dein自体のインストール関数を定義
" とりあえずプラグイン無しでVimを動かしたいときにdeinに待たされないように手動としている
if !DeinIsInstalled()
    echo "dein.vim is not installed. If you want, run \":call InstallDein()\"."
    function! InstallDein() "{{{1
        echo "Installing dein..."
        call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
    endfunction
else
    call InstallPlugins()
endif



