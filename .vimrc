set hidden
let g:racer_cmd = "/Users/danielbokser/Downloads/racer/target/release/racer"
let $RUST_SRC_PATH = "/Users/danielbokser/Downloads/rustc-1.4.0/src"


set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()
" alternatively, pass a path where Vundle should install plugins
"let path = '~/some/path/here'
"call vundle#rc(path)

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between here and filetype plugin indent on.
" scripts on GitHub repos
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'tpope/vim-rails.git'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" scripts from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
Plugin 'FuzzyFinder'
" scripts not on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" ...
"

Plugin 'ARM9/arm-syntax-vim'
Plugin 'vim-scripts/a.vim'
Plugin 'danro/rename.vim'
Plugin 'rust-lang/rust.vim'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'timonv/vim-cargo'
Plugin 'ervandew/supertab'

let g:SuperTabMappingTabLiteral = '<C-space>'

filetype plugin indent on     " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Plugin commands are not allowed.
" Put your stuff after this line


imap jj <Esc>
set number
syntax on
colorscheme darkblue

" use indentation of previous line
set autoindent
" use intelligent indentation for C
set smartindent
" configure tabwidth and insert spaces instead of tabs
set tabstop=4 " tab width is 4 spaces
set shiftwidth=4 " indent also with 4 spaces
set expandtab " expand tabs to spaces


set hlsearch
if has("unix")
    "map µ :wa<CR>:r! cargo build<CR>
    map <CR> :<C-U>call BuildSource()<CR>
    map ® :wa<CR>:!cargo run samples/mbc0.gb<CR>
else
    "map <A-m> :wa<CR>:r! cargo build<CR>
    map <A-m> :wa<CR>:call BuildSource()<CR>
    map <A-r> :wa<CR>:!cargo run samples/mbc0.gb<CR>
endif
inoremap {<CR> {<CR>}<Esc>ko
inoremap {} {}

if has("gui_running")
  " GUI is running or is about to start.
  " Maximize gvim window (for an alternative on Windows, see simalt below).
  set lines=50 columns=225
endif

function! Refactor()
    call inputsave()
    let @z=input("What do you want to rename '" . @z . "' to? ")
    call inputrestore()
endfunction
 
" Locally (local to block) rename a variable
nmap <Leader>rf "zyiw:call Refactor()<cr>mx:silent! norm gd<cr>[{V%:s/<C-R>//<c-r>z/g<cr>`x


let g:ycm_extra_conf_globlist = ['~/.vim/bundle/YouCompleteMe/*', './*']

let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
au BufNewFile,BufRead *.s,*.S set filetype=arm

highlight CommentTypes guifg=green
match CommentTypes /NOTE/
let $LIBRARY_PATH="$LIBRARY_PATH:/usr/local/lib"

function! BuildSource()
    :wa
    if (&ft == 'rust')
        :make! build
    else
        :make!
    endif
endfunction
