% paper26.ly

paper_twentysix = \paper {
	staffheight = 26.0\pt;

	quartwidth = 8.59\pt;
	wholewidth = 12.87\pt;
	
	font_large = 14.;
	font_Large = 17.;	
	font_normal = 12.;
	font_dynamic = 10.;
	% Ugh
	magnification_dynamic = 4.;

	font_finger = 8.;
	font_volta = 10.;
	font_number = 10.;
	magnification_number = 2.;
	font_mark = 14.;

	0=\font "feta26"
	-1 = \font "feta23"
	-2 = \font "feta20"
	\include "params.ly";
}

\paper { \paper_twentysix }
