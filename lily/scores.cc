/*
  scores.cc -- implement some globals

  source file of the GNU LilyPond music typesetter

  (c)  1997--2000 Han-Wen Nienhuys <hanwen@cs.uu.nl>
*/
#include <fstream.h>
#include "main.hh"
#include "score.hh"
#include "string.hh"
#include "paper-def.hh"
#include "scope.hh"
#include "debug.hh"
#include "parray.hh"
#include "file-path.hh"
#include "file-results.hh"
#include "my-lily-parser.hh"
#include "source.hh"
#include "lily-version.hh"
#include "scm-hash.hh"

Sources* source_global_l = 0;
Array<String> inclusion_global_array;
Array<String> target_str_global_array;
Link_array<Score> score_global_array;
Scheme_hash_table * global_header_p;


void write_dependency_file (String fn, Array<String> targets,
			    Array<String> deps)
{
  const int WRAPWIDTH = 65;

  progress_indication (_f ("Writing dependency file: `%s'...", fn.ch_C ()));
  progress_indication ("\n");
  ofstream f (fn.ch_C ());
  if (!f)
    warning (_f ("can't open file: `%s'", fn));

  f << "# Automatically generated by " << gnu_lilypond_version_str ()  << '\n';
  String out;
  for (int i=0; i < targets.size (); i ++)
     out += targets[i] + " ";
  out +=  ": ";
  for (int i=0; i < deps.size (); i ++)
    {
      if (out.length_i() > WRAPWIDTH)
	{
	  f << out << "\\\n";
	  out = "  ";
	}
      out  += " " +  deps[i];
    }
  f << out << endl; 
}

void
do_deps()
{
  if (dependency_global_b)
    {
      write_dependency_file (default_outname_base_global  + ".dep", target_str_global_array,
			     inclusion_global_array);
    }
}


void
do_scores()
{
  if (!global_header_p)
    global_header_p = new Scheme_hash_table;
  for (int i=0; i < score_global_array.size(); i++)
    {
      Score* is_p = score_global_array[i];

      if (is_p->errorlevel_i_)
	{
	  is_p->warning (_("Score contains errors; will not process it"));
	  exit_status_i_ |= 1;
	}
      else
	{
	  is_p->process();
	}
    }
  do_deps ();
}

void
clear_scores ()
{
  for (int i=0; i < score_global_array.size (); i++)
    scm_unprotect_object (score_global_array[i]->self_scm ());
  score_global_array.clear();
  
  inclusion_global_array.clear ();
  scm_unprotect_object (global_header_p ->self_scm ());
  global_header_p =0; 
}


void
do_one_file (String init_str, String file_str)
{
  if (init_str.length_i () && global_path.find (init_str).empty_b ())
    {
      warning (_f ("can't find file: `%s'", init_str));
      warning (_f ("(search path: `%s')", global_path.str ().ch_C()));
      return;
    }
  if ((file_str != "-") && global_path.find (file_str).empty_b ())
    {
      warning (_f ("can't find file: `%s'", file_str));
      return;
    }

  Sources sources;
  source_global_l = &sources;
  source_global_l->set_path (&global_path);
  {
    My_lily_parser parser (source_global_l);
    parser.set_version_check (false);
    progress_indication (_f ("Now processing: `%s'", file_str.ch_C ()));
    progress_indication ("\n");
    parser.parse_file (init_str, file_str);

    if (parser.error_level_i_)
      {
	exit_status_i_  = 1;
      }
    else
      do_scores ();
    clear_scores ();
  }
  source_global_l = 0;
}

