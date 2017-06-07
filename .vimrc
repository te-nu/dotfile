" vim-plug初期化
if has('vim_starting')
  set rtp+=~/.vim/plugged/vim-plug
  if !isdirectory(expand('~/.vim/plugged/vim-plug'))
    echo 'install vim-plug...'
    call system('mkdir -p ~/.vim/plugged/vim-plug')
    call system('git clone https://github.com/junegunn/vim-plug.git ~/.vim/plugged/vim-plug/autoload')
  end
endif

call plug#begin('~/.vim/plugged')
  Plug 'junegunn/vim-plug', {'dir': '~/.vim/plugged/vim-plug/autoload'}
  Plug 'rking/ag.vim'
  Plug 'yegappan/mru'
  Plug 'LeafCage/yankround.vim'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-rails'
  Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
  Plug 'slim-template/vim-slim', { 'for': 'slim' }
  Plug 'scrooloose/nerdcommenter'
  Plug 'koron/codic-vim'
  Plug 'rhysd/accelerated-jk'
  Plug 'itchyny/lightline.vim'
  Plug 'scrooloose/syntastic'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'junegunn/vim-easy-align'
  Plug 'thinca/vim-quickrun'
  Plug 'elzr/vim-json'
  Plug 'leafgarland/typescript-vim'
  Plug 'Glench/Vim-Jinja2-Syntax'

  " color schemes
  Plug 'altercation/vim-colors-solarized'
  Plug 'croaker/mustang-vim'
  Plug 'jeffreyiacono/vim-colors-wombat'
  Plug 'nanotech/jellybeans.vim'
  Plug 'vim-scripts/Lucius'
  Plug 'vim-scripts/Zenburn'
  Plug 'mrkn/mrkn256.vim'
  Plug 'jpo/vim-railscasts-theme'
  Plug 'therubymug/vim-pyte'
  Plug 'tomasr/molokai'
  Plug 'sickill/vim-monokai'
  Plug 'morhetz/gruvbox'
  Plug 'jonathanfilip/vim-lucius'
  Plug 'cocopon/iceberg.vim'
  Plug 'w0ng/vim-hybrid'
  Plug 'gosukiwi/vim-atom-dark'
  Plug 'KeitaNakamura/neodark.vim'
call plug#end()


" バックスペースを動作するようにする
set backspace=indent,eol,start

" 行番号の表示
set number

" タブをスペースにしたり自動インデントにしたり
set shiftwidth=2
set autoindent
set tabstop=2
set softtabstop=2
set expandtab

" タイトル表示
set title

" かっこの組を表示
set showmatch

" コマンドの補完機能
set wildmenu

" 検索文字を打ち込むと即検索
set incsearch

" スワップファイルを作らない
set noswapfile

" C-jでエスケープ
imap <C-j> <esc>

" カーソルキーをタブ切り替えに
nmap <Left> gT
nmap <Right> gt

" タブをかっこよく --------------------------------------------------------------------
" function! s:SID_PREFIX()
 " return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
" endfunction
" function! s:my_tabline()
 " let s = ''
 " for i in range(1, tabpagenr('$'))
   " let bufnrs = tabpagebuflist(i)
   " let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
   " let no = i  " display 0-origin tabpagenr.
   " let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
   " let title = fnamemodify(bufname(bufnr), ':t')
   " let title = '[' . title . ']'
   " let s .= '%'.i.'T'
   " let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
   " let s .= no . ':' . title
   " let s .= mod
   " let s .= '%#TabLineFill# '
 " endfor
 " let s .= '%#TabLineFill#%T%=%#TabLine#'
 " return s
" endfunction
" let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
" set showtabline=2 " 常にタブラインを表示

" vimrc自動更新
augroup source-vimrc
  autocmd!
  autocmd BufWritePost *vimrc source $MYVIMRC | set foldmethod=marker
  autocmd BufWritePost *gvimrc if has('gui_running') source $MYGVIMRC
augroup END

" ,v でvimrcを開く
nmap ,v :edit $MYVIMRC<CR>

" スペースを可視化
augroup HighlightTrailingSpaces
  autocmd!
  autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
  autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
augroup END

" -------------------------------------------
" for plugins
" -------------------------------------------

" for yegappan/mru
nmap <Space><Space> :MRU<CR>

" for LeafCage/yankround.vim
nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
let g:yankround_max_history = 100
nnoremap <Leader><C-p> :<C-u>Unite yankround<CR>

" for rhysd/accelerated-jk
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)

" for scrooloose/nerdcommenter
filetype plugin indent on
let NERDSpaceDelims = 1
nmap ,, <Plug>NERDCommenterToggle
vmap ,, <Plug>NERDCommenterToggle

" for itchyny/lightline.vim
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'wombat'
      \ }

" for kchmck/vim-coffee-script
" vimにcoffeeファイルタイプを認識させる
au BufRead,BufNewFile,BufReadPre *.coffee set filetype=coffee
" インデント設定
autocmd FileType coffee setlocal sw=2 sts=2 ts=2 et
" Ctrl-cで右ウィンドウにコンパイル結果を一時表示する
nnoremap <silent> <C-C> :CoffeeCompile vert <CR><C-w>h

" for syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" for ctrlp
let g:ctrlp_map = '<c-k>'
let g:ctrlp_cmd = 'CtrlP'

" for vim-easy-align
" ヴィジュアルモードで選択し，easy-align 呼んで整形．(e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
"
" easy-alignを呼んだ上で，移動したりテキストオブジェクトを指定して整形．(e.g. gaip)
nmap ga <Plug>(EasyAlign)


" -------------------------------------------
" for colorchemes
" -------------------------------------------
syntax enable
colorscheme gruvbox

" for tmux
set t_ut=
set t_Co=256

" gruvbox
if g:colors_name == 'gruvbox'
  set background=dark
  let g:gruvbox_contrast_dark  = 'medium'
  let g:gruvbox_contrast_light = 'medium'
endif

" molokai
if g:colors_name == 'molokai'
  let g:molokai_original=1
  let g:rehash256=1
  highlight Normal ctermbg=none
endif

let g:vim_json_syntax_conceal = 0
