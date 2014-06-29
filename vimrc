runtime! debian.vim

" Vim5 and later versions support syntax highlighting. Uncommenting the
" following enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
 filetype plugin indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

filetype on
:filetype plugin on

" NERDTree
autocmd VimEnter * NERDTree
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
map <F2> :NERDTreeToggle<CR>

" styling
:set number
:set guifont=DroidSansMono\ 11
:colorscheme wombat
if has("gui_running")
	set lines=999 columns=999
endif

" remove toolbars and menus
:set go=

" key remappings
:imap jk <Esc>
:nmap <Space> :

"enable normal copy paste
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<Esc>"+p
imap <C-v> <C-r><C-o>+
