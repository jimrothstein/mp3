
file <- "tests/testthat/test_MP3_TESTING.R"

## PURPOSE:   
  *  Actual mp3 files. 
  *  Can TEST all you want.
  *  But do not write back to disk.
  *  NO SANBOX here.
  *  GO BACK if sandbox tests not complete!
  *  WRITE?   ONLY very last step.
##
##



##  work with file names as char[]
{
  load_all()
  library(tinytest)
  library(data.table)

  the_dir  <- "~/mp3_files"
  the_files  <- list.files(the_dir)
## save
    OLD  <- the_files
    the_files
}

##  Put into data.table
{
    dt  <- get_file_names()

}
dt
dt |> head()

dt1  <- setkey(dt, size)
str(dt1)
tables()
View(dt1[order(-size)])
dt1 |> head()

## BEFORE changing, LOOK if problems
## AFTER changing, run again and expect character(0)
{ ## 
  problems <- function(pattern = NULL) {
    # grep returns the index
    p  <- grep(x=the_files, pattern=pattern)
    print(the_files[p])
  }



{
  # p.1 first set of problems
  p.1    <- problems(pattern="^NA")
  the_files[p.1]




  # character vecctor
  p.2   <- problems(pattern="_NA_")

  ### Use data.table
  {
  #  as data.table, returns only rows that match pattern
  View(dt[d.1  <- grepl(x=the_files, pattern="_NA_")])
  dt[, .(new = sub(x=names, pattern="_NA_", replacement="_"))]

  # add new col with change:
  f  <- function(e) sub(x=e, pattern="_NA_", replacement="_")
  dt[, .(name,new = sapply(name, f))] |> View()


  
  dt[grepl(x=the_files, pattern= "^[[:digit:]]{5}_")]
  }  
}

    ## double check: (Success means there are NO ^NA files)
    tinytest::expect_equal(character(0),the_files[p.1])

{
  p.4  <- problems(pattern= "^[[:digit:]]{6}_")
  p.4a  <- problems(pattern= "^[[:digit:]]{5}_")
  p.5  <- problems(pattern="(\\w*)(.*)\\1)")
}

  


{ ## remove prefix

  # first do nothing
  remove_prefix(the_files, pattern="")

  # now remove prefix
  the_pattern = "^[[:digit:]]{1,6}_"
  the_files  <- remove_prefix(the_files, pattern = the_pattern)
  the_files %>% head()
  the_files
}


## GREP, returns the index of match 
{
      the_pattern  <- "\\?" 
      grep(x=the_files, pattern=the_pattern)
      ## now display 
      the_files[grep(x=the_files, pattern=the_pattern)]
}

{ ## remove some more!

  ## any leadning `_`
  p.5 <- problems(pattern="^_")
  p.5
  the_files  <- sub(x=the_files, pattern="^_+", replacement="")
  

  # Any files now begin with  NA?
  p.6 <- problems(pattern="^NA")
  # remove ^NA
  the_files  <- sub(x=the_files, pattern="^NA", replacement="") 

  p.11  <- problems(pattern="\\?{1,}")
  the_files  <- gsub(x=the_files, pattern = "\\?{1,}", replacement="_")
  the_files

  ## Any files with a blank space, tab ... (grep returns index)
  p.2  <- grep(x=the_files, pattern="\\s+")
  the_files[p.2]
  # remove empty space, but this is not GREEDY
  the_files  <- sub(x=the_files, pattern="\\s+", replacement="_")  
  the_files

  # this is greedy
  the_files  <- gsub(x=the_files, pattern="\\s+", replacement="_")  
  the_files

  # remove ugly "<sp>-<sp>"
  p.7  <- problems(pattern = "_-_")
  ## not greedy, run multiple or change to gsub
  the_files  <- sub(x=the_files, pattern="_-_", replacement="_")
  the_files

  # remove ugly "_~_"
  p.8  <- problems(pattern = "_~_")
  the_files  <- sub(x=the_files, pattern="_~_", replacement="_")
  the_files

  # remove  "_.ogg"   BE smarter about this one!
  p.9  <- problems(pattern = "_.ogg$")
  the_files  <- sub(x=the_files, pattern="_.ogg", replacement=".ogg")
  the_files

  ## any ",_"
  p.12  <- problems (pattern = ",_") 
  the_files  <- gsub(x=the_files, pattern=",_", replacement="_")
  

  ## any files now with multiple "_", again  use gsub, for greedy
  p.10  <- problems(pattern = "_{2,}")
  the_files  <- gsub(x=the_files, pattern="_{2,}", replacement="_")

  ## TODO
  ## Files that DO NOT begin with proper prefix
  p.13  <- problems(pattern = "^[[:digit:]]{2,6}")

  ## Files that contain ' , convert to _
  p.14  <- problems(pattern = "'")
  ## change
  the_files  <- gsub(x=the_files, pattern="'", replacement="_")
  the_files
}


## View ... easiest way to check
{ 

  View(the_files)
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

  ## check
  paste0(the_dir,"/",OLD)
  paste0(the_dir,"/",NEW)

  ## returns T if renamed
  if (F) {
  file.rename(from = paste0(the_dir,"/",OLD), 
              to= paste0(the_dir,"/",NEW))
  }

  list.files(the_dir)
  )
}



