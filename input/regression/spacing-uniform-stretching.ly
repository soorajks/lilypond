\header {

  texidoc = "Notes are spaced exactly according to durations,
  if @code{uniform-stretching} is set. Accidentals are ignored, and no
  optical-stem spacing is performed."

}

\version "2.17.11"

\relative c''
<<
  \override  Score.SpacingSpanner.uniform-stretching = ##t 
  \new Staff {
    c16[ c c c c c c c c c16]
  }
  \new Staff {
    \tuplet 7/6 { c16 c c cis c c c }
    c8[ c32 c32 c16]
    
  }
>>

   
	 

  
