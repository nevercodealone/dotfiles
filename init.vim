" Install neovim
" Symlink this file into ~/.config/nvim/init.vim
" Install vim-plug https://github.com/junegunn/vim-plug
" Open nvim and run: :PlugInstall
" Requires python3 for autocomplete

" plugins
call plug#begin('~/.local/share/nvim/plugged')
    " completion
    Plug 'phpactor/ncm2-phpactor'
    " completion for quotes, parans, brackets, etc.
    Plug 'mhartington/oceanic-next'
    " comment stuff out
    Plug 'tpope/vim-commentary'
    " quoting/parenthesizin
    Plug 'tpope/vim-surround'
    " git wrapper
    Plug 'tpope/vim-fugitive'
    " show git diff
    Plug 'airblade/vim-gitgutter'
    " file finder
    Plug 'ctrlpvim/ctrlp.vim'
    " theme
    Plug 'Raimondi/delimitMate'
    Plug 'lifepillar/vim-solarized8'
    Plug 'dracula/vim', { 'as': 'dracula' }
    Plug 'altercation/vim-colors-solarized'
    " status bar
    Plug 'vim-airline/vim-airline'
    " ack support
    Plug 'mileszs/ack.vim'
    " php
    Plug 'phpactor/phpactor', {'do': ':call phpactor#Update()', 'for': 'php'}
    Plug 'joonty/vim-phpqa'
    " Xdebug
    Plug 'vim-vdebug/vdebug'
    " twig
    Plug 'lumiliet/vim-twig'
    " linting
    Plug 'w0rp/ale'
    " trim
    Plug 'koryschneider/vim-trim'
    " file tree
    Plug 'scrooloose/nerdtree'
    " Leader guide
    Plug 'hecal3/vim-leader-guide'
call plug#end()

" Leader key
let mapleader=","
let g:lmap =  {}

let g:lmap.f = { 'name' : 'File Menu' }
let g:lmap.o = { 'name' : 'Open Stuff' }

" autocomplete

let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"

" PHP7
let g:ultisnips_php_scalar_types = 1

" Omni-completion
autocmd FileType php setlocal omnifunc=phpactor#Complete
let g:phpactorOmniError = v:true
let g:phpactorPhpBin = "/usr/bin/php"
let g:phpactorCompletionIgnoreCase = 0

" context-aware menu with all functions (ALT-m)
nnoremap <m-m> :call phpactor#ContextMenu()<cr>
nnoremap gd :call phpactor#GotoDefinition()<CR>
nnoremap gr :call phpactor#FindReferences()<CR>
" Extract method from selection
vmap <silent><Leader>em :<C-U>call phpactor#ExtractMethod()<CR>
" " extract variable
vnoremap <silent><Leader>ee :<C-U>call phpactor#ExtractExpression(v:true)<CR>
nnoremap <silent><Leader>ee :call phpactor#ExtractExpression(v:false)<CR>
" " extract interface
nnoremap <silent><Leader>rei :call phpactor#ClassInflect()<CR>

" spaces as tabs
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" show line numbers
set number
" relative line numbers
set rnu

" disable that line numbers are also copied
set mouse=a

" linter
let g:ale_set_highlights = 0
let g:ale_php_phpcs_standard='ENTWICKLUNGSHILFE'

" Don't run messdetector on save (default = 1)
let g:phpqa_messdetector_autorun = 0

" Don't run codesniffer on save (default = 1)
let g:phpqa_codesniffer_autorun = 0


" Set the codesniffer args
let g:phpqa_codesniffer_args = "--standard=ENTWICKLUNGSHILFE"

" decrease updatetime for gitcutter
set updatetime=1000

" ctrlp
let g:ctrlp_max_files = 0
let g:ctrlp_custom_ignore = '\v(node_modules|vendor/.*/vendor|var/cache|tests/Resources/cache|tests/app/cache)$'

" enable cr expansion
let delimitMate_expand_cr = 1

" theme
syntax enable
colorscheme torte

" copy to system clipboard
set clipboard=unnamed

" airline theme
let g:airline_theme='oceanicnext'

" NERDtree
" map ctrl+n to nerdtree
map <C-n> :NERDTreeToggle<CR>
" Hidden files
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.git$']
" nerdtree code highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('js', 'red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'magenta', 'none', '#ff00ff', '#151515')
