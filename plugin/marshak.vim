if !exists("g:trans_command")
    let g:trans_command = "trans"
endif

if !exists("g:trans_target_lang")
    let g:trans_target_lang = "ru"
endif

if !exists("g:trans_source_lang")
    let g:trans_source_lang = ""
endif

function! TransBriefly(word)
    let l:quatation_word = "\"" . a:word . "\""
    let l:options =  g:trans_source_lang . ":" . g:trans_target_lang . " -b "
    let l:command = g:trans_command . " " . l:options . l:quatation_word
    " Run trans and get translation
    silent let l:ret = system(l:command)
    " Remove ^@
    let l:ret = substitute(l:ret, '[[:cntrl:]]', '', 'g')
    echom l:ret
endfunction

" Translate word under cursor
function! TransBrieflyCurrentWord()
    call TransBriefly(expand("<cword>"))
endfunction

" Translate current line under cursor
function! TransLine()
    call TransBriefly(getline('.'))
endfunction

function! TransSelected() range
    let l:text = s:Get_visual_selection()
    call TransBriefly(l:text)
endfunction

function! TransCopy() range
    let l:text = @"
    call TransBriefly(l:text)
endfunction

" Get selected in vim text
function! s:Get_visual_selection()
    " Thanks xolox from http://stackoverflow.com/a/6271254/794380
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]
    let lines = getline(lnum1, lnum2)
    let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][col1 - 1:]
    let text = join(lines, ' ')
    return substitute(text, '\n\+$', '', 'g')
endfunction

nnoremap <buffer> <leader>tl :call TransLine()<cr>
nnoremap <buffer> <leader>tb :call TransBrieflyCurrentWord()<cr>
vnoremap <buffer> <leader>ts :call TransSelected()<cr>
nnoremap <buffer> <leader>tc :call TransCopy()<cr>
