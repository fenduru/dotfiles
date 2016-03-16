filetype off                   " required!

call plug#begin('~/.vim/plugged')
" UI enhancements
" Plug 'altercation/vim-colors-solarized' " pretty colors
Plug 'morhetz/gruvbox'
Plug 'bling/vim-airline' " pretty status bar
Plug 'airblade/vim-gitgutter' " git diff gutter icons

" Languages
" better js highlighting/indenting
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'carlitux/deoplete-ternjs'
" mustache/handlebars template support
Plug 'mustache/vim-mustache-handlebars', { 'for': ['handlebars', 'mustache'] }
Plug 'wting/rust.vim', { 'for': 'rust' } " rust syntax
Plug 'cespare/vim-toml', { 'for': 'toml' } " toml syntax

" Autocomplete
Plug 'Shougo/deoplete.nvim'
Plug 'ervandew/supertab'

Plug 'Raimondi/delimitMate'

" rust autocompletion
Plug 'phildawes/racer', { 'for': 'rust', 'do': 'cargo build --release' }

" Motion
Plug 'camelcasemotion' " Motion for camelcase words
Plug 'tpope/vim-surround' " edit surronding tags of text object

" Time savers
Plug 'kien/ctrlp.vim' " fuzzy filename matching.

" Dev tools
Plug 'scrooloose/syntastic' " syntax checker

call plug#end()

syntax on
filetype plugin indent on
set hidden
set fileformat=unix
set shortmess=filmnrxtTI

""""DISPLAY
set nu
set ruler
set showcmd
set showmatch
set title
set wildignore=*.o,*.obj,*.bak,*.exe,*.py[co],*.swp,*~,*.pyc,.svn
set matchpairs+=<:>
set smartindent

set ignorecase
set smartcase

set whichwrap+=<,>,h,l " cursor keys also wrap

" spaces instead of tabs
" prefer 2 spaces
set softtabstop=2
set tabstop=2
set shiftwidth=0
set expandtab

" wrap settings
set nowrap " wrap lines rather than use horiz. scrolling
set linebreak " try not to wrap in the middle of a word
set textwidth=100 " 100-character lines maximum

" Seed normal omnicomplete dbs
set omnifunc=deoplete#mappings#manual_complete

"" Mappings
"""""""""""""
inoremap jk <Esc>

"" Matchit
"""""""""""""""
runtime macros/matchit.vim

" Automatically restore cursor position when possible
autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \ exe "normal! g`\"" |
      \ endif

""""""""""""""""""""""""""""""""""""""""
"" settings controlling temporary/backup files
""""""""""""""""""""""""""""""""""""""""
set undofile

""
" Stop annoying me every time I have a file open in two different vim
" sessions.
" 'e' is "Edit Anyway" in this circumstance. Other options you could use
" here:
" 'q' - quit.
" 'o' - open the file in read-only mode.
" 'r' - recover the changes.
augroup SimultaneousEdits
  autocmd!
  autocmd SwapExists * :let v:swapchoice = 'e'
augroup END

" Highlight EOL whitespace, http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=darkred guibg=#382424
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/

" The above flashes annoyingly while typing, be calmer in insert mode
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/

function! s:FixWhitespace(line1,line2)
    let l:save_cursor = getpos(".")
    silent! execute ':' . a:line1 . ',' . a:line2 . 's/\s\+$//'
    call setpos('.', l:save_cursor)
endfunction

" Run :FixWhitespace to remove end of line white space
command! -range=% FixWhitespace call <SID>FixWhitespace(<line1>,<line2>)

let g:airline_theme = 'gruvbox'
let g:airline_powerline_fonts = 1

set background=dark
let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox
" colorscheme solarized
" let g:solarized_termcolors=256

" \ is leader
let mapleader = ' '
let maplocalleader = '\\'

""Syntastic

" Fix quickfix list to wrap
autocmd FileType qf setlocal wrap linebreak
nnoremap <leader>e :Errors<CR>
nnoremap <leader>n :lnext<CR>
nnoremap <leader>N :lprev<CR>
let g:syntastic_enable_balloons = 0
" potentially risky. it will run BEGIN, UNITCHECK, CHECK blocks and use
" statements
let g:syntastic_enable_perl_checker = 1

"" ctrlp
" let g:ctrlp_custom_ignore= {
"  \ 'dir': '\v[\/](\.(git|hg|svn))|(node_modules|vendor|bin|rint|tmp|image_results)$',
"  \ 'file': '\v\.(exe|so|dll|.a)$'
"  \ }
let g:ctrlp_user_command = ['.git', 'git --git-dir=%s/.git ls-files']

let g:ctrlp_root_markers = ['.git']
let g:ctrlp_mruf_default_order = 0
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0

"" YouCompleteMe
" Load .ycm_extra_conf without prompting
let g:ycm_confirm_extra_conf = 0
" Seed the identifiers db with language keywords
let g:ycm_seed_identifiers_with_syntax = 1
" close the preview window after completing
let g:ycm_autoclose_preview_window_after_completion = 1
" close the preview window when leaving insert mode
let g:ycm_autoclose_preview_window_after_insertion = 1

"" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

"" SuperTab
let g:SuperTabDefaultCompletionType = "<c-n>"

"" delimitMate
let g:delimitMate_expand_cr=2
let g:delimitMate_backspace = 1
let g:delimitMate_jump_expansion= 1
let g:delimitMate_balance_matchpairs = 1
