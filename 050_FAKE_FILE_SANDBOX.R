file <- "/home/jim/code/jimTools/tests/testthat/test_change_file_names.R"
#   TAGS:  tinytest,


# --------------------------------------------
## PURPOSE:   Test Renaming files in sandbox
##            safely play!
# --------------------------------------------
## USES:  tinytest
## setup
## create tmpdir and empty tempfile
##
# ------------------
##  Create Sandbox
# ------------------
{
  load_all()
  library(tinytest)
  library(data.table)
  library(kableExtra)
  the_dir  <- jimTools::create_sandbox()
  the_dir

  # expect empty
  # tinytest::expect_
  tinytest::expect_silent(list.files(the_dir), info="files created")
  print(tinytest::expect_silent(list.files(the_dir)))
  

}

{
# -------------------------------
##  populate sandbox with files
##  WHAT files?
# -------------------------------

  # get_files, as DT (TODO add check)
    the_files  <- get_file_names()
        
    # save original names
    #   
    OLD  <- the_files

    ls.str(the_files)
    head(the_files)

    # for our purposes here, need only base name column
    the_files[, size := NULL]
    the_files

    ##  in-place, keep only basename
    the_files[, name := sapply(name, basename)]


    
  # TRUE means, file was created in the_dir
  tinytest::expect_silent(the_files  <- jimTools::populate_sandbox(the_dir,the_files$name))

  ## list - At this point:  we have sandbox, populated by just the names of
  ## files
  list.files(the_dir)
}

## Work with /tmp/X, which now  has the names of mp3 files
{
    ## create dt with all the file names in tmp directory
    dt  <- data.table(name = list.files(the_dir))
    dt

    ##  for testing, use subset
    dt  <- dt[1:20]
    dt
        
    ##  begin cleanup!
    ##
    dt[, name2 := sapply(name, sub, pattern="_NA_", replacement="_")]
    dt[, name3 := sapply(name2, gsub, pattern="~", replacement="_")]
    dt[, name4 := sapply(name3, gsub, pattern="_&_", replacement="_and_")] 
    dt[,       name2 := NULL]

    ## remove annoying single quotes
    dt[, name5 := sapply(name4, gsub, pattern="'", replacement="_")] 
    dt[, name3 := NULL]
    View(dt)

    





}

#### Alternative to previous: Use chain of gsub() |>  on dt$name
{

    ## create dt with all the file names in tmp directory
    dt  <- data.table(name = list.files(the_dir))
    dt

    ##  for testing, use subset
    dt  <- dt[1:200]
    dt
        
    ##  begin cleanup!
    dt$name2  <- gsub(dt$name, pattern = "_NA_", replacement = "_") |>
        gsub(pattern = "~", replacement = "_") |>

        # FIX:  this also does:  don't ==>  don_t
        gsub(pattern = "'", replacement = "_") 

    dt

{
    kbl(dt, booktabs="T") |> 
    ## looks smaller than 12 !
    kable_styling(full_width=F, font_size=12) |>
    column_spec(1, width="40em") |>
    column_spec(2, bold=F, color="red") 
}

}

{
#--------
# LEGACY
#--------
{ ## remove prefix

  # first do nothing
  remove_prefix(the_files, pattern="")

  # now remove prefix
  the_pattern = "^[[:digit:]]{1,2}_"
  the_files  <- remove_prefix(the_files, pattern = the_pattern)
  the_files
}

{ ## prepare new index
   the_prefix <- create_new_prefix(the_files, digits=4)
the_prefix
}

#### experiment - another way to prepare new index
{
    # 10 names (character vector)
    names  <- letters[1:10]
    names

    prefix  <- 90:99
    prefix
    prefix  <- sprintf("%04i_", prefix) 
    prefix

    ## seems to work
    ## names and prefix are character vectors of same length
    paste0(prefix, names)


    ## now wit functions
    f  <- function(names = NULL) {

        function(prefix = NULL){
            prefix  <- sprintf("%04i_", prefix) 
            paste0(prefix, names)
        } 
    }
    g  <- f(names)
    g(90:99) # works

    ## yikes (I think g is vectorized with all names; try re-writing f using just
    ## one `name` at a time)
    sapply(90:99, g)

    ## fails
    purrr::map_chr(90:99, g)
}

{ ## attach new index
  the_files <- attach_new_prefix(the_files, prefix=the_prefix)
  the_files
}




{  ##  NEW and OLD


  OLD
  NEW  <- the_files
  NEW

  jimTools::rename_file_names(path=the_dir, from=OLD, to=NEW)
  # check what is the disk
  list.files(the_dir)



## other testing
  # do it again, lengths wrong
  OLD  <- NEW
  # expect error
  NEW  <- c("A.mp3")
  OLD
  NEW


  expect_error(jimTools::rename_file_names(path=the_dir, from=OLD, to=NEW))
  list.files(the_dir)

}

{

### remove sandbox
expect_silent(remove_sandbox(the_dir))
}



