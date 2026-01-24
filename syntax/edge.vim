if exists('b:current_syntax')
  finish
endif

" Include HTML syntax as base
runtime! syntax/html.vim
unlet! b:current_syntax

" Edge comments: {{-- comment --}}
syntax region edgeComment start="{{--" end="--}}" contains=@Spell

" Edge escaped mustache (tells Edge to skip parsing): @{{ }}
syntax region edgeEscaped start="@{{" end="}}" contains=@Spell

" Edge safe/unescaped mustache: {{{ }}}
syntax region edgeSafeMustache start="{{{\s*" end="\s*}}}" contains=@edgeExpressions keepend

" Edge mustache (escaped output): {{ }}
syntax region edgeMustache start="{{\s*" end="\s*}}" contains=@edgeExpressions keepend

" JavaScript expression highlighting within mustache
syntax cluster edgeExpressions contains=edgeString,edgeNumber,edgeBoolean,edgeNull,edgeOperator,edgeKeyword,edgeBuiltin,edgeProperty,edgeFunction

syntax match edgeString /'[^']*'/ contained
syntax match edgeString /"[^"]*"/ contained
syntax match edgeString /`[^`]*`/ contained
syntax match edgeNumber /\<\d\+\(\.\d\+\)\?\>/ contained
syntax match edgeBoolean /\<\(true\|false\)\>/ contained
syntax match edgeNull /\<\(null\|undefined\)\>/ contained
syntax match edgeOperator /[+\-*/%=<>!&|?:,.]/ contained
syntax match edgeKeyword /\<\(await\|async\|typeof\|instanceof\|new\|in\|of\)\>/ contained
syntax match edgeProperty /\.\@<=\w\+/ contained
syntax match edgeFunction /\w\+\ze\s*(/ contained

" Edge built-in runtime variables
syntax match edgeBuiltin /\$\(props\|slots\|context\)\>/ contained

" Edge Tags
" Block-level conditional tags
syntax match edgeTagConditional /@if\>/ nextgroup=edgeTagArgs
syntax match edgeTagConditional /@elseif\>/ nextgroup=edgeTagArgs
syntax match edgeTagConditional /@else\>/
syntax match edgeTagConditional /@unless\>/ nextgroup=edgeTagArgs

" Block-level loop tags
syntax match edgeTagLoop /@each\>/ nextgroup=edgeTagArgs

" Include/partial tags
syntax match edgeTagInclude /@include\>/ nextgroup=edgeTagArgs
syntax match edgeTagInclude /@includeIf\>/ nextgroup=edgeTagArgs

" Component tags
syntax match edgeTagComponent /@component\>/ nextgroup=edgeTagArgs
syntax match edgeTagComponent /@!component\>/ nextgroup=edgeTagArgs
syntax match edgeTagComponent /@slot\>/ nextgroup=edgeTagArgs
syntax match edgeTagComponent /@endslot\>/

" Layout tags (component-as-tag for layouts)
syntax match edgeTagLayout /@layout\.\w\+/ nextgroup=edgeTagArgs

" Variable/state tags
syntax match edgeTagVariable /@let\>/ nextgroup=edgeTagArgs
syntax match edgeTagVariable /@assign\>/ nextgroup=edgeTagArgs

" Stack tags
syntax match edgeTagStack /@stack\>/ nextgroup=edgeTagArgs
syntax match edgeTagStack /@pushTo\>/ nextgroup=edgeTagArgs
syntax match edgeTagStack /@pushOnceTo\>/ nextgroup=edgeTagArgs
syntax match edgeTagStack /@prependTo\>/ nextgroup=edgeTagArgs
syntax match edgeTagStack /@prependOnceTo\>/ nextgroup=edgeTagArgs

" Provide/inject tags
syntax match edgeTagInject /@inject\>/ nextgroup=edgeTagArgs

" Debugging
syntax match edgeTagDebug /@debugger\>/

" End tag (closes blocks)
syntax match edgeTagEnd /@end\>/

" Newline swallowing modifier
syntax match edgeTagModifier /\~$/ contained

" Generic component-as-tag syntax: @componentName() or @folder.componentName()
" Must come after specific tags to not override them
syntax match edgeTagCustom /@!\?\w\+\(\.\w\+\)*\>/ nextgroup=edgeTagArgs contains=edgeTagModifier

" Tag arguments (parentheses with content)
syntax region edgeTagArgs start="(" end=")" contained contains=@edgeExpressions,edgeTagArgsNested keepend transparent
syntax region edgeTagArgsNested start="(" end=")" contained contains=@edgeExpressions,edgeTagArgsNested transparent

" Highlighting
highlight default link edgeComment Comment
highlight default link edgeEscaped Special

highlight default link edgeMustache Delimiter
highlight default link edgeSafeMustache Delimiter

highlight default link edgeString String
highlight default link edgeNumber Number
highlight default link edgeBoolean Boolean
highlight default link edgeNull Constant
highlight default link edgeOperator Operator
highlight default link edgeKeyword Keyword
highlight default link edgeBuiltin Special
highlight default link edgeProperty Identifier
highlight default link edgeFunction Function

highlight default link edgeTagConditional Conditional
highlight default link edgeTagLoop Repeat
highlight default link edgeTagInclude Include
highlight default link edgeTagComponent Structure
highlight default link edgeTagLayout Structure
highlight default link edgeTagVariable Define
highlight default link edgeTagStack PreProc
highlight default link edgeTagInject PreProc
highlight default link edgeTagDebug Debug
highlight default link edgeTagEnd Keyword
highlight default link edgeTagModifier Special
highlight default link edgeTagCustom Function

let b:current_syntax = 'edge'
