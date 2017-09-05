source $VIMRUNTIME/macros/matchit.vim


"カラースキーム {{{1
colorscheme industry
"colorscheme baycomb
"colo solarized

""VimFilerでファイルを開くときにタブで開く
"let g:vimfiler_edit_action = 'tabswitch'

"スニペット {{{1
imap <expr><C-k>
            \ neosnippet#expandable() <Bar><Bar> neosnippet#jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)" : "\<C-n>"

smap <expr><C-k>
            \ neosnippet#expandable() <Bar><Bar> neosnippet#jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)" : "\<C-n>"

xmap <C-k> <Plug>(neosnippet_expand_target)

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
set fillchars=vert:\|
let g:foldCCtext_maxchars=200
let g:foldCCtext_head='v:folddashes. " "'
let g:foldCCtext_tail='printf(" %s[%4d lines Lv%-2d]%s", v:folddashes, v:foldend-v:foldstart+1, v:foldlevel, v:folddashes)'

augroup Git
    autocmd!
    autocmd FileType git setlocal foldtext=fugitive#foldtext()
augroup END

" ステータスラインの設定                                 
"set statusline=%F%m%r%h%w\ %=%{fugitive#statusline()}\ \ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]

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

""アンダーバーをShiftなしで入力(バックスラッシュは右上のBSの左側で) "{{{1
"inoremap \ _
"inoremap _ \

"ConqueGDB "{{{1
let g:ConqueGdb_Leader="<Leader>gd"


"VimDiff by Histogram "{{{1
"set diffexpr=unified_diff#diffexpr()

"Calender "{{{1
let g:calendar_first_day = 'monday'


"DiffChar "{{{1
let g:DiffUnit="Word1"

