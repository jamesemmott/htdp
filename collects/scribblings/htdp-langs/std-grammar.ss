#reader(lib "scribble/reader.ss")
#lang scheme/base
(require "common.ss"
         scribble/decode
         (for-label lang/htdp-beginner-abbr))

(provide prim-nonterms
         schemegrammar*+library
         schemegrammar*+qq)

(define ex-str "This is a string with \" inside")

(define-syntax-rule (schemegrammar*+library form ...)
  (schemegrammar*
   form ...
   (...
    [libray-require #, @scheme[(require string)]
                    #, @scheme[(require (lib string string ...))]
                    #, @scheme[(require (planet string package))]])
   (...
    [package #, @scheme[(string string number number)]])))

(define-syntax-rule (schemegrammar*+qq form ...)
  (schemegrammar*+library
   form ...
   (...
    [quoted id
            number
            string
            character
            #, @scheme[(quoted ...)]
            #, @elem{@schemevalfont{'}@scheme[quoted]}
            #, @elem{@schemevalfont{`}@scheme[quoted]}
            #, @elem{@schemefont{,}@scheme[quoted]}
            #, @elem{@schemefont[",@"]@scheme[quoted]}])
   (...
    [quasiquoted id
                 number
                 string
                 character
                 #, @scheme[(quasiquoted ...)]
                 #, @elem{@schemevalfont{'}@scheme[quasiquoted]}
                 #, @elem{@schemevalfont{`}@scheme[quasiquoted]}
                 #, @elem{@schemefont{,}@scheme[expr]}
                 #, @elem{@schemefont[",@"]@scheme[expr]}])))

(define prim-nonterms
  (make-splice
   (list

@t{An @scheme[_id] is a sequence of characters not including a
space or one of the following:}

@t{@hspace[2] @litchar{"} @litchar{,} @litchar{'} @litchar{`} 
@litchar{(} @litchar{)} @litchar{[} @litchar{]} 
@litchar["{"] @litchar["}"] @litchar{|} @litchar{;}
@litchar{#}}

@t{A @scheme[_number] is a number such as @scheme[123], @scheme[3/2], or
@scheme[5.5].}

@t{A @scheme[_string] is enclosed by a pair of @litchar{"}. Unlike
symbols, strings may be split into characters and manipulated by a
variety of primitive functions.  For example, @scheme["abcdef"],
@scheme["This is a string"], and @scheme[#,ex-str] are all strings.}

@t{A @scheme[_character] begins with @litchar{#\} and has the
name of the character. For example, @scheme[#\a], @scheme[#\b],
and @scheme[#\space] are characters.}

)))