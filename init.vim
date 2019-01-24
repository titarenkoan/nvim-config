" Platform detection {{{
	silent function! OSX()
		return has('macunix')
	endfunction
	silent function! LINUX()
		return has('unix') && !has('macunix') && !has('win32unix')
	endfunction
	silent function! WINDOWS()
		return  (has('win32') || has('win64'))
	endfunction
" }}}


" Some useful variables {{{
	if OSX() || LINUX()
		if has('nvim')
			let vimDir = '$HOME/.config/nvim/'
			let vimRc = '$HOME/.config/nvim/init.vim'
		else
			let vimDir = '$HOME/.vim/'
			let vimRc = '$HOME/.vimrc'
		endif
	elseif WINDOWS()
		let vimDir = '$HOME/vimfiles/'
		let vimRc = '$HOME/_vimrc'
	endif
" }}}

" Load local ‘before’ settings {{{

	if filereadable(expand(vimRc . '.before'))
		source expand(vimRc . '.before')
	endif

  " }}}

call plug#begin('~/.local/share/nvim/plugged')

" Autocompletion
Plug 'Valloric/YouCompleteMe'
Plug 'jiangmiao/auto-pairs'

" Color schemes
Plug 'mhartington/oceanic-next'
Plug 'altercation/vim-colors-solarized'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'fszymanski/fzf-gitignore'

" Navigation
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'kien/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'mhinz/vim-sayonara'
Plug 'janlay/NERD-tree-project' " Try to find project dir
Plug 'Xuyuanp/nerdtree-git-plugin' " NERDTree showing git status
Plug 'tpope/vim-commentary'  " Comments
Plug 'yuttie/comfortable-motion.vim'  " Scrolling physics
let g:NTPNames = ['.git*']
let g:NTPNamesDirs = ['.git']

" Startify (Home screen)
Plug 'mhinz/vim-startify'

" Neomake
Plug 'neomake/neomake'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'


call plug#end()

if (has("termguicolors"))
set termguicolors
endif

" General settings
syntax on
colorscheme OceanicNext
set encoding=UTF-8
set number
set relativenumber
set lazyredraw
set wildmenu  " List possible completions on status line
set autoindent
set linebreak
" set cursorline  " Slowers screen redrawing

" display incomplete commands
set showcmd
set noruler

" Faster moving
nmap <c-j> 4j
nmap <c-k> 4k
nmap <c-h> 4h
nmap <c-l> 4l

" Make spaces visible
set list
set listchars=tab:𝄀\ ,trail:·,extends:→,precedes:←,nbsp:¬

set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
let g:mapleader=','

set hlsearch
set incsearch
set wildignore+=*~,.git
set mouse=a

set nrformats=hex  " Hex numbers"
set smarttab  " Respect shift width setting

set hidden  " Switch buffers even if modified
set splitright  " Better split window locations

" " Stop backup files from littering all over the system
" let myBackupDir = expand(vimDir . 'tmp/backup/')
" call system('mkdir -p ' . myBackupDir)
" let &backupdir = myBackupDir . ',' . &backupdir
" " Keep backup files
" set backup

" Stop swap files from littering all over the system
let mySwapDir = expand(vimDir . 'tmp/swap//')
call system('mkdir -p ' . mySwapDir)
let &directory = mySwapDir . ',' . &directory

" " Spell check & word completion
" set spell spelllang=en_us
" set complete+=kspell

" Linting with neomake

autocmd! BufWritePost,BufEnter Neomake  " To disable lintink for readable files

call neomake#configure#automake('nrwi', 500)

let g:neomake_python_enabled_makers = ['flake8', 'cppcheck']
let g:neomake_list_height=5
let g:neomake_verbose=0

nmap <Leader>k :lclose
nmap <Leader>l :lopen


"  Comfort scrolling
noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(40)<CR>
noremap <silent> <ScrollWheelUp>   :call comfortable_motion#flick(-40)<CR>


" NERDTree settings
map <C-n> :NERDTreeToggle<CR>
autocmd BufEnter * lcd %:p:h

" YouCompleteMe settings
let g:ycm_python_binary_path = '/usr/local/bin/python3'
map <C-s> :pclose
let g:ycm_autoclose_preview_window_after_insertion = 0
let g:ycm_autoclose_preview_window_after_completion = 0
let g:ycm_global_ycm_extra_conf = '~/.local/share/nvim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_max_num_candidates = 25

map <Leader>jg :YcmCompleter GoTo<CR>
map <Leader>jdf :YcmCompleter GoToDefinition<CR>
map <Leader>jdc :YcmCompleter GoToDeclaration<CR>
map <Leader>ji :YcmCompleter GoToInclude<CR>  " c, cpp, objc, objcpp
map <Leader>jr :YcmCompleter GoToReference<CR>  " Python, JS, Java, TS
map <Leader>je :YcmCompleter GetDoc<CR>

" Easymotion settings
map <Leader> <Plug>(easymotion-prefix)

" Airline settings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline_theme = 'bubblegum'
let g:airline_powerline_fonts = 1

