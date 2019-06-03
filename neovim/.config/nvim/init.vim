"" ----------- PLUGINS ----------------------------------

" Bootstrap vimplug system
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'benmills/vimux'
Plug 'chriskempson/base16-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'editorconfig/editorconfig-vim'
Plug 'janko/vim-test'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --no-bash' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/gv.vim'
Plug 'junegunn/limelight.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-ruby/vim-ruby'
Plug 'w0rp/ale'
call plug#end()

" ----------- GENERAL EDITOR ----------------------------------

filetype plugin indent on                "enable detection, plugins and indenting in one step
set encoding=utf-8                       "Force UTF-8 encoding for special characters
set ruler                                "Turn on the ruler
set number                               "Show line numbers
set scrolloff=10                         "Keep 10 lines below cursor always
set cursorline                           "underline the current line in the file
set cursorcolumn                         "highlight the current column. Visible in GUI mode only.
set colorcolumn=80,120
" highlight ColorColumn ctermbg=8        "set color to a light gray

" search and navigation
set showmatch                            "set show matching parenthesis
set ignorecase                           "up and lower-case when entering
set smartcase                            "assume upcase is intentional
set incsearch                            "start searching while entering

" general editor settings
set shiftwidth=2                         "number of spaces to use in each autoindent step
set tabstop=2                            "two tab spaces
set softtabstop=2                        "number of spaces to skip or insert when <BS>ing or <Tab>ing
set expandtab                            "spaces instead of tabs for better cross-editor compatibility
set smarttab                             "use shiftwidth and softtabstop to insert or delete (on <BS>) blanks
set shiftround                           "when at 3 spaces, and I hit > ... go to 4, not 5
set nowrap                               "no wrapping

" Disable beeps.
set noerrorbells visualbell t_vb=
set wildmenu                             "make tab completion act more like bash
set wildmode=list:longest                "tab complete to longest common string, like bash
set mouse=a                              "Enable the mouse in the terminal

set noswapfile                           "Disable swp files
set undofile                             "Enable persistent undo

set clipboard+=unnamedplus              " Share the system clipboard 
set splitright                           "splits open on the right.
set splitbelow                           "splits open below existing window..

" Live substitution
set inccommand=split

" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

set showcmd

" Don't autocomplete filenames that match these patterns
set wildignore=.git

au BufNewFile,BufRead *.markdown setlocal syntax=markdown

" ----------- KEY MAPPINGS ----------------------------------
"
" Note the required backslash.
let mapleader = "\<space>"

"Switch to previous file with ',spacebar'
nmap <leader><SPACE> <C-^>

" Use leader l to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Quickly save, quit, or save-and-quit
map <leader>w :w<CR>
map <leader>x :x<CR>
map <leader>q :q<CR>

" Edit config files faster
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>et :vsplit ~/.tmux.conf<cr>

" clear search highlighting with <space>,
nnoremap <esc> :noh<cr>

" simple pasting from the system clipboard
" http://tilvim.com/2014/03/18/a-better-paste.html
map <Leader>p :set paste<CR>o<esc>"+]p:set nopaste<cr>


" ----------- VISUALS ----------------------------------
"
" Try to display very long lines, rather than showing @
set display+=lastline

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬
set list

" Load the current base16-vim color scheme.
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace = 256
  silent! source ~/.vimrc_background
endif

" ----------- PLUGINS ----------------------------------

" ---- FZF
" Search from the git repo root, if we're in a repo, else the cwd
function! FuzzyFind(show_hidden)
  " Contains a null-byte that is stripped.
  let gitparent=system('git rev-parse --show-toplevel')[:-2]
  if a:show_hidden
    let $FZF_DEFAULT_COMMAND = g:fzf_default_command . ' --hidden'
  else
    let $FZF_DEFAULT_COMMAND = g:fzf_default_command
  endif
  if empty(matchstr(gitparent, '^fatal:.*'))
    silent execute ':FZF -m ' . gitparent
  else
    silent execute ':FZF -m .'
  endif
endfunction

nnoremap <c-p> :call FuzzyFind(0)<cr>
nnoremap <c-o> :call FuzzyFind(1)<cr>

" Use rg to perform the search, so that .gitignore files and the like are
" respected
let g:fzf_default_command = 'rg --files'

nnoremap <c-p> :call FuzzyFind(0)<cr>
nnoremap <c-o> :call FuzzyFind(1)<cr>
map <leader>b  :Buffer<cr>


" ---- AIRLINE
let g:airline_theme = 'base16'
let g:airline_powerline_fonts = 1

" ---- vim commentary
noremap \ :Commentary<CR>
autocmd FileType ruby setlocal commentstring=#\ %s

" ---- TSLIM
let g:tslime_always_current_session = 1

" tests
let test#strategy = "vimux"
let test#ruby#rspec#executable = "bin/rspec"

" run tests
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tt :TestVisit<CR>

" autoindentation for vim
autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType eruby setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType markdown setlocal expandtab shiftwidth=2 tabstop=2

" LINTING
let g:ale_linters = {
			\  'css':        ['csslint'],
			\  'javascript': ['eslint'],
			\  'json':       ['jsonlint'],
			\  'markdown':   ['mdl'],
			\  'ruby':       ['rubocop'],
			\  'scss':       ['sasslint'],
			\  'yaml':       ['yamllint']
			\}

let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 'never'
let g:ale_ruby_rubocop_executable = 'bundle'

nmap <silent> <leader><k> <Plug>(ale_previous_wrap)
nmap <silent> <leader><j> <Plug>(ale_next_wrap)


" GIT GUTTER
nnoremap <leader>gn :GitGutterEnable<cr>:GitGutter<cr>:GitGutterNextHunk<cr>

" ----------- Private Configuration ----------------------------------

try
  source ~/.config/nvim/air.vim
catch
  " no file.
endtry
