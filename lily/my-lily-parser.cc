/*
  my-lily-parser.cc -- implement My_lily_parser

  source file of the GNU LilyPond music typesetter

  (c)  1997--1998 Han-Wen Nienhuys <hanwen@cs.uu.nl>
       Jan Nieuwenhuizen <janneke@gnu.org>
*/

#include "my-lily-parser.hh"
#include "my-lily-lexer.hh"
#include "debug.hh"
#include "main.hh"
#include "music-list.hh"
#include "musical-request.hh"
#include "command-request.hh"
#include "parser.hh"
#include "scope.hh"
#include "file-results.hh"
#include "midi-def.hh"
#include "paper-def.hh"
#include "identifier.hh"
#include "chord.hh"

My_lily_parser::My_lily_parser (Sources * source_l)
{
  first_b_ = true;
  source_l_ = source_l;
  lexer_p_ = 0;
  default_duration_.durlog_i_ = 2;
  error_level_i_ = 0;
  extender_req = 0;
  fatal_error_i_ = 0;
  default_header_p_ =0;
}

My_lily_parser::~My_lily_parser()
{
  delete lexer_p_;
  delete default_header_p_;
}



void
My_lily_parser::set_version_check (bool ig)
{
  ignore_version_b_ = ig;
}

void
My_lily_parser::parse_file (String init, String s)
{
  lexer_p_ = new My_lily_lexer;
  init_str_ = init;
  lexer_p_->main_input_str_ = s;

  *mlog << _ ("Parsing...");

  init_parse_b_ = false;
  set_yydebug (!monitor->silent_b ("Parser") && check_debug);
  lexer_p_->new_input (init, source_l_);
  do_yyparse ();

  if (!define_spot_array_.empty())
    {
      warning (_ ("braces don't match"));
      error_level_i_ = 1;
    }

  inclusion_global_array = lexer_p_->filename_str_arr_;
}

void
My_lily_parser::remember_spot()
{
  define_spot_array_.push (here_input());
}

char const *
My_lily_parser::here_ch_C() const
{
  return lexer_p_->here_ch_C();
}

void
My_lily_parser::parser_error (String s)
{
  here_input().error (s);
  if (fatal_error_i_)
    exit (fatal_error_i_);
  error_level_i_ = 1;
  exit_status_i_ = 1;
}



void
My_lily_parser::set_last_duration (Duration const *d)
{
  default_duration_ = *d;
}


Simultaneous_music*
My_lily_parser::get_word_element (String s, Duration * duration_p)
{
  Simultaneous_music* velt_p = new Request_chord;

  Lyric_req* lreq_p = new Lyric_req;
  lreq_p ->text_str_ = s;
  lreq_p->duration_ = *duration_p;
  lreq_p->set_spot (here_input());

  velt_p->add_music (lreq_p);

  delete  duration_p;
  return velt_p;
}


Simultaneous_music *
My_lily_parser::get_rest_element (String s,  Duration * duration_p)
{
  Simultaneous_music* velt_p = new Request_chord;
  velt_p->set_spot (here_input());

  if (s=="s")
    { /* Space */
      Skip_req * skip_p = new Skip_req;
      skip_p->duration_ = *duration_p;

      skip_p->set_spot (here_input());
      velt_p->add_music (skip_p);
    }
  else
    {
      Rest_req * rest_req_p = new Rest_req;
      rest_req_p->duration_ = *duration_p;
      rest_req_p->set_spot (here_input());

      velt_p->add_music (rest_req_p);
    }

  delete duration_p;
  return velt_p;
}

Simultaneous_music *
My_lily_parser::get_chord (Musical_pitch tonic, Array<Musical_pitch>* add_arr_p, Array<Musical_pitch>* sub_arr_p, Musical_pitch* inversion_p, Duration d)
{
  Simultaneous_music*v = new Request_chord;
  v->set_spot (here_input ());

  Chord chord (tonic, add_arr_p, sub_arr_p, inversion_p);

  for (int i = 0; i < chord.pitch_arr_.size (); i++)
    {
      Musical_pitch p = chord.pitch_arr_[i];
      Note_req* n = new Note_req;
      n->pitch_ = p;
      n->duration_ = d;
      v->add_music (n);
    }

  v->set_spot (here_input ());
  return v;
}

Simultaneous_music *
My_lily_parser::get_note_element (Note_req *rq, Duration * duration_p)
{
  Simultaneous_music*v = new Request_chord;
  v->set_spot (here_input ());

  v->add_music (rq);

  rq->duration_ = *duration_p;
  rq->set_spot (here_input ());
  delete duration_p ;
  return v;
}


/*
  UGH.
 */
Array<Request*>*
My_lily_parser::get_parens_request (int t)
{
  Array<Request*>& reqs = *new Array<Request*>;
  switch (t)
    {
    case '~':
      reqs.push (new Tie_req);
      break;

    case '[':
    case ']':
      {
	reqs.push (new Beam_req);
      }
      break;

    case '>':
    case '!':
    case '<':
      reqs.push (new Span_dynamic_req);
      break;

    case ')':
    case '(':
      {
	reqs.push (new Slur_req);
      }
      break;
    default:
      assert (false);
      break;
    }

  switch (t)
    {
    case '<':
    case '>':
    case '(':
    case '[':
      dynamic_cast<Span_req*> (reqs[0])->spantype_ = START;
      break;
      
    case '!':
    case ')':
    case ']':
      dynamic_cast<Span_req*> (reqs[0])->spantype_ = STOP;
      break;

    default:
      break;
    }

  for (int i = 0; i < reqs.size (); i++)
    if (dynamic_cast<Span_dynamic_req*> (reqs[i]))
      {
	Span_dynamic_req* s_l= dynamic_cast<Span_dynamic_req*> (reqs[i]);
	s_l->dynamic_dir_ = (t == '<') ? UP:DOWN;
      }

  // ugh? don't we do this in the parser too?
  reqs[0]->set_spot (here_input());
  return &reqs;
}

void
My_lily_parser::add_requests (Simultaneous_music*v)
{
  for (int i = 0; i < pre_reqs.size(); i++)
    {
      v->add_music (pre_reqs[i]);
    }
  pre_reqs.clear();
  for (int i = 0; i <post_reqs.size(); i++)
    {
      v->add_music (post_reqs[i]);
    }

  post_reqs.clear();
}

Input
My_lily_parser::pop_spot()
{
  return define_spot_array_.pop();
}

Input
My_lily_parser::here_input() const
{
  Source_file * f_l= lexer_p_->source_file_l();
  return Input (f_l, here_ch_C());
}

Paper_def*
My_lily_parser::default_paper_p ()
{
  Identifier *id = lexer_p_->lookup_identifier ("$defaultpaper");
  return id ? id->access_content_Paper_def (true) : new Paper_def ;
}

Midi_def*
My_lily_parser::default_midi_p ()
{
  Identifier *id = lexer_p_->lookup_identifier ("$defaultmidi");
  return id ? id->access_content_Midi_def (true) : new Midi_def ;
}

