" AlexIs
" Based on https://github.com/dougblack/dotfiles/blob/master/.vimrc
" https://dougblack.io/words/a-good-vimrc.html

" Security {{{
set exrc            " Позволим конфигурационным файлам в проекте изменять настройки vim'a
                    " Включим чтение конфигурационных файлов .vimrc в текущей директории
set secure          " Запретим опасные команды в локальных .vimrc файлах (эта опция должна идти в вашем
                    " ~/.vimrc после запрещаемых команд, таких как write)
set cm=blowfish2
set viminfo=
set nobackup
set nowritebackup
" }}}

" Editor {{{
set ff=unix         " Auto EOL conversion
set fileencoding=utf-8
set tags=./tags
set autoread 
" }}}

" Colors {{{
syntax enable           " enable syntax processing
" let g:gruvbox_italic=1
" set background=dark
" let g:solarized_termcolors=256
" colorscheme solarized
" colorscheme gruvbox
" set termguicolors
set t_Co=256
" }}}

" Keyboard {{{
imap <Insert> <Nop>
" }}}

" Misc {{{
set backspace=indent,eol,start
set clipboard=unnamed
" Disable annoying beeping
set noerrorbells
set vb t_vb=
" }}}

" Wiki {{{
" http://thedarnedestthing.com/vimwiki%20cheatsheet
" https://github.com/vimwiki/vimwiki
" https://github.com/zimbatm/wiki
let wiki_1 = {}
let wiki_1.path = '~/.wiki/'
let wiki_1.syntax = 'markdown'
let wiki_1.ext = '.md'

" let wiki_2 = {}
" let wiki_2.path = '~/vimwiki_personal_md/'
" let wiki_2.syntax = 'markdown'
" let wiki_2.ext = '.md'

"let g:vimwiki_list = [wiki_1, wiki_2]
"let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}

" let g:vimwiki_list = [{'path': '~/.wiki/'}]
let g:vimwiki_list = [wiki_1]
" let g:vimwiki_dir_link = 'index'
" let g:vimwiki_use_calendar = 1
" }}}

" Spaces & Tabs {{{
set tabstop=4           " 4 space tab
set expandtab           " use spaces for tabs
set softtabstop=4       " 4 space tab
set shiftwidth=4
set modelines=1
filetype indent on
filetype plugin on
set autoindent          " Новая строка будет с тем же отступом, что и предыдущая
set textwidth=113       " Ширина строки 113 символов
set smartindent         " Умная расстановка отступов (например, отступ при начале нового блока)
set cindent
" }}}

" UI Layout {{{
set number              " show line numbers
set relativenumber      " show relative line numbers
set showcmd             " show command in bottom bar
set nocursorline        " highlight current line
set wildmenu
" set lazyredraw
set showmatch           " higlight matching parenthesis
" set fillchars+=vert:┃
" set fillchars+=vert:|
set ruler               " Добавить информацию о положении каретки
set laststatus=2        " Всегда отображать строку состояния
let &colorcolumn=&textwidth             " Подсветить максимальную ширину строки
highlight ColorColumn ctermbg=darkgray  " Цвет линии - тёмно-серый
set wildmode=longest:list,full          " Включаем bash-подобное дополнение командной строки
set noequalalways       " Не делать все окна одинакового размера        
set winheight=20        " Высота окон по-умолчанию 20 строк
" }}}

" Searching {{{
set ignorecase          " ignore case when searching
set incsearch           " search as characters are entered
set hlsearch            " highlight all matches
" }}}


" Folding {{{
"=== folding ===
" set foldmethod=indent   " fold based on indent level
set foldmethod=syntax
set foldcolumn=3
set foldnestmax=10      " max 10 depth
set foldenable          " don't fold files by default on open
nnoremap <space> za
set foldlevelstart=10   " start with fold level of 1
" }}}
 
" Line Shortcuts {{{
" nnoremap j gj
" nnoremap k gk
" nnoremap gV `[v`]
" }}}

