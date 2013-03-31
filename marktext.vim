" Vim syntax file
" Language:     Marktext
" Author:       Christian Kuelker <christian.kuelker@cipworx.org>
" Maintainer:   Christian Kuelker <christian.kuelker@cipworx.org>
" URL:          http://www.marktext.org/1.0/vim-mode/marktext.vim
" Version:      0.1 DRAFT (Marktext Version 1.0)
" Last Change:  2013-03-19
" Disclaimer:   This is not a Marktext specification
" Contributors: Christian Kuelker
" TODO:         How to match unicode u0333 and u0332 

syntax spell toplevel
syntax sync linebreaks=1
syntax sync fromstart

" VIM regex syntax reminder:
" \{-n,} - non greedy matching n times ore more
" \_^    - matches start-of-line.

" Marktext 1.0 DRAFT
syn region mktQuoteBlock  start=/^\s\{-4,}>/    end=/$/ contains=@Spell
syn match  mktVerbBlock      /^\s*\n\(\(\s\{4,}[^ ]\|\t\+[^\t]\).*\n\)\+/  contains=mktListItem,mktQuoteBlock,@mktMeta

syn match  mktAbstract       /⌇ \s\+.*\s\+⌇ / containedin=ALL

" - - -  hyper links
" - - - - external
"             "wikipedia" ↦ |ftp://www.wikipedia.org|
"                         ↦ |ftp://www.wikipedia.org|
syn match mktExtLink /\(".\{-1,}"\s\{1}\|\)↦\s\{1}|.\+|/ containedin=mktQuote
" - - - - internal
"              "wikipedia" → |http://www.wikipedia.org|
"                          → |http://www.wikipedia.org|
syn match mktIntLink /\(".\{-1,}"\s\{1}\|\)→\s\{1}|.\+|/ containedin=mktQuote
" - - inline
syn keyword mktMarktext  Marktext containedin=ALL
syn keyword mktTodo      TODO containedin=ALL
syn keyword mktTodo      FIXME containedin=ALL
syn region  mktBold      start=/\(\s\+\|\_^\)\*.\{-1,}/ end=/\*/ oneline   
syn region  mktItalic    start=/\(\s\+\|\_^\)_.\{-1,}/ end=/_/ oneline   
syn match   mktVerb      /|.\{-1,}|/ 
syn match   mktCode      /`.\{-1,}`/
syn match   mktQuote     /".\{-1,}"/ 
syn match   mktListItem  "\_^\s*[-*+]\s\+.*\n"
syn match   mktListItem  "\_^\s*\d\+\.\s\+.*\n"

" This defines mktIdent to match at the beginning of the line for at least 5 
" spaces and do not assign a syntax highlightning for it. The content is
" highlighted for mktAuthor, mktVersion, mktDate, mktLicense and mktStatus
" It is not exactly clear if matchgroup=mktMeta works and how. There seems some
" contradiction in vim 7.2
syn region mktAuthor   start=/\s\{-2,}\(b\|B\)y:\s\+/      end=/\n/ oneline containedin=mktIdent contained nextgroup=@mktMeta skipwhite
syn region mktVersion  start=/\s\{-2,}\(v\|V\)ersion:\s\+/ end=/\n/ oneline containedin=mktIdent contained nextgroup=@mktMeta skipwhite
syn region mktDate     start=/\s\{-2,}\(d\|D\)ate:\s\+/    end=/\n/ oneline containedin=mktIdent contained nextgroup=@mktMeta skipwhite
syn region mktLicense  start=/\s\{-2,}\(l\|L\)icense:\s\+/  end=/\n/ oneline containedin=mktIdent contained nextgroup=@mktMeta skipwhite
syn region mktStatus   start=/\s\{-2,}\(s\|S\)tatus:\s\+/  end=/\n/ oneline containedin=mktIdent contained nextgroup=@mktMeta skipwhite
syn region mktIdent    matchgroup=mktMeta start=/\_^\s\{5,}/ end=/\n/ oneline display contains=@mktMeta
syn region mktToc      start=/\n\n\nTable of Contents/ skip=/\n\n\n/ end=/…\+\s\{3}\d\+\n\n\n/ nextgroup=mktH1 skipnl excludenl


