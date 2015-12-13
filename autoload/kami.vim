let s:save_cpo = &cpo
set cpo&vim

let s:V = vital#of('kami')
let s:FP = s:V.import('System.Filepath')
let s:DT = s:V.import('DateTime')

if !exists('g:kami#dir')
  let g:kami#dir = s:FP.join($HOME, '.vim', 'memo')
endif

if !exists('g:kami#ext')
  let g:kami#ext = 'md'
endif

if !exists('g:kami#timestamp_format')
  let g:kami#timestamp_format = '## %s'
endif

function! kami#filepath(name) abort
  let name = printf('%s.%s', a:name, g:kami#ext)
  return s:FP.join(g:kami#dir, name)
endfunction

function! kami#open(name) abort
  execute printf(':e! %s', kami#filepath(a:name))
endfunction

function! kami#list() abort
  let ext_len = len(g:kami#ext)
  let expr = s:FP.join(g:kami#dir, printf('*.%s', g:kami#ext))
  let ls = glob(expr, 0, 1)

  return map(copy(ls), 's:FP.basename(v:val)[:-(ext_len+2)]')
endfunction

function! kami#open_from_list() abort
  execute printf(':CtrlP %s', g:kami#dir)
endfunction

function! kami#move(from, to, name) abort
  let path = kami#filepath(a:name)
  let lines = getline(a:from, a:to)
  execute printf(':redir! >> %s', path)
  silent! echo printf(g:kami#timestamp_format, s:DT.now().to_string())
  for line in lines
    silent! echo line
  endfor
  silent! echo ''
  execute ':redir END'
  execute printf(':%d,%ddelete', a:from, a:to)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
