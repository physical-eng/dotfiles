let g:quickrun_no_default_key_mappings = 1
nnoremap <Leader>r :cclose<CR>:write<CR>:QuickRun -mode n<CR>
xnoremap <Leader>r :<C-U>cclose<CR>:write<CR>gv:QuickRun -mode v<CR>

nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"
au QuickfixCmdPost make,grep,grepadd,vimgrep copen
let g:quickrun_config = {}

let g:quickrun_config._ = {
\   'runner'    : 'vimproc',
\   'runner/vimproc/updatetime' : 60,
\   'outputter' : 'error',
\   'outputter/error/success' : 'buffer',
\   'outputter/error/error'   : 'quickfix',
\   'outputter/buffer/split'  : ':vertical rightbelow 8sp',
\   'outputter/buffer/close_on_empty' : 1,
\}

" quickrun-vcvarsall {{{
let s:hook = {
\   "name" : "vcvarsall",
\   "kind" : "hook",
\   "config" : {
\       "enable" : 0,
\       "bat" : "",
\   },
\}

function! s:hook.on_module_loaded(session, context)
    if type(a:session.config.exec) == type([])
        let a:session.config.exec[0] = join([self.config.bat, $PROCESSOR_ARCHITECTURE, '\&']) . a:session.config.exec[0]
    else
        let a:session.config.exec = join([self.config.bat, $PROCESSOR_ARCHITECTURE, '\&']) . a:session.config.exec
    endif
endfunction


call quickrun#module#register(s:hook, 1)
unlet s:hook
" }}}

"let g:quickrun_config = {'*': {'hook/time/enable': '1'},}
"let g:quickrun_config.markdown = {
"      \ 'outputter' : 'null',
"      \ 'command'   : 'pandoc',
"      \ 'cmdopt'    : '--indented-code-classes=verilog,c -o',
"      \ 'args'      : '',
"      \ 'exec'      : '%c -f %s %o %s:r.html',
"      \ }
""      \ 'exec'      : '%c -f markdown_phpextra %s --toc %o %s:r.docx',
"
"let g:quickrun_config.timingchart = {
"      \ 'outputter' : 'null',
"      \ 'command'   : 'tcbmp',
"      \ 'cmdopt'    : '',
"      \ 'args'      : '',
"      \ 'exec'      : '%c %s',
"      \ }
"
"let g:quickrun_config['cpp/msvc2019'] = {
"      \ "command" : "cl",
"      \ "exec"    : ['%c %o %s', '%s:p:r.exe %a'],
"      \ "cmdopt"  : "/EHsc",
"      \ "hook/output_encode/encoding" : "sjis",
"      \ "hook/vcvarsall/enable" : 1,
"      \ "hook/vcvarsall/bat" : shellescape($VS160COMNTOOLS  . '..\..\VC\Auxiliary\Build\vcvarsall.bat'),
"      \   }
"
