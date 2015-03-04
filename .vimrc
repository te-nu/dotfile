if !1 | finish | endif

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here
NeoBundle 'rking/ag.vim'
NeoBundle 'yegappan/mru'
NeoBundle 'vim-scripts/opsplorer'
NeoBundle 'rhysd/accelerated-jk'
NeoBundle 'vim-perl/vim-perl'
NeoBundle "slim-template/vim-slim"
NeoBundle 'Townk/vim-autoclose'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'scrooloose/nerdtree'
nnoremap <silent><C-e> :NERDTreeToggle<CR>

" カラースキーマ一覧表示にUnite.vimを使う
NeoBundle 'Shougo/unite.vim'
NeoBundle 'ujihisa/unite-colorscheme'

" coffeeとSCSSに対応
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'cakebaker/scss-syntax.vim'

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

" HTML,CSS を簡略化して書き、展開を行う
NeoBundle 'mattn/emmet-vim'

" 自動構文チェック
NeoBundle 'scrooloose/syntastic'
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2

" jkキーを加速
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)

" perlの自動成形
map ,pt <Esc>:%! perltidy -se<CR>
map ,ptv <Esc>:'<,'>! perltidy -se<CR>

call neobundle#end()

let g:treeExplVertical=1

" Required
filetype plugin indent on

NeoBundleCheck

" nerdcommenter の設定
let NERDSpaceDelims = 1
nmap ,, <Plug>NERDCommenterToggle
vmap ,, <Plug>NERDCommenterToggle

" coffee script-------------------------------------------------------
" vimにcoffeeファイルタイプを認識させる
au BufRead,BufNewFile,BufReadPre *.coffee   set filetype=coffee
" インデント設定
autocmd FileType coffee    setlocal sw=2 sts=2 ts=2 et
" オートコンパイル
"保存と同時にコンパイルする
autocmd BufWritePost *.coffee silent make! 
"エラーがあったら別ウィンドウで表示
autocmd QuickFixCmdPost * nested cwindow | redraw! 
" Ctrl-cで右ウィンドウにコンパイル結果を一時表示する
nnoremap <silent> <C-C> :CoffeeCompile vert <CR><C-w>h

"行番号の表示
set number

"タブをスペースにしたり自動インデントにしたり
set shiftwidth=2
set smartindent
set autoindent
"タブでスペースを入れる
set tabstop=2
set softtabstop=2
set title
set laststatus=1

"カラースキーマの表示
syntax enable
set t_Co=256

"縦棒と横棒を表示
"set cursorline
"set cursorcolumn

"かっこの組を表示
set showmatch

"コマンドの補完機能
set wildmenu

"マウスの有効化
set mouse=a

"タブの代わりに空白を使用
set expandtab

"C-jでエスケープ
imap <C-j> <esc>

"分割したウィンドウの大きさを変える
noremap <S-l> <C-w>>
noremap <S-h> <C-w><
noremap <S-k> <C-w>-
noremap <S-j> <C-w>+

augroup HighlightTrailingSpaces
  autocmd!
  autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
  autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
augroup END

"molokai
colorscheme molokai
let g:molokai_original=1
let g:rehash256=1
set background=dark
highlight Normal ctermbg=none
