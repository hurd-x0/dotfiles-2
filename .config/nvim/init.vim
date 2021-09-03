call plug#begin('~/.config/nvim/plugged')

Plug 'windwp/nvim-autopairs'
Plug 'ghifarit53/tokyonight-vim'
Plug 'tpope/vim-surround'
Plug 'mattn/emmet-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-commentary'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/nvim-bufferline.lua'
Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'ayu-theme/ayu-vim'
Plug 'airblade/vim-rooter'
Plug 'lifepillar/vim-gruvbox8'

call plug#end()

let mapleader = ";"

inoremap jk <ESC>

set hidden
set number
set cursorline
set termguicolors
set signcolumn=yes

set tabstop=2
set shiftwidth=2
set expandtab

set nowrap

set scrolloff=7
set sidescrolloff=20

set splitbelow
set splitright

set bg=dark

" let g:tokyonight_style = 'night' " available: night, storm
" let g:tokyonight_enable_italic = 1
" colorscheme tokyonight

let ayucolor="mirage"
colorscheme ayu

" let g:gruvbox_contrast_light= 'hard'
" let g:gruvbox_contrast_dark= 'hard'
" colorscheme gruvbox

au BufRead,BufNewFile *.py match BadWhitespace /\s\+$/
highlight BadWhitespace ctermbg=red guibg=darkred

let t:is_transparent = 1
function! Toggle_transparent_background()
  if t:is_transparent == 0
    set bg=dark
    let t:is_transparent = 1
  else
    hi Normal guibg=NONE ctermbg=NONE
    let t:is_transparent = 0
  endif
endfunction
nnoremap <leader>tt :call Toggle_transparent_background()<CR>

nnoremap <leader>vs :vsplit<CR>
nnoremap <leader>hs :split<CR>

nmap <leader>tn :set nu!<CR>

vmap <leader>y "+y
nmap <leader>y "+y
nmap <leader>p "+p

vnoremap K :move '<-2<CR>gv-gv
vnoremap J :move '>+1<CR>gv-gv

nnoremap <C-Up> :resize +2<CR>
nnoremap <C-Down> :resize -2<CR>
nnoremap <C-Left> :vertical resize +2<CR>
nnoremap <C-Right> :vertical resize -2<CR>

vnoremap > >gv
vnoremap < <gv

nnoremap <leader>h :set hlsearch!<CR>

nmap <leader>c gcc
vmap <leader>c gc

nnoremap <Leader>b :BufferLineCyclePrev<CR>
nnoremap <Leader>n :BufferLineCycleNext<CR>
nnoremap <Leader>d :bd<CR>

nnoremap <leader>e :NvimTreeToggle<CR>

nnoremap <leader>f :Files<CR>

lua << EOF
require("lualine").setup({
    options= {
      theme= 'ayu_mirage'
    }
})
require("nvim-web-devicons").setup()
require("bufferline").setup()
require("nvim-autopairs").setup()
require("colorizer").setup()
require("gitsigns").setup({
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '▎', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '▎', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '▎', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '▎', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '▎', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
})
require('nvim-treesitter.configs').setup {
  ensure_installed = {"javascript", "typescript", "css", "html", "python", "rust"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    additional_vim_regex_highlighting = false,
  },
}
EOF

let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ]
let g:nvim_tree_show_icons = {
    \ 'git': 0,
    \ 'folders': 1,
    \ 'files': 1,
    \ 'folder_arrows': 1,
    \ }
let g:nvim_tree_auto_open = 1
let g:nvim_tree_quit_on_open = 1
let g:nvim_tree_follow = 1
let g:nvim_tree_hide_dotfiles = 1
let g:nvim_tree_highlight_opened_files = 1
let g:nvim_tree_tab_open = 0

set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c

let g:coc_global_extensions = [
      \'coc-css',
      \'coc-json',
      \'coc-tsserver',
      \'coc-snippets',
      \'coc-prettier',
      \'coc-eslint',
      \'coc-tailwindcss',
      \'coc-prisma',
      \]

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

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

autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <leader>rn <Plug>(coc-rename)

xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)

if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

command! -nargs=0 Format :call CocAction('format')

command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
