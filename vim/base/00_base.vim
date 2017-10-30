"挿入モードにおいて jjでESC {{{1
inoremap jj <ESC>

"挿入モードにおいてCtrl+j で改行 {{{1
inoremap <C-j> <NL>

"挿入モードにおいてCtrl+lでDel {{{1
inoremap <C-l> <Del>

"<Leader> {{{1
let mapleader      = "\<Space>"
let maplocalleader = "\<Space>"

"Speed "{{{1
nnoremap <Leader>w <Nop>
nnoremap <Leader>q <Nop>
nnoremap <Leader>o <Nop>

nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>qq :qa<CR>
nnoremap <Leader>qa :qa<CR>
nnoremap <Leader>o :on<CR>

"S-Tabでインデント上げ "{{{1
nnoremap <S-Tab> <ESC><<
inoremap <S-Tab> <ESC><<i

"現在居る行の折りたたみ解除
nnoremap z<S-v> zMzv

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
set winminheight=10 "カレント以外のウインドウの最小高さ
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
"       文字コード関係           
"****************************"{{{
set encoding=utf-8
set fileencodings=utf-8,cp932,sjis
set fileformats=unix,dos,mac

set ambiwidth=double
set backspace=indent,eol,start

"}}}
"********************************
"         入力関係
"****************************"{{{

"コマンド補完時に候補表示 "{{{1
set wildmenu wildmode=list:longest,full 


"IMEを自動OFF "{{{1
set iminsert=0
set imsearch=-1

"********************************
"        色設定 
"********************************
"256 Color
set t_Co=256

set background=dark


"ハイライト関係の設定 "{{{1
augroup MyColorScheme
    au!

    "カーソルの色 {{{2
    au ColorScheme * hi CursorColumn ctermbg=8
    au ColorScheme * hi CursorLine   cterm=underline

    " コメントハイライト 設定 {{{2
    au ColorScheme * highlight Comment ctermfg=darkgreen guifg=#008800

    " コメントキーワードハイライト 設定 {{{2
    au ColorScheme * syn match   myTodo   contained   "\<\(TBD\|TODO\|FIXME\):"
    au ColorScheme * hi def link myTodo Todo

    "ビジュアルモードハイライト設定 {{{2
    au ColorScheme * highlight Visual  cterm=NONE ctermbg=236

    "アクティブなタブ/ステータスラインの設定 {{{2
    au ColorScheme * hi TabLineSel cterm=bold ctermfg=cyan ctermbg=236  guifg=#000000 guibg=#777777
    au ColorScheme * hi StatusLine cterm=bold ctermfg=cyan ctermbg=236  guifg=#000000 guibg=#777777

    "非アクティブなタブ/ステータスラインの設定 {{{2
    au ColorScheme * hi TabLine       cterm=NONE ctermfg=250 ctermbg=233 
    au ColorScheme * hi StatusLineNC  cterm=NONE ctermfg=250 ctermbg=233 
    "}}}2
augroup END


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

"拡張子 md をMarkDownとして認識 {{{1
au BufRead *.md set filetype=markdown
au BufRead *.txt set filetype=markdown
au BufNewFile *.txt set filetype=markdown fenc=utf-8 ff=unix
au BufNewFile *.md set filetype=markdown fenc=utf-8 ff=unix

"拡張子 plt をgnuplotファイルとして認識 {{{1
au BufRead, BufNewFile *.plt set filetype=gnuplot

"Verilog/vimrcは折りたたみをマーカーで {{{1
au BufRead *.vim setlocal foldmethod=marker
au BufRead *.v setlocal foldmethod=marker
au BufRead *.sv setlocal foldmethod=marker
au BufRead .vimrc setlocal foldmethod=marker

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

"まさかのマウス
set mouse=n
set ttymouse=xterm2
set virtualedit+=all
