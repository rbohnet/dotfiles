" Folding cheet sheet 
" zR    open all folds
" zM    close all folds
" za    toggle fold at cursor position
" zj    move down to start of next fold
" zk    move up to end of previous fold
" Manage plugins. {{{1
runtime macros/matchit.vim
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
let g:GetLatestVimScripts_allowautoinstall=1

set nocompatible                  " Must come first because it changes other options.
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()


" Settings and preferences. {{{1

syntax enable                     " Turn on syntax highlighting.
set backspace=indent,eol,start    " Intuitive backspacing.

set history=50                    " keep 50 lines of command line history
set ruler                         " show the cursor position all the time
set showcmd                       " display incomplete commands
set incsearch                     " do incremental searching

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

if has("autocmd")
  filetype plugin indent on       " Turn on file type detection.

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Preferences {{{1
set visualbell t_vb=
set number
set cursorline

" UNCOMMENT TO USE
"set tabstop=2                    " Global tab width.
"set shiftwidth=2                 " And again, related.
"set expandtab                    " Use spaces instead of tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set hidden
set nojoinspaces
set listchars=tab:▸\ ,eol:¬
set wildmode=longest,list
"set spelllang=en_gb
" Put swap files in /tmp file
set backupdir=~/tmp
set directory=~/tmp

set showmode                      " Display the mode you're in.
set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.
set hlsearch                      " Highlight matches.
set wrap                          " Turn on line wrapping.
set scrolloff=3                   " Show 3 lines of context around the cursor.
set title                         " Set the terminal's title
set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.

set laststatus=2                  " Show the status line all the time

" Useful status information at bottom of screen
if exists(":fugitive")
  set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{fugitive#statusline()}%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P
endif 

if has("autocmd")
  autocmd FileType html,css,scss,ruby,pml,yaml,coffee,vim setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab
  autocmd FileType markdown setlocal wrap linebreak nolist
  autocmd BufNewFile,BufRead *.rss setfiletype xml
  autocmd BufNewFile,BufRead Rakefile,Capfile,Gemfile,Termfile,config.ru setfiletype ruby
  autocmd FileType ruby :Abolish -buffer initialise initialize
  autocmd FileType vo_base :colorscheme solarized
endif

" Toggles & Switches (Leader commands) {{{1
let mapleader = ","
nmap <silent> <leader>l :set list!<CR>
nmap <silent> <leader>w :set wrap!<CR>
nmap <silent> <buffer> <leader>s :set spell!<CR>
nmap <silent> <leader>n :silent :nohlsearch<CR>
nmap <silent> <leader>c :IndentGuidesToggle<CR>
command! -nargs=* Wrap set wrap linebreak nolist
command! -nargs=* Maxsize set columns=1000 lines=1000

" CTags {{{1
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>
let Tlist_Ctags_Cmd = "/usr/local/bin/ctags"
let tlist_markdown_settings='markdown;h:Headings'
let Tlist_Show_One_File=1
nmap <Leader>/ :TlistToggle<CR>

" Mappings {{{1
" Speed up buffer switching {{{2
map <C-k> <C-W>k
map <C-j> <C-W>j
map <C-h> <C-W>h
map <C-l> <C-W>l
" Speed up tab switching {{{2
map <D-S-]> gt
map <D-S-[> gT
map <D-1> 1gt
map <D-2> 2gt
" Tab mappings.
map <leader>tt :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>to :tabonly<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>tf :tabfirst<cr>
map <leader>tl :tablast<cr>
map <leader>tm :tabmove

" Shortcuts for opening file in same directory as current file {{{2
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%
map <leader>er :e <C-R>=expand("%:r")."."<CR>

" Alignment commands {{{1
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
endif


" Insert mode mappings {{{1
" emacs style jump to end of line
imap <C-e> <C-o>A
imap <C-a> <C-o>I
" Open line above (ctrl-shift-o much easier than ctrl-o shift-O)
imap <C-Enter> <C-o>o
imap <C-S-Enter> <C-o>O

" Easily modify vimrc {{{1
nmap <leader>v :e $MYVIMRC<CR>
" http://stackoverflow.com/questions/2400264/is-it-possible-to-apply-vim-configurations-without-restarting/2400289#2400289
if has("autocmd")
  augroup myvimrchooks
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
  augroup END
endif


" Or use vividchalk
colorscheme topfunky-light

" Custom commands and functions {{{1
" Create a :Quickfixdo command, to match :argdo/bufdo/windo {{{2
" Define a command to make it easier to use
command! -nargs=* Qargs execute 'args ' . QuickfixFilenames()
function! QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(values(buffer_numbers))
endfunction

command! -nargs=+ QFDo call QFDo(<q-args>)
" Function that does the work
function! QFDo(command)
  " Create a dictionary so that we can get the list of buffers rather than
  " the list of lines in buffers (easy way to get unique entries)
  let buffer_numbers = {}
  " For each entry, use the buffer number as a dictionary key (won't get
  " repeats)
  for fixlist_entry in getqflist()
    let buffer_numbers[fixlist_entry['bufnr']] = 1
  endfor
  " Make it into a list as it seems cleaner
  let buffer_number_list = keys(buffer_numbers)

  " For each buffer
  for num in buffer_number_list
    " Select the buffer
    exe 'buffer' num
    " Run the command that's passed as an argument
    exe a:command
    " Save if necessary
    update
  endfor
endfunction
" http://stackoverflow.com/questions/4792561/how-to-do-search-replace-with-ack-in-vim
" Show syntax highlighting groups for word under cursor {{{2
" Tip: http://stackoverflow.com/questions/1467438/find-out-to-which-highlight-group-a-particular-keyword-symbol-belongs-in-vim
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
" Wipe all buffers which are not active (i.e. not visible in a window/tab) {{{2
" http://stackoverflow.com/questions/2974192/how-can-i-pare-down-vims-buffer-list-to-only-include-active-buffers
" http://stackoverflow.com/questions/1534835/how-do-i-close-all-buffers-that-arent-shown-in-a-window-in-vim
command! -nargs=* Only call CloseHiddenBuffers()
function! CloseHiddenBuffers()
  " figure out which buffers are visible in any tab
  let visible = {}
  for t in range(1, tabpagenr('$'))
    for b in tabpagebuflist(t)
      let visible[b] = 1
    endfor
  endfor
  " close any buffer that are loaded and not visible
  let l:tally = 0
  for b in range(1, bufnr('$'))
    if bufloaded(b) && !has_key(visible, b)
      let l:tally += 1
      exe 'bw ' . b
    endif
  endfor
  echon "Deleted " . l:tally . " buffers"
endfun

" Set tabstop, softtabstop and shiftwidth to the same value {{{2
" From http://vimcasts.org/episodes/tabs-and-spaces/
command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction
 
function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    end
  finally
    echohl None
  endtry
endfunction

" Strip trailing whitespaces  {{{2
function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>
nmap _= :call Preserve("normal gg=G")<CR>
" Swap words in a single substitution command {{{2
" http://stackoverflow.com/questions/765894/can-i-substitute-multiple-items-in-a-single-regular-expression-in-vim-or-perl/766093#766093
function! Refactor(dict) range
  execute a:firstline . ',' . a:lastline .  's/\C\<\%(' . join(keys(a:dict),'\|'). '\)\>/\='.string(a:dict).'[submatch(0)]/ge'
endfunction
command! -range=% -nargs=1 Refactor :<line1>,<line2>call Refactor(<args>)

" Running :Refactor {'quick':'slow', 'lazy':'energetic'}  will change the following text:
"    The quick brown fox ran quickly next to the lazy brook.
"into:
"    The slow brown fox ran slowly next to the energetic brook.

" TODO: create a :Swap command, which turns:
"    :Swap(portrait,landscape)
" into
"    :Refactor {'portrait':'landscape', 'landscape':'portrait'}

" Status line {{{1
" Good article on setting a statusline:
"   http://got-ravings.blogspot.com/2008/08/vim-pr0n-making-statuslines-that-own.html
" Always show the status line (even if no split windows)
set laststatus=2
" Mappings for a recovering TextMate user {{{1
" Indentation {{{2
nmap <D-[> <<
nmap <D-]> >>
vmap <D-[> <gv
vmap <D-]> >gv

" Commenting {{{2
" requires NERDCommenter plugin
vmap <D-/> ,c<space>gv
map <D-/> ,c<space>

" Duplicate selection {{{2
"vmap <S-C-D> :copy'> <CR>V`[o
"nmap <S-C-D> :copy .<CR>
" Move selection {{{2
  " Move current line down/up
  map <C-Down> ]e
  map <C-Up> [e
  " Move visually selected lines down/up
  vmap <C-Down> ]egv
  vmap <C-Up> [egv
" Move visual selection back/forwards
set ww+=<,>
vmap <C-Left> x<Left>P`[v`]
vmap <C-Right> x<Right>P`[v`]
" Configure plugins {{{1
" Gundo.vim {{{2
map <Leader>u :GundoToggle<CR>

" TextObject customizations {{{2
" Entire text object {{{3
" Map text-object for entire buffer to `ia` and `aa`.
let g:textobj_entire_no_default_key_mappings = 1
xmap aa  <Plug>(textobj-entire-a)
omap aa  <Plug>(textobj-entire-a)
xmap ia  <Plug>(textobj-entire-i)
omap ia  <Plug>(textobj-entire-i)
" }}}
" Space.vim {{{2
let g:space_disable_select_mode=1
let g:space_no_search = 1

" Solarized {{{2
set background=light
colorscheme solarized
if has("autocmd")
  " For some reason, opening a vimoutliner file switches to another
  " colorscheme. This prevents that from happening.
  autocmd FileType vo_base :colorscheme solarized
endif
function! ToggleBackground()
    if (g:solarized_style=="dark")
    let g:solarized_style="light"
    colorscheme solarized
else
    let g:solarized_style="dark"
    colorscheme solarized
endif
endfunction
command! Togbg call ToggleBackground()

" EasyMotion {{{2
let g:EasyMotion_leader_key = ',,'

" Vim wiki {{{2
"let g:vimwiki_menu=''
" NERDcommenter {{{2
" let g:NERDMenuMode=0
"  Modelines: {{{1
" vim: nowrap fdm=marker
" }}}

" Controversial...swap colon and semicolon for easier commands
"nnoremap ; :
"nnoremap : ;

"vnoremap ; :
"vnoremap : ;

" Automatic fold settings for specific files. Uncomment to use.
" autocmd FileType ruby setlocal foldmethod=syntax
" autocmd FileType css  setlocal foldmethod=indent shiftwidth=2 tabstop=2

" For the MakeGreen plugin and Ruby RSpec. Uncomment to use.
" autocmd BufNewFile,BufRead *_spec.rb compiler rspec


