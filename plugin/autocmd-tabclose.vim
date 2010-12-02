" vim:foldmethod=marker:fen:
scriptencoding utf-8

" Load Once {{{
if exists('g:loaded_autocmd_tabclose') && g:loaded_autocmd_tabclose
    finish
endif
let g:loaded_autocmd_tabclose = 1
" }}}
" Saving 'cpoptions' {{{
let s:save_cpo = &cpo
set cpo&vim
" }}}


augroup tabclose
    autocmd BufEnter * echom 'BufEnter'
    autocmd BufLeave * echom 'BufLeave'
    autocmd WinEnter * echom 'WinEnter'
    autocmd WinLeave * echom 'WinLeave'
    autocmd TabEnter * echom 'TabEnter'
    autocmd TabLeave * echom 'TabLeave'
    autocmd BufWinLeave * echom 'BufWinLeave'
    autocmd BufWinEnter * echom 'BufWinEnter'

    let s:closing_tab = 0
    autocmd BufWinLeave * if tabpagenr('$') != 1 && winnr('$') == 1 | let s:closing_tab = 1 | endif
    autocmd TabLeave * if s:closing_tab | doautocmd User tabclose-pre | endif
    autocmd TabEnter * if s:closing_tab | doautocmd User tabclose-post | endif
    autocmd BufWinEnter * let s:closing_tab = 0

    " dummy to not echo "No matching event" message.
    autocmd User tabclose-pre :
    autocmd User tabclose-post :
augroup END


" Restore 'cpoptions' {{{
let &cpo = s:save_cpo
" }}}
