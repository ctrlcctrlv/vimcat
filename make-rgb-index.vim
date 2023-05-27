" Reads rgb.txt and transforms it into a dictionary inside a VimScript

" Open the file to transform
e ../../runtime/rgb.txt

" Set up working environment
set notitle noicon
set nomore nowarn
set report=1000000
set noro
set modifiable

" Keep comments
%s/^!/"/
" Transform color lines into dictionary assignment body
%s/^\s*\(\d\+\)\s\+\(\d\+\)\s\+\(\d\+\)\s\+\([a-zA-Z0-9 ]\+\)\s*$/    \\   '\L\4\E' : '\1;\2;\3',/
" Prepend dictionary assignment begin
0
norm! O
call setline(1, 'let g:ansicolorcodes_colors = {')
" Put all comments in the top
g/^"/m0
" (they were reversed in the process, reverse them back)
g/^"/m0
" Append dictionary assignment end
$
norm o
call setline(line('$'), '    \}')

" Write output file
w! 2ansicolorcodes_colors.vim
" And quit
qa!

" vim: ts=8 sw=2 sts=2 et
