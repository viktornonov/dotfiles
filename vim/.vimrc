imap jk <Esc>

"hardcore
map <Left> <NOP>
map <Up> <NOP>
map <Right> <NOP>
map <Down> <NOP>
imap <Left> <NOP>
imap <Up> <NOP>
imap <Right> <NOP>
imap <Down> <NOP>

nmap h <NOP>
nmap l <NOP>

syntax on
set nocompatible
filetype off

set guifont=Monaco:h13
" indentation shit
set cindent

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

"C/C++ custom functions
map gc :call CompileCplus()<CR>

function CompileCplus()
  !clear && echo '------------------' && g++ -std=c++11 -Wall % && ./a.out
endfunction


"this was breaking the vim 7.4 so deleted it not sure if it is pathogen or
"some some of the plugins that it uses
"call pathogen#infect()
"call pathogen#helptags()
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'gmarik/Vundle.vim'

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
Plugin 'Raimondi/delimitMate' "plugin for autoclosing parenthesis and quotes

Plugin 'vim-javascript'

Plugin 'git@github.com:kannokanno/previm.git'
Plugin 'fakeclip' "pseudo clipboard that is used with the option set clipboard=unnamed below
Plugin 'bling/vim-airline' "line at the bottom
Plugin 'easymotion/vim-easymotion'

call vundle#end()
filetype plugin indent on
" fuzzy search
set rtp+=/usr/local/opt/fzf
let g:fzf_layout = { 'down': '~20%' }
let currentDir = getcwd()
map ,f :FZF .<CR>

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
autocmd FileType java :setlocal sw=4 ts=4 sts=4
autocmd FileType crontab setlocal nobackup nowritebackup
autocmd FileType ruby setlocal smartindent sw=2 ts=2 et cinwords=if,else,for,while,try,except,finally,def,class,describe,context,it

:set hlsearch
nnoremap <F3> :set hlsearch!<CR>

set laststatus=2 " always show status line
set backupdir=~/tmp
set directory^=$HOME/tmp// "// at the end makes Vim use the absolute path to the file to create the swap file

map <F2> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

nmap <Space> :

:set encoding=utf-8
:set fileencodings=utf-8
:set foldmethod=indent
:set foldlevel=99
:set foldlevelstart=1

:set number
:colorscheme kolor
:highlight LineNr ctermfg=darkgrey
:set guioptions-=L
:set guioptions-=r

" copy/paste
" does not work under tmux
map <C-c> "+y
map <C-e> $
map <C-a> ^
"<C-r><C-o> paste content of the buffer with the original indentation, which
"is way faster
imap <C-v> <C-r><C-o>+

"highlight trailing spaces
:highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+$/
:set colorcolumn=80
:set t_Co=256

set tags=.git/tags

"ctags
"<Esc> is the option key (set Option as Esc+ in the terminal profile)
":map <Esc>] :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

"cscope

":cscope add .git/cscope.out
:map <Esc>p :cscope find c <cword><CR>

"syntastic
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_javascript_jslint_args = "--white --nomen --browser --devel --windows --predef jQuery --predef $ --todo"
let g:syntastic_cpp_compiler_options = ' -std=c++11'

" Wrap visual selection in an LaTex tag.
vmap <Leader>w <Esc>:call VisualLatexWrap()<CR>
function! VisualLatexWrap()
  let tag = '$'
  normal `>
  if &selection == 'exclusive'
    exe "normal i[/".tag."]"
  else
    exe "normal a[/".tag."]"
  endif
  normal `<
  exe "normal i[".tag."]"
  normal `<
endfunction

nmap ls <Plug>(easymotion-sn)
