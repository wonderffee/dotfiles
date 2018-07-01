call pathogen#infect()
"set transparency=10
":colorscheme evening
colorscheme ir_black
"设置菜单语言
set langmenu=zh_cn
syntax on
  
" =========
" 功能函数
" =========
" 获取当前目录
func GetPWD()
    return substitute(getcwd(), "", "", "g")
endf
  
" =========
" 环境配置
" =========
  
" 保留历史记录
set history=400
  
" 命令行于状态行
set ch=1
set stl=\ [File]\ %F%m%r%h%y[%{&fileformat},%{&fileencoding}]\ %w\ \ [PWD]\ %r%{GetPWD()}%h\ %=\ [Line]\ %l,%c\ %=\ %P 
set ls=2 " 始终显示状态行
  
" 制表符
set tabstop=4
set expandtab
set smarttab
set shiftwidth=4
set softtabstop=4
  
" 状态栏显示目前所执行的指令
set showcmd 
  
" 行控制
set linebreak
set nocompatible
set textwidth=80
set wrap
  
" 行号和标尺
set number
set ruler
set rulerformat=%15(%c%V\ %p%%%)
  
" 控制台响铃
:set noerrorbells
:set novisualbell
:set t_vb= "close visual bell
  
" 插入模式下使用 <BS>、<Del> <C-W> <C-U>
set backspace=indent,eol,start
  
" 标签页
set tabpagemax=20
set showtabline=2
  
" 缩进
set autoindent
set cindent
set smartindent
  
" 自动重新读入
set autoread
  
" 代码折叠
set foldmethod=manual
"set foldmethod=indent
  
" 自动切换到文件当前目录
set tags=tags;
set autochdir
  
"在查找时忽略大小写
"set ignorecase
set incsearch
set hlsearch
  
"显示匹配的括号
set showmatch
  
"实现全能补全功能，需要打开文件类型检测
"filetype plugin indent on
"打开vim的文件类型自动检测功能
filetype on
  
"在所有模式下都允许使用鼠标，还可以是n,v,i,c等
set mouse=a
  
" 恢复上次文件打开位置
set viminfo='10,\"100,:20,%,n~/.viminfo
  
" =====================
" 多语言环境
"    默认为 UTF-8 编码
" =====================
if has("multi_byte")
    set encoding=utf-8
    " English messages only
    "language messages zh_CN.utf-8
  
    if has('win32')
        language english
        let &termencoding=&encoding
    endif
  
    set fencs=ucs-bom,utf-8,gbk,cp936,latin1
    set formatoptions+=mM
    set nobomb " 不使用 Unicode 签名
  
    if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
        set ambiwidth=double
    endif
else
    echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif
  
" =========
" 插件
" =========
filetype plugin indent on
" =========
" AutoCmd
" =========
if has("autocmd")
    filetype plugin indent on
  
    " 括号自动补全
    func! AutoClose()
        :inoremap ( ()<ESC>i
        :inoremap " ""<ESC>i
        :inoremap ' ''<ESC>i
        :inoremap { {}<ESC>i
        :inoremap [ []<ESC>i
        :inoremap } <c-r>=ClosePair('}')<CR>
        :inoremap ] <c-r>=ClosePair(']')<CR>
        :inoremap ) <c-r>=ClosePair(')')<CR>
 
    endf
  
    func! ClosePair(char)
        if getline('.')[col('.') - 1] == a:char
            return "\<Right>"
        else
            return a:char
        endif
    endf
  
  
    "auto close quotation marks for PHP, Javascript, etc, file
    au FileType php,c,python,javascript exe AutoClose()
  
    " Auto Check Syntax
    "au BufWritePost,FileWritePost *.js,*.php call CheckSyntax(1)
  
    " JavaScript 语法高亮
    au FileType html,javascript let g:javascript_enable_domhtmlcss = 1
  
    " 给 Javascript 文件添加 Dict
    if has('gui_macvim') || has('unix')
        au FileType javascript setlocal dict+=~/.vim/dict/javascript.dict
    else
        au FileType javascript setlocal dict+=$VIM/vimfiles/dict/javascript.dict
    endif
  
    " 格式化 JavaScript 文件
    "au FileType javascript map <f12> :call g:Jsbeautify()<cr>
    au FileType javascript set omnifunc=javascriptcomplete#CompleteJS
  
    " 给 CSS 文件添加 Dict
    if has('gui_macvim') || has('unix')
        au FileType css setlocal dict+=~/.vim/dict/css.dict
    else
        au FileType css setlocal dict+=$VIM/vimfiles/dict/css.dict
    endif
  
    " 增加 ActionScript 语法支持
    au BufNewFile,BufRead *.as setf actionscript
 
    " CSS3 语法支持
    au BufRead,BufNewFile *.css set ft=css syntax=css3
 
    " 增加 Objective-C 语法支持
    au BufNewFile,BufRead,BufEnter,WinEnter,FileType *.m,*.h setf objc
 
    " 将指定文件的换行符转换成 UNIX 格式
    au FileType php,javascript,html,css,python,vim,vimwiki set ff=unix
 
    " 保存编辑状态
    au BufWinLeave * if expand('%') != '' && &buftype == '' | mkview | endif
    au BufRead     * if expand('%') != '' && &buftype == '' | silent loadview | syntax on | endif
  
    " 自动最大化窗口
    if has('gui_running')
        if has("win32")
            au GUIEnter * simalt ~x
        "elseif has("unix")
            "au GUIEnter * winpos 0 0
            "set lines=999 columns=999
        endif
    endif
