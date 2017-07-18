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
Plugin 'Shougo/denite.nvim'
Plugin 'Shougo/neomru.vim'
Plugin 'tpope/vim-surround'
Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/deoplete.nvim'
Plugin 'tomtom/tcomment_vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'kshenoy/vim-signature'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'majutsushi/tagbar'
Plugin 'fatih/vim-go'
Plugin 'Valloric/MatchTagAlways'
Plugin 'alvan/vim-closetag'
Plugin 'vim-syntastic/syntastic'


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

" colors
set t_Co=256
let base16colorspace=256
colorscheme base16-mocha

" hilight all search matches
set hlsearch

" columns text is indented with the reindent operations (<< and >>)
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
execute "set colorcolumn=" . join(range(100,999), ',')

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

autocmd FileType go setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2

highlight Normal ctermbg=NONE
highlight nonText ctermbg=NONE

nnoremap ; :
nnoremap j gj
nnoremap k gk

set backspace=indent,eol,start

" Denite
" call denite#custom#source('file_rec/async','sorters','sorter_rank', )
" call denite#custom#var('file_rec', 'command',
"             \ ['ag', '--follow', '--nocolor', '--nogroup', '-r',
"             \ '--ignore', 'node_modules',
"             \  '-g', '',])
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts',
            \ ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

call denite#custom#option('default', 'prompt', '» ')
call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
            \ ['src-generator/', 'node_modules/', '.tmp/', 'CI/',
            \ '*~', '*.o', '*.exe', '*.bak',
            \ '.DS_Store', '*.pyc', '*.sw[po]', '*.class',
            \ '.hg/', '.git/', '.bzr/', '.svn/',
            \ 'tags', 'tags-*', '.*', 'fonts/', 'images/'])
call denite#custom#source('file_rec', 'matchers', ['matcher_fuzzy', 'matcher_ignore_globs'])
call denite#custom#source('file_mru', 'matchers', ['matcher_fuzzy', 'matcher_ignore_globs'])
call denite#custom#map('insert', '<Esc>', '<denite:enter_mode:normal>', 'noremap')

nnoremap <silent> <c-p> :Denite -auto-resize file_mru file_rec<cr>
" nnoremap <silent> <c-p> :Denite -auto-resize file_rec<cr>

nnoremap <space>/ :Denite -auto-resize grep:.<cr>
nnoremap <space>s :Denite -quick-match buffer<cr>
nnoremap <leader>8 :<C-u>DeniteCursorWord grep:. -mode=normal<CR>

" Airline
let g:airline#extensions#tabline#enabled=1
set laststatus=2


"Deocomplete
let g:deoplete#enable_at_startup = 1
"use neocomplete.
let g:deoplete#enable_at_startup = 1
" Use smartcase.
let g:deoplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:deoplete#sources#syntax#min_keyword_length = 3
let g:deoplete#lock_buffer_name_pattern = '\*ku\*'
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" omnicompletion
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete

cabbrev E Explore

" ctags
cabbrev T TagbarToggle
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
    \ }

" tag matching on jsx files
let g:mta_filetypes = { 'html' : 1, 'xhtml' : 1, 'xml' : 1, 'jinja' : 1 , 'js' : 1}
nnoremap <space>5 :MtaJumpToOtherTag<cr>
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.xml,*.js,*.jsx"

" syntastic
cabbrev R SyntasticReset
cabbrev S SyntasticCheck
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_javascript_checkers=['eslint']
let g:syntastic_javascript_eslint_exe='$(npm bin)/eslint'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
