if (exists('b:did_ftplugin'))
  finish
endif

let b:did_ftplugin = 1

setlocal commentstring={{--%s--}}

setlocal path+=resources/views
setlocal path+=resources/views/components/**
setlocal path+=resources/views/pages/**
setlocal suffixesadd=.edge
