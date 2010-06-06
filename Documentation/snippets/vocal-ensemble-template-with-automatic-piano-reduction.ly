%% Do not edit this file; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.16"

\header {
  lsrtags = "vocal-music, keyboards, template"

%% Translation of GIT committish: 5a7301fc350ffc3ab5bd3a2084c91666c9e9a549
  texidoces = "

Esta plantilla añade una reducción de piano automática a la partitura
vocal SATB estándar que se mostró en la @qq{Plantilla de conjunto
vocal}. Esto presenta uno de los puntos fuertes de LilyPond: podemos
usar una definición de música más de una vez. Si se hace cualquier
cambio en las notas de la parte vocal (digamos @code{tenorMusic}),
entonces los cambios se aplicarán también a la reducción de piano.

"
  doctitlees = "Plantilla de conjunto vocal con reducción de piano automática"

%% Translation of GIT committish: fa1aa6efe68346f465cfdb9565ffe35083797b86
  texidocja = "
このテンプレートは、\"合唱テンプレート\"で示された標準の SATB ボーカル譜に自動@c
ピアノ譜を付け加えています。これは LilyPond の強みの 1 つを示しています - 音楽@c
定義を何回も使用することができます。ボーカルの音符 (例えば、@code{tenorMusic}
の音符) に変更が加えられた場合、その変更はピアノ譜にも適用されます。
"
%% Translation of GIT committish: 0a868be38a775ecb1ef935b079000cebbc64de40
  texidocde = "
In diesem Beispiel wird ein automatischer Klavierauszug zu der
Chorpartitur hinzugefügt. Das zeigt eine der Stärken von LilyPond
-- man kann eine Variable mehr als einmal benutzen. Wenn Sie
irgendeine Änderung an einer Chorstimme vornehmen, (etwa
tenorMusic), verändert sich auch der Klavierauszug entsprechend.
"

%% Translation of GIT committish: bdfe3dc8175a2d7e9ea0800b5b04cfb68fe58a7a
  texidocfr = "
Ce canevas ajoute une réduction pour piano à une partition standard pour
chœur à quatre voix mixtes.  Ceci illustre l'un des avantages de
LilyPond : une expression musicale peut être réutilisée sans effort.
Toute modification apportée à l'une des voix, mettons @code{tenorMusique},
sera automatiquement reportée dans la réduction pour piano.

"
  doctitlefr = "Ensemble vocal avec réduction pour piano"

  texidoc = "
This template adds an automatic piano reduction to the standard SATB
vocal score demonstrated in @qq{Vocal ensemble template}. This
demonstrates one of the strengths of LilyPond – you can use a music
definition more than once. If any changes are made to the vocal notes
(say, @code{tenorMusic}), then the changes will also apply to the piano
reduction.

"
  doctitle = "Vocal ensemble template with automatic piano reduction"
} % begin verbatim

global = {
  \key c \major
  \time 4/4
}

sopMusic = \relative c'' {
  c4 c c8[( b)] c4
}
sopWords = \lyricmode {
  hi hi hi hi
}

altoMusic = \relative c' {
  e4 f d e
}
altoWords =\lyricmode {
  ha ha ha ha
}

tenorMusic = \relative c' {
  g4 a f g
}
tenorWords = \lyricmode {
  hu hu hu hu
}

bassMusic = \relative c {
  c4 c g c
}
bassWords = \lyricmode {
  ho ho ho ho
}

\score {
  <<
    \new ChoirStaff <<
      \new Lyrics = sopranos { s1 }
      \new Staff = women <<
        \new Voice = sopranos { \voiceOne << \global \sopMusic >> }
        \new Voice = altos { \voiceTwo << \global \altoMusic >> }
      >>
      \new Lyrics = altos { s1 }
      \new Lyrics = tenors { s1 }
      \new Staff = men <<
        \clef bass
        \new Voice = tenors { \voiceOne <<\global \tenorMusic >> }
        \new Voice = basses { \voiceTwo <<\global \bassMusic >> }
      >>
      \new Lyrics = basses { s1 }
      \context Lyrics = sopranos \lyricsto sopranos \sopWords
      \context Lyrics = altos \lyricsto altos \altoWords
      \context Lyrics = tenors \lyricsto tenors \tenorWords
      \context Lyrics = basses \lyricsto basses \bassWords
    >>
    \new PianoStaff <<
      \new Staff <<
        \set Staff.printPartCombineTexts = ##f
        \partcombine
        << \global \sopMusic >>
        << \global \altoMusic >>
      >>
      \new Staff <<
        \clef bass
        \set Staff.printPartCombineTexts = ##f
        \partcombine
        << \global \tenorMusic >>
        << \global \bassMusic >>
      >>
    >>
  >>
  \layout {
    \context {
      % a little smaller so lyrics
      % can be closer to the staff
      \Staff
      \override VerticalAxisGroup #'minimum-Y-extent = #'(-3 . 3)
    }
  }
}

