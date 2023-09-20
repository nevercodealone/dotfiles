" Initialize plugin manager
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Declare the list of plugins.
Plug 'preservim/nerdtree'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'lifepillar/vim-solarized8'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'phpactor/phpactor', {'for': 'php', 'do': ':PhpactorInstall'}

" End of plugin declaration
call plug#end()

" General Vim settings
set tabstop=4
set shiftwidth=4
set expandtab
set spell
set spelllang=en_us,de_de
syntax on
set termguicolors
set background=dark
colorscheme solarized8
set number
set rnu
set mouse=a

" NERDTree settings (omitted for brevity)

" coc.nvim settings
set encoding=utf-8
set nobackup
set nowritebackup
set updatetime=300
set signcolumn=yes

" Leader
let mapleader = ","

" Cursor shape settings
let &t_SI = "\e[5 q"  " Cursor shape in Insert mode
let &t_SR = "\e[4 q"  " Cursor shape in Replace mode
let &t_EI = "\e[2 q"  " Cursor shape in Normal mode

" Toggle cursor line on entering and leaving insert mode
autocmd InsertEnter,InsertLeave * set cul!

" Save
nnoremap <C-s> :w<CR>

" Use tab for trigger completion with characters ahead and navigate
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <CR> to confirm completion, `<C-g>u` means break undo chain at current position.
inoremap <expr> <CR> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Fuzzy finder
nnoremap ff :Files<CR>
nnoremap <leader>w :w!<CR>


nnoremap <C-t> :NERDTreeToggle<CR>

" coc.nvim key mappings
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nnoremap <silent> K :call ShowDocumentation()<CR>
autocmd CursorHold * silent call CocActionAsync('highlight')

" Other coc.nvim settings and mappings (omitted for brevity)

" Function to show documentation
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" End of file

