\version "1.3.148"
\header {
texidoc = "slur or long note on other staves fool lily into extending melisma"
}
\score {
  <
    \addlyrics
      \notes {
	\property Staff.automaticMelismata= ##t
	c4 () c r c
      }
      \context Lyrics \lyrics { foo __ bar }
    \context Staff=foolMelismata \notes{
      c4 ( c c ) c
    }  
    \context Staff=foolMelismata \notes{
      c1
    }  
  >  
}