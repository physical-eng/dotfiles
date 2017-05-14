source $VIMRUNTIME/macros/matchit.vim

filetype plugin indent on

set backspace=indent,eol,start

set cursorcolumn
set cursorline

set ignorecase

set incsearch
set hlsearch
set number
set nowrap
set tabstop=4
set autoindent
set expandtab
set shiftwidth=4
"set breakindent
set tw=0
set encoding=utf-8
"set fileencodings=sjis
set fileencodings=utf-8,sjis
set fileformats=unix,dos,mac

set ambiwidth=double

"コマンド補完時に候補表示 "{{{1
set wildmenu

"IMEを自動OFF "{{{1
set iminsert=0
set imsearch=-1

""香り屋版Vimの拡張コマンド {{{1
command! -nargs=1 -complete=file VDsplit vertical diffsplit <args> 
command! -nargs=0 CdCurrent cd %:p:h
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

"コメント内部での改行時に自動でコメントアウトになる挙動を抑制 {{{1
au FileType * setlocal formatoptions-=ro 

"256 Color
set t_Co=256

" タブページを常に表示 {{{1
set showtabline=2

"Verilogのみ折りたたみをマーカーで {{{1
au BufRead *.v set foldmethod=marker
au BufRead *.sv set foldmethod=marker
au BufRead .vimrc set foldmethod=marker
set foldmethod=syntax

"カラースキーム {{{1
colorscheme industry
"colorscheme baycomb
"colo solarized
set background=dark

"vsplitで開く時新しいウィンドウを右に表示する "{{{
set splitright

"カーソルの色 {{{1
hi CursorColumn ctermbg=9
hi CursorLine   cterm=underline

"Git コミットメッセージをUTF-8でエンコード {{{1
au BufRead COMMIT_EDITMSG set fenc=utf8
au BufRead TAG_EDITMSG set fenc=utf8
au BufRead *_EDITMSG set fenc=utf8
au BufRead *_MSG set fenc=utf8

"スニペット {{{1
imap <expr><C-k>
            \ neosnippet#expandable() <Bar><Bar> neosnippet#jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)" : "\<C-n>"

smap <expr><C-k>
            \ neosnippet#expandable() <Bar><Bar> neosnippet#jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)" : "\<C-n>"

xmap <C-k> <Plug>(neosnippet_expand_target)

"長い行も最後まで表示 {{{1
set display=lastline

"補完メニューの高さ {{{1
set pumheight=10

"対応する括弧へ飛ぶ(showmatch)と、その時間0.1秒単位(matchtime) {{{1
set showmatch
set matchtime=1

".vh,.vtのファイルをSystemVerilogとして認識 {{{1
au BufRead,BufNewFile *.vh set filetype=verilog_systemverilog
au BufRead,BufNewFile *.vt set filetype=verilog_systemverilog

".vb.bas, vb.clsのファイルをVBとして認識 {{{1
au BufRead,BufNewFile *.vb.bas set filetype=VB
au BufRead,BufNewFile *.vb.cls set filetype=VB

".tcのファイルをTiming Chartとして認識 {{{1
au BufRead,BufNewFile *.tc set filetype=timingchart

"vim-tex {{{1
let g:vimtex_view_general_viewer = 'texworks'
let g:vimtex_latexmk_options = '-pdfdvi'

"Choose Win {{{1
" オーバーレイ機能を有効にする。
let g:choosewin_overlay_enable = 1

" オーバーレイ時、マルチバイト文字を含むバッファで、ラベル文字が崩れるのを防ぐ
let g:choosewin_overlay_clear_multibyte = 1

"Ctags {{{1
set tags=tags

"TagList
let Tlist_Show_One_File = 0 "現在編集中のソースのタグしか表示しない
let Tlist_Show_Menu = 0

"QuickFix {{{1
autocmd QuickFixCmdPost *grep* cwindow

"Quick Run {{{1
"let g:quickrun_config = {'*': {'hook/time/enable': '1'},}
let g:quickrun_config = {}
let g:quickrun_config.markdown = {
      \ 'outputter' : 'null',
      \ 'command'   : 'pandoc',
      \ 'cmdopt'    : '--indented-code-classes=verilog,c -o',
      \ 'args'      : '',
      \ 'exec'      : '%c -f %s %o %s:r.html',
      \ }
"      \ 'exec'      : '%c -f markdown_phpextra %s --toc %o %s:r.docx',

let g:quickrun_config.timingchart = {
      \ 'outputter' : 'null',
      \ 'command'   : 'tcbmp',
      \ 'cmdopt'    : '',
      \ 'args'      : '',
      \ 'exec'      : '%c %s',
      \ }

"Syntastic {{{1
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list = 1
let g:syntastic_debug=0
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"Folding {{{1
set foldtext=FoldCCtext()
set foldcolumn=5
set fillchars=vert:\|
nnoremap z<S-v> zMzv

" 個別のタブの表示設定をします                                                                     {{{1
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

set guitablabel=%{GuiTabLabel()}

"" guitablabel に上の関数を設定します
"" その表示の前に %N というところでタブ番号を表示させています
set guitablabel=%N%{GuiTabLabel()}


" ステータスラインの設定                                 
"set statusline=%F%m%r%h%w\ %=%{fugitive#statusline()}\ \ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set statusline=%F%m%r%h%w\ %=%{fugitive#statusline()}\ \ [%Y,%{&ff}]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2

"HDL Plugin Header {{{1
let g:HDL_Company = "AVC Technology Co., Ltd."
let g:HDL_Author  = "Nobuo Ito"

"------------------------------------------------------------------------
"Function    : AddFileInformation() 
"Decription  : Add File Header 
"------------------------------------------------------------------------
function! AddFileInformation()
    if Check_File_Type() == 1
        let comment = "--"
        let others = "library ieee;\nuse ieee.std_logic_1164.all;\nuse ieee.std_logic_arith.all;\n"
                    \."use ieee.std_logic_unsigned.all;\n\n"
    elseif Check_File_Type() == 2 
        let comment = "//"
        let others = ""
    elseif Check_File_Type() == 3 
        let comment = "\""
        let others = ""
        "if you want add other file type ,then add in here 
        "    elseif file_type_temp == ""
        "        let comment = ""
        "        let others = ""
    else 
        let comment = ""
        let others = ""
    endif
    let header =  comment."############################################################################################{{{\n"
                \.comment."# Created by\t\t: ".g:HDL_Company."\n"
                \.comment."# Filename\t\t: ".expand("%:t")."\n"
                \.comment."# Author\t\t\t: ".g:HDL_Author."\n"
                \.comment."# Created On\t\t: ".strftime("%Y-%m-%d %H:%M")."\n"
                \.comment."# Last Modified\t: \n"
                \.comment."# Version\t\t\t: v1.0\n"
                \.comment."# Description\t\t: \n"
                \.comment."#\t\t\t\t\t\t\n"
                \.comment."#\t\t\t\t\t\t\n"
                \.comment."#-------------------------------------------------------------------------------------------\n"
                \.comment."# Revision History\n"
                \.comment."#-------------------------------------------------------------------------------------------{{{\n"
                \.comment."# Date       | Author \t| Description \n"
                \.comment."#-------------------------------------------------------------------------------------------\n"
                \.comment."# ".strftime("%Y/%m/%d")." | ".g:HDL_Author."\t| File Create\n"
                \.comment."#-------------------------------------------------------------------------------------------}}}\n"
                \.comment."#\t\t\t\t\t\t\n"
                \.comment."############################################################################################\n"
                \."\n"
                \.others
    exe "ks"
    exe "normal gg"
    silent put! =header
    exe "'s"
endfunction

" Graphviz  {{{1
let g:WMGraphviz_output = 'svg'

if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.dot = '\%(=\|,\|\[\)\s*\w*'

"\ 'exec'                           : ['%c -T png %s -o %s:r.png', 'start %s:r.png'],


let g:quickrun_config['dot'] = {
            \ 'hook/cd/directory'              : '%S:p:h',
            \ 'command'                        : 'dot', 
            \ 'cmdopt'                         : '',
            \ 'exec'                           : ['%c -T png %s -o %s:r.png'],
            \ 'outputter/quickfix/errorformat' : 'Error: %f: %m in line %l %.%#,%EError: %m,%C%m,%Z%m'
            \}



" コメントハイライト 設定 {{{1
syn match   myTodo   contained   "\<\(TBD\|TODO\|FIXME\):"
hi def link myTodo Todo

"拡張子 md をMarkDownとして認識 {{{1
au BufRead *.md set filetype=markdown
au BufRead *.txt set filetype=markdown
au BufNewFile *.txt set filetype=markdown fenc=utf-8 ff=unix
au BufNewFile *.md set filetype=markdown fenc=utf-8 ff=unix

"Table ModeのフォーマットをMarkDown互換に {{{1
let g:table_mode_corner="|" 

"PreVimのリアルタイム表示 {{{1
let g:previm_enable_realtime = 1

"Tex quick run {{{1


" LaTeX Quickrun {{{1
let g:quickrun_config['tex'] = {
            \ 'command' : 'latexmk',
            \ 'outputter' : 'error',
            \ 'outputter/error/success' : 'null',
            \ 'outputter/error/error' : 'quickfix',
            \ 'cmdopt': '-pdfdvi',
            \ 'exec': '%c %o %a %s',
            \}

""Verilog Quickrun {{{1
"let g:quickrun_config['verilog'] = {
"            \ 'command' : 'verilator',
"            \ 'outputter' : 'error',
"            \ 'outputter/error/success' : 'null',
"            \ 'outputter/error/error' : 'quickfix',
"            \ 'cmdopt': '--lint-only',
"            \ 'exec': '%c %o %a %s',
"            \}
"
"
" Gitv {{{1
nnoremap <C-G><C-l> :Gitv<CR>
nnoremap <Leader>gv :Gitv<CR>
nnoremap <Leader>gl :Gitv<CR>

"Git flow コマンド {{{1
command! -nargs=+ -complete=custom,GitFlowCommand Gflow :Git flow <args> 
nnoremap <Leader>gf :Gflow 

fun! GitFlowCommand(A,L,P)
    let coms =     "feature"."\n" 
                \. "release"."\n" 
                \. "hotfix"
    let feature_args = "start"."\n"."finish"."\n"."publish"."\n"."pull"
    let release_args = "start"."\n"."finish"."\n"."publish"
    let hotfix_args  = "start"."\n"."finish" 

    let command_args = split(a:L," ")

    if     ( len( command_args ) <  2 ) | return coms 
    elseif ( len( command_args ) <  4 ) 
        if      command_args[1] == "feature" | return feature_args
        elseif  command_args[1] == "release" | return release_args
        elseif  command_args[1] == "hotfix"  | return hotfix_args
        else                                 | return coms
        endif
    endif
endfun

"AGit {{{1
let g:agit_stat_width=45
command! AgitReload <Plug>(agit-reload)

"Committia {{{1

"S-Tabでインデント上げ "{{{
nnoremap <S-Tab> <ESC><<
inoremap <S-Tab> <ESC><<i

"}}}

syntax on

"Renameコマンドで現在編集中のファイル名を変更 "{{{1
command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))

""差分表示の色設定 "{{{1
"highlight DiffAdd    cterm=bold ctermfg=15 ctermbg=0  guifg=#DDDDDD guibg=#0000FF
"highlight DiffDelete cterm=bold ctermfg=14 ctermbg=0  guifg=#DDDDDD guibg=#0000FF
"highlight DiffChange cterm=bold ctermfg=13 ctermbg=0  guifg=#DDDDDD guibg=#000077
"highlight DiffText   cterm=bold ctermfg=12 ctermbg=0  guifg=#DDDDDD guibg=#a0522d

"Tab Color
highlight TabLineSel ctermfg=Black ctermbg=White
highlight TabLine    ctermfg=white ctermbg=Black

""アンダーバーをShiftなしで入力(バックスラッシュは右上のBSの左側で) "{{{1
"inoremap \ _
"inoremap _ \

"ConqueGDB "{{{1
let g:ConqueGdb_Leader="<Leader>gd"

"VimDiffでは空白の数の違いを無視 "{{{1
set diffopt=filler,iwhite,context:3

"VimDiff by Histogram "{{{1
"set diffexpr=unified_diff#diffexpr()

"Calender "{{{1
let g:calendar_first_day = 'monday'

"C-aのインクリメント時に8進数表記を10進数として認識 "{{{1
set nf=""

"DiffChar "{{{1
let g:DiffUnit="Word1"

"バイナリ編集(xxd)モード（vim -b での起動、もしくは *.bin ファイルを開くと発動します）
augroup BinaryXXD
  autocmd!
  autocmd BufReadPre  *.bin let &binary =1
  autocmd BufReadPost * if &binary | silent %!xxd -g 1
  autocmd BufReadPost * set ft=xxd | endif
  autocmd BufWritePre * if &binary | %!xxd -r | endif
  autocmd BufWritePost * if &binary | silent %!xxd -g 1
  autocmd BufWritePost * set nomod | endif
augroup END

"新規ウィンドウを下に開く "{{{1
set splitbelow

"VimFilerでファイルを開くときにタブで開く
let g:vimfiler_edit_action = 'tabswitch'
