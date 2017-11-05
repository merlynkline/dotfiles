set encoding=utf-8

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
  set t_Co=256
endif

set background=dark

" Remember various things between edits
set viminfo='10,\"1000,:20,%,n~/.viminfo

" Highlight search matches
set hlsearch
hi Search ctermfg=none ctermbg=19
nnoremap / :noh<CR>/
" Change bracket highlighting so I don't get confused with the cursor!
highlight MatchParen ctermbg=DarkGrey cterm=bold ctermfg=NONE

" Highlight subroutine definitions in perl files
hi perlFunction ctermfg=red
hi perlSubName ctermfg=red

" More reasonable netrw directory layout
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 0

let perl_include_pod   = 1
let perl_extended_vars = 1
let perl_sync_dist     = 250

set expandtab    " Insert spaces instead of tabs in insert mode. Use spaces for indents
set tabstop=4    " Number of spaces that a <Tab> in the file counts for
set shiftwidth=4 " Number of spaces to use for each step of (auto)indent
set smartindent  " Automatically change indent level when appropriate
set ignorecase   " Case insensitive searching...
set smartcase    "  ...if your search string is all lowercase
set mouse=a      " use mouse in xterm
set list lcs=trail:·,tab:»·,nbsp:░
set backspace=indent,eol,start " Backspace can delete past start of line
set complete-=i  " Don't autocomplete from included files
set smarttab     " Tab at start of line shifts it
set incsearch    " Search as you type
set laststatus=2 " Always show status line in multi-window layouts
set wildmenu     " Menu for tab completeion of command-line
set scrolloff=2  " Minimum lines visible above/below cursor
set siso=5       " Minimum chars visible beside cursor
set display=lastline,uhex " Display start of very long last lines, use hex for controls
set formatoptions+=j " Delete comment character when joining commented lines
set autoread     " Automatically reload files changed outside vim
set sessionoptions-=options " Don't store options and mappings in sessions
set history=1000 " Max command line history entries
set tabpagemax=50 " Max tabs

" Ctrl-cursor-left/right to move between tabs
nnoremap [D :tabprevious<CR>
nnoremap [C :tabnext<cr>

" Use F2 to toggle and show 'paste' mode (no auto-indent etc)...
" ...in normal mode...
nnoremap <F2> :set invpaste paste?<CR>
" ...and in edit mode
set pastetoggle=<F2>
set noshowmode

" Use F2 to open the filename under the curosr in a new tab
nnoremap <F3> <C-W>gf

" Start file edits at same cursor position as last edit"
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

au BufRead,BufNewFile *.pm,*.pl syn match psub /^\s*sub\s.*/
au BufRead,BufNewFile *.pm,*.pl hi psub cterm=underline

if has("persistent_undo")
    set undodir=~/.vim/undodir/
    set undofile
endif

"-----------------------------------------------
" Plugins with vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()

" Status line
Plug 'itchyny/lightline.vim'

" Intelligent mixed case search and replace
Plug 'tpope/vim-abolish'

" Automatically save sessions
Plug 'powerman/vim-plugin-autosess'

" Perl syntax highlighting
Plug 'vim-perl/vim-perl', {'for': 'perl', 'do': 'make clean carp highlight-all-pragmas moose test-more try-tiny heredoc-sql'}

call plug#end()
"-----------------------------------------------

" Dark comments
hi Comment ctermfg=240

