%% Do not edit this file; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.16"

\header {
  lsrtags = "template"

%% Translation of GIT committish: 5a7301fc350ffc3ab5bd3a2084c91666c9e9a549
  texidoces = "
Esta plantilla simple prepara un pentagrama con notas, adecuado para
un instrumento solista o un fragmento melódico. Córtelo y péguelo en
un archivo, escriba las notas y ¡ya está!

"
  doctitlees = "Plantilla de un solo pentagrama con notas únicamente"

%% Translation of GIT committish: fa1aa6efe68346f465cfdb9565ffe35083797b86
  texidocja = "
これは音符を持つ譜表を提供するとても簡単なテンプレートであり、ソロの楽器や旋律に適しています。@c
これをファイルにカット＆ペーストして、音符を付け加えれば完了です！
"

%% Translation of GIT committish: 0a868be38a775ecb1ef935b079000cebbc64de40
  texidocde = "
Das erste Beispiel zeigt ein Notensystem mit Noten, passend für ein
Soloinstrument oder ein Melodiefragment. Kopieren Sie es und fügen
Sie es in Ihre Datei ein, schreiben Sie die Noten hinzu, und Sie haben
eine vollständige Notationsdatei.
"

  doctitlede = "Vorlage für ein Notensystem"

%% Translation of GIT committish: bdfe3dc8175a2d7e9ea0800b5b04cfb68fe58a7a
  texidocfr = "
Cet exemple simpliste se compose d'une portée agrémentée de quelques
notes.  Il convient tout à fait pour un instrument seul ou un
fragment mélodique.  Recopiez-le dans un nouveau fichier, ajoutez-y
d'autres notes et c'est pret !

"
  doctitlefr = "Portée unique avec quelques notes"

  texidoc = "
This very simple template gives you a staff with notes, suitable for a
solo instrument or a melodic fragment. Cut and paste this into a file,
add notes, and you're finished!

"
  doctitle = "Single staff template with only notes"
} % begin verbatim

melody = \relative c' {
  \clef treble
  \key c \major
  \time 4/4

  a4 b c d
}

\score {
  \new Staff \melody
  \layout { }
  \midi { }
}

