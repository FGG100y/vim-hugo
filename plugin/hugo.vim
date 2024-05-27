" hugo.vim
" Author:  fmh (brantvan49@outlook.com)
" Version: 0.1.1
" License: Same as Vim itself (see :help license)

" original repo URL:     https://github.com/juev/vim-hugo

if exists('g:loaded_hugo') || &cp || v:version < 700
  finish
endif
let g:loaded_hugo = 1

" Configuration {{{

if ! exists('g:hugo_path')
  let g:hugo_path = "~/blog"
endif

if ! exists('g:hugo_post_dirs')
  let g:hugo_post_dirs = "/content/posts/"
endif

if !exists('g:post_file_ext')
  let g:post_file_ext = "md"
endif

if !exists('g:hugo_title_pattern')
  let g:hugo_title_pattern = "[ '\"]"
endif

" }}}

" Utility functions {{{

function! s:esctitle(str)
  let str = a:str
  let str = tolower(str)
  let str = substitute(str, g:hugo_title_pattern, '-', 'g')
  let str = substitute(str, '\(--\)\+', '-', 'g')
  let str = substitute(str, '\(^-\|-$\)', '', 'g')
  return str
endfunction

function! s:error(str)
  echohl ErrorMsg
  echomsg a:str
  echohl None
  let v:errmsg = a:str
endfunction

" }}}

" Post functions {{{

function! HugoPost2(title)
  let created = strftime("%FT%T%z") " 2019-10-24T08:56:12+03:00{{{
  let title = a:title
  if title == ''
    let title = input("Post title: ")
    let file_name = "index" . "." . g:post_file_ext
    let g:hugo_post_dirs = fnamemodify(getcwd(), ':p')
    echo "Making that post " . file_name
    exe "e " . g:hugo_post_dirs . file_name
  else
    let file_name = strftime("%Y-%m-%d-") . s:esctitle(title) . "." . g:post_file_ext
    echo "Making that post " . file_name
    exe "e " . g:hugo_path . g:hugo_post_dirs . file_name
  endif

  " the front matters:
  let template = ["---", "title: \"" . title . "\"", "summary: ", "description: ", "date: " . created, "draft: true", "tags: []"]
  call extend(template,["---", ""])

  let err = append(0, template)"}}}
endfunction

command! -nargs=? HugoPost2 :call HugoPost2(<q-args>)

function! HugoPost(filename)
  let filename = a:filename
  if filename == ''
    let g:hugo_post_dirs = fnamemodify(getcwd(), ':p')
    let title = input("Post title: ")
    let file_name = strftime("%Y-%m-%d-") . s:esctitle(title) . "." . g:post_file_ext
    echo "Making that post " . file_name
    exe "e " . g:hugo_post_dirs . file_name
  else
    " Parse the input filename into directory, name, and extension
    let dir_name = fnamemodify(a:filename, ':h')
    let file_name = fnamemodify(a:filename, ':t:r')
    let file_ext = fnamemodify(a:filename, ':e')
    if file_name == 'index'
      let title = dir_name
    else
      let title = file_name
    endif
    
    " If no extension is provided, use the default Hugo post suffix
    if file_ext == ''
      let file_ext = g:post_file_ext
    endif
    
    " Create the full file path
    let full_path = dir_name . '/' . file_name . '.' . file_ext

    " Ensure the directory exists
    if !isdirectory(dir_name)
      call mkdir(dir_name, "p")
    endif
    
    " Echo the action being performed
    echo "Making that post " . full_path
    
    " Open the file for editing
    exe "e " . full_path
  endif

  " Create the front matter template
  " Get the current date and time
  let created = strftime("%FT%T%z") " 2019-10-24T08:56:12+03:00
  let template = [
        \ "---",
        \ "title: \"" . title . "\"",
        \ "summary: ",
        \ "description: ",
        \ "date: " . created,
        \ "draft: true",
        \ "tags: []",
        \ "---",
        \ ""
        \ ]
  
  " Append the template to the file
  let err = append(0, template)
endfunction

command! -nargs=? HugoPost :call HugoPost(<q-args>)

" }}}

" vim:ft=vim:fdm=marker:ts=2:sw=2:sts=2:et
