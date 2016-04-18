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
    silent let l:ret = system(l:command)
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

nnoremap <buffer> <leader>tl :call TransLine()<cr>
nnoremap <buffer> <leader>tb :call TransBrieflyCurrentWord()<cr>
