let s:suite = themis#suite('Test open query')
let s:expect = themis#helper('expect')

function! s:suite.before() abort
  call SetupTestDbs()
endfunction

function! s:suite.after() abort
  call Cleanup()
endfunction

function! s:suite.should_open_new_query_buffer() abort
  :DBUI
  norm ojo
  call s:expect(&filetype).to_equal('sql')
  call s:expect(getline(1)).to_be_empty()
endfunction

function! s:suite.should_open_contacts_table_list_query() abort
  :DBUI
  norm 4jojojo
  call s:expect(getline(1)).to_equal('SELECT * from "contacts" LIMIT 200;')
endfunction

function! s:suite.should_write_query() abort
  write
  call s:expect(bufname('.dbout')).not.to_be_empty()
  call s:expect(getwinvar(bufwinnr('.dbout'), '&previewwindow')).to_equal(1)
endfunction
