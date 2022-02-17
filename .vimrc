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
Plugin 'w0rp/ale'
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
Plugin 'dikiaap/minimalist'
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

if has("nvim")
    Plugin 'rktjmp/lush.nvim'
    Plugin 'nvim-treesitter/nvim-treesitter'
    Plugin 'neovim/nvim-lspconfig'
    Plugin 'williamboman/nvim-lsp-installer'
end

call vundle#end()

" set indent sizes by filetype
filetype plugin indent on

" (vim-airline/vim-airline)
" let g:airline_theme='gruvbox'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
" removes special characters to make file info shorter
let g:airline_section_z = '%3l/%L:%3v'
let g:airline#extensions#branch#enabled = 1
" shortens git branch name. feature/foo -> foo
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

" (wincent/command-t)
" let g:CommandTHighlightColor = 'white'

" fzf
" Enable per-command history
" - History files will be stored in the specified directory
" - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
"   'previous-history' instead of 'down' and 'up'.
let g:fzf_history_dir = '~/.local/share/fzf-history'


" (w0rp/ale)
let g:ale_fixers = {'javascript': []}

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
nnoremap <leader>n :NERDTreeToggle<CR>

" opens nerdtree and jumps the cursor to the directory location of the active
" buffer
nnoremap <leader>f :NERDTreeFind<CR>

" quick n dirty grepping. query is a text literal and not regex per `-F`.
" `-W` truncates output to 100 characters of the matching line, so the output
" doesn't take forever to print fun fact: results open in a quickfix window
" you can do :cfdo stuff in this will grep from whatever directory vim is
" operating out of, (check with :pwd)
nnoremap <leader>/ :Ack!<space>-W<space>100<space>-F<space>""<left>

" puts the absolute path of the active buffer in your system clipboard
nnoremap <leader>cp :let @+=expand("%:p")<CR>

" attempt to open path under cursor in a vertical split
nnoremap <silent> <C-w>f :vert wincmd f<CR>

" don't remember what this does. might check system clipboard when pasting?
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

nnoremap <leader>t :FZF<CR>

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
set expandtab
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

" lines of code will not wrap to the next line
set nowrap

" ignore case when searching
set ignorecase

" ... unless there's a capital letter in the query
set smartcase

" enable 256 colors
let base16colorspace=256
set t_CO=256

" use visual bells instead of audio
set noerrorbells

" delete trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" silently back up the vimrc to Dropbox on save
" autocmd BufWritePost ~/.vimrc :silent !cp ~/.vimrc ~/Dropbox/dotfiles/.vimrc
" bash_profile too
" autocmd BufWritePost ~/.bash_profile :silent !cp ~/.bash_profile ~/Dropbox/dotfiles/.bash_profile

" don't ingest unnecessary huge folders when loading fuzzy matching uses vim's
" default wildignore matches
let g:CommandTWildIgnore=&wildignore . ",node_modules,coverage,dist,build"

" allow us to use the mouse like a punk
set mouse=a

set background=dark
colorscheme gruvbox

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
" this might be on by default in neovim
set incsearch

" highlight matching search results
set hlsearch
" after doing a search, hit enter to silently clear
" highlighting until the next search
nnoremap <silent> <CR> :noh<CR><CR>

" make search results visually stand out
hi Search cterm=bold,underline

" Delete comment character when joining commented lines.
" requires vim 7 or up. just get vim 8, dummy
if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j
endif

" use a different default font if we're using MacVim
if has("gui_macvim")
    " you can get Source Code Pro and a billion other fonts with Homebrew:
    " brew tap caskroom/fonts -> brew cask install source-code-pro
    set guifont=Source\ Code\ Pro:h13
endif

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
"http://rdmedia.bbc.co.uk/dash/ondemand/bbb/2/client_manifest-common_init.mpd
" http://dash.akamaized.net/dash264/TestCases/1a/sony/SNE_DASH_SD_CASE1A_REVISED.mpd
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
