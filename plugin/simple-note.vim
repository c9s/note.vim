
" Simple Vim Note
let s:noteDir = expand('~/notes')
fun! s:loadNoteSeq()
  let list = split(system( 'ls -1 ' . s:noteDir ))
  cal filter(  list , ' v:val =~ ''^\d\+.*\.note$'' ' )
  cal sort( list )
  if len(list) == 0
    let seq = 0
  else
    let seq = matchstr(list[ len(list) - 1 ],'^\d\+')
    let seq = seq + 1
  endif
  return seq
endf
fun! s:addNote(...)
  if a:0 == 1
    let title = a:1
  endif
  let seq = s:loadNoteSeq()
  if strlen( title ) > 0
    exec 'tabe ' . s:noteDir . '/' . printf('%02d',seq) . '-' . title . '.note'
  else
    exec 'tabe ' . s:noteDir . '/' . printf('%02d',seq) . '.note'
  endif
endf
com! -nargs=? AddNote :cal s:addNote(<q-args>)
