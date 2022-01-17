syntax on
filetype plugin indent on
set encoding=utf-8
set hidden
set updatetime=300
set shortmess+=c
set nowritebackup
set noerrorbells
set tabstop=2 
set softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set nu
set relativenumber
set nowrap
set smartcase 
set noswapfile
set nocompatible
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set nohlsearch
set scrolloff=8
set colorcolumn=90
set cmdheight=2
set tabpagemax=10 " How mani tabs you want to open
set showtabline=2 " Show the tab line on top


highlight ColorColumn ctermbg=0 guibg=lightgrey
  
call plug#begin('~/.vim/plugged')

Plug 'dominikduda/vim_current_word' " To highlight another same words
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'frazrepo/vim-rainbow'
Plug 'jiangmiao/auto-pairs'
"Plug 'mattn/emmet-vim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'} " To multi select lines
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } "fzf to find files
Plug 'junegunn/fzf.vim' "fzf to find files
Plug 'morhetz/gruvbox'
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'
"Plug 'leafgarland/typescript-vim'
Plug 'vim-utils/vim-man'
"Plug 'mbbill/undotree'
Plug 'rust-lang/rust.vim'
Plug 'preservim/nerdtree'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-surround'
Plug 'sheerun/vim-polyglot' " To enable jsx, js, syntax
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"Plug 'pangloss/vim-javascript'

call plug#end()

colorscheme gruvbox
set background=dark

"Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
else
    set signcolumn=yes
endif

if executable('rg')
    let g:rg_derive_root='true'
endif

" Change the block cursor to beam: 
"augroup my_cursor
"    au!
"    autocmd VimEnter * silent !echo -ne "\e[5 q"
"    autocmd VimLeave * silent !echo -ne "\e[2 q"
"augroup END
" let &t_SI = "\e[2 q
" let &t_EI = "\e[6 q 
let mapleader = " "
let g:ctrlp_user_command = [".git/","git --git-dir=%s/.git ls-files -oc --exclude-standard"]
let g:netrw_browse_split=2
let g:netrw_banner=0
let g:netrw_winsize=25
let g:ctrlp_use_caching=0
" let g:rainbow_active = 1
let NERDTreeShowHidden=1 " Show the hidden files
let g:NERDTreeWinSize=18 " Check the NerdTree size with :let g:NERDTreeWinSize
let g:closetag_filenames='*.html,*.xhtml,*.phtml,*.js,*.php' " Close automaticly tags
let g:closetag_xhtml_filenames='*.xhtml,*.jsx'
let g:rustfmt_autosave=1

" NerdTree commands
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Find files with fzf 
nnoremap <leader>f :Files<CR>

" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif
 

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | 

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Arrows 
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''

"----- Coc-config -----
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
    \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Map function and class text objects
" " NOTE: Requires 'textDocument.documentSymbol' support from the language
" server."
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Vim_current_word config
let g:vim_current_word#highlight_twins = 1 " Enable the underscore in each duplicate word
let g:vim_current_word#highlight_current_word = 0 " Disable highlight in current word
autocmd BufAdd NERD_tree_*,your_buffer_name.rb,*.js :let b:vim_current_word_disabled_in_this_buffer = 1
hi CurrentWord ctermbg=53
hi CurrentWordTwins ctermbg=237

" nnoremaps with Leader
" Moving into the windows
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" Moving lines
nnoremap <Leader>mj :m +1<CR> 
nnoremap <Leader>mk :m -2<CR> 

" Close the vim window
nnoremap <Leader>q :q<CR>

" Resize windows
nnoremap <silent> <Leader>+ :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>


