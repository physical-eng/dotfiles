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
    au ColorScheme * hi CursorLine   cterm=underline gui=underline guibg=#3F3F3F

    "折り返しの代わりにハイライト
    au ColorScheme * hi ColorColumn ctermbg=237

    " コメントハイライト 設定 {{{2
    au ColorScheme * highlight Comment ctermfg=darkgreen guifg=#00FF00

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

    "特殊文字の色設定 {{{2
    au ColorScheme,GUIEnter * hi NonText    ctermbg=NONE ctermfg=59 guibg=NONE guifg=NONE
    au ColorScheme,GUIEnter * hi SpecialKey ctermbg=NONE ctermfg=59 guibg=NONE guifg=NONE
    "}}}2
augroup END
"}}}1

let s:colorscheme='slate'

colo slate