cnoreabbrev <expr> x getcmdtype() == ":" && getcmdline() == 'x' ? 'Sayonara' : 'x'
nmap <Leader>t :term<CR>
nmap <Leader>] :bnext<CR>
nmap <Leader>[ :bprevious<CR>

" Devicons {{{
        let g:sol = {
                \"gui": {
                        \"base03": "#002b36",
                        \"base02": "#073642",
                        \"base01": "#586e75",
                        \"base00": "#657b83",
                        \"base0": "#839496",
                        \"base1": "#93a1a1",
                        \"base2": "#eee8d5",
                        \"base3": "#fdf6e3",
                        \"yellow": "#b58900",
                        \"orange": "#cb4b16",
                        \"red": "#dc322f",
                        \"magenta": "#d33682",
                        \"violet": "#6c71c4",
                        \"blue": "#268bd2",
                        \"cyan": "#2aa198",
                        \"green": "#719e07"
                \},
                \"cterm": {
                        \"base03": 8,
                        \"base02": 0,
                        \"base01": 10,
                        \"base00": 11,
                        \"base0": 12,
                        \"base1": 14,
                        \"base2": 7,
                        \"base3": 15,
                        \"yellow": 3,
                        \"orange": 9,
                        \"red": 1,
                        \"magenta": 5,
                        \"violet": 13,
                        \"blue": 4,
                        \"cyan": 6,
                        \"green": 2
                 \}
        \}

		augroup startify
			autocmd!
			" No need to show spelling ‘errors’
			autocmd FileType startify setlocal nospell
			" Better header colour
			exec 'autocmd FileType startify if &background == ''dark'' | '.
				\ 'highlight StartifyHeader guifg='.g:sol.gui.base1.' ctermfg='.g:sol.cterm.base1.' | '.
				\ 'else | '.
				\ 'highlight StartifyHeader guifg='.g:sol.gui.base01.' ctermfg='.g:sol.cterm.base01.' | '.
				\ 'endif'
			" Better section colour
			exec 'autocmd FileType startify highlight StartifySection guifg='.g:sol.gui.blue.' ctermfg='.g:sol.cterm.blue
			" Better file colour
			exec 'autocmd FileType startify if &background == ''dark'' | '.
				\ 'highlight StartifyFile guifg='.g:sol.gui.base0.' ctermfg='.g:sol.cterm.base0.' | '.
				\ 'else | '.
				\ 'highlight StartifyFile guifg='.g:sol.gui.base00.' ctermfg='.g:sol.cterm.base00.' | '.
				\ 'endif'
			" Better special colour
			exec 'autocmd FileType startify highlight StartifySpecial gui=italic cterm=italic guifg='.g:sol.gui.yellow.' ctermfg='.g:sol.cterm.yellow
			" Hide those ugly brackets
			exec 'autocmd FileType startify if &background == ''dark'' | '.
				\ 'highlight StartifyBracket guifg='.g:sol.gui.base03.' ctermfg='.g:sol.cterm.base03.' | '.
				\ 'else | '.
				\ 'highlight StartifyBracket guifg='.g:sol.gui.base3.' ctermfg='.g:sol.cterm.base3.' | '.
				\ 'endif'
		augroup END

		augroup devicons
			autocmd!
			autocmd FileType nerdtree setlocal nolist
			autocmd FileType nerdtree syntax match hideBracketsInNerdTree "\]" contained conceal containedin=ALL
			autocmd FileType nerdtree syntax match hideBracketsInNerdTree "\[" contained conceal containedin=ALL
			autocmd FileType nerdtree setlocal conceallevel=3
			autocmd FileType nerdtree setlocal concealcursor=nvic
		augroup END
			autocmd FileType nerdtree setlocal concealcursor=nvic
		augroup END
		function! DeviconsColors(config)
			let colors = keys(a:config)
			augroup devicons_colors
				autocmd!
				for color in colors
					if color == 'normal'
						exec 'autocmd FileType nerdtree if &background == ''dark'' | '.
							\ 'highlight devicons_'.color.' guifg='.g:sol.gui.base01.' ctermfg='.g:sol.cterm.base01.' | '.
							\ 'else | '.
							\ 'highlight devicons_'.color.' guifg='.g:sol.gui.base1.' ctermfg='.g:sol.cterm.base1.' | '.
							\ 'endif'
					elseif color == 'emphasize'
						exec 'autocmd FileType nerdtree if &background == ''dark'' | '.
							\ 'highlight devicons_'.color.' guifg='.g:sol.gui.base1.' ctermfg='.g:sol.cterm.base1.' | '.
							\ 'else | '.
							\ 'highlight devicons_'.color.' guifg='.g:sol.gui.base01.' ctermfg='.g:sol.cterm.base01.' | '.
							\ 'endif'
					else
						exec 'autocmd FileType nerdtree highlight devicons_'.color.' guifg='.g:sol.gui[color].' ctermfg='.g:sol.cterm[color]
					endif
					exec 'autocmd FileType nerdtree syntax match devicons_'.color.' /\v'.join(a:config[color], '|').'/ containedin=ALL'
				endfor
			augroup END
		endfunction
		let g:devicons_colors = {
			\'normal': ['', '', '', '', ''],
			\'emphasize': ['', '', '', '', '', '', '', '', '', '', ''],
			\'yellow': ['', '', ''],
			\'orange': ['', '', '', 'λ', '', ''],
			\'red': ['', '', '', '', '', '', '', '', ''],
			\'magenta': [''],
			\'violet': ['', '', '', ''],
			\'blue': ['', '', '', '', '', '', '', '', '', '', '', '', ''],
			\'cyan': ['', '', '', ''],
			\'green': ['', '', '', '']
		\}
		call DeviconsColors(g:devicons_colors)
" }}}

