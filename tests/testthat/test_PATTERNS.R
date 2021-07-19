# PURPOSE:   
#
# Collect patterns.  Many regex patterns with groupings and
# foward/backward looks can be useful to changing mp3 files.  Organize these
# and tips from !so  here.
#
# TEST only on fake strings.  Don't use on mp3 till tested!
#
#
# file <- "tests/testthat/test_PATTERNS.R###  Change file names, add/remove prefix, use `base R`"
#
load_all()
{
Main idea is this:
  * Set dir, 
  * Choose pattern to match files
  * old = original file names
  * new = proposed file names, with changes (using gsub)
  * prepend the dir
  * file.rename(old, new)

#### base:: comands
file.rename()
file.create()
basename()
dirname()
list.dirs()
dir()
}


{ ## working, sub
  # sub(x = "_NA", pattern = "_NA", replacement = "NA")
# list of strings, pattern, replacement when matches
#
  #
  #
# multiple matching, need to use gsub
f  <- function(e) {
gsub(x = e[[1]],
    pattern = e[[2]],
    perl = F,
    replacement = e[[3]])

}


l  <- list(c("A,B,C,D", "((?:[[:upper:]]+)+),?", "\\1_"))
l  <- list(
           c(the_phrase,
             "_\\s+*", "_"),

           c(the_phrase,
             "\\s+[-]\\s+", "_"),

           c("_NA_jim", "^_NA", "_"),
           c("NA_jim", "NA", ""),
           c("_.ogg", "_.ogg$", ".ogg"),
           c("jim_.ogg", "_.ogg$", ".ogg"),
           c("___","_+", "_"   ),  # + = 1 or more
           c("_____","_+", "_"   )  ,
           c("__ ____","_+", "_"   )  # fix:  make greedy
           )


lapply(l, f)
}

{
the_phrase  <-"_ End of The World - Skeeter Davis Live_08Sep2020_.ogg" 

gsub(the_phrase, pattern = " ", replacement ="_")
gsub(the_phrase, pattern = "\\s+", replacement = "_")

# works
gsub(the_phrase, pattern = "\\s+-\\s+", replacement = "_")
# almost
#
#
## can chain !!
library(magrittr)
gsub(the_phrase, pattern = "(\\s+)", replacement = "_") %>% gsub(pattern="_-_", replacement="_")




/((?:\w+)+),?/gm


}
{
  val  <- "~/My_Files/F0/F1/F2/0b27ea5fad61c99d/0b27ea5fad61c99d/2015-04-1-04-25-12-925" 

  # work from right?   /[^/]+$   leaves everything to left of 1st /
  sub(".*/(.*)/[^/]+$","\\1",val)
  sub(".*/(.*)/" , "\\1", val)
  sub(".*/" , "\\1", val) # greedy! take maximium

gsub("([^/]*)/([^/]*)/([^/]*)/([^/]*)/([^/]*)/([^/][0-9a-z]+)/(.*)",
     "\\6",val)

# ([^/]*): Selecting all from starting to till a / and keeping it in first place holder of memory.

# /: Mentioning / then. Again repeating these above 2 steps till 5 times to select 6th field which is mentioned by ([^/][0-9a-z]+) then /(.*) means taking all rest of the matches in 7th memory place.

# "\\6": Now substituting whole value of variable val with only 6th memory place which is actually required by OP to get the desired results.
}

{ ## VERSION .2   DT
##
library(rdatatable)
  create_dt  <- function () {
    DT = data.table(
      before = "_NA",
      regex = "_NA",
      replace = "NA"
    )
    return(DT)
}

dt  <- create_dt()
dt
}

{ ## a few real mp3 file names to practice  
  the_dir  <- "~/mp3_files"
  head(list.files(the_dir))
# [1] "_ End of The World - Skeeter Davis Live_08Sep2020_.ogg"                                   
# [2] "__Bob_Lucille__LUCILLE_STARR_The_French_Song_First_Recording_06Dec2020.ogx"               
# [3] "__Bob_Lucille__Lucille_Starr_TRIBUTE_Freight_Train_(1963)._06Dec2020.ogx"                 
# [4] "__Bob_Lucille__Quand_le_Soleil_Dit_Bonjour_aux_Montagnes_Lucille_Starr_1965_06Dec2020.ogx"
# [5] "__Bob_Lucille__The_French_Song_06Dec2020.ogx"                                             
# [6] "__THE_CHARTS_DESERIE_(1957)_01Aug2020.ogg"                                                
}



## available patterns
{
#  Choose pattern, 
list.files("rmd", full.names= T, pattern="*.Rmd")
list.files("./rmd", pattern="*.Rmd")
list.files("./rmd", full.names = TRUE ,pattern="*.Rmd")
pat  <-  "^[:digit:]{4,6}"
pat  <-  `^[[:digit:]]{4,6}`
pattern=  "^[0-9]*"
pat  <-  `'^_'`
pat  <- `'^_00056'`
pat  <- "^_[[:digit:]]{5}"
pat  <-  "^_[[:digit:]]{5,6}"
pat  <-  "^[[:digit:]]{4,6}"
pat  <-  "^_0[[:digit:]]{4,6}"
pat  <- "^_NA"
pat  <- "^NA"
pat  <-  "^NA[[:digit:]]{4,6}"
pat  <- "_NA_"
pat  <- "^__"
pat  <- "__+"    # + = 1 or more of SECOND _
pat  <- "\\s+"    # 1 or more
pat  <- "_._"   # any character between two '_'
pat  <- "_.ogg"
pat  <- "_\\."  # _ followed by literal .
pat  <- "'"
pat  <- "-"
pat  <- ",_"
#  match 06_Apr_2018
pat  <-  "[[:digit:]]{2}_[[:alpha:]]{3}_[[:digit:]]{4}"
pat  <-  "([[:digit:]]{2})_([[:alpha:]]{3})_([[:digit:]]{4})"
# match 2018_04_06
pat  <-  "([[:digit:]]{4})_([[:digit:]]{2})_([[:digit:]]{2})"
}


   
## sprintf has some nice features!
{
sprintf("hello %s", "jim")

sprintf("hello %s", 23)

sprintf("hello %04s", 23)         # min of 4
sprintf("hello %04f", 23)         # 23.000000

sprintf("hello %04i", 23)         # int, min of 4 digits
}


