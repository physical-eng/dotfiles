augroup mySyntaxRange
    autocmd!
augroup END

autocmd mySyntaxRange BufNewFile,BufRead dein*.toml call s:syntax_range_dein()

function! s:syntax_range_dein() abort
  let start = '^\s*hook_\%('.
  \           'add\|source\|post_source\|post_update'.
  \           '\)\s*=\s*%s'

  call SyntaxRange#Include(printf(start, "'''"), "'''", 'vim', '')
  call SyntaxRange#Include(printf(start, '"""'), '"""', 'vim', '')
endfunction
