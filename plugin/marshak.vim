" Defines {{{
if !exists("g:trans_command")
    let g:trans_command = "trans"
endif

if !exists("g:trans_target_lang")
    let g:trans_target_lang = "ru"
endif

if !exists("g:trans_source_lang")
    let g:trans_source_lang = ""
endif
" }}}

" Core function for translate text {{{
function! TransBriefly(text)
    let l:quatation_text = "\"" . a:text . "\""
    let l:options =  g:trans_source_lang . ":" . g:trans_target_lang . " -b "
    let l:command = g:trans_command . " " . l:options . l:quatation_text
    " Run trans and get translation
    silent let l:ret = system(l:command)
    " Remove ^@
    let l:ret = substitute(l:ret, '[[:cntrl:]]', '', 'g')
    echom l:ret
endfunction "}}}

" Translate word under cursor {{{
function! TransWord()
    call TransBriefly(expand("<cword>"))
endfunction "}}}

" Translate current line under cursor {{{
function! TransLine()
    call TransBriefly(getline('.'))
endfunction "}}}

" Translate sentence under cursor {{{
" Thanks Jeremy Cantrell {{{
" http://stackoverflow.com/a/677918/3465146 }}}
function! TransSentence()
    " Save unnamed register's state
    let reg_save = getreg('"')
    let regtype_save = getregtype('"')
    let cb_save = &clipboard
    set clipboard&
    " Select sentence under cursor
    " and copy to unnamed register
    " mq - save position of cursor
    " `q - restore position
    execute "normal! mq\<ESC>visy`q"
    " Save sentence to variable
    let l:sentence = getreg('"')
    " Restore unnamed register's state
    call setreg('"', reg_save, regtype_save)
    let &clipboard = cb_save
    call setreg('"', reg_save, regtype_save)
    " Translate sentence
    call TransBriefly(l:sentence)
endfunction " }}}

" Translate selected in visual mode text {{{
function! TransSelected() range
    let l:text = s:Get_visual_selection()
    call TransBriefly(l:text)
endfunction "}}}

" Translate copied in buffer text {{{
function! TransCopy()
    let l:text = @"
    call TransBriefly(l:text)
endfunction "}}}

" Get selected text in visual mode {{{
function! s:Get_visual_selection()
    " Thanks xolox from http://stackoverflow.com/a/6271254/794380
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]
    let lines = getline(lnum1, lnum2)
    let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][col1 - 1:]
    let text = join(lines, ' ')
    return substitute(text, '\n\+$', '', 'g')
endfunction "}}}

" Default mapping {{{
nnoremap <buffer> <leader>tw :call TransWord()<cr>
nnoremap <buffer> <leader>tl :call TransLine()<cr>
vnoremap <buffer> <leader>tv :call TransSelected()<cr>
nnoremap <buffer> <leader>ts :call TransSentence()<cr>
nnoremap <buffer> <leader>ty :call TransCopy()<cr>
"}}}
