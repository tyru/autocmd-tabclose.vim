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


" TODO: tabclose-pre

augroup tabclose
    autocmd BufEnter * echom 'BufEnter'
    autocmd BufLeave * echom 'BufLeave'
    autocmd WinEnter * echom 'WinEnter'
    autocmd WinLeave * echom 'WinLeave'
    autocmd TabEnter * echom 'TabEnter'
    autocmd TabLeave * echom 'TabLeave'
    autocmd BufWinLeave * echom 'BufWinLeave'
    autocmd BufWinEnter * echom 'BufWinEnter'

    let s:info = {}
    autocmd TabLeave *
    \   let s:info = {'last_winnr': winnr('$')}

    " the only buffer in the tab is removed.
    autocmd BufWinLeave *
    \     if get(s:info, 'last_winnr', -1) == 1
    \   |   doautocmd User tabclose-post
    \   | endif

    " all above events are done. finalizing...
    autocmd BufWinEnter *
    \   let s:info = {}

    " dummy to not echo "No matching event" message.
    autocmd User tabclose-pre :
    autocmd User tabclose-post :
augroup END


" Restore 'cpoptions' {{{
let &cpo = s:save_cpo
" }}}
