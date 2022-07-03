set langmenu=en_US
let $LANG = 'en_US'
set number " Show line numbers
set incsearch
set hlsearch " Highlight search
set autoread " Automatically reload files from disk in current buffer if changed in external program
syntax on " Syntax highlighting

set nocompatible

" Disable matchit and matchparen if they exist, so match-up works properly
" match-up bracket/language keyword matching plugin:
" https://github.com/andymass/vim-matchup
let g:loaded_matchit = 1

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
call plug#end()

" ALE asynchronous linter : https://github.com/dense-analysis/ale

" Don't autoselect first omnicomplete option, show options even if there is only
" one (so the preview documentation is accessible). Remove 'preview', 'popup'
" and 'popuphidden' if you don't want to see any documentation whatsoever.
" Note that neovim does not support `popuphidden` or `popup` yet:
" https://github.com/neovim/neovim/issues/10996
if has('patch-8.1.1880')
	set completeopt=longest,menuone,popuphidden
	" Highlight the completion documentation popup background/foreground the same as
	" the completion menu itself, for better readability with highlighted
	" documentation.
	set completepopup=highlight:Pmenu,border:off
else
	set completeopt=longest,menuone,preview
	" Set desired preview window height for viewing documentation.
	set previewheight=5
endif

" Tell ALE to use OmniSharp for linting C# files, and no other linters.
let g:ale_linters = { 'cs': ['OmniSharp'] }

augroup omnisharp_commands
	autocmd!

	" Show type information automatically when the cursor stops moving.
	" Note that the type is echoed to the Vim command line, and will overwrite
	" any other messages in this space including e.g. ALE linting messages.
	"	autocmd CursorHold *.cs OmniSharpTypeLookup


	" The following commands are contextual, based on the cursor position.
	autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)
	autocmd FileType cs nmap <silent> <buffer> <Leader>osfu <Plug>(omnisharp_find_usages)
	autocmd FileType cs nmap <silent> <buffer> <Leader>osfi <Plug>(omnisharp_find_implementations)
	autocmd FileType cs nmap <silent> <buffer> <Leader>ospd <Plug>(omnisharp_preview_definition)
	autocmd FileType cs nmap <silent> <buffer> <Leader>ospi <Plug>(omnisharp_preview_implementations)
	autocmd FileType cs nmap <silent> <buffer> <Leader>ost <Plug>(omnisharp_type_lookup)
	autocmd FileType cs nmap <silent> <buffer> <Leader>osd <Plug>(omnisharp_documentation)
	autocmd FileType cs nmap <silent> <buffer> <Leader>osfs <Plug>(omnisharp_find_symbol)
	autocmd FileType cs nmap <silent> <buffer> <Leader>osfx <Plug>(omnisharp_fix_usings)
	autocmd FileType cs nmap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
	autocmd FileType cs imap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)

	" Navigate up and down by method/property/field
	autocmd FileType cs nmap <silent> <buffer> [[ <Plug>(omnisharp_navigate_up)
	autocmd FileType cs nmap <silent> <buffer> ]] <Plug>(omnisharp_navigate_down)
	" Find all code errors/warnings for the current solution and populate the quickfix window
	autocmd FileType cs nmap <silent> <buffer> <Leader>osgcc <Plug>(omnisharp_global_code_check)
	" Contextual code actions (uses fzf, vim-clap, CtrlP or unite.vim selector when available)
	autocmd FileType cs nmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)
	autocmd FileType cs xmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)
	" Repeat the last code action performed (does not use a selector)
	autocmd FileType cs nmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)
	autocmd FileType cs xmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)

	autocmd FileType cs nmap <silent> <buffer> <Leader>os= <Plug>(omnisharp_code_format)

	autocmd FileType cs nmap <silent> <buffer> <Leader>osnm <Plug>(omnisharp_rename)

	autocmd FileType cs nmap <silent> <buffer> <Leader>osre <Plug>(omnisharp_restart_server)
	autocmd FileType cs nmap <silent> <buffer> <Leader>osst <Plug>(omnisharp_start_server)
	autocmd FileType cs nmap <silent> <buffer> <Leader>ossp <Plug>(omnisharp_stop_server)
augroup END

" Remap Tab to open completion suggestions
" if not at start line or after whitespace
inoremap <expr> <Tab> pumvisible() ? '<C-n>' :
			\ getline('.')[col('.')-2] =~# '[[:alnum:].-_#$]' ? '<C-x><C-o>' : '<Tab>'

" Enable snippet completion, using the ultisnips plugin
let g:OmniSharp_want_snippet=1
" UltiSnips snippet provider :  https://github.com/SirVer/ultisnips


" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Colorscheme gruvbox-material : https://github.com/sainnhe/gruvbox-material/

" Important!!
if has('termguicolors')
	set termguicolors
endif
" For dark version.
set background=dark
" For light version.
"set background=light
" Set contrast.
" This configuration option should be placed before `colorscheme gruvbox-material`.
" Available values: 'hard', 'medium'(default), 'soft'
let g:gruvbox_material_background = 'soft'
colorscheme gruvbox-material

" NERDTree file explorer : https://github.com/preservim/nerdtree
" NERDTree config

" Start NERDTree. If a file is specified, move the cursor to its window.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif
" Keybinds
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

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
