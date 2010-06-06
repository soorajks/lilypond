%% Do not edit this file; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.16"

\header {
  lsrtags = "rhythms, fretted-strings"

%% Translation of GIT committish: 5a7301fc350ffc3ab5bd3a2084c91666c9e9a549
  texidoces = "
Para la música de guitarra, es posible mostrar los ritmos de rasgueo,
además de las notas de la melodía, acordes y diagramas de posiciones.

"
  doctitlees = "Ritmos rasgueados de guitarra"

%% Translation of GIT committish: 0a868be38a775ecb1ef935b079000cebbc64de40
  texidocde = "
In Guitarrennotation kann neben Melodie, Akkordbezeichnungen und
Bunddiagrammen auch der Schlagrhythmus angegeben werden.

"
  doctitlede = "Schlagrhythmus für Guitarren"


%% Translation of GIT committish: 015b8e65e5e9a74cea1618b597402b5b74f89b89
  texidocfr = "
En matière de notation pour guitare, il arrive que soient indiqués les
@qq{coups de gratte} en plus de la mélodie, grilles d'accords et
diagrammes de tablature.

"
  doctitlefr = "Rythmique et guitare"

  texidoc = "
For guitar music, it is possible to show strum rhythms, along with
melody notes, chord names and fret diagrams.

"
  doctitle = "Guitar strum rhythms"
} % begin verbatim

\include "predefined-guitar-fretboards.ly"
<<
  \new ChordNames {
    \chordmode {
      c1 | f | g | c
    }
  }
  \new FretBoards {
    \chordmode {
      c1 | f | g | c
    }
  }
  \new Voice \with {
    \consists "Pitch_squash_engraver"
  } {
    \relative c'' {
      \improvisationOn
      c4 c8 c c4 c8 c
      f4 f8 f f4 f8 f
      g4 g8 g g4 g8 g
      c4 c8 c c4 c8 c
    }
  }
  \new Voice = "melody" {
    \relative c'' {
      c2 e4 e4
      f2. r4
      g2. a4
      e4 c2.
    }
  }
  \new Lyrics {
    \lyricsto "melody" {
      This is my song.
      I like to sing.
    }
  }
>>

