" starttig.vim - start tig.
" Version: 0.1.0
" Author:  hankei6km
" License: Licensed under the MIT License. See LICENSE.txt in the project root.

" tigを開始するためのコマンド定義. {{{
function! s:StartTigCmdDef()
  " コマンド定義文字列.
  " バッファ別に挙動を変えるときは"-buffer "も
  " 追加すること.
  let l:cmddefstr = "command! " .
        \"-complete=custom,starttig#TigComplete ".
        \"-nargs=* " .
        \" " . starttig#GetTigCmdName() . " " .
        \" call starttig#StartTig(<f-args>)"
  execute l:cmddefstr
endfunction " }}}

" コマンド定義用autocmd定義. {{{
" vimが開始されたときに一括で定義する.
" 現状では外部からコマンド名を定義できるくらいで
" あまり意味はないが、いずれバッファのディレクトリが
" gitリポジトリかで定義するしないを変更するかも
" しれないのでとりあえず定義.
augroup StartTigCmdDef
  autocmd!
  autocmd VimEnter * call s:StartTigCmdDef()
augroup END "}}}

" vim:set ts=8 sw=2 sts=2 et fdm=marker:
