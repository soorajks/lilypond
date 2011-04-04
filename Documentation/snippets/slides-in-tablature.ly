% DO NOT EDIT this file manually; it is automatically
% generated from Documentation/snippets/new
% Make any changes in Documentation/snippets/new/
% and then run scripts/auxiliar/makelsr.py
%
% This file is in the public domain.
%% Note: this file works from version 2.13.49
\version "2.13.49"

\header {
%% Translation of GIT committish: 69d7781c6ab26df02bc81ff1eb294d47fa673491
  texidoces = "

Los deslizamientos se pueden componer tipográficamente tanto en los
contextos de @code{Staff} como en los de @code{TabStaff}:

"

  doctitlees = "Deslizamientos en tablatura"

  lsrtags = "fretted-strings"
  texidoc = "
Slides can be typeset in both @code{Staff} and @code{TabStaff} contexts:
"
  doctitle = "Slides in tablature"
} % begin verbatim


slides = {
  c'8\3(\glissando d'8\3)
  c'8\3\glissando d'8\3
  \hideNotes
  \grace { g16\3\glissando }
  \unHideNotes
  c'4\3
  \afterGrace d'4\3\glissando {
  \stemDown \hideNotes
  g16\3 }
  \unHideNotes
}

\score {
  <<
    \new Staff { \clef "treble_8" \slides }
    \new TabStaff { \slides }
  >>
  \layout {
    \context {
      \Score
      \override Glissando #'minimum-length = #4
      \override Glissando #'springs-and-rods =
                          #ly:spanner::set-spacing-rods
      \override Glissando #'thickness = #2
    }
  }
}