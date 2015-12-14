if exists('g:loaded_kami')
  finish
endif
let g:loaded_kami = 1

let s:save_cpo = &cpo
set cpo&vim

let s:V = vital#of('kami')
let s:FP = s:V.import('System.Filepath')

command! KamiToday call kami#open_today()
command! -nargs=1 -complete=customlist,CompletionMemo KamiOpen call kami#open(<q-args>)
command! KamiOpenFromList call kami#open_from_list()
command! -nargs=1 -range=% -complete=customlist,CompletionMemo KamiMove call kami#move(<line1>, <line2>, <q-args>)

function! CompletionMemo(ArgLead, CmdLine, CusorPos) abort
  return filter(kami#list(), printf('v:val =~ "^%s"', a:ArgLead))
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

