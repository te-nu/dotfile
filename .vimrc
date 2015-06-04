if !1 | finish | endif

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

" Bundle関係ここから ------------------------------------------------------------------------

" ファイル検索用
NeoBundle 'rking/ag.vim'

" 統合ユーザインターフェース
NeoBundle 'Shougo/unite.vim'

" ファイル履歴を表示(スペース二回)
NeoBundle 'yegappan/mru'
nmap <Space><Space> :MRU<CR>

" かっこを自動で閉じる
NeoBundle 'Townk/vim-autoclose'

" ファイルツリーを表示(Ctrl+e)
NeoBundle 'scrooloose/nerdtree'
nnoremap <silent><C-e> :NERDTreeToggle<CR>

" コピペ拡張
NeoBundle 'LeafCage/yankround.vim'
nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
let g:yankround_max_history = 100
nnoremap <Leader><C-p> :<C-u>Unite yankround<CR>

" Railsに色々対応
NeoBundle 'tpope/vim-rails'

" Rubyファイル編集中endを自動挿入してくれる
NeoBundle 'tpope/vim-endwise'

" カラースキーマ一覧表示にUnite.vimを使う
NeoBundle 'ujihisa/unite-colorscheme'

" coffee, SCSS, slimに対応
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'cakebaker/scss-syntax.vim'
NeoBundle "slim-template/vim-slim"

" 自動構文チェック
NeoBundle 'scrooloose/syntastic'
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2

" jkキーを加速
NeoBundle 'rhysd/accelerated-jk'
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)

" nerdcommenter の設定(カンマ二つでコメントのオンオフ)
NeoBundle 'scrooloose/nerdcommenter'
let NERDSpaceDelims = 1
nmap ,, <Plug>NERDCommenterToggle
vmap ,, <Plug>NERDCommenterToggle

" color schema
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'croaker/mustang-vim'
NeoBundle 'jeffreyiacono/vim-colors-wombat'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'vim-scripts/Lucius'
NeoBundle 'vim-scripts/Zenburn'
NeoBundle 'mrkn/mrkn256.vim'
NeoBundle 'jpo/vim-railscasts-theme'
NeoBundle 'therubymug/vim-pyte'
NeoBundle 'tomasr/molokai'
NeoBundle 'morhetz/gruvbox'

" タブをかっこよく --------------------------------------------------------------------
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction
function! s:my_tabline()
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示
" -------------------------------------------------------------------------------------

call neobundle#end()
let g:treeExplVertical=1

" Required
filetype plugin indent on

NeoBundleCheck

" coffee script -----------------------------------------------------------------------
" vimにcoffeeファイルタイプを認識させる
au BufRead,BufNewFile,BufReadPre *.coffee set filetype=coffee
" インデント設定
autocmd FileType coffee setlocal sw=2 sts=2 ts=2 et
" オートコンパイル
" 保存と同時にコンパイルする
" autocmd BufWritePost *.coffee silent make!
" エラーがあったら別ウィンドウで表示
autocmd QuickFixCmdPost * nested cwindow | redraw!
" Ctrl-cで右ウィンドウにコンパイル結果を一時表示する
nnoremap <silent> <C-C> :CoffeeCompile vert <CR><C-w>h
" -------------------------------------------------------------------------------------

" バックスペースが動作しないものを解消
set backspace=indent,eol,start

" 行番号の表示
set number

" タブをスペースにしたり自動インデントにしたり
set shiftwidth=2
set smartindent
set autoindent
set tabstop=2
set softtabstop=2

" ステータスバーを2行に
set laststatus=2

" タイトル表示
set title

" カラースキーマを有効化
syntax enable
set t_ut=

" かっこの組を表示
set showmatch

" コマンドの補完機能
set wildmenu

" マウスの有効化
set mouse=a

" タブの代わりに空白を使用
set expandtab

" 検索文字を打ち込むと即検索
set incsearch

" C-jでエスケープ
imap <C-j> <esc>

" 分割したウィンドウの大きさを変える
noremap <S-l> <C-w>>
noremap <S-h> <C-w><
noremap <S-k> <C-w>-
noremap <S-j> <C-w>+

" vimrcを保存した時に自動更新
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

colorscheme gruvbox
set background=dark

" molokai
"colorscheme molokai
"let g:molokai_original=1
"let g:rehash256=1
"set background=dark
"highlight Normal ctermbg=none
