" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイル（後述）を用意しておく
  let g:rc_dir    = expand('~/.vim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

" バックスペースが動作しないものを解消
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

" マウスの有効化
set mouse=a

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

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

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

" カラースキーマを有効化
syntax enable
set t_ut=

" gruvbox
colorscheme gruvbox
set background=dark
" set t_Co=256

" colorscheme jellybeans
"colorscheme hybrid

" molokai
"colorscheme molokai
"let g:molokai_original=1
"let g:rehash256=1
"set background=dark
"highlight Normal ctermbg=none