endif
  
"acp 自动补全插件
let g:AutoComplPop_Behavior = { 
\ 'c': [ {'command' : "\<C-x>\<C-o>",
\ 'pattern' : ".",
\ 'repeat' : 0}
\ ] 
\}
  
  
" =========
" 快捷键
" =========
map cal :Calendar<cr>
let NERDTreeWinSize=22
map ntree :NERDTree <cr>
map nk :NERDTreeClose <cr>
map <leader>n :NERDTreeToggle<cr>
map cse :ColorSchemeExplorer
  
" 标签相关的快捷键 Ctrl
map tn :tabnext<cr>
map tp :tabprevious<cr>
map tc :tabclose<cr>
map <C-t> :tabnew<cr>
map <C-p> :tabprevious<cr>
map <C-n> :tabnext<cr>
map <C-k> :tabclose<cr>
map <C-Tab> :tabnext<cr>
  
" 新建 XHTML 、PHP、Javascript 文件的快捷键
nmap <C-c><C-h> :NewQuickTemplateTab xhtml<cr>
nmap <C-c><C-p> :NewQuickTemplateTab php<cr>
nmap <C-c><C-j> :NewQuickTemplateTab javascript<cr>
nmap <C-c><C-c> :NewQuickTemplateTab css<cr>
  
" 在文件名上按gf时，在新的tab中打开
map gf :tabnew <cfile><cr>
  
  
"jquery 配色
au BufRead,BufNewFile *.js set syntax=jquery
  
" jsLint for Vim
let g:jslint_highlight_color  = '#996600'
" 指定 jsLint 调用路径，通常不用更改
let g:jslint_command = $HOME . '\/.vim\/jsl\/jsl'
" 指定 jsLint 的启动参数，可以指定相应的配置文件
let g:jslint_command_options = '-nofilelisting -nocontext -nosummary -nologo -process'
  
  
" 返回当前时间
func! GetTimeInfo()
    "return strftime('%Y-%m-%d %A %H:%M:%S')
    return strftime('%Y-%m-%d %H:%M:%S')
endfunction
  
" 插入模式按 Ctrl + D(ate) 插入当前时间
imap <C-d> <C-r>=GetTimeInfo()<cr>
  
" ==================
" plugin list
" ==================
"Color Scheme Explorer
"jsbeauty \ff
"NERDTree
"Calendar
"conquer_term
"nerd_commenter
  
"setup for C and C++
filetype plugin on
set nocp

let g:LargeFile=10

inoremap jk <Esc>
inoremap <Esc> <Nop>
inoremap fes <Esc>A
inoremap vvb <Esc>I

set hlsearch
set incsearch
set ignorecase
set smartcase
set showmode
set number
set relativenumber
set scrolloff=3
set clipboard=unnamed

" clear the highlighted search result
nnoremap <Leader>sc :nohlsearch<CR>

nnoremap <Leader>fs :w<CR>

" Quit normal mode
nnoremap <Leader>q  :q<CR>
nnoremap <Leader>Q  :qa!<CR>

" Move half page faster
nnoremap <Leader>d  <C-d>
nnoremap <Leader>u  <C-u>

" Insert mode shortcut
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-d> <Delete>

" Quit insert mode
inoremap jj <Esc>
inoremap jk <Esc>
inoremap kk <Esc>
inoremap vve <Esc>A
inoremap vvb <Esc>I

" Quit visual mode
vnoremap v <Esc>

" Move to the start of line
"nnoremap H ^

" Move to the end of line
"nnoremap L $

" Redo
nnoremap U <C-r>

" Yank to the end of line
nnoremap Y y$

nnoremap x "_x
nnoremap X "_X
nnoremap d "_d
nnoremap dd "_dd
nnoremap D "_D
vnoremap x "_x
vnoremap X "_X
vnoremap d "_d
vnoremap dd "_dd

nnoremap <Leader>x ""x
nnoremap <Leader>X ""X
nnoremap <Leader>d ""d
nnoremap <Leader>dd ""dd
nnoremap <Leader>D ""D
vnoremap <Leader>x ""x
vnoremap <Leader>X ""X
vnoremap <Leader>d ""d
vnoremap <Leader>dd ""dd

" Window operation
nnoremap <Leader>ww <C-W>w
nnoremap <Leader>wd <C-W>c
nnoremap <Leader>wj <C-W>j
nnoremap <Leader>wk <C-W>k
nnoremap <Leader>wh <C-W>h
nnoremap <Leader>wl <C-W>l
nnoremap <Leader>ws <C-W>s
nnoremap <Leader>w- <C-W>s
nnoremap <Leader>wv <C-W>v
nnoremap <Leader>w\| <C-W>v

" Tab operation
nnoremap tn gt
nnoremap tp gT
