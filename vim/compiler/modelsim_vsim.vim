" Vim Compiler File
" Compiler: Modelsim Vsim

if exists("current_compiler")
    finish
endif
let current_compiler = "modelsim_vsim"

if exists(":CompilerSet") != 2      " older Vim always used :setlocal
    command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet errorformat=\#\ \*\*\ %tRROR:\ \(vlog\-%*[0-9]\)\ %f(%l):\ %m
"CompilerSet errorformat=#\ \*\*\ %tRROR:\ \(vlog\-%*[0-9]\)\ %f(%l):\ %m,\*\*\ %tRROR:\ %m,\*\*\ %tARNING:\ %m,\*\*\ %tOTE:\ %m,%tRROR:\ %f(%l):\ %m,%tARNING\[%*[0-9]\]:\ %f(%l):\ %m,%tRROR:\ %m,%tARNING\[%*[0-9]\]:\ %m,%-G%.#
