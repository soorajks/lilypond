%% Do not edit this file; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.20"

\header {
  lsrtags = "rhythms, tweaks-and-overrides"

%% Translation of GIT committish: e0aa246e0ed1a86dc41a99ab79bff822d3320aa7
  texidoces = "
Se puede ajustar la separación entre las notas de adorno utilizando la
propiedad @code{spacing-increment} de @code{Score.GraceSpacing}.

"

  doctitlees = "Ajuste del espaciado de las notas de adorno"

  texidoc = "
The space given to grace notes can be adjusted using the
@code{spacing-increment} property of @code{Score.GraceSpacing}.

"
  doctitle = "Adjusting grace note spacing"
} % begin verbatim

graceNotes = {
  \grace { c4 c8 c16 c32 }
  c8
}

\relative c'' {
  c8
  \graceNotes
  \override Score.GraceSpacing #'spacing-increment = #2.0
  \graceNotes
  \revert Score.GraceSpacing #'spacing-increment
  \graceNotes
}
