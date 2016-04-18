if !exists("g:trans_command")
    let g:trans_command = "trans"
endif

if !exists("g:trans_target_lang")
    let g:trans_target_lang = "ru"
endif

if !exists("g:trans_source_lang")
    let g:trans_source_lang = ""
endif

function! TransBriefly()
    let l:command = g:trans_command . " " .
                \ g:trans_source_lang . ":" . g:trans_target_lang .
                \ " -b " . expand("<cword>")
    silent execute "!" . l:command
endfunction

nnoremap <buffer> <leader>tb :call TransBriefly()<cr>
