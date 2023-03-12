
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
        " For better performance
        let g:gruvbox_material_better_performance = 1
        colorscheme gruvbox-material
		" To enable [airline](https://github.com/vim-airline/vim-airline) color scheme, put this in your vimrc:
		let g:airline_theme = 'gruvbox_material'

