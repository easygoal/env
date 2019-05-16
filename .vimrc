" ========================================
" general settings
" ========================================
set nocompatible 
filetype off
set nosol	"跳转到其他行时不跳转到相应列的开头
set cin
set sm
set cino=:0g0t0(sus
set lbr	"linebreak在列的最右边单词可以断开显示
set backspace=indent,eol,start
set whichwrap=b,s,<,>,[,]
set fo+=mB
set noet	"不展开tab为空格
set selectmode=
set mousemodel=popup
set keymodel=
set selection=inclusive
set tabstop=4	"设置tab占4个空格
set softtabstop=4
set mousehide	"当输入文字时自动隐藏鼠标
set ru	"显示行和列的信息
set scrolljump=-50	"保持光标在中间
set scrolloff=0
set autochdir	"打开文件、切换缓冲区、删除缓冲区或者打开/关闭窗口时改变当前工作目录的值。

if has ('win32') || has ('win64')
  let $CHERE_INVOKING=1
  set shell=c:\cygwin\bin\bash.exe
  set shellcmdflag=--login\ -c
  set shellxquote=\"             "default value is (, but bash needs "
  set shellslash
  "set makeprg=mingw32-make	"说明:make时使用的程序
endif

set cindent shiftwidth=4	"自动缩进
set autoindent shiftwidth=4
set isfname+={,}
set isfname-=61		"61代表=
set isfname-=\44		"44代表,
set ignorecase	"忽略大小写
set is	"incsearc增量查找
set scs	"smartcase查找时智能大小写,如果输入中有大小写就不忽略大写
set lsp=0	"linespace在边上留一点空间（便于阅读）
set wildmenu	"当在命令行输入命令时以菜单形式显示可能选项
set wildignore=*.bak,*.o,*.e,*~
set viminfo='1000,f1,<500,:500
set hls
syntax enable
syntax on
set nu
set undofile "持久性撤销
set undolevels=500 "可以撤销的最大改变次数
if has('win32') || has('win64')
	set undodir=d:\Vim\backup
else
	set undodir=~/.vim/backup
endif
set history=100 "记住历史命令100个
" set list	"显示控制字符
set laststatus=2	"总显示状态行
" set showmode	"总显示命令或插入模式
" set shortmess=lnrxI	"简略消息，不要显示介绍
" set showcmd	"显示部分命令
" set more	"使用页调度程序来显示长列表
"set vertical and horizontal line cursor
set cursorline
"set cursorcolumn
highlight CursorLine   guibg=darkgrey guifg=lightgrey ctermbg=lightred
highlight CursorColumn guibg=darkgrey guifg=lightgrey ctermbg=lightred
highlight DiffAdd      ctermbg=235 ctermfg=108 guibg=#262626 guifg=#87af87 cterm=reverse gui=reverse
highlight DiffChange   ctermbg=235 ctermfg=103 guibg=#262626 guifg=#8787af cterm=reverse gui=reverse
highlight DiffDelete   ctermbg=235 ctermfg=131 guibg=#262626 guifg=#af5f5f cterm=reverse gui=reverse
highlight DiffText     ctermbg=235 ctermfg=208 guibg=#262626 guifg=#ff8700 cterm=reverse gui=reverse

" 标签上只显示文件名，不显示路径
function! ShortTabLabel ()
	let bufnrlist = tabpagebuflist (v:lnum)
	let label = bufname (bufnrlist[tabpagewinnr (v:lnum) -1])
	let filename = fnamemodify (label, ':t')
	return filename
endfunction
set guitablabel=%{ShortTabLabel()}

"au FileType vhdl set fo-=cro|set comments=:--
"set mapleader
let mapleader = ","

set tags=tags
"set autochdir


" 在文件名上按gf时，在新的tab中打开
map gf :tabnew <cfile><cr>

"enable renderoptions
if has('win32') || has('win64')
    if (v:version == 704 && has("patch393")) || v:version > 704
        set renderoptions=type:directx,level:0.50,
                    \gamma:1.0,contrast:0.0,geom:1,renmode:5,taamode:1
    end
end

" 缩写
iab idate <c-r>=strftime("%Y-%m-%d")<CR>
iab itime <c-r>=strftime("%H:%M")<CR>
iab igmail easygoa@gmail.com
iab iname Guoyou Jiang

"--------------------------------------------------------------------------- 
" plugin - Vundle.vim  
"--------------------------------------------------------------------------- 
if has('win32') || has ('win64')
	" This path is for gVimPortable
	set  rtp+=$VIM\..\..\Data\settings\vimfiles/bundle/Vundle.vim
	call vundle#begin('$VIM\..\..\Data\settings\vimfiles\bundle\')
else
	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin()
	"	set runtimepath+=~/.vim/bundle/powerline/powerline/bindings/vim
endif
Plugin 'VundleVim/Vundle.vim'

" My Bundles here:
" vim-scripts repos

Plugin 'tmux-plugins/vim-tmux-focus-events'
Plugin 'roxma/vim-tmux-clipboard'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-fugitive'

"Plugin 'vim-scripts/OutlookVim'
"Plugin 'guyzmo/notmuch-abook'

" Verilog mode
Plugin 'zhuzhzh/verilog_emacsauto.vim'

" Syntax
"Plugin 'asciidoc.vim'
"Plugin 'confluencewiki.vim'
"Plugin 'html5.vim'
"Plugin 'JavaScript-syntax'
"Plugin 'mako.vim'
"Plugin 'moin.vim'
"Plugin 'python.vim--Vasiliev'
"Plugin 'xml.vim'

" Lint
Plugin 'w0rp/ale'

" Color
"Plugin 'desert256.vim'
"Plugin 'Impact'
"Plugin 'matrix.vim'
"Plugin 'vibrantink'
"Plugin 'vividchalk.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'altercation/vim-colors-solarized'
Plugin 'Pychimp/vim-luna'
Plugin 'sjl/badwolf'
Plugin 'Wombat'
Plugin 'tomasr/molokai'
Plugin 'chriskempson/vim-tomorrow-theme'
Plugin 'chriskempson/base16-vim'
Plugin 'Pychimp/vim-sol'
Plugin 'morhetz/gruvbox'

" Ftplugin
"Plugin 'python_fold'

" Indent
"Plugin 'indent/html.vim'
"Plugin 'IndentAnything'
"Plugin 'Javascript-Indentation'
"Plugin 'mako.vim--Torborg'
"Plugin 'gg/python.vim'

" Plugin
Plugin 'mileszs/ack.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

"Plugin 'lifepillar/vim-mucomplete'  "自动补齐
Plugin 'ConradIrwin/vim-bracketed-paste'
Plugin 'Shougo/neocomplcache'
Plugin 'Shougo/neosnippet'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'The-NERD-tree'
Plugin 'junegunn/vim-easy-align'
Plugin 'mattn/calendar-vim'
Plugin 'a.vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'tpope/vim-surround'
Plugin 'kien/ctrlp.vim'
Plugin 'MultipleSearch'
Plugin 'bufexplorer.zip'
Plugin 'WeiChungWu/vim-SystemVerilog'
Plugin 'TxtBrowser'
Plugin 'automatic-for-Verilog'
Plugin 'VisIncr'
Plugin 'winmanager'
Plugin 'cskeeters/vim-calutil'
Plugin 'mbbill/fencview'
Plugin 'matrix.vim'
Plugin 'mru.vim'
Plugin 'taglist.vim'
Plugin 'matchit.zip'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
"Plugin 'verilog_systemverilog_fix'
"Plugin 'scrooloose/vim-statline'
"Plugin 'kdurant/verilog-testbench'
"Plugin 'msanders/snipmate'
"Plugin 'SirVer/ultisnips'
"Plugin 'tpope/vim-repeat'
"Plugin 'AutoClose--Alves'
"Plugin 'auto_mkdir'
"Plugin 'cecutil'
"Plugin 'fcitx.vim'
"Plugin 'FuzzyFinder'
"Plugin 'jsbeautify'
"Plugin 'L9'
"Plugin 'Mark'
"Plugin 'The-NERD-Commenter'
"Plugin 'project.vim'
"Plugin 'restart.vim'
"Plugin 'templates.vim'
"Plugin 'vimim.vim'
"Plugin 'ZenCoding.vim'
"Plugin 'css_color.vim'
"Plugin 'hallettj/jslint.vim'

call vundle#end()
filetype plugin indent on
"----------------------END Vundle.vim--------------------------------------

"Mapping for copy and paste
"vnoremap y y`]
"noremap p jmzP`zk
vmap / y/<C-R>"<CR>

if has("win32")
	set tags+=$VIM\vimfiles\tags\ovm.tags
	"set tags+="$VIM\vimfiles\tags\libc.tags"
	"set tags+="$VIM\vimfiles\tags\glib.tags"
	"set tags+="$VIM\vimfiles\tags\cpp.tags"
endif

" 打开文件时光标自动到上次退出该文件时的光标所在位置
"autocmd BufReadPost * if line("'\"") && line("'\"") <= line("$") | exe "normal`\"" | endif
" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
	au BufReadPost * if line("`\"") > 1 && line("`\"") <= line("$") | exe "normal! g`\"" | endif
	" for simplicity, "  au BufReadPost * exe "normal! g`\"", is Okay.
endif


"--------------------------------------------------------------
" backup settings
"--------------------------------------------------------------
if has("win32")
	" for windows
	set backup
	set backupext=.bak
	set dir=d:\Vim\tmp\
	set backupdir=d:\Vim\tmp
	set directory=d:\Vim\tmp
	set makeef=error.err
else
	" for linux
	"set backup
	"set backupext=.bak
	"set dir=/tmp/vim
	"set backupdir=/tmp/vim
	"set directory=/tmp/vim
	"set makeef=error.err
endif

" ========================================
" 编码设置
" ========================================
"if has("multi_byte")
"     " Set fileencoding priority
"     if getfsize(expand("%")) > 0
"         set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,UTF16LE,UTF16,latin1
"     else
"         set fileencodings=utf8,GB18030,big5,euc-jp,euc-kr,latin1
"     endif
"
"     " CJK environment detection and corresponding setting
"     if v:lang =~ "^zh_CN"
"         " Use cp936 to support GBK, euc-cn == gb2312
"         set encoding=cp936
"         set termencoding=cp936
"         set fileencoding=cp936
"     elseif v:lang =~ "^zh_TW"
"         " cp950, big5 or euc-tw
"         " Are they equal to each other?
"         set encoding=big5
"         set termencoding=big5
"         set fileencoding=big5
"     elseif v:lang =~ "^ko"
"         " Copied from someone's dotfile, untested
"         set encoding=euc-kr
"         set termencoding=euc-kr
"         set fileencoding=euc-kr
"     elseif v:lang =~ "^ja_JP"
"         " Copied from someone's dotfile, unteste
"         set encoding=euc-jp
"         set termencoding=euc-jp
"         set fileencoding=euc-jp
"     endif
"     " Detect UTF-8 locale, and replace CJK setting if needed
"     if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
"         set encoding=utf-8
"         set termencoding=utf-8
"         set fileencoding=utf-8
"     endif
"else
"     echoerr "Sorry, this version of (g)vim was not compiled with multi_byte"
"endif

"vim-airline needs utf-8
set encoding=utf-8  
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,UTF16LE,UTF16,latin1

" 设置编码为utf-8
:nmap ,eu :set encoding=utf-8<CR>
:nmap ,es :set encoding=cp936<CR>
:nmap ,et :set encoding=big5<CR>

"格式化
:nmap ,ft ggVG=

"使用中文帮助
if version>603
	set helplang=cn
endif

"C/C++注释
set comments=://	"设置可以作为注释符的符号

"取消新行自动添加注释
au FileType * setl fo-=cro

" Toggle line number
"nmap <C-F12> :set nu!<CR>
"imap <C-F12> <C-o>:set nu!<CR>

" Toggle spell check
" For VIM7 only
nmap <C-F10> :set spell!<CR>
imap <C-F10> <C-o>:set spell!<CR>


" ==============================================
" 光标移动 
" ==============================================
nnoremap <Down> gj
nnoremap <Up>   gk
vnoremap <Down> gj
vnoremap <Up>   gk
inoremap <Down> <C-o>gj
inoremap <Up>   <C-o>gk

nnoremap <End>  g$
nnoremap <Home> g0
vnoremap <End>  g$
vnoremap <Home> g0
inoremap <End>  <C-o>g$
inoremap <Home> <C-o>g0

" jump only one 'line' when wrap set on
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
inoremap <A-h> <C-o>h
inoremap <A-j> <C-o>gj
inoremap <A-k> <C-o>gk
inoremap <A-l> <C-o>l

:map <space> <C-F>
:map <S-Insert> <MiddleMouse>
":map! <S-Insert> <MiddleMouse>

"imap <C-s> <C-o>:update<CR>

map <F3> ^i"<ESC>	"在行首添加引号
map <C-F3> ^x

nmap <C-F4> :confirm bd<CR>
vmap <C-F4> <ESC>:confirm bd<Enter>
omap <C-F4> <ESC>:confirm bd<Enter>
map! <C-F4> <ESC>:confirm bd<Enter>

"nmap <F5> ^W_^W\| 
"nmap <F6> ^W=
"imap <F5> <ESC>^W_^W\|a
"imap <F6> <ESC>^W=a
"nmap gF ^Wf

" ==============================================
" 行间移动
" ==============================================
nmap <C-Down> :<C-u>move .+1<CR>
nmap <C-Up> :<C-u>move .-2<CR>

imap <C-Down> <C-o>:<C-u>move .+1<CR>
imap <C-Up> <C-o>:<C-u>move .-2<CR>

vmap <C-Down> :move '>+1<CR>gv
vmap <C-Up> :move '<-2<CR>gv

"按HOME键时光标移动到第一个非空字符  
"imap <HOME> <ESC>^i  
"nmap <HOME> ^  
"vmap <HOME> ^

" 使用alt+<num>切换标签栏  
:nmap <M-1> 1gt<ESC>
:nmap <M-2> 2gt<ESC>
:nmap <M-3> 3gt<ESC>
:nmap <M-4> 4gt<ESC>
:nmap <M-5> 5gt<ESC>
:nmap <M-6> 6gt<ESC>
:nmap <M-7> 7gt<ESC>
:imap <M-1> <C-o>1gt<ESC>
:imap <M-2> <C-o>2gt<ESC>
:imap <M-3> <C-o>3gt<ESC>
:imap <M-4> <C-o>4gt<ESC>
:imap <M-5> <C-o>5gt<ESC>
:imap <M-6> <C-o>6gt<ESC>
:imap <M-7> <C-o>7gt<ESC>
:nmap <C-S-tab> :tabprevious<cr>  
:nmap <C-tab> :tabnext<cr>  
map <S-Left> :tabp<CR>
map <S-Right> :tabn<CR>
":map <M-1> 1gt
":map <M-2> 2gt
":map <M-3> 3gt
":map <M-4> 4gt
":map <M-5> 5gt
":map <M-6> 6gt
":map <M-7> 7gt
":map <C-S-tab> :tabprevious<cr>  
":map <C-tab> :tabnext<cr>  
":imap <C-S-tab> <ESC><ESC>:tabprevious<cr>i  
":imap <C-tab> <ESC><ESC>:tabnext<cr>i  
":nmap <C-n> :tabnew<cr> 
":imap <C-n> <ESC>:tabnew<cr> 


" next file in buffer
nmap ,gn :next<CR>
nmap ,gp :previous<CR>
vmap ,gn <Esc>:next<CR>i
vmap ,gp <ESC>:previous<CR>i

" ==============================================
"  copy & paste
" ==============================================
:imap <C-y> <ESC>"*y
:nmap <C-y> "*y
:vmap <C-y> "*y
:imap <C-e> <ESC>"*p<ESC>a
:nmap <C-e> "*p<ESC>
:vmap <C-e> "*p

" 按下ctrl+s自动保存
":imap <C-s>	<ESC>:w<CR>a 

" 光标在链接上时打开浏览器
func Browser ()
	let line0 = getline (".")
	let line  = matchstr (line0, "http[^ ,;\t)]*")
	if line==""
		let line = matchstr (line0, "ftp[^ ,;\t)]*")
	endif
	if line==""
		let line = matchstr (line0, "www\.[^ ,;\t)]*")
	endif
	exec "!d:\Program Files\Mozilla Firefox\firefox.exe".line
	" TODO chrome cannot be run as root
endfunc
if has("win32")
	nnoremap <Leader>ch :call Browser ()<CR>
	" F12: Call external browser 
	map <F12> :silent! !"d:\Program Files\Mozilla Firefox\firefox.exe" % <CR>
endif

" 快速打开常用文件
"command! Vimrc :tabe+ c:\vim\_vimrc
if has("win32")
	:nmap 'vc :tabnew $VIM/_vimrc<CR>
else
	:nmap 'vc :tabnew ~/.vimrc<CR>
endif

" 快速切换wrap和nowrap
noremap <F9> :set wrap<CR>
noremap <F10> :set nowrap<CR>

" 光标颜色  
set guicursor=n-v-c:block-Cursor/lCursor,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver15-Cursor/lCursor,r-cr:

" ==============================================
" folding setting
" ==============================================
if version>700
	set foldenable " Turn on folding
	"set foldmethod=indent " Make folding indent sensitive
	"set foldmethod=manual " Make folding indent sensitive
	set foldlevel=100 " Don't autofold anything (but I can still fold manually)
	set foldopen-=search " don't open folds when you search into them
	set foldopen-=undo " don't open folds when you undo stuff
	set foldmethod=indent
	"按照语法折叠代码，indent为按照缩进折叠代码，zi命令打开/关闭所有折叠
	set foldcolumn=2  "设置折叠区域的宽度
	"set foldclose=all "设置为自动关闭折叠
	"nmap <M-l> zo
	"nmap <M-h> zc
	" Toggle fold state between closed and opened.  
	" If there is no fold at current line, just moves forward. 
	" If it is present, reverse it's state.  
	fun! ToggleFold()  
		if foldlevel('.') == 0   
			normal! l  
		else  
			if foldclosed('.') < 0  
				. foldclose  
			else  
				. foldopen  
			endif  
		endif  
		" Clear status line 
		echo 
	endfun 
endif


" Map this function to Space key.  
"noremap <space> :call ToggleFold()<CR> 

"let g:solarized_visibility= "high" 
"let g:solarized_termcolors=256

if (has("gui_running"))
	set wrap
	set guioptions+=b
	set guioptions-=T   "remove toolbar
	set background=dark
	if $USER == "root"
		colo peachpuff
	else
		"color solarized
		color gruvbox
	endif
else
	set t_Co=256
	set background=dark
	set wrap
	if $USER == "root"
		colo shine
	else
		"colo solarized
		color gruvbox
	endif
endif
"	set guifont=Consolas\ for\ Powerline\ FixedD:h9
"	set guifont=Consolas:h12:cANSI
"	set guifont=DejaVu\ Sans\ Mono\ for\ Powerline
"   set guifont=Bitstream_Vera_Sans_Mono:h10:cANSI
"	set guifont=Consolas:h12:cANSI
"	set guifont=Consolas\ for\ Powerline\ FixedD:h12
"   set guifontwide=雅黑_Mono:h12:cGB2312
"	set guifont=DejaVu_Sans_Mono_for_Powerline:h10
"	set guifont=courier_new:h11
"	set guifont=Inconsolata\ for\ Powerline:h12
"	colo desertEx
"	colo murphy
"	colo tolerable
"	colo desert
"	colo solarized


" 轻松编辑相同目录下的文件 vim_tips(2,64) 
function! CHANGE_CURR_DIR() 
	let _dir = expand("%:p:h") 
	exec "cd " . _dir 
	unlet _dir 
endfunction 
"autocmd BufEnter * call CHANGE_CURR_DIR() 


" move the line
" 移动行(类似eclipse)  
"nmap <M-Up> :<C-U>move .-2<CR>  
"nmap <M-Down> :<C-U>move .+1<CR>  
"imap <M-Down> <C-o>:<C-u>move .+1<CR>  
"imap <M-Up> <C-o>:<C-u>move .-2<CR>  
"vmap <M-Down> :move '>+1<CR>gv 
"vmap <M-Up> :move '<-2<CR>gv  

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
"command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
"set diffexpr=MyDiff()
"function MyDiff()
"  let opt = '-a --binary '
"  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
"  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
"  let arg1 = v:fname_in
"  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
"  let arg2 = v:fname_new
"  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
"  let arg3 = v:fname_out
"  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
"  let eq = ''
"  if $VIMRUNTIME =~ ' '
"    if &sh =~ '\<cmd'
"      let cmd = '""' . $VIMRUNTIME . '\diff"'
"      let eq = '"'
"    else
"      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
"    endif
"  else
"    let cmd = $VIMRUNTIME . '\diff'
"  endif
"  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
"endfunction



"===========================================================================
" Functions
"===========================================================================
function! TextWork()
	set nocin
	set nosm
	set noai
	set tw=78
	set sw=8
	set ts=8
	set nowrap
endfunction

function! NoTextWork()
	set cin
	set sm
	set ai
	set tw=0
	set sw=4
	set ts=4
	if (!has("gui_running"))
		set wrap
	endif
endfunction

function! CodeWork()
	call NoTextWork()
	"	WManager
	"	Tlist
endfunction

" =======================================
" Commands
" =======================================
"command -nargs=0 TextWork call TextWork()
"command -nargs=0 NoTextWork call NoTextWork()
"command -nargs=0 CodeWork call CodeWork()

" =======================================
" html里删除&bsp;  
" =======================================
augroup Foo  
	autocmd FileType html,xhtml,xml  
				\ inoremap <Buffer> <BS> x<Esc>:call SmartBS('&[^ \t;]*;')<CR>a<BS><BS>  
augroup END  

fun! SmartBS(pat)  
	let init = strpart(getline("."), 0, col(".")-1)  
	let len = strlen(matchstr(init, a:pat . "$")) - 1  
	if len > 0  
		execute "normal!" . len . "X"  
	endif  
endfun 


" ********************Plugin Configuration**********************

"--------------------------------------------------------------------------- 
" plugin - vim-easymotion.vim  
"--------------------------------------------------------------------------- 
let g:EasyMotion_leader_key = '<Leader>'

"--------------------------------------------------------------------------- 
" plugin - vim-airline.vim  
"--------------------------------------------------------------------------- 
if has("win32")
	set guifont=DejaVu_Sans_Mono_for_Powerline:h10 
else
	set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
endif
let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts = 1
let g:airline#extensionstabline#left_sep = ' '
let g:airline#extensionstabline#left_alt_sep = '|'
"let g:airline_theme = 'powerlineish'
let g:airline_theme = 'gruvbox'

"--------------------------------------------------------------------------- 
" plugin - ctrlp.vim  
"--------------------------------------------------------------------------- 
let g:ctrlp_map = ',p'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_open_multiple_files = 'v'

set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = {
			\ 'dir':  '\v[\/]\.(git|hg)$',
			\ 'file': '\v\.(log|jpg|png|jpeg|svn)$',
			\ }

noremap <C-W><C-U> :CtrlPMRU<CR>
nnoremap <C-W>u :CtrlPMRU<CR>
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1


"--------------------------------------------------------------------------- 
" plugin - matchit.vim  
"--------------------------------------------------------------------------- 
let b:match_ignorecase=1
let b:match_words = 
			\ '\<begin\>:\<end\>,' .
			\ '\<if\>:\<else\>,' .
			\ '\<module\>:\<endmodule\>,' .
			\ '\<class\>:\<endclass\>,' .
			\ '\<program\>:\<endprogram\>,' .
			\ '\<clocking\>:\<endclocking\>,' .
			\ '\<property\>:\<endproperty\>,' .
			\ '\<sequence\>:\<endsequence\>,' .
			\ '\<package\>:\<endpackage\>,' .
			\ '\<covergroup\>:\<endgroup\>,' .
			\ '\<primitive\>:\<endprimitive\>,' .
			\ '\<specify\>:\<endspecify\>,' .
			\ '\<generate\>:\<endgenerate\>,' .
			\ '\<interface\>:\<endinterface\>,' .
			\ '\<function\>:\<endfunction\>,' .
			\ '\<task\>:\<endtask\>,' .
			\ '\<case\>\|\<casex\>\|\<casez\>:\<endcase\>,' .
			\ '\<fork\>:\<join\>\|\<join_any\>\|\<join_none\>,' .
			\ '`ifdef\>:`else\>:`endif\>,'

"--------------------------------------------------------------------------- 
" plugin - taglist.vim  
"--------------------------------------------------------------------------- 
"let Tlist_Ctags_Cmd = "ctags.exe"
":map <silent> <F8> :Tlist<cr>
"imap <F8> <ESC>:Tlist<CR>i
":nmap <silent><F8> :TlistToggle<cr>  
"let Tlist_Show_Menu=1						"显示taglist菜单
"let Tlist_Sort_Type = "name"               "order by 
"let Tlist_Use_Right_Window = 1             "把函数列在右边  
let Tlist_Compart_Format = 1               "show small meny 
let Tlist_Exit_OnlyWindow = 1             "if you are the last, kill yourself  
"let Tlist_File_Fold_Auto_Close = 1         "当前不被编辑的文件的方法列表自动折叠起来 
"let Tlist_Enable_Fold_Column = 0           "do not show folding tree  
let Tlist_Show_One_File = 1                "只显示一个文件中的tag

"--------------------------------------------------------------------------- 
" plugin - winmanger.vim  
"--------------------------------------------------------------------------- 
"let g:winManagerWindowLayout = "TagList|FileExplorer"		" 设置界面分割
"let g:winManagerWidth = 30									"设置winmanager的宽度，默认为25
"nmap <silent> <F8> :WMToggle<cr>							"定义打开关闭winmanager快捷键为F8
"let g:AutoOpenWinManager = 1								"在进入vim时自动打开winmanager

"---------------------------------------------------------------------------  
" plugin - BufExplorer.vim 
"---------------------------------------------------------------------------  
":nmap <F4> :BufExplorer<CR> 
"let g:bufExplorerSplitBelow=1        " Split new window below current.
let g:bufExplorerDefaultHelp=0       " Do not show default help.
let g:bufExplorerShowRelativePath=1  " Show relative paths.
"let g:bufExplorerSortBy='mru'        " Sort by most recently used.
"let g:bufExplorerSplitRight=0        " Split left.
let g:bufExplorerSplitVertical=1     " Split vertically.
"let g:bufExplorerSplitVertSize = 30  " Split width
let g:bufExplorerSplitHorzSize= 5  " Split width
let g:bufExplorerUseCurrentWindow=0  " Open in new window.

"--------------------------------------------------------------------------- 
" plugin - NERD_tree.vim  
"--------------------------------------------------------------------------- 
nmap <C-F8> :NERDTreeToggle<cr> 
imap <C-F8> <Esc>:NERDTreeToggle<cr> 

"--------------------------------------------------------------------------- 
" plugin -BASH_SUPPORT.vim  
"--------------------------------------------------------------------------- 
let g:BASH_AuthorName = 'Guoyou Jiang'
let g:BASH_AuthorRef  = 'guoyou'
let g:BASH_Email      = ''
let g:BASH_Company    = ''

"--------------------------------------------------------------------------- 
" plugin -marksbrowser.vim
"--------------------------------------------------------------------------- 
nmap ,mk :MarksBrowser<cr>

"--------------------------------------------------------------------------- 
" plugin -TVO.vim
"--------------------------------------------------------------------------- 
"let g:otl_install_menu = 1 "install TVO menu
"let g:otl_instll_toolbar = 1
"let g:no_otl_maps = 0 "use TVO maps
"let g:no_otl_insert_maps = 1 "do not use TVO insert maps
"let g:otl_bold_headers = 1 "use bold headers in otl files
"let g:otl_map_tabs = 0 "do not install <tab> and <s-tab> map
"let otl_use_thlnk = 0
"au BufWinLeave *.otl mkview
"au BufWinEnter *.otl silent loadview
"au BufWinEnter *.otl :set textwidth=80
"let maplocalleader = "," "use , for the leader key instead of \
"map <C-F12> :!otl2html.py -D -S c:/vim/vim71/webpage.css % > %.html<CR>
"map <M-F12> :!otl2html.py -D -S c:/vim/vim71/nnnnnn.css % > %.html<CR>
"map <C-F11> :!otlParser.rb -f HTML % > %.html<CR>
"map <M-F11> :!otlParser.rb -f HTMLLit % > %.html<CR>

"autocmd BufEnter * call DoWordComplete()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"--------------------------------------------------------------------------- 
" plugin -showmarks setting
"--------------------------------------------------------------------------- 
let showmarks_enable = 1
" Show which marks
let showmarks_include = "'`abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
" Ignore help, quickfix, non-modifiable buffers
let showmarks_ignore_type = "hqm"
" Hilight lower & upper marks
let showmarks_hlline_lower = 1
let showmarks_hlline_upper = 1
" For showmarks plugin
hi ShowMarksHLl ctermbg=Yellow   ctermfg=Black  guibg=#FFDB72    guifg=Black
hi ShowMarksHLu ctermbg=Magenta  ctermfg=Black  guibg=#FFB3FF    guifg=Black

"--------------------------------------------------------------------------- 
" plugin - ack.vim
"--------------------------------------------------------------------------- 
let g:ackprg = 'ag --vimgrep'

"--------------------------------------------------------------------------- 
" plugin - MUComplete.vim
"--------------------------------------------------------------------------- 
set  showmode shortmess-=c
setl completeopt-=preview
setl completeopt+=longest,menu,menuone
let g:mucomplete#enable_auto_at_startup = 1

"--------------------------------------------------------------------------- 
" plugin -Vim2Ansi.vim
"--------------------------------------------------------------------------- 
function! GetRangeAsString(line1, line2)
	let l = getline(a:line1, a:line2)
	let s = ''
	for i in range(len(l))
		let s .= l[i] . "\n"
	endfor
	return s
endfunction

function! BBSColor(line1, line2)
	let buf1 = bufname('%')
	exec a:line1 . ',' . a:line2 . 'TOansi'
	let buf2 = bufname('%')
	if buf2 != buf1 . '.ansi'
		echoerr 'Fail to get into the ansi buffer.'
		return
	endif
	let s = GetRangeAsString(0, '$')
	let s = substitute(s, "\<Esc>", "\<Esc>\<Esc>", 'ge')
	set buftype=nofile
	bdelete
	let @* = s
endfunction
command! -range=% BBSColor :call BBSColor(<line1>,<line2>)

"--------------------------------------------------------------------------- 
" plugin -jianfan-v.vim
"--------------------------------------------------------------------------- 
"nmap <leader>g2b <ESC>:cal G2B()<CR>
"nmap <leader>b2g <ESC>:cal B2G()<CR> 

"--------------------------------------------------------------------------- 
" plugin -SuperTab.vim
"--------------------------------------------------------------------------- 
" use neocomplcache instead of it
"if version>700
"	set completeopt+=longest
"endif
"let g:SuperTabRetainCompletionType=2
"let g:SuperTabDefaultCompletionType="<C-X><C-O>"
"let g:SuperTabDefaultCompletionType="context"

"--------------------------------------------------------------------------- 
" plugin -neocomplcache.vim
"--------------------------------------------------------------------------- 
"禁用AutoComplPop
let g:acp_enableAtStartup = 0
"打开VIM启动neocomplcache
let g:neocomplcache_enable_at_startup = 1
"设定字典文件
if has("win32")
	let g:neocomplcache_dictionary_filetype_lists = {
				\ 'default' : '',
				\ 'mydict' : 'D:\Vim\dict' 
				\ }
else
	let g:neocomplcache_dictionary_filetype_lists = {
				\ 'default' : '',
				\ 'mydict' : '~/.vim/dict' 
				\ }
endif
" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
	let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
" <CR>: close popup and save indent.

"inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"function! s:my_cr_function()
"	return neocomplcache#smart_close_popup() . "\<CR>"
"	" For no inserting <CR> key.
"	"return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
"endfunction

" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><C-h>  neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><BS>   neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><C-y>  neocomplcache#close_popup()
"inoremap <expr><C-e>  neocomplcache#cancel_popup()
"使用tab在候选词之间切换
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"使用Ctrl+l逐字补全
inoremap <expr><C-l>  neocomplcache#complete_common_string()
"撤销补全
inoremap <expr><C-g>  neocomplcache#undo_completion()
" Enable omni completion.
autocmd FileType css        setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html       setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType markdown   setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python     setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml        setlocal omnifunc=xmlcomplete#CompleteTags

"--------------------------------------------------------------------------- 
" plugin -neoSnippet.vim
"--------------------------------------------------------------------------- 
" Plugin key-mappings.
imap <C-k>  <Plug>(neosnippet_expand_or_jump)
smap <C-k>  <Plug>(neosnippet_expand_or_jump)
xmap <C-k>  <Plug>(neosnippet_expand_target)
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?  "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?   "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" For snippet_complete marker.
if has('conceal')
	set conceallevel=2 concealcursor=i
endif


"--------------------------------------------------------------------------- 
" plugin -TxtBrowser.vim
"--------------------------------------------------------------------------- 
let tlist_txt_settings = 'txt;c:content;f:figures;t:tables'
au BufRead,BufNewFile *.txt setlocal ft=txt

"--------------------------------------------------------------------------- 
" plugin -miniBufExpl.vim
"--------------------------------------------------------------------------- 
"let g:miniBufExplMapWindowNavVim = 1		" 按下Ctrl+h/j/k/l，可以切换到当前窗口的上下左右窗口
"let g:miniBufExplMapWindowNavArrows = 1		" 按下Ctrl+箭头，可以切换到当前窗口的上下左右窗口
"let g:miniBufExplMapCTabSwitchBufs = 1		" 启用以下两个功能：Ctrl+tab移到下一个buffer并在当前窗口打开；Ctrl+Shift+tab移到上一个buffer并在当前窗口打开；ubuntu好像不支持
"let g:miniBufExplMapCTabSwitchWindows = 1	" 启用以下两个功能：Ctrl+tab移到下一个窗口；Ctrl+Shift+tab移到上一个窗口；ubuntu好像不支持
"let g:miniBufExplModSelTarget = 1    " 不要在不可编辑内容的窗口（如TagList窗口）中打开选中的buffer

" Added by VimOutliner installer
" syntax on
"au! BufRead,BufNewFile *.otl		setfiletype vo_base
" End modifications by VimOutliner installer

"  ==============================================
"  自定义文件头
"  ==============================================
function! Mytitle()
	call setline(1,"/**********************************************")
	call append(line("."),"作者:自己名字")
	call append(line(".")+1,"时间:".strftime("%c"))
	call append(line(".")+2,"文件名:".expand("%"))
	call append(line(".")+3,"描述:")
	call append(line(".")+4,"**********************************************/")
endfunction
map <F1> <Esc>:call !Mytitle()<CR><Esc>:$<Esc>o      

function! MySVTitle()
	call append(0,  "//")
	"  call append(1,  "// Created by         :".b:vlog_company)
	call append(1,  "// Created by         : Guoyou Jiang")
	call append(2,  "// Filename           : ".expand("%"))
	call append(3,  "// Author             : Guoyou Jiang")  
	".$USER."Guoyou")
	call append(4,  "// Created On         : ".strftime("%Y-%m-%d %H:%M"))
	call append(5,  "// Last Modified      : ")
	call append(6,  "// Update Count       : ".strftime("%Y-%m-%d %H:%M"))
	call append(7,  "// Tags               :  ")
	let save_tags=getpos(".")
	call append(8,  "// Description        : ")
	call append(9,  "// Conclusion         : ")
	call append(10, "//                      ")
	call append(10, "//=======================================================================")
	"call append(11,  "module ".expand("%"))
	call setpos('.', [0, 8, 25,0])
	:startinsert
endfunction
autocmd BufNewFile *.sv call MySVTitle()

"  ==============================================
"  根椐文件格式加注释(你可以自己改一下)
"  =============================================
function! Mycomment()
	if &syntax=="cpp" || &syntax=="c"
		execute "normal  \<Esc>\<S-$>a\<TAB>/**/\<Esc>2ha"
	elseif &syntax=="perl" || &syntax=="sh"
		execute "normal \<Esc>\<S-$>a\<TAB>#\<Esc>k\<S-$>"
	endif
endfunction
"map <F2> <Esc>:call Mycomment()<CR><Esc> $<Esc>o                           

"  ==============================================
"  插入日期 
"  =============================================
map  <F7> a<C-R>=strftime("%c")<CR><Esc>
imap <F7>  <C-R>=strftime("%c")<CR> 
"from edyfox.codecarver.org/html/_vimrc.html
function TimeStamp()
	let curposn= SaveWinPosn()
	%s/\$Date: .*\$/\=strftime("$Date: %Y-%m-%d %H:%M:%S$")/ge
	%s/Last Change: .*$/\=strftime("Last Change: %Y-%m-%d %H:%M:%S")/ge
	%s/Last Modified: .*$/\=strftime("Last Modified: %Y-%m-%d %H:%M:%S")/ge
	" Replace once and never update.
	%s/Created: *$/\=strftime("Created: %Y-%m-%d %H:%M:%S")/ge
	call RestoreWinPosn(curposn)
endfunction
command -nargs=0 TimeStamp call TimeStamp()

function AutoTimeStamp()
	augroup tagdate
		au!
		au BufWritePre,FileWritePre * call TimeStamp()
	augroup END
endfunction
command -nargs=0 AutoTimeStamp call AutoTimeStamp()

function NoAutoTimeStamp()
	augroup tagdate
		au!
	augroup END
endfunction
command -nargs=0 NoAutoTimeStamp call NoAutoTimeStamp()

" run perl script
"map ;r :w<CR>:!perl -w "%:p"<CR>
" debug perl script
"map ;d :w<CR>:!perl -d "%:p"<CR>

augroup filetypedetect 
    autocmd BufRead,BufNewFile *.cdf   setfiletype c
    autocmd BufRead,BufNewFile *.swbc  setfiletype sh
    autocmd BufRead,BufNewFile *.txt   setfiletype txt
    autocmd BufRead,BufNewFile *.zxt   setfiletype zxt
    autocmd BufRead,BufNewFile *.zlg   setfiletype ztxlog
    autocmd BufRead,BufNewFile *.sv    setfiletype systemverilog
augroup END

function VsbFunction (arg1)
	execute 'vert sb' a:arg1
endfunction
command -nargs=1 Vsb call VsbFunction(<f-args>)

function! Html(filename)
	color spring
	TOhtml
	"exec "quit"
	"let s:hfn="d:\" . a:filename . "\.html"
	"let fn="d:"
	"call append(fn, a:filename)
	"let hfn=fn . ".html"
	"saveas! hfn
	let hfn = "d:/tmp/" . a:filename . ".html"
	"	saveas "d:" . "/" . a:filename . ".html"
	exec "saveas!" hfn
	color torte
endfunction
com! -nargs=1 Shtml :call Html(<q-args>)

"if filereadable(expand("~/.vimrc.extra"))
"    so ~/.vimrc.extra
"endif

" 将当前正在编辑但未保存的文件与已保存的做diff
function DiffWithSaved()
	let ft=&filetype
	diffthis
	vnew | r # | normal! 1Gdd
	diffthis
	exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . ft
endfunc
com DiffSaved call DiffWithSaved()
nnoremap <Leader>df :call DiffWithSaved()<CR>

" 自动更新文件头处的修改时间，文件名
function LastMod()
	let l:line = line(".")                            " save cursor position
	let l:col = col(".")
	let l = min([line("$"), 8])
	exec '1,' . l . 'substitute/' . '^\(.*Date:\).*$' . '/\1 ' . strftime('%a %b %d %H:%M:%S %Y %z') . '/e'
	exec '1,' . l . 'substitute/' . '^\(.*File:\).*$' . '/\1 ' . expand('<afile>:t') . '/e'
	call cursor(l:line, l:col)
endfun
au BufWritePre,FileWritePre * call LastMod()

" 从上一行复制一个单词下来
inoremap <M-i> <C-C>:let @z = @"<CR>mz
			\:exec 'normal!' (col('.')==1 && col('$')==1 ? 'k' : 'kl')<CR>
			\:exec (col('.')==col('$') - 1 ? 'let @" = @_' : 'normal! yw')<CR>
			\`zp:let @" = @z<CR>a

""" " Vertical Split Buffer
""" "    Function 
""" function VerticalSplitBuffer(buffer)
""" 	execute "vert belowright sb" a:buffer
""" endfunction
""" "    Mapping
""" command -nargs=1 Vbuffer call VerticalSplitBuffer(<f-args>)

