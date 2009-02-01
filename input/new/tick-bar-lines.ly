\version "2.12.0"
\header {
  lsrtags = "staff-notation"
  texidoc = "
'Tick' bar lines are often used in music where the bar line is used
only for coordination and is not meant to imply any rhythmic stress.
"
  doctitle = "Tick bar lines"
}
\relative c' {
  \set Score.defaultBarType = #"'"
  c4 d e f
  g4 f e d
  c4 d e f
  g4 f e d
  \bar "|."
}