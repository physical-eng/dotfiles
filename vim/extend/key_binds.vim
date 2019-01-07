"makeの簡素化
nnoremap <Leader>wm :w<CR>:make<CR>

"Git ショートカット {{{1
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gd :Gvdiff<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>ga :Gwrite<CR>
nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>gc :Git commit<CR>
nnoremap <Leader>gca :Git commit -a<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gt :Git tr<CR>

"スニペット {{{1
"imap <expr><C-k>
"            \ neosnippet#expandable() <Bar><Bar> neosnippet#jumpable() ?
"            \ "\<Plug>(neosnippet_expand_or_jump)" : "\<C-n>"
"
"smap <expr><C-k>
"            \ neosnippet#expandable() <Bar><Bar> neosnippet#jumpable() ?
"            \ "\<Plug>(neosnippet_expand_or_jump)" : "\<C-n>"
"
"xmap <C-k> <Plug>(neosnippet_expand_target)
"
"Ctrl+Eでカーソル下の単語をファイル名として開く {{{1
noremap <C-e> <Nop>
noremap <C-e> :lcd %:h<CR>:e <C-r><C-w><Tab>

"Yで行末までヤンク {{{1
nnoremap Y y$

"<ESC><ESC>でハイライト解除 {{{1
nnoremap <silent> <C-j> :noh<CR>

"挿入モードで",date",',time'で日付、時刻挿入 {{{1
inoremap ,date <C-R>=strftime('%m/%d/%Y')<CR>
"inoremap ,date <C-R>=strftime('%Y/%m/%d (%a)')<CR>
inoremap ,time <C-R>=strftime('%H:%M')<CR>

"挿入モードで",date",',time'で日付、時刻挿入 {{{1
inoremap ,auth  伊東信雄@AVCT

"Ctrl+Cでクリップボードにコピー {{{1
noremap <C-c> <Nop>
vnoremap <C-c> "*y
nnoremap <C-c> "*yy


"VimfilerのIDE風表示 {{{1
let g:vimfiler_enable_auto_cd = 0
nnoremap <silent><Leader>f     :VimFiler -split -toggle -direction=botright -winwidth=70 -no-quit -columns=type:size:time<CR>
nnoremap <silent><Leader>F     :VimFilerBufferDir -split -toggle -direction=botright -winwidth=70 -no-quit -columns=type:size:time<CR>
nnoremap <silent><Leader><C-f> :VimFiler -split -toggle -direction=botright -winwidth=70 -no-quit -columns=type:size:time 

"VimShell {{{1
noremap <F10> <Nop>
nnoremap <F10> :VimShellBufferDir -popup -toggle<CR>
inoremap <F10> <ESC>:VimShellBufferDir -popup -toggle<CR>

noremap <S-F10> <Nop>
nnoremap <S-F10> :VimShellBufferDir -toggle<CR>
inoremap <S-F10> <ESC>:VimShellBufferDir -toggle<CR>

"HDL  {{{1
noremap  <F6> <Nop>
nnoremap <F6> :!vlib R:\\modelsim\\work && vmap work R:\\modelsim\\work<CR>

"grep {{{1
nnoremap * <Nop>
nnoremap * /\<<C-R><C-W>\><CR>:vim /\<<C-R><C-W>\>/ %<CR>

"grep(ディレクトリ) {{{1
nnoremap <C-*> <Nop>
nnoremap <C-*> :CdCurrent<CR>/\<<C-R><C-W>\><CR>:vim /\<<C-R><C-W>\>/ *<CR><C-W><C-J>

"c*でカーソル上の単語を置換 //{{{1
nnoremap <expr> c* ':%s/\(\<' . expand('<cword>') . '\>\)/'

"QuickFix {{{1
autocmd QuickFixCmdPost *grep* :botright cwindow
nnoremap <Leader>p :cprevious<CR>
nnoremap <Leader>n :cnext<CR>
nnoremap <Leader>gg :<C-u>cfirst<CR>
nnoremap <Leader>GG :<C-u>clast<CR>


"Folding {{{1
nnoremap z<S-v> zMzv

"TTで Table Mode {{{1
nnoremap <silent> TT :TableModeToggle<CR>

"F8で下書きバッファ作成 {{{1
nnoremap <silent> <F8> :Scratch<CR>

" Gitv {{{1
nnoremap <C-G><C-l> :Gitv<CR>
nnoremap <Leader>gv :Gitv<CR>
nnoremap <Leader>gl :Gitv<CR>

" Git Merginal
nnoremap <Leader>gm :Merginal<CR>


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


""アンダーバーをShiftなしで入力(バックスラッシュは右上のBSの左側で) "{{{1
"inoremap \ _
"inoremap _ \

"C-nで次の差分へ "{{{1
nnoremap <C-n> ]c
nnoremap <C-p> [c

"3-way Diff "{{{1
nnoremap dr :diffg //2<CR>
nnoremap dl :diffg //3<CR>
