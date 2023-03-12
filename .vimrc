set langmenu=en_US
let $LANG = 'en_US'
set number " Show line numbers
set incsearch
set hlsearch " Highlight search
set autoread " Automatically reload files from disk in current buffer if changed in external program
set expandtab " Expand tabs to spaces
set tabstop=4 " One tab = 4 spaces
syntax on " Syntax highlighting

set nocompatible

" Plug (vim plugin manager)

call plug#begin()
" plugins go here
" gruvbox-material UI theme
Plug 'sainnhe/gruvbox-material'
" Syntax highlighting for many programming languages
Plug 'sheerun/vim-polyglot'
" OmniSharp C# engine running on Roslyn Server
Plug 'OmniSharp/omnisharp-vim'
" Asynchronous linter
Plug 'dense-analysis/ale'
" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Project Explorer
Plug 'preservim/nerdtree'
Plug 'tpope/vim-surround'
" Graphical debugger
Plug 'puremourning/vimspector'
Plug 'andymass/vim-matchup'
" Vim Git integration
Plug 'tpope/vim-fugitive'
" Airline status bar
Plug 'vim-airline/vim-airline'
" tt.vim: Configurable timer
Plug 'mkropat/vim-tt'
" vim-rainbow: Rainbow-coloured highlighting of matching brackets
Plug 'frazrepo/vim-rainbow'
" commentary.vim: Quickly comment/uncomment stuff
Plug 'tpope/vim-commentary'
" coc.nvim: Autocompletion/Intellisense engine
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" tagalong.vim: Automatically edits closing html tag when the opening tag is
" changed
Plug 'AndrewRadev/tagalong.vim'

call plug#end()

" Windows sourcing plugin paths:
if has('win32') || has('win64')

" Custom configs for ALE 
source $HOME/.vim/userconfigs/ale.vim
" Custom configs for vim-tt plugin
source $HOME/.vim/userconfigs/vim-tt.vim
" Custom configs for vim-rainbow plugin
source $HOME/.vim/userconfigs/vim-rainbow.vim
" Custom configs for vim-matchup 
source $HOME/.vim/userconfigs/vim-matchup.vim
" Custom configs for vim-omnisharp
source $HOME/.vim/userconfigs/vim-omnisharp.vim
" Custom configs for ultisnippets
source $HOME/.vim/userconfigs/ultisnippets.vim
" Custom configs for gruvbox-material 
source $HOME/.vim/userconfigs/gruvbox-material.vim
" Custom configs for NERDTree
source $HOME/.vim/userconfigs/nerdtree.vim
" Custom configs for coc.nvim
source $HOME/.vim/userconfigs/coc-nvim.vim
" Custom configs for coc-html
source $HOME/.vim/userconfigs/coc-html.vim
" Custom configs for tagalong.vim
source $HOME/.vim/userconfigs/tagalong.vim
" Custom configs for nu HTML checker script
source $HOME/.vim/userconfigs/nu-html-checker.vim
"
" UNIX sourcing plugin paths:
else
" Custom configs for ALE 
source ~/.vim/userconfigs/ale.vim
" Custom configs for vim-tt plugin
source ~/.vim/userconfigs/vim-tt.vim
" Custom configs for vim-rainbow plugin
source ~/.vim/userconfigs/vim-rainbow.vim
" Custom configs for vim-matchup 
source ~/.vim/userconfigs/vim-matchup.vim
" Custom configs for vim-omnisharp
source ~/.vim/userconfigs/vim-omnisharp.vim
" Custom configs for ultisnippets
source ~/.vim/userconfigs/ultisnippets.vim
" Custom configs for gruvbox-material 
source ~/.vim/userconfigs/gruvbox-material.vim
" Custom configs for NERDTree
source ~/.vim/userconfigs/nerdtree.vim
" Custom configs for coc.nvim
source ~/.vim/userconfigs/coc-nvim.vim
" Custom configs for tagalong.vim
source ~/.vim/userconfigs/tagalong.vim
" Custom configs for nu HTML checker script
source ~/.vim/userconfigs/nu-html-checker.vim
endif

" Show current command, e.g. leader key (default: '\')
set showcmd
" Set leader key timeout to two seconds (1 second default), the time the
" leader key waits for chained hotkeys
set timeoutlen=2000
set ttimeoutlen=100

map <esc> :let @/ = "" <CR>
nnoremap <c-z> <nop> " Unmaps 'Ctrl Z' to not return to terminal without warning

" Remap carriage return to insert an empty line after typing out {, [ or (
inoremap {<cr> {<cr>}<c-o>O<tab>
inoremap [<cr> [<cr>]<c-o>O<tab>
inoremap (<cr> (<cr>)<c-o>O<tab>

" Shortcut for switching buffers (by buffer number, e.g. 'gb 3')
nnoremap gb :ls<CR>:b<Space>

" Fix coc-json highlighting of json comments
autocmd FileType json syntax match Comment +\/\/.\+$+

" Remaps gf to open a new file if file under cursor does not exist
noremap <leader>gf :e <cfile><cr>