" Leader Shortcuts {{{
" let mapleader=","
" nnoremap <leader>m :silent make\|redraw!\|cw<CR>
" nnoremap <leader>h :A<CR>
" nnoremap <leader>ev :vsp $MYVIMRC<CR>
" nnoremap <leader>et :exec ":vsp /Users/dblack/notes/vim/" .
" strftime('%m-%d-%y') . ".md"<CR>
" nnoremap <leader>ez :vsp ~/.zshrc<CR>
" nnoremap <leader>sv :source $MYVIMRC<CR>
" nnoremap <leader>l :call <SID>ToggleNumber()<CR>
" nnoremap <leader><space> :noh<CR>
" nnoremap <leader>s :mksession<CR>
" nnoremap <leader>a :Ag 
" nnoremap <leader>c :SyntasticCheck<CR>:Errors<CR>
" nnoremap <leader>1 :set number!<CR>
" nnoremap <leader>d :GoDoc 
" nnoremap <leader>t :TestFile<CR>
" nnoremap <leader>r :call <SID>RunFile()<CR>
" nnoremap <leader>b :call <SID>BuildFile()<CR>
" vnoremap <leader>y "+y
" }}}

" CtrlP {{{
" let g:ctrlp_match_window = 'bottom,order:ttb'
" let g:ctrlp_switch_buffer = 0
" let g:ctrlp_working_path_mode = 0
" let g:ctrlp_custom_ignore =
" '\vbuild/|dist/|venv/|target/|\.(o|swp|pyc|egg)$'
" " }}}
" " Syntastic {{{
" let g:syntastic_python_flake8_args='--ignore=E501'
" let g:syntastic_ignore_files = ['.java$']
" let g:syntastic_python_python_exec = 'python3'
" }}}

" AutoGroups {{{
" augroup configgroup
" autocmd!
" autocmd VimEnter * highlight clear SignColumn
" autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md,*.rb :call <SID>StripTrailingWhitespaces()
" autocmd BufEnter *.cls setlocal filetype=java
" autocmd BufEnter *.zsh-theme setlocal filetype=zsh
" autocmd BufEnter Makefile setlocal noexpandtab
" autocmd BufEnter *.sh setlocal tabstop=2
" autocmd BufEnter *.sh setlocal shiftwidth=2
" autocmd BufEnter *.sh setlocal softtabstop=2
" autocmd BufEnter *.py setlocal tabstop=4
" autocmd BufEnter *.md setlocal ft=markdown
" autocmd BufEnter *.go setlocal noexpandtab
" autocmd BufEnter *.avsc setlocal ft=json
" augroup END
" }}}

" Vim Plug {{{
" source  ~/.vim/plugged/matchit.vim
call plug#begin('~/.vim/plugged')
" Plug 'jceb/vim-orgmode'
Plug 'tpope/vim-speeddating'
Plug 'mattn/calendar-vim'
Plug 'tibabit/vim-templates'
Plug 'peterhoeg/vim-qml'
" Plug 'tpope/vim-commentary'
" Plug 'tomtom/tcomment_vim'
" Plug 'bling/vim-airline'
" Plug 'derekwyatt/vim-scala'
" Plug 'elixir-editors/vim-elixir'
" Plug 'fatih/vim-go'
" Plug 'janko-m/vim-test'
" Plug 'keith/swift.vim'
Plug 'kien/ctrlp.vim'
" Plug 'leafgarland/typescript-vim'
" Plug 'moll/vim-node'
" Plug 'scrooloose/syntastic'
" Plug 'simnalamburt/vim-mundo'
" Plug 'tpope/vim-abolish'
" Plug 'tpope/vim-fugitive'
" Plug 'vim-airline/vim-airline-themes'
Plug 'vimwiki/vimwiki'
" Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
" Plug 'michaeljsmith/vim-indent-object'
" https://github.com/Yggdroot/indentLine
" https://github.com/zaiste/tmux.vim
" https://github.com/benmills/vimux
Plug 'preservim/nerdcommenter'
" Plug 'preservim/nerdtree'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
" Plug 'gabrielelana/vim-markdown'
call plug#end()
" }}}

" netrw {{{
" let g:netrw_banner = 0
" let g:netrw_liststyle = 3
" let g:netrw_browse_split = 4
" let g:netrw_altv = 1
" let g:netrw_winsize = 25
" augroup ProjectDrawer
"   autocmd!
"   autocmd VimEnter * :Vexplore
" augroup END
" }}}

" С/C++ файлы {{{
autocmd filetype c,cpp set cin  " Расставлять отступы в стиле С
" }}}

" make-файлы {{{ 
autocmd filetype make set noexpandtab   " В make-файлах нам не нужно заменять табуляцию пробелами
autocmd filetype make set nocin
" }}}



