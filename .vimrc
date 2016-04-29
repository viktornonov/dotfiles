"source $VIMRUNTIME/mswin.vim
"behave mswin
imap jk <Esc>
syntax on
set nocompatible
filetype off

set guifont=Monaco:h13

command -bar Hex call ToggleHex()

" helper function to toggle hex mode
function ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    silent :e " this will reload the file without trickeries
              "(DOS line endings will be shown entirely )
    let &ft="xxd"
    " set status
    let b:editHex=1
    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction

"this was breaking the vim 7.4 so deleted it not sure if it is pathogen or
"some some of the plugins that it uses
"call pathogen#infect()
"call pathogen#helptags()
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'gmarik/Vundle'

Plugin 'MarcWeber/vim-addon-mw-utils' "needed by snipMate
Plugin 'tomtom/tlib_vim' " needed by snipMate
Plugin 'garbas/vim-snipmate' "add snippets
Plugin 'honza/vim-snippets' " needed by snipMate

Plugin 'jQuery'
Plugin 'kchmck/vim-coffee-script'
Plugin 'tpope/vim-rails'
Plugin 'taglist.vim' "showing the classes and the methods in the split window
Plugin 'tpope/vim-fugitive' "git plugin which I should use more
Plugin 'The-NERD-tree' "the file tree on the left
Plugin 'syntastic' "syntax checking for vim
Plugin 'L9' "utility functions and commands
Plugin 'jamessan/vim-gnupg' "plugin for editing gnupg

Plugin 'ctrlp.vim'

Plugin 'fakeclip' "pseudo clipboard (not sure if I use it)
Plugin 'bling/vim-airline' "line at the botton

call vundle#end()
filetype plugin indent on

" CtrlP shortcuts

" tweaking airline
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_branch_prefix= 'Ϟ'
let g:airline_readonly_symbol = 'X'

:set tabstop=2
:set shiftwidth=2
:set expandtab
autocmd FileType html :setlocal sw=2 ts=2 sts=2
autocmd FileType php :setlocal sw=4 ts=4 sts=4
autocmd FileType phtml :setlocal sw=4 ts=4 sts=4
autocmd FileType c :setlocal sw=4 ts=4 sts=4
autocmd FileType cpp :setlocal sw=4 ts=4 sts=4
:set hlsearch
nnoremap <F3> :set hlsearch!<CR>

set laststatus=2 " always show status line
set backupdir=~/tmp

map <F2> :NERDTreeToggle<CR>
nmap <Space> :

:set encoding=utf-8
:set fileencodings=utf-8
:set foldmethod=indent
:set foldlevel=99

:set number
:colorscheme kolor
:highlight LineNr ctermfg=darkgrey
:set guioptions-=L
:set guioptions-=r

" copy/paste
map <C-c> "+y
"highlight trailing spaces
:highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+$/
:set colorcolumn=80
:set t_Co=256

"ctags
"<Esc> is the option key (set Option as Esc+ in the terminal profile)
map <Esc>] :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

