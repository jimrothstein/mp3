file <- "/home/jim/code/jimTools/tests/testthat/test_change_file_names.R"
#   TAGS:  tinytest,


## PURPOSE:   Test Renaming files in sandbox
## USES:  tinytest
## setup
## create tmpdir and empty tempfile
##
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
##  populate sandbox with files

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


##  begin clean-up
##  ][ is effectively data.table method of chaining, without %>%
{
    dt  <- data.table(name = list.files(the_dir))

    ##  for testing, use subset
    dt  <- dt[1:200]
    dt

    dt[, old_name := name
       ][, name := sub(name, pattern = "^[[:digit:]]{5,6}", replacement =  "")
       ][, name := gsub(name, pattern = "_NA_", replacement = "_")
       ][, name := gsub(name, pattern = "~", replacement = "_")
       ][, name := gsub(name, pattern = "'", replacement = "_") 
       ][, name := gsub(name, pattern = "~", replacement = "_")
       ][, name := gsub(name, pattern = "_&_", replacement = "_and_")]

## prepare new index &  attach
{ 
   the_prefix <- create_new_prefix(the_files, digits=4)
   the_prefix  <- the_prefix[1:200] # testing

    dt[, name := paste0(the_prefix, name)]
    View(dt)
}




##  printing   
{
    kbl(dt, booktabs="T") |> 
    ## looks smaller than 12 !
    kable_styling(full_width=F, font_size=12) |>
    column_spec(1, width="40em") |>
    column_spec(2, bold=F, color="red") 
}

}



## another way to prefix
{
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



