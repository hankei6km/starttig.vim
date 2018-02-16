" starttig.vim - start tig.
" Version: 0.1.0
" Author:  hankei6km
" License: Licensed under the MIT License. See LICENSE.txt in the project root.

" tigを開始するコマンド名.
let s:StartTigCmdName = "Stig"

" tig開始時にオプションが指定されていなかったときの
" 代替オプション.
let s:StartTigBlankedOpt = []

" tigを開始するコマンド名のsetter.
" @param cmdName[in] {String} コマンド名.
function starttig#SetTigCmdName(cmdName) " {{{
  let s:StartTigCmdName = a:cmdName
endfunction " }}}

" tigを開始するコマンド名のgetter.
" @return コマンド名.
function starttig#GetTigCmdName() " {{{
  return s:StartTigCmdName
endfunction " }}}

" 代替オプションのsetter.
" @param opt[in] {List} オプションのリスト. 
" 現状、指定できるのは"--all"と"--topo-order"
function starttig#SetTigBlankedOpt(opt) " {{{
  for item in a:opt
    if item !=# "--all" && item !=# "--topo-order"
      echoerr "invalid option:" . item
      return
    endif
  endfor
  let s:StartTigBlankedOpt = a:opt
endfunction " }}}

" 代替オプションのgetter.
" @return 代替オプション.
function starttig#GetTigBlankedOpt() " {{{
  return s:StartTigBlankedOpt
endfunction " }}}


" tigのオプション等補完用定義. {{{
let s:tig_opt_words1 = ["-h", "-v"]
let s:tig_opt_words2 = ["--abbrev-commit",
      \ "--abbrev=",
      \ "--after=",
      \ "--all",
      \ "--all-match",
      \ "--author=",
      \ "--before=",
      \ "--committer=",
      \ "--date-order",
      \ "--grep=",
      \ "--help",
      \ "--max-age=",
      \ "--max-count=",
      \ "--min-age=",
      \ "--name-only",
      \ "--name-status",
      \ "--no-merges",
      \ "--not",
      \ "--pretty=",
      \ "--relative-date",
      \ "--root",
      \ "--since=",
      \ "--topo-order",
      \ "--until=",
      \ "--version"]
let s:tig_cmd_words = ["blame", "show", "status"]
" }}}

" gitの補完用定義. {{{
let s:git_refs_words = ["FETCH_HEAD", "HEAD", "ORIG_HEAD"]
" }}}

" カスタム補完関数.
" @return 改行区切りの補完候補文字列.
" @param A[in] {String} カスタム補完の引数(補完対象).
" @param L[in] {String} カスタム補完の引数(コマンド行全体).
" @param P[in] {Number} カスタム補完の引数(カーソル位置).
function! starttig#TigComplete(A, L, P) " {{{
  " 戻り値は関数内では List として扱う(扱いやすいので).
  let l:ret = []

  if !empty(matchstr(a:A, "^0")) "「Tig -」でTabだとAが0になる?
    " tigのオプションをセットする.
    let l:ret = s:tig_opt_words1

  elseif !empty(matchstr(a:A, "^--"))
    " tigのオプションをセットする.
    let l:ret = s:tig_opt_words2

  else
    " tig のコマンド(verb)をセットする.
    let l:ret = s:tig_cmd_words 

    " ブランチなどをセットする.
    " gitでshow-refが使えるのが前提となっているので、
    " あまりよくないかも.
    let l:tmp = split(system("git show-ref"), "\n")
    if empty(matchstr(a:A, "^refs"))
      " show-ref の結果を整形する.
      let l:pat =  "^[^ ]\\+ refs/[^/]\\+/"
      let l:sub = ""
    else
      " refsで始まっていたら整形内容を変える.
      let l:pat =  "^[^ ]\\+ refs/"
      let l:sub = "refs/"
    endif
    if v:shell_error == 0
      call extend(l:ret, s:git_refs_words)
      for item in l:tmp
        call add(l:ret, substitute(item, l:pat , l:sub, ""))
      endfor
    endif
  endif

  " ファイル名補完用.
  " とくに文脈は考慮しないで常に一覧を追加.
  " 「Tig -」でTabだと-でなく0になるので、正しく補完できない.
  " 他にもクオートが扱えないとかいろいろあるが、
  " vimから実行するときは % を使うことが多そうなので、
  " ということにしておく.
  call extend(l:ret, split(glob(a:A . "*"), "\n"))

  " 改行区切りの文字列にして返す.
  return join(l:ret, "\n")
endfunction " }}}

" tigの実行.
" param[in] ... {List} tigへ渡すオプション等.
function! starttig#StartTig(...) " {{{
  " tigを実行す方法(コマンド)の決定.
  " (基本的にはhit-enterプロンプトを出さない)
  let l:tc = "silent !tig"

  " オプションなどによりtigを実行する方法を変更.
  let l:opts = copy(a:000)
  let l:len = len(l:opts)
  if l:len == 0 && len(s:StartTigBlankedOpt) > 0
    " オプション無しだが代替オプションがあったので、差し替え.
    let l:opts = copy(s:StartTigBlankedOpt)
    let l:len = len(l:opts)
  endif
  if l:len > 0 && (l:opts[0] ==# "-h" || l:opts[0] ==# "-v" || l:opts[0] ==# "--help")
    " ヘルプメッセージなどの表示なので、
    " hit-enter プロンプトありでtigを実行.
    let l:tc = "!tig"

  elseif l:len == 1 && l:opts[0] ==# "blame"
    let l:curfn = expand("%")
    if l:curfn != ""
      " 編集中のファイルがあったので
      " blameの指定に使う.
      call add(l:opts, shellescape("+" . line("."))) " 表示位置.
      call add(l:opts, "--") 
      call add(l:opts, shellescape(l:curfn)) " ファイル名.
    else
      " blameのみ指定でエラーになるので、
      " hit-enter プロンプトありでtigを実行.
      let l:tc = "!tig"
    endif
  endif

  " tigを実行する.
  execute l:tc . " " . join(l:opts, " ")

  " 戻り値から後処理を決める.
  if v:shell_error == 0
    redraw!
  else
    if !empty(matchstr(l:tc, "^silent "))
      " silentだが戻り値があったので hit-enter を
      " 表示させるようにしてみる.
      " コマンドからの表示が前回の表示にくっついて
      " しまうのと、echoコマンドがあることを前提に
      " しているので、正しい?方法があれば置き換える.
      execute "!echo shell returned " . v:shell_error
    else
      redraw!
    endif
  endif

endfunction " }}}

" vim:set ts=8 sw=2 sts=2 et fdm=marker:
