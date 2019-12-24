"挿入モードにおいて jjでESC {{{1
inoremap <silent>jj <ESC>:set iminsert=0<CR>

"挿入モードにおいてCtrl+j で改行 {{{1
inoremap <C-j> <NL>

"挿入モードにおいてCtrl+lでDel {{{1
inoremap <C-l> <Del>

"通常モードで<ESC>でハイライトOFF {{{1
nnoremap <silent> <ESC><ESC> :noh<CR>

"<Leader> {{{1
let mapleader      = "\<Space>"
let maplocalleader = "\<Space>"

"Speed "{{{1
nnoremap <Leader>w <Nop>
nnoremap <Leader>q <Nop>
nnoremap <Leader>o <Nop>

nnoremap <silent><Leader>w :w<CR>
nnoremap <silent><Leader>wq :wq<CR>
nnoremap <silent><Leader>q :q<CR>
nnoremap <silent><Leader>qq :qa<CR>
nnoremap <silent><Leader>qa :qa<CR>
nnoremap <silent><Leader>o :on<CR>

"S-Tabでインデント上げ "{{{1
nnoremap <S-Tab> <ESC><<
inoremap <S-Tab> <ESC><<i

"現在居る行の折りたたみ解除
nnoremap z<S-v> zMzv

filetype off
filetype plugin indent off

"********************************
"       文字コード関係
"****************************"{{{
set encoding=utf-8
set fileencodings=utf-8,cp932,sjis,utf-16le,
set fileformats=unix,dos,mac

set ambiwidth=double
set backspace=indent,eol,start

"}}}

syntax on
set hidden
set autoread

set nf="" "C-aのインクリメント時に8進数表記を10進数として認識

set splitbelow "splitで開く時新しいウィンドウを下に表示する
set splitright "vsplitで開く時新しいウィンドウを右に表示する

set foldmethod=syntax "通常の折りたたみはシンタックス依存
set foldcolumn=5     " 画面の左端に折りたたみ表示用の列を5列表示

set winwidth=100 "カレントウインドウの最低限の幅
set winheight=15 "カレントウインドウの最低限の高さ
set winminwidth=20  "カレント以外のウィンドウの最小幅
set winminheight=1 "カレント以外のウインドウの最小高さ
set display=lastline "長い行も最後まで表示

set pumheight=5 "補完メニューの高さ
set cmdheight=2
set showcmd "入力中のコマンドをステータスラインに表示
set laststatus=2
set scrolloff=10
set history=10000

"対応する括弧へ飛ぶ(showmatch)と、その時間0.1秒単位(matchtime) {{{1
set showmatch
set matchtime=1

set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set number
set nowrap
set colorcolumn=80
set tw=0

set cursorcolumn
set cursorline

"***************************
"        検索設定
"**********************"{{{
set ignorecase
set smartcase
set incsearch
set hlsearch

"}}}
"********************************
"    インデントおよびタブ 
"****************************"{{{
set tabstop=4
set expandtab
set shiftwidth=4
set autoindent

if ((v:version == 704 && has("patch785")) || v:version >= 705)
    set breakindent
endif


"}}}
"********************************
"         入力関係
"****************************"{{{

"コマンド補完時に候補表示 "{{{1
set wildmenu wildmode=list:longest,full 


"IMEを自動OFF "{{{1
set iminsert=0
set imsearch=-1

filetype plugin indent on
"VimDiffでは空白の数の違いを無視 "{{{1
set diffopt=filler,iwhite,context:3

" タブページを常に表示 {{{1
set showtabline=2

"個別のタブの表示設定 {{{1
function! GuiTabLabel()
    " タブで表示する文字列の初期化をします
    let l:label = ''

    " タブに含まれるバッファ(ウィンドウ)についての情報をとっておきます。
    let l:bufnrlist = tabpagebuflist(v:lnum)

    " 表示文字列にバッファ名を追加します
    " パスを全部表示させると長いのでファイル名だけを使います 詳しくは help fnamemodify()
    let l:bufname = fnamemodify(bufname(l:bufnrlist[tabpagewinnr(v:lnum) - 1]), ':t')
    " バッファ名がなければ No title としておきます。ここではマルチバイト文字を使わないほうが無難です
    let l:label .= l:bufname == '' ? 'No title' : l:bufname

    " タブ内にウィンドウが複数あるときにはその数を追加します(デフォルトで一応あるので)
    let l:wincount = tabpagewinnr(v:lnum, '$')
    if l:wincount > 1
        let l:label .= '[' . l:wincount . ']'
    endif

    " このタブページに変更のあるバッファがるときには '[+]' を追加します(デフォルトで一応あるので)
    for bufnr in l:bufnrlist
        if getbufvar(bufnr, "&modified")
            let l:label .= '[+]'
            break
        endif
    endfor

    """
    let l:tabbufnrlist = tabpagebuflist(v:lnum)
    let l:tabbufnr     = l:tabbufnrlist[tabpagewinnr(v:lnum) - 1]
    let l:label    = '(' . l:tabbufnr . '): ' . l:label

    " 表示文字列を返します
    return l:label
endfunction

"" guitablabel に上の関数を設定します
set guitablabel={GuiTabLabel()}
"" guitablabel に上の関数を設定します
"" その表示の前に %N というところでタブ番号を表示させています
set guitablabel=%N%{GuiTabLabel()}

"バイナリ編集(xxd)モード（vim -b での起動、もしくは *.bin ファイルを開くと発動します）
augroup BinaryXXD
    au!
    au BufReadPre  *.bin let &binary =1
    au BufReadPost * if &binary | silent %!xxd -g 1
    au BufReadPost * set ft=xxd | endif
    au BufWritePre * if &binary | %!xxd -r | endif
    au BufWritePost * if &binary | silent %!xxd -g 1
    au BufWritePost * set nomod | endif
augroup END

"QuickFix {{{1
au QuickFixCmdPost *grep* :botright cwindow

"コメント内部での改行時に自動でコメントアウトになる挙動を抑制 {{{1
au FileType * setlocal formatoptions-=ro 

"Git コミットメッセージをUTF-8でエンコード {{{1
au BufRead COMMIT_EDITMSG set fenc=utf8
au BufRead TAG_EDITMSG set fenc=utf8
au BufRead *_EDITMSG set fenc=utf8
au BufRead *_MSG set fenc=utf8


""香り屋版Vimの拡張コマンド {{{1
command! -nargs=1 -complete=file VDsplit vertical diffsplit <args> 
command! -nargs=0 CdCurrent cd %:p:h
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

"Renameコマンドで現在編集中のファイル名を変更 "{{{1
command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))

"" 挿入モードに入る時，前回の挿入モードにおける IME の状態を復元する．
" 挿入モードを出る時，現在の IME の状態を保存し，IME をオフにする．
" Vim 終了時，IME を無効にし，無効にした状態を保存する．
if exists('$TMUX')
    "TMUX経由で制御シーケンスを受け取るには、
    "1シーケンス毎にエスケープが必要
    let &t_SI .= "\ePtmux;\e\e[<0t\e\\"
    let &t_EI .= "\ePtmux;\e\e[<s\e\\"
    let &t_EI .= "\ePtmux;\e\e[<0t\e\\"
    let &t_te .= "\ePtmux;\e\e[<0t\e\\"
    let &t_te .= "\ePtmux;[<s\e\\"
else
    let &t_SI .= "\e[<0t"
    let &t_EI .= "\e[<s"
    let &t_EI .= "\e[<0t"
    let &t_te .= "\e[<0t"
    let &t_te .= "\e[<s"
endif

set ttimeoutlen=100

"まさかのマウス
set mouse=n
if !has('nvim')
    set ttymouse=xterm2
endif
set virtualedit+=all

filetype on
filetype plugin indent on



