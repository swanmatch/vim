" vim起動時のみruntimepathにneobundle.vimを追加
if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif

" neobundle.vimの初期化 
" NeoBundleを更新するための設定
call neobundle#begin(expand('~/.vim/bundle'))
  NeoBundleFetch 'Shougo/neobundle.vim'

  " 読み込むプラグインを記載
  NeoBundle 'Shougo/unite.vim'
  NeoBundle 'itchyny/lightline.vim'
  NeoBundle 'taichouchou2/vim-rails'
  NeoBundle 'romanvbabenko/rails.vim'
  NeoBundle 'vim-ruby/vim-ruby'
  NeoBundle 'scrooloose/nerdtree'
  NeoBundle 'jistr/vim-nerdtree-tabs'
  NeoBundle 'tpope/vim-endwise'
  " インデントに色を付けて見やすくする
  NeoBundle 'nathanaelkane/vim-indent-guides'
  NeoBundle 'Shougo/neocomplete'
  NeoBundle 'mattn/emmet-vim'
  NeoBundle "tyru/caw.vim.git"
  NeoBundle 'ConradIrwin/vim-bracketed-paste'
  NeoBundle 'tomasr/molokai'
  " コメントトグル(_)
  NeoBundle 'tomtom/tcomment_vim'
  " 末尾空白強調
  NeoBundle 'bronson/vim-trailing-whitespace'
  " vim拡張
  NeoBundle 'airblade/vim-gitgutter'
  NeoBundle 'tpope/vim-fugitive'
  " タブ復元
  NeoBundle 'xolox/vim-session', { 'depends' : 'xolox/vim-misc' }
call neobundle#end()

" 読み込んだプラグインも含め、ファイルタイプの検出、ファイルタイプ別プラグイン/インデントを有効化する
filetype plugin indent on

" インストールのチェック
NeoBundleCheck

" netrwは常にtree view
let g:netrw_liststyle = 3

" 隠しファイルをデフォルトで表示させる
let NERDTreeShowHidden = 1

" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
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
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]b :tabprevious<CR>
" tp 前のタブ

cnoremap tree :NERDTreeToggle<CR>


noremap <S-h>   ^
noremap <S-j>   }
noremap <S-k>   {
noremap <S-l>   $

autocmd User Rails.controller* Rnavcommand api app/controllers/api -glob=**/* -suffix=_controller.rb
autocmd User Rails.controller* Rnavcommand tmpl app/controllers/tmpl -glob=**/* -suffix=_controller.rb
autocmd User Rails Rnavcommand config config   -glob=*.*  -suffix= -default=routes.rb
autocmd User Rails nmap :<C-u>RTcontroller :<C-u>Rc
autocmd User Rails nmap :<C-u>RTmodel :<C-u>Rm
autocmd User Rails nmap :<C-u>RTview :<C-u>Rv

syntax on
colorscheme molokai

set ts=2 sw=2 et

let g:nerdtree_tabs_open_on_new_tab=1
let g:nerdtree_tabs_open_on_console_startup=1
let NERDTreeWinSize=48
" インデントに色付け
let g:indent_guides_enable_on_vim_startup = 1
" let g:indent_guides_start_level = 0
let g:indent_guides_guide_size = 2
let g:indent_guides_auto_colors = 0
" 奇数インデントのカラー
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#262626 ctermbg=gray
" 偶数インデントのカラー
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#3c3c3c ctermbg=darkgray
" ハイライト色の変化の幅
let g:indent_guides_color_change_percent = 30

set list  " 不可視文字を表示する
set listchars=tab:>-,trail:-,extends:>,precedes:<,nbsp:%

"---------------------------------------------------------------------------
" Vi互換をオフ
set nocompatible

"---------------------------------------------------------------------------
" 行数を表示
set number
" 新しい行のインデントを現在行と同じにする
set autoindent
" バックアップ取らない
set nobackup
" 他で書き換えられたら自動で読み直す
set autoread
" スワップファイル作らない
set noswapfile
" バックアップファイルを作るディレクトリ
" set backupdir=$HOME/vimbackup
" バックアップをとる場合
"set backup
" バックアップファイルを作るディレクトリ
"set backupdir=~/backup
" スワップファイルを作るディレクトリ
"set directory=~/swap
" スワップファイル用のディレクトリ
" set directory=$HOME/vimbackup
" ファイル保存ダイアログの初期ディレクトリをバッファファイル位置に設定
" set browsedir=buffer
" クリップボードをWindowsと連携
set clipboard=unnamed
" タブの代わりに空白文字を挿入する
set expandtab
" 変更中のファイルでも、保存しないで他のファイルを表示
set hidden
" インクリメンタルサーチを行う
set incsearch
" シフト移動幅
set shiftwidth=4
" 閉じ括弧が入力されたとき、対応する括弧を表示する
set showmatch
" 検索時に大文字を含んでいたら大/小を区別
set smartcase
" 新しい行を作ったときに高度な自動インデントを行う
set smartindent
" 行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする。
set smarttab
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
" ファイル内の <Tab> が対応する空白の数
set tabstop=2
" カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]
" 検索をファイルの先頭へループしない
set nowrapscan
" Windowsでディレクトリパスの区切り文字に / を使えるようにする
set shellslash


highlight Pmenu ctermbg=4
highlight PmenuSel ctermbg=1
highlight PMenuSbar ctermbg=4

let g:neocomplete#enable_at_startup = 1

" 補完ウィンドウの設定
set completeopt=menuone

" 補完ウィンドウの設定
set completeopt=menuone

" rsenseでの自動補完機能を有効化
let g:rsenseUseOmniFunc = 1
" let g:rsenseHome = '/usr/local/lib/rsense-0.3'

" auto-ctagsを使ってファイル保存時にtagsファイルを更新
let g:auto_ctags = 1

" 起動時に有効化
let g:neocomplcache_enable_at_startup = 1

" 大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplcache_enable_smart_case = 1

" _(アンダースコア)区切りの補完を有効化
let g:neocomplcache_enable_underbar_completion = 1

let g:neocomplcache_enable_camel_case_completion  =  1

" 最初の補完候補を選択状態にする
let g:neocomplcache_enable_auto_select = 1

" ポップアップメニューで表示される候補の数
let g:neocomplcache_max_list = 20

" シンタックスをキャッシュするときの最小文字長
let g:neocomplcache_min_syntax_length = 3

" 補完の設定
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'

if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" let g:user_emmet_leader_key='<c-e>'
let g:user_emmet_leader_key='<c-t>'

set undodir=%userprofile%/.vim/undo

nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)

""""""""""""""""""""""""""""""
" 全角スペースの表示
""""""""""""""""""""""""""""""
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd ColorScheme * call ZenkakuSpace()
    autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
  augroup END
  call ZenkakuSpace()
endif
""""""""""""""""""""""""""""""i

"Git
nnoremap [fugitive]  <Nop>
nnoremap G [fugitive]
nnoremap [fufitive]p :GitGutterPreviewHunk<CR>
nnoremap [fugitive]s :Gstatus<CR><C-w>T
nnoremap [fugitive]a :Gwrite<CR>
nnoremap [fugitive]c :Gcommit-v<CR>
nnoremap [fugitive]b :Gblame<CR>
nnoremap [fugitive]d :Gdiff<CR>
nnoremap [fugitive]m :Gmerge<CR>

" FileOpenをタブ化
nnoremap :te :tabe<Space>
