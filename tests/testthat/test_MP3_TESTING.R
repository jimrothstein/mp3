
file <- "tests/testthat/test_MP3_TESTING.R"

## PURPOSE:   
  *  Actual mp3 files.
  *  But do not write back to disk.
  *  NO SANBOX here.
  *  GO BACK if sandbox tests not complete!
##
##
##  work with file names as char[]
{
  load_all()
  library(tinytest)

  the_dir  <- "~/mp3_files"
  the_files  <- list.files(the_dir)
  # save
  OLD  <- the_files
  the_files
}


{ ## remove prefix

  # first do nothing
  remove_prefix(the_files, pattern="")

  # now remove prefix
  the_pattern = "^[[:digit:]]{1,6}_"
  the_files  <- remove_prefix(the_files, pattern = the_pattern)
  the_files
}


  ## ?  LOT of ???? 
    {
      the_pattern  <- "\\?" 
      # return index
      grep(x=the_files, pattern=the_pattern)
      the_files[grep(x=the_files, pattern=the_pattern)]
    }

{ ## remove some more!

  # Any files now begin with  NA?
   
  
  # remove ^NA
  the_files  <- sub(x=the_files, pattern="^NA", replacement="") 

  # remove empty space, but this is not GREEDY
  the_files  <- sub(x=the_files, pattern="\\s+", replacement="_")  
  the_files

  # this is greedy
  the_files  <- gsub(x=the_files, pattern="\\s+", replacement="_")  
  the_files

  # remove ugly "<sp>-<sp>"
  the_files  <- sub(x=the_files, pattern="_-_", replacement="_")
  the_files

  # remove ugly "_~_"
  the_files  <- sub(x=the_files, pattern="_~_", replacement="_")
  the_files

  # remove  "_.ogg"   BE smarter about this one!
  the_files  <- sub(x=the_files, pattern="_.ogg", replacement=".ogg")
  the_files

}



{ ## LOOK for problem Patterns. 

  problems <- function(pattern = NULL) {
    p  <- grep(x=the_files, pattern=pattern)
    print(the_files[p])
  }

  # p.1 first set of problems
  p.1    <- problems(pattern="^NA")
  
  # spaces (1 space?)
  p.2  <- grep(x=the_files, pattern="\\s+")
  the_files[p.2]

  # not working 
  p.3  <- grep(x=the_files, pattern="(\\s+)+)")
  the_files[p.3]

  p.4  <- problems(pattern="[Jj]udith")
  p.5 <- problems(pattern="^_")
  p.6 <- problems(pattern="^NA")
}
  



{ ## prepare new index
   the_prefix <- create_new_prefix(the_files, digits=4)
    the_prefix

}

{ ## attach new index
  the_files <- attach_new_prefix(the_files, prefix=the_prefix)
  the_files
}




{  ##  rename:  OLD to NEW 
  if (F) (
  OLD
  NEW  <- the_files
  NEW

  jimTools::rename_file_names(path=the_dir, from=OLD, to=NEW)
  # check what is the disk
  list.files(the_dir)
  )
}



