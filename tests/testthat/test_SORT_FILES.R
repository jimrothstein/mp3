# TAGS:     sprintf, regex, mp3, DT,
#
# PURPOSE:   Sort mp3 file names, by name, by size
# USE CASE:     Find dupicate files
#
# THIS FILE:  tests/testthat/test_SORT_FILES.R#
#
{
load_all()
library(data.table)
library(kableExtra)
}

{
#### base:: comands
file.rename()
file.create()
basename()
dirname()
list.dirs()
dir()
}





#### DT, with columns for filename and size
{ 
    ## a few real mp3 file names to practice  
  the_dir  <- "~/mp3_files"
the_files  <- list.files(path="~/mp3_files", full.names=T)
the_files
y  <- sapply(the_files, file.size)
y %>% head()

dt  <- data.table(name = names(y), size = y)
dt


dt[, .N]
# [1] 3915
#

## convert bytes to MB
## 1MB = 2^20 (= 1,048,576) 
dt  <- dt[, .(name,   MB= size/2^20)]
dt
View(dt)

## sort on MB
    setorder(dt, -MB, name)
    dt

## large files
    dt[,.N]
    dt[MB >50, .N]
    dt[MB >20, .N]

    dt[MB > 50] %>% head(10L)

## sort on name
    setorder(dt, name, -MB)
    dt


## find files with SAME MB (and > 5MB) - BUG - need same NAME and MB
    dt[, .(name, .N), by=MB][N > 1]




### LEGACY
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


