# TAGS:     sprintf, regex, mp3, DT,
#
# PURPOSE:   Collect regex patterns with R.
#            * Practice with Simple strings and regex with R
#            * May use Read-only file names, matching
#               Including groupings; forward/backword; !so tips.
#            * To practice REGEX, grep, sed:  SEE zsh_scripts, HERE:  R only.
#
# CAUTION:   Nothing in this file should WRITE file names to disk. 
# TEST only on fake strings.  Don't use on mp3 till tested!
#
#
# file <- "tests/testthat/test_PATTERNS.R###  Change file names, add/remove prefix, use `base R`"
#
```
Main idea is this:
  * Set dir, 
  * Choose pattern to match files
  * old = original file names
  * new = proposed file names, with changes (using gsub)
  * prepend the dir
  * file.rename(old, new)

# -------------------
#### base:: comands
# -------------------
file.rename()   # NO WRITING in this file!
file.create()
basename()
dirname()
list.dirs()
dir()
```

#### setup
{

    load_all()
    library(tinytest)
    library(data.table)
    library(magrittr)
}

{
dt  <- data.table(x=letters[1:5], y=letters[1:5])
dt  <- data.table(str=list(c("A,B,C,D"), c("A", "B")),
                  pattern = list("((?:[[:upper:]]+)+),?", 
                                 "[[:upper:]]")
                  replacement=list("\\1_" , 
                                   "-"))
dt

f  <- function(x, y, z) {
    gsub(x, pattern=y, replacement=z)
}

dt[, .(new = mapply(f, x=str,pattern, replacement))]
}

####  gsub, multiple
{
    f  <- function(e) {
        gsub(x = e[[1]],
        pattern = e[[2]],
        perl = F,
        replacement = e[[3]])
}


####  GSUB EXAMPLES, simple  |x = string | pattern = regex | replacement
{
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

#### GSUB Examples, longer strings
{
the_phrase  <-"_  End of The World - Skeeter Davis Live_08Sep2020_.ogg" 

gsub(the_phrase, pattern = " ", replacement ="_")
gsub(the_phrase, pattern = "\\s+", replacement = "_")

# works
gsub(the_phrase, pattern = "\\s+-\\s+", replacement = "_")
# almost
#
#
## can chain !!

gsub(the_phrase, pattern = "(\\s+)", replacement = "_") %>% gsub(pattern="_-_", replacement="_")


##     /((?:\w+)+),?/gm
}


#### Working with file paths
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

#### VERSION .2   DT
{ 
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

#### More Complicated grep -P
{
x  <- "XSeekers._ SeekersZ"
pattern  <- "(Seekers)(.*)\\1"
grep(pattern, x, perl=T, value=T)


## Files
x  <- list.files("~/mp3_files")    


}
#### a few real mp3 file names to practice  
{ 
  the_dir  <- "~/mp3_files"
  head(list.files(the_dir))
# [1] "_ End of The World - Skeeter Davis Live_08Sep2020_.ogg"                                   
# [2] "__Bob_Lucille__LUCILLE_STARR_The_French_Song_First_Recording_06Dec2020.ogx"               
# [3] "__Bob_Lucille__Lucille_Starr_TRIBUTE_Freight_Train_(1963)._06Dec2020.ogx"                 
# [4] "__Bob_Lucille__Quand_le_Soleil_Dit_Bonjour_aux_Montagnes_Lucille_Starr_1965_06Dec2020.ogx"
# [5] "__Bob_Lucille__The_French_Song_06Dec2020.ogx"                                             
# [6] "__THE_CHARTS_DESERIE_(1957)_01Aug2020.ogg"                                                
}



#### Match file names 
{
list.files("rmd", full.names= T, pattern="*.Rmd")
list.files("./rmd", pattern="*.Rmd")
list.files("./rmd", full.names = TRUE ,pattern="*.Rmd")
}

#### More Regex patterns
{
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



# ----------------------
####    EXAMPLES: precedes (?<=)
# ----------------------
{
#  letter o (1 or more) preceded by f 
    x  <- c("foo","boo", "faa", "fstool", "fo", "foooo")
    grep(x, pattern="(?<=f)(o+)", value = T, perl=T)

    sub(x=x, pattern="(?<=f)(o+)", replacement="X", perl=T)
# [1] "fX"     "boo"    "faa"    "fstool" "fX"     "fX"    
}

  x  <- "foo"
  sub(x=x, pattern="(f)(o+)", replacement="\\1_\\2_")

## see rmd/..regex.. examples in try project
## remove _NA_
    x  <- "_xyz_NA_abc" 
  sub(x=x, pattern="(?<=_)(NA_+)", replacement="\\2", perl=T, fixed=F)


#### letter o (1 or more) preceded by f, replace with group
  sub(x=x, pattern="(?<=f)(o+)", replacement="\\1", perl=T, fixed=F)
  sub(x=x, pattern="(?<=f)(o+)", replacement="\\2", perl=T, fixed=F)
  sub(x=x, pattern="(?<=f)(o+)", replacement="\\3", perl=T, fixed=F)
   
#### match all puncutation
  {
      ## for regex, use fixed = F (default)
      ## for string match, fixed = T
      ##
      f  <- function(string = NULL, pattern = NULL){
          gsub(x = string, pattern = pattern, replacement = "", perl=T, fixed=F)
      }

      ## Examples:
      f("JAR", pattern="J")
      f(string = "~!@#$%^&*()_+)", pattern = "[[:punct:]]" )

      ## remove everything (including SP) EXCEPT alpha, ' /
      ans  <- f(string = "/ABD'-+?:;{}[]<>~!^@#$%^&*()_+)", 
        pattern = "[^A-Za-z///' ]" )

      tinytest::expect_identical(ans, "/ABD'")
# ----- PASSED      : <-->
#  call| tinytest::expect_identical(ans, "/ABD'") 

}


#### sprintf has some nice features!
{
sprintf("hello %s", "jim")

sprintf("hello %s", 23)

sprintf("hello %04s", 23)         # min of 4
sprintf("hello %04f", 23)         # 23.000000

sprintf("hello %04i", 23)         # int, min of 4 digits
}


