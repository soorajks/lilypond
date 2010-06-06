%% Do not edit this file; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.16"

\header {
  lsrtags = "expressive-marks"

%% Translation of GIT committish: 5a7301fc350ffc3ab5bd3a2084c91666c9e9a549
  texidoces = "
La función @code{\\parenthesize} es un truco especial que encierra
objetos entre paréntesis.  El grob asociado es @code{ParenthesesItem}.

"
  doctitlees = "Encerrar entre paréntesis una marca expresiva o una nota de un acorde"

  texidoc = "
The @code{\\parenthesize} function is a special tweak that encloses
objects in parentheses.  The associated grob is @code{ParenthesesItem}.


"
  doctitle = "Adding parentheses around an expressive mark or chordal note"
} % begin verbatim

\relative c' {
  c2-\parenthesize ->
  \override ParenthesesItem #'padding = #0.1
  \override ParenthesesItem #'font-size = #-4
  <d \parenthesize f a>2
}

