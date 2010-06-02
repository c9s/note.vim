
fun! s:defopt(name,val)
  if !exists(a:name)
    let {a:name} = a:val
  endif
endf

fun! s:echo(msg)
  redraw
  echomsg a:msg
endf


" Simple Vim Note
let g:simpleNoteDir = expand('~/notes')

fun! s:loadNoteSeq()
  if ! isdirectory( g:simpleNoteDir )
    cal mkdir( g:simpleNoteDir )
  endif

  let list = split(system( 'ls -1 ' . g:simpleNoteDir ))
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
    exec 'tabe ' . g:simpleNoteDir . '/' . printf('%02d',seq) . '-' . title . '.note'
  else
    exec 'tabe ' . g:simpleNoteDir . '/' . printf('%02d',seq) . '.note'
  endif
endf
com! -nargs=? AddNote :cal s:addNote(<q-args>)

cal s:defopt('g:simpleNoteDir' , expand('~/note') )

