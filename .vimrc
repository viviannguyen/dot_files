set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'Shougo/unite.vim'
Plugin 'Shougo/neomru.vim'
Plugin 'tpope/vim-surround'
Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/neocomplete.vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'kshenoy/vim-signature'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/syntastic'
Plugin 'vim-scripts/taglist.vim'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

if has("syntax")
  syntax on
endif

if has("autocmd")
  filetype plugin indent on
endif

set t_Co=256
colorscheme base16-mocha

set hlsearch
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
execute "set colorcolumn=" . join(range(81,999), ',')

set rnu
set ruler
set list
set listchars=tab:→\ ,trail:·
set showcmd
set showmode
set showmatch
set scrolloff=7

set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.class,.svn,*.gem
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*.swp,*~,._*

autocmd InsertEnter * :set nu
autocmd InsertLeave * :set rnu
autocmd WinLeave * set nocursorline
autocmd WinEnter * set cursorline

highlight Normal ctermbg=NONE
highlight nonText ctermbg=NONE

nnoremap ; :

set backspace=indent,eol,start

"Unite
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
"call unite#custom#source('file_rec/async','sorters','sorter_rank', )
"replacing unite with ctrl-p
let g:unite_data_directory='~/.vim/.cache/unite'
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable=1
let g:unite_prompt='» '
let g:unite_split_rule = 'botright'
if executable('ag')
  let g:unite_source_grep_command='ag'
  let g:unite_source_grep_default_opts='--nocolor --nogroup -S -C4'
  let g:unite_source_grep_recursive_opt=''
endif
nnoremap <silent> <c-p> :Unite -auto-resize file_mru file_rec/async<cr>

nnoremap <space>/ :Unite -auto-resize grep:.<cr>
nnoremap <space>s :Unite -quick-match buffer<cr>

" Airline
let g:airline#extensions#tabline#enabled=1
set laststatus=2


"Syntastic settings
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0

"Neocomplete
"use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" omnicompletion
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete

cabbrev E Explore
cabbrev T TlistOpen
cabbrev R SyntasticReset
