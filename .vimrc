" TODO:
"  - See how much of these settings and remaps match Neovim's defaults
"  - Swap Vundle out with packer.nvim or vim-plug
"  - Combine this file and ~/.config/nvim/init.vim
"  - See how much of this Just Works in the Windows build of Qt-Nvim
"  - Unfuck fzf configuration, which is probably blocking Windows compat
"  - Plugin research:
"   - coc.nvim
"  - What's this guy's deal: https://github.com/shxfee/dotfiles/tree/master/nvim
"

set nocompatible
filetype off

" set rtp+=/opt/homebrew/bin/fzf
set rtp+=/opt/homebrew/Cellar/fzf/0.28.0/bin/

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" make my life less shitty
Plugin 'gmarik/Vundle.vim'
" 'you are bad at vim' plugins
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" git status for NERDTree
Plugin 'Xuyuanp/nerdtree-git-plugin'
" fuzzy finder
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/fzf'
" grep helper
Plugin 'mileszs/ack.vim'
" 'vim is totally an IDE' plugins
Plugin 'rust-lang/rust.vim'
Plugin 'jwalton512/vim-blade'
Plugin 'prisma/vim-prisma'
" Plugin 'w0rp/ale'
Plugin 'dense-analysis/ale'
Plugin 'jlcrochet/vim-razor'
" QOL buffer handling
Plugin 'qpkorr/vim-bufkill'
" auto closing html/xml/jsx tags
Plugin 'alvan/vim-closetag'
" smart argument/array/object wrapping
Plugin 'FooSoft/vim-argwrap'
" moving argument/array/object values forward and backward
Plugin 'AndrewRadev/sideways.vim'
" themes
Plugin 'savq/melange'
Plugin 'sainnhe/everforest'
Plugin 'dikiaap/minimalist'
Plugin 'junegunn/seoul256.vim'
Plugin 'haystackandroid/strawberry'
" disabled for neovim Plugin 'morhetz/gruvbox'
Plugin 'gruvbox-community/gruvbox'
" source for hybrid_reverse colorscheme
Plugin 'kristijanhusak/vim-hybrid-material'
" smarter word verbs (w/b/e etc)
Plugin 'chaoren/vim-wordmotion'
" smarter commenting
Plugin 'tomtom/tcomment_vim'
""" MARRY ME, TPOPE
" vim troubleshooting
Plugin 'tpope/vim-scriptease'
" format your json
Plugin 'tpope/vim-jdaddy'
" quotes, braces, tags, all u need
Plugin 'tpope/vim-surround'
" . repeat command works with plugins, is generally smarter
Plugin 'tpope/vim-repeat'
" git helper
Plugin 'tpope/vim-fugitive'
Plugin 'tommcdo/vim-fubitive'
Plugin 'tpope/vim-sleuth'

Plugin 'prettier/vim-prettier'

if has("nvim")
    Plugin 'rktjmp/lush.nvim'
    Plugin 'nvim-treesitter/nvim-treesitter'
    Plugin 'neovim/nvim-lspconfig'
    Plugin 'williamboman/nvim-lsp-installer'
    Plugin 'nvim-lua/plenary.nvim'
    Plugin 'nvim-telescope/telescope.nvim'
    Plugin 'nvim-telescope/telescope-fzf-native.nvim'
    Plugin 'lewis6991/gitsigns.nvim'
    Plugin 'hrsh7th/cmp-nvim-lsp'
    Plugin 'hrsh7th/cmp-buffer'
    Plugin 'hrsh7th/nvim-cmp'
end

call vundle#end()

" set indent sizes by filetype
filetype plugin indent on

set completeopt=menu,menuone,noselect

let g:ale_enabled = 0

" (vim-airline/vim-airline)
" let g:airline_theme='gruvbox'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
" removes special characters to make file info shorter
let g:airline_section_z = '%3l/%L:%3v'
let g:airline#extensions#branch#enabled = 1
" shortens git branch name. origin/feature/foo -> foo
let g:airline#extensions#branch#format = 1
" don't render the empty space of the sections we hide
let g:airline_skip_empty_sections = 1
" hide syntax label
let g:airline_section_x=''
" hide encoding label
let g:airline_section_y=''
" shorten mode label to a single character
let g:airline_mode_map = {
\ '__' : '-',
\ 'n'  : 'N',
\ 'i'  : 'I',
\ 'R'  : 'R',
\ 'c'  : 'C',
\ 'v'  : 'V',
\ 'V'  : 'V',
\ '' : 'V',
\ 's'  : 'S',
\ 'S'  : 'S',
\ 't'  : 'T',
\ }

" fzf
" Enable per-command history
" - History files will be stored in the specified directory
" - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
"   'previous-history' instead of 'down' and 'up'.
let g:fzf_history_dir = '~/.local/share/fzf-history'


" (w0rp/ale)

" (FooSoft/vim-argwrap)
let g:argwrap_tail_comma = 1

" (mileszs/ack.vim) use ag, ack's faster cousin, if it's installed
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif


" set leader to spacebar
let mapleader = "\<Space>"

" allowing backspaces over the start of insert
set backspace=2

"" maps
inoremap jk <ESC>

" jump between buffers
nnoremap <silent> <tab> :bnext<CR>
nnoremap <silent> <S-tab> :bprev<CR>

" redirect delete into /dev/null buffer. IOW don't yank. i think this still
" wipes what was in the registry, so need a better solution?
nnoremap x "_x

" quick bufkill
nnoremap <leader>bd :BD<CR>

" quick save
noremap <leader>s :update<CR>

" (scrooloose/nerdtree)
nnoremap <leader>nt :NERDTreeToggle<CR>

" opens nerdtree and jumps the cursor to the directory location of the active
" buffer
nnoremap <leader>nf :NERDTreeFind<CR>

" quick n dirty grepping. query is a text literal and not regex per `-F`.
" `-W` truncates output to 100 characters of the matching line, so the output
" doesn't take forever to print.
" results open in a quickfix window you can do :cfdo stuff in.
" this will grep from your pwd.
nnoremap <leader>/ :Ack!<space>-W<space>100<space>-F<space>""<left>

" puts the absolute path of the active buffer in your system clipboard
nnoremap <leader>cp :let @+=expand("%:p")<CR>

" attempt to open path under cursor in a vertical split
nnoremap <silent> <C-w>f :vert wincmd f<CR>

" i don't remember what this does.
xnoremap <silent> p p:let @+=@0<CR>

" easier switching focus between window splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" insert a line above or below while remaining cursor position,
" and without going into insert mode (technically we go in and out very
" quickly)
nnoremap <leader>o mzo<esc>`z
nnoremap <leader>O mzO<esc>`z

" (FooSoft/vim-argwrap)
nnoremap <silent> <leader>a :ArgWrap<CR>

" (AndrewRadev/sideways.vim)
nnoremap <leader>h :SidewaysLeft<CR>
nnoremap <leader>l :SidewaysRight<CR>

" Preview markdown in the browser; deletes the generated html as soon as the
" page has been opened.
nnoremap <silent> <leader><C-r> :!pandoc % -f markdown -t html --css ~/github-markdown.css -s -o /tmp/render.html && open /tmp/render.html -g<CR>
" nnoremap <leader>t :FZF<CR>

" // while in visual mode to forward search what's visually highlighted.
" this does a text literal search, NOT regexp.
" also escapes slash characters to be slightly more robust.
" more naive implementation would look like:
" vnoremap // y/\V<C-R>"<CR>
vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>

" move everything from cursor to end of line onto a new line below, while
" maintaining normal mode & cursor position. saves a small amount of time
nnoremap <silent> <leader>i mxi<CR><esc>`x

" turns on syntax highlighting
syntax on

set encoding=utf-8

" turn on line numbers. the current line will display the absolute line
" number, and all lines above and below will show the relative number.
" your coworkers hate this.
set number relativenumber

" highlight the line the cursor is on
set cursorline

" enable copying to system clipboard. doesn't seem to break anything else
set clipboard=unnamed

" what is your team's current indentation scheme?
set autoindent
set noexpandtab
set tabstop=2
set shiftwidth=2

" auto reload files when they're changed outside of vim
" (I think) unless they're deleted
set autoread

" allow . repeats in visual mode
vnoremap . :norm.<CR>

" open new splits to the right or below like a non sicko
set splitbelow
set splitright

" multiple buffers open in a session
set hidden

" softwrap on word boundaries at 80 chars (ignoring gutter)
set wrap
set linebreak
set textwidth=80
" indent 4 chars from the the indent depth of the wrapped line
set breakindent
set breakindentopt=shift:4,sbr
" little gutter guy to indicate a line is part of a softwrap
set showbreak=>>

" ignore case when searching
set ignorecase

" ... unless there's a capital letter in the query
set smartcase

" use visual bells instead of audio
set noerrorbells

" delete trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" enable mouse input like the coward you are
set mouse=a

set background=dark
let g:gruvbox_italic=1
let g:everforest_enable_italic=1
set termguicolors
colorscheme everforest

" highlight the current (absolute) line number to make it stand out
hi CursorLineNR guifg=#D75F5F ctermfg=167
augroup CLNRSet
    autocmd! ColorScheme * hi CursorLineNR ctermfg=167 guifg=#D75F5F
augroup END
" make relative line numbers stand out a bit more
highlight LineNr ctermfg=grey

" set code folding to use syntax (e.g. braces)
set foldmethod=syntax

" don't fold the whole file on open
set foldlevel=99

" start searching before we hit enter when we do /
set incsearch

" highlight matching search results
set hlsearch

" after doing a search, hit enter to silently clear highlighting until the
" next search. this doesn't remove the search term from vim's state, so you
" can still do "cgn" etc.
nnoremap <silent> <CR> :noh<CR><CR>

" make search results visually stand out
hi Search cterm=bold,underline

" Delete comment character when joining commented lines.
set formatoptions+=j

vnoremap <leader><C-p> :PrettierFragment<CR>

" opens the git history of currently visually selected lines.
" slightly less buggy than vim-fugitive's Glog. useful
" if you are too angry for a single git blame
function! GitDiffFileRange() range
    " 1th index of getpos is line number. see `:help getpos()`
    " '< param means `start of visual selection`
    let visual_start = getpos("'<")[1]
    " '> means `end of visual selection`
    let visual_end = getpos("'>")[1]
    " @% is active buffer's absolute file path
    let range = visual_start . ',' . visual_end . ':' . @%

    " shhh quietly clear the terminal so you don't see previous log output
    silent !clear

    " full execution should look like `git log -L 1,5:myfile.js`
    execute ":!git log -L " . range
endfunction
" i vow never to write another line of vimscript

vnoremap <C-l> :call GitDiffFileRange()<CR>

" LAB WEEK SPRING 2020
let $CACA_DRIVER = 'ncurses'
nnoremap <leader>oa :execute "terminal ++close mplayer -prefer-ipv4 -really-quiet -vo caca -nosound -playlist " . expand("<cfile>")<cr>
nnoremap <leader>ob :execute "ver terminal ++curwin ++close mplayer -prefer-ipv4 -really-quiet -vo caca -nosound -playlist " . expand("<cfile>")<cr>
" /Users/kburke348/Downloads/bbb.m3u8
" http://multiplatform-f.akamaihd.net/i/multi/april11/cctv/cctv_,512x288_450_b,640x360_700_b,768x432_1000_b,1024x576_1400_m,.mp4.csmil/master.m3u8
" http://multiplatform-f.akamaihd.net/i/multi/will/bunny/big_buck_bunny_,640x360_400,640x360_700,640x360_1000,950x540_1500,.f4v.csmil/master.m3u8


" # CHEATSHEET
"
" ## Mega-global find/replace
" Example: replace foo with bar everywhere in the current project
" <space>/ foo
" (a quickfix window should open through ack.vim)
" :cfdo %s//bar/gce
" %s// -> captures the text found by ack.vim so you don't have to type it out
" again
" bar -> what you want to replace it with
" g -> replaces every occurrence in the matched file
" c -> confirm each replacement
" e -> swallow errors
"
" ## Equalize split buffer sizes
" <ctrl-w>=
"
" ## Quickfix + Macro
" Example: do something too complicated for a single sed command
" in all of your quickfix buffers.
" :cfdo :norm! @a
" :norm! -> switch to normal mode before executing the next command (our macro)
" @a -> run the macro 'a'. can also do @@ to execute the last run macro
