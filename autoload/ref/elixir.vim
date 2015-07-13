" A ref source for Elixir.
" Version: 0.0.0
" Author : Adam Rutkowski <hq@mtod.org>
"          Based on work done by thinca <thinca+vim@gmail.com>
"          and Michael Coles <michael.coles@gmail.com>

" License: Creative Commons Attribution 2.1 Japan License
"          <http://creativecommons.org/licenses/by/2.1/jp/deed.en>

let s:save_cpo = &cpo
set cpo&vim

if !exists('g:ref_elixir_cmd')
  let g:ref_elixir_cmd = executable('elixir') ? 'elixir' : ''
endif

let s:FUNC_PATTERN = '[A-Z]\{1\}[A-Za-z_.]\+'

let s:source = {'name': 'elixir'}

function! s:source.get_body(query)
  let query = a:query
  let code = 'require(IEx.Helpers);IEx.Helpers.h('.query.')'
  let res = ref#system(ref#to_list(g:ref_elixir_cmd, '-e', code))
  return {'body': res.stdout, 'query': query}
endfunction

function! s:source.opened(query)
    set ft=markdown
endfunction

function! s:source.get_keyword()
  return ref#get_text_on_cursor(s:FUNC_PATTERN)
endfunction

function! ref#elixir#define()
  return copy(s:source)
endfunction

call ref#register_detection('elixir', 'elixir')

let &cpo = s:save_cpo
unlet s:save_cpo
