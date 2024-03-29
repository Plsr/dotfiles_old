" My vimrc. Not that impressive, huh?
" Maintainer:	Christian Poplawski
" @_chrispop
" github.com/plsr
" Last change:	March 21, 2016

" Basics {{{
:autocmd BufRead ~/dotfiles/vimrc setlocal foldmethod=marker " Set folding method to "marker" for this file
set encoding=utf-8 " Set character representation to utf-8
set list " Make Whitespaces Visible
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮,trail:· " Show eols trails etc

" }}}


" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

"pathogen.vim
execute pathogen#infect()

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  set undofile		" keep an undo file (undo changes after closing)
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set number "enable line numbers
autocmd VimEnter * NERDTree "Start NERDTree on vim startup
autocmd VimEnter * wincmd p "Prevent cursor to start in NERDTRee window

" Close NERDTree if its the only open buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

"Set tab width
set tabstop=2
set softtabstop=0
set expandtab
set shiftwidth=2
set smarttab

"Map 'za' to Spacebar
nnoremap <Space> za

"Folding
au FileType javascript call JavaScriptFold()

set foldmethod=manual
set foldlevelstart=1

let javaScript_fold=1         " JavaScript

" Enable powerline fonts in airline
let g:airline_powerline_fonts = 1

" Set airline theme
  let g:airline_theme='oceanicnext'

" Set color to 256
set t_Co=256

"Prevent pasting over words overwriting the cache
xnoremap p pgvy

"Set tab navigation for NERDTree
map <C-l> :tabn<CR>
map <C-h> :tabp<CR>
map <C-n> :tabnew<CR>

"Show statusline immediatley, don't wait for a split to happen
set laststatus=2

"Remap :nohl to esc key to get rid of text highlights after searching
nnoremap <silent> <esc> :noh<cr><esc>

"Remove highlighting of tabs. whitespace, etc.
hi Normal ctermbg=none
highlight NonText ctermbg=none
highlight SpecialKey ctermbg=none

" Colorscheme
syntax enable
colorscheme OceanicNext

" Neede for 
set background=dark

