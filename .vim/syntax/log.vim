" Vim syntax file
" Language:          Generic log files
" Maintainer:        Alex Dzyoba <avd@reduct.ru>
" Lastest Revision:  2013-03-08
" Changes:           2013-03-08 Initial version

" Based on messages.vim -syntax file for highlighting kernel messages

if exists("b:current_syntax")
		finish
endif

syn match   log_error    '\c.*\<\(FATAL\|ERROR\|ERRORS\|FAIL\|FAILED\|FAILURE\|SPRD_Error_P0\|UVM_FAIL\|UVM_ERROR\).*'
syn match   log_warning  '\c.*\<\(WARNING\|RETRY\|RETRYING\|SPRD_Error_P2\).*'
syn match   log_number   '0x[0-9a-fA-F]*\|\[<[0-9a-f]\+>\]\|\<\d[0-9a-fA-F]*'

syn match   log_date     '\(Jan\|Feb\|Mar\|Apr\|May\|Jun\|Jul\|Aug\|Sep\|Oct\|Nov\|Dec\) [ 0-9]\d *'
syn match   log_date     '\d\{4}-\d\d-\d\d'

syn match   log_time     '\d\d:\d\d:\d\d\s*'
syn match   log_time     '\c\d\d:\d\d:\d\d\(\.\d\+\)\=\([+-]\d\d:\d\d\|Z\)'

syn region  log_string   start=/'/ end=/'/ end=/$/ skip=/\\./
syn region  log_string   start=/"/ end=/"/         skip=/\\./

hi def link log_string   String
hi def link log_number   Number
hi def link log_date     Constant
hi def link log_time     Type

"hi def link log_error   ErrorMsg
"hi def link log_warning WarningMsg

hi def log_error         ctermfg=red     guifg=red
hi def log_warning       ctermfg=yellow  guifg=yellow
hi def log_info          ctermfg=green   guifg=green

let b:current_syntax = "log"