" monocolor block
syn region mktTable        start=/^\s*╭/ end=/╯/
syn match  mktDocEnd       /\(┗━\+┛\)/
syn match  mktDocStart     /\(┏━\+.*━┓\)/
syn match  mktDocLine      /┃\s\+.*\s\+┃/ contains=mktDoc
syn match  mktDoc          /┃\s\+.*\s\+┃/ contained
"syn region mktCodeBlock    start=/\n\n⍿/ end=/\n⍿.\+\n\n/ containedin=ALL

" footnote
syn region mktFootnote       start=/__________/ end=/$/
syn region mktFootnote       start=/\s\+¹/ end=/$/
syn region mktFootnote       start=/\s\+⁰/ end=/$/
syn region mktFootnote       start=/\s\+¹/ end=/$/
syn region mktFootnote       start=/\s\+²/ end=/$/
syn region mktFootnote       start=/\s\+³/ end=/$/
syn region mktFootnote       start=/\s\+⁴/ end=/$/
syn region mktFootnote       start=/\s\+⁵/ end=/$/
syn region mktFootnote       start=/\s\+⁶/ end=/$/
syn region mktFootnote       start=/\s\+⁷/ end=/$/
syn region mktFootnote       start=/\s\+⁸/ end=/$/
syn region mktFootnote       start=/\s\+⁹/ end=/$/



" this is checked at the last minute
syn cluster mktHeading contains=mktH1,mktH2,mktH3,mktH4,mktH5,mktTitle
syn cluster mktMeta    contains=mktAuthor,mktVersion,mktDate,mktStatus,MktLicense

" DEFAULT HIGHLIGHT - should be done more flexible?
"            0       0       Black
"            1       4       DarkBlue
"            2       2       DarkGreen
"            3       6       DarkCyan
"            4       1       DarkRed
"            5       5       DarkMagenta
"            6       3       Brown, DarkYellow
"            7       7       LightGray, LightGrey, Gray, Grey
"            8       0*      DarkGray, DarkGrey
"            9       4*      Blue, LightBlue
"            10      2*      Green, LightGreen
"            11      6*      Cyan, LightCyan
"            12      1*      Red, LightRed
"            13      5*      Magenta, LightMagenta
"            14      3*      Yellow, LightYellow
"            15      7*      White
" frontmatter:
:hi mktAuthor      ctermfg=green       guifg=green
:hi mktVersion     ctermfg=green       guifg=green
:hi mktStatus      ctermfg=green       guifg=green
:hi mktDate        ctermfg=green       guifg=green
:hi mktLicense     ctermfg=green       guifg=green
:hi mktToc         ctermfg=darkcyan    guifg=darkcyan
:hi mktMarktext    ctermfg=darkcyan    guifg=darkcyan
:hi mktAbstract    ctermfg=darkgrey    guifg=darkgrey
:hi mktTitle       ctermfg=lightcyan        guifg=lightcyan
" mainmatter: 
:hi mktVerb        ctermfg=magenta     guifg=magenta
:hi mktVerbBlock   ctermfg=magenta     guifg=magenta
:hi mktBold        ctermfg=red         guifg=red    
:hi mktItalic      ctermfg=darkred     guifg=darkred   
:hi mktTable       ctermfg=brown       guifg=brown
:hi mktExtLink     ctermfg=blue        guifg=blue
:hi mktIntLink     ctermfg=green       guifg=green
:hi mktCode        ctermfg=darkyellow  guifg=darkyellow
:hi mktCodeBlock   ctermfg=darkyellow  guifg=darkyellow
:hi mktQuote       ctermfg=yellow      guifg=yellow  
:hi mktQuoteBlock  ctermfg=yellow      guifg=yellow  
:hi mktDoc         ctermbg=white       guibg=#ffffff ctermfg=black guifg=#000000
:hi mktDocStart    ctermbg=white       guibg=#ffffff ctermfg=black guifg=#000000
:hi mktDocEnd      ctermbg=white       guibg=#ffffff ctermfg=black guifg=#000000
:hi mktTodo        ctermfg=red         guifg=red    
:hi mktListItem    ctermfg=brown       guifg=brown
:hi mktH1          ctermfg=cyan        guifg=cyan      
:hi mktH2          ctermfg=cyan        guifg=cyan      
:hi mktH3          ctermfg=cyan        guifg=cyan      
:hi mktH4          ctermfg=cyan        guifg=cyan      
:hi mktH5          ctermfg=cyan        guifg=cyan      
:hi mktHeading     ctermfg=cyan        guifg=cyan      
:hi mktFootnote    ctermfg=darkgreen   guifg=darkgreen

let b:current_syntax = "marktext"
