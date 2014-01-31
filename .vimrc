filetype plugin on
filetype indent on
syntax enable
set background=dark
colorscheme solarized
set number
set expandtab
set tabstop=4
set shiftwidth=4
set statusline+=%F
set statusline+=%=      "right side...
set statusline+=%b      "Unicode Values"
set statusline+=\ %c,   "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set laststatus=2

let g:explVertical=1    " open vertical split winow

let g:explSplitRight=1  " Put new window to the right of the explorer
let g:explStartRight=0  " new windows go to right of explorer window
