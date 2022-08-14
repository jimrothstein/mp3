
##	file <- "/home/jim/code/mp3/tests/testthat/test_10_fork_test04_use_list_ONLY.R"
##
#==============
## PURPOSE:   
-	Fork of test_04
- remove DT; use list only.
-	Use list, the_files;   NOT DT; to clean mp3 file names
- Actual mp3 file names changed ONLY in final step.
- Use glue
-	REGEX practice, improve.
#==============
##
##

	##	TODO
-	store old file names in separate ENV
-	using data.table or list: the_files ??
-	key on size?  name? or don't bother?
-	renumber:  use clever glue? (see try...6000)
-	obpaque functions:   get rid of
-	View:   shortcut to close?  try ALT-F4
-	p.5 and regex - explain!
-	problems()
	-	return atomic vector files meeting the criteria
	- print this to console
	- also print, using glue::glue, the total number



##  000 - work with file names as char[]
{
  #load_all()
  library(tinytest)
  library(data.table)
	library(glue)
	library(magrittr)


  the_dir  <- "~/mp3_files"

	#	use function
	get_files = function(the_dir=the_dir){
		list.files(the_dir)
	}

	the_files = get_files(the_dir)

##	make backup
    OLD  <- the_files
    glue::glue("Total mp3 files  {length(the_files)} ")  # 4225
}


#### 010 - functions
{
  
  problems <- function(x=NULL, pattern = NULL) {
		if (is.null(x)) x=the_files
    p  <- grep(x=x, pattern=pattern)
		x[p]
		#list(x[p], glue::glue("Total matching mp3 files {length(x[p])} "))
  }
}

	

##	012 - tests for function `problems` (how to get glue to work?)
	{
		problems(pattern="^_") 
	}

	##	no problems like this
	{
		problems(pattern="abc")
	}

	{
		problems(pattern="'")   #367
		
	}



##	40 First set of problems	

##	Next, `_NA_`
{
	   
  problems(pattern="_NA_")
  p.2   <- problems(pattern="_NA_")
	tinytest::expect_equal(problems(pattern="_NA_"),p.2)

}

}



------------------------
100_find all the problems
------------------------
-	assign p.N later (p.2, p.25 etc)

{

  p.1    <- problems(pattern="^NA")
  p.2   <- problems(pattern="_NA_")
	p.3   <- problems(pattern="\\s+") 
  p.4  <- problems(pattern= "^[[:digit:]]{6}_")
  p.4a  <- problems(pattern= "^[[:digit:]]{5}_")

  p.5 <- problems(pattern="^_")

	problems(pattern="'")	 


  p.8  <- problems(pattern = "_~_")
	problems(pattern="~")
	# one or more
	problems(pattern="~+")
	##	any question marks?
	problems(pattern="\\?")



	# one or more whitespace char
	problems(pattern="\\s+")


	#	ugly {dir}   braces are meta char
	p.30 =problems(pattern="\\{dir\\}")
	p.30
	length(p.30)
    glue::glue("Total files  {length(p.30)} ")  # 85 


	#
	problems(pattern="\\&")
	problems(pattern="\\;") # META?
	problems(pattern=";")
	problems(pattern="\\+")
	problems(pattern="\\!")
	problems(pattern="`")


	##	NOT SURE, fix !!
	# group1 greedily all word char	 (stem)
	# group2 greedily find remainder
  p.5  <- problems(pattern="(\\w*)(.*))")
  p.5  <- problems(pattern="(\\w*)(.*)\\1)")
}



##	Next step, remove problems

  


{ ## remove prefix

}


## GREP, contains `?`, returns the index of match 
{
      the_pattern  <- "\\?" 
      grep(x=the_files, pattern=the_pattern)
      ## now display 
      the_files[grep(x=the_files, pattern=the_pattern)]
}

####	p.20, Find filenames with `-`
{
	#	splits string into 2 pieces:  `stem` that greedily includes all characters EXCLUDING `-`
	#	(.*) Read greedy dot;  finds all the  rest
	the_pattern="^([^-]*)-(.*)"
	p.20  <- problems(pattern=the_pattern)

	#
	p.21  <- the_files[grep(x=the_files, pattern=the_pattern)]
	p.21
	tinytest::expect_identical(p.20, p.21)

	# even simpler!
	p.22   <- the_files[grep(x=the_files, pattern="-")]
	p.22
	tinytest::expect_identical(p.20, p.22)

}
####	p.20, Replace that `-` with `_`
{
	the_pattern="'"

	p.23  = problems(pattern="'")	 
	problems(pattern="'") |> length()



	#	sub(x=p.23, pattern="-",  replacement="_")


	## poof ... all gone.
	p.24 =	gsub(x=p.23, pattern=the_pattern, replacement="_")
	problems(x=p.24, pattern=the_pattern)


	the_files %>% length()
	p.24 =	gsub(x=the_files, pattern=the_pattern, replacement="_")
	# all gone
	problems(p.24, pattern=the_pattern)
	the_files = p.24
	the_files

}




{ ## remove some more!

## -----------------------------------
{
	## careful,  some numbers are needed and NOT prefix
  # now remove prefix
  the_pattern = "^[[:digit:]]{1,6}_"
	problems(pattern=the_pattern)


	##	safer to insist 6 digits and first is zero
	##	then, insist 5 digits and 1st is zero
  the_pattern = "^[[:digit:]]{4,6}_"
	problems(pattern=the_pattern)



##-----------------------------------
	problems(pattern="^NA")
  p.1    <- problems(pattern="^NA")
	p.1
  the_files[p.1]

## double check: (Success means there are NO ^NA files)
    tinytest::expect_equal(character(0),the_files[p.1])
# ----- PASSED      : <-->
#  call| tinytest::expect_equal(character(0), the_files[p.1]) 

}
##-----------------------------------
{
  ## Any files with a blank space, tab ... (grep returns index)
	problems(pattern="\\s+")
}
  p.3  <- grep(x=the_files, pattern="\\s+")
  the_files[p.3]

  # remove empty space, but this is not GREEDY
  the_files  <- sub(x=the_files, pattern="\\s+", replacement="_")  
  the_files

  # this is greedy
  the_files  <- gsub(x=the_files, pattern="\\s+", replacement="_")  
  the_files

##-----------------------------------
  ## any leadning `_` (one or more)
  p.5 <- problems(pattern="^_+")
  p.5

  the_files  <- sub(x=the_files, pattern="^_+", replacement="")
	the_files

	# check:
  p.5 <- problems(pattern="^_+")
  tinytest::expect_equal(character(0),p.5)
  

##-----------------------------------
  # Any files now begin with  NA?
  p.6 <- problems(pattern="^NA")
	p.6

  # remove ^NA
  the_files  <- sub(x=the_files, pattern="^NA", replacement="") 
	the_files

	# check
  p.6 <- problems(pattern="^NA")
  tinytest::expect_equal(character(0),p.6)


##-----------------------------------

  # remove ugly "<sp>-<sp>"
  p.7  <- problems(pattern = "_-_")
	p.7
  ## not greedy, run multiple or change to gsub
  the_files  <- sub(x=the_files, pattern="_-_", replacement="_")
  the_files

##-----------------------------------
  # remove ugly "_~_"
  p.8  <- problems(pattern = "_~_")
	p.8
  the_files  <- sub(x=the_files, pattern="_~_", replacement="_")
  the_files

##-----------------------------------
  # remove  "_.ogg"   BE smarter about this one!
  p.9  <- problems(pattern = "_.ogg$")
	p.9
  the_files  <- sub(x=the_files, pattern="_.ogg", replacement=".ogg")
  the_files

##-----------------------------------
  ## any files now with multiple "_", again  use gsub, for greedy
  p.10  <- problems(pattern = "_{2,}")
	p.10
  the_files  <- gsub(x=the_files, pattern="_{2,}", replacement="_")
##-----------------------------------
	##  one or more `?` (question mark)
  p.11  <- problems(pattern="\\?{1,}")
	p.11

	## fix all
  the_files  <- gsub(x=the_files, pattern = "\\?{1,}", replacement="_")
  the_files

	#check
  p.11 <- problems(pattern="^NA")
  tinytest::expect_equal(character(0),p.11)


##-----------------------------------
  ## any ",_"
  p.12  <- problems (pattern = ",_") 

	p.12
  the_files  <- gsub(x=the_files, pattern=",_", replacement="_")
  
	##	any `,` (comma) ?
	problems(pattern=",")
	the_files  <- gsub(x=the_files, pattern=",", replacement="_")
	problems(pattern=",")



##-----------------------------------
  ## TODO, careful .. not all digits are prefix
  ## Files that DO NOT begin with proper prefix
  p.13  <- problems(pattern = "^[[:digit:]]{2,6}")
	p.13


##-----------------------------------


	# BE SMARTER   can't 's  maybe NEED
  ## Files that contain ' , convert to _
  p.14  <- problems(pattern = "'")
	p.14
  ## change
  the_files  <- gsub(x=the_files, pattern="'", replacement="_")
  the_files

##-----------------------------------
	##  files with German, `<fc>` or `<dc>`  seem to cause adb push to CHOKE
	##  ` < >`   are NOT special  or metacharac
	{	

		p.16=problems(pattern="<.*>")
		p.16

		p.16  <- sub(x=p.16, pattern="<.*>" , replacement="_")
		p.16

		##	 for real.
		the_files  <- sub(x=the_files, pattern="<.*>" , replacement="_")
		
		tinytest::expect_equal(character(0),problems(pattern="<.*>"))

		


	##
	# p.30
	{
		# to perfect algorithm, find p.30 and work with it.
		# do not go back the the_files
		# instead massage p.30, till is character(0) - no errors

		
	#	begins with,   `${dir}`
	the_pattern="^\\$\\{dir\\}"
	p.30 =problems(pattern=the_pattern)
	p.30

  p.30 <- sub(x=p.30, pattern=the_pattern, replacement="_")
	p.30


	# any problems remaining?
	#
	p.30 =problems(x=p.30, pattern=the_pattern)
	p.30

	##	done, when:
   tinytest::expect_equal(character(0),p.30)
	
	}

	## Now that we have the algorithm, make changes and return the_files with all the corrections.
	## Get in habit of perl=T, EXCEPT sub chokes with non-UTF-8 characters
	{

	the_pattern="^\\$\\{dir\\}"
	problems(x=the_files, pattern=the_pattern)

	#	sub makes changes, returns every element.
  y  <- sub(x=the_files, pattern=the_pattern, replacement="_", perl=F)

	the_files[[1694]]  
	the_files  <- y


	## done?
		
	problems(x=the_files, pattern=the_pattern)
	test

   tinytest::expect_equal(character(0),problems(x=the_files, pattern=the_pattern))
	}

##-----------------------------------
###----------------------------------
#
## View ... easiest way to check
{ 

  View(the_files)
}




{ ## prepare new index (glue faniier?)
   the_prefix <- create_new_prefix(the_files, digits=4)
    the_prefix

}

{ ## attach new index
  the_files <- attach_new_prefix(the_files, prefix=the_prefix)
  the_files
}



##	OLD & NEW same?
{
	tinytest::expect_identical(OLD, the_files)
	
}

{  ##  rename:  OLD to NEW 
  if (F) (
  OLD

  NEW  <- the_files
  NEW

	tinytest::expect_equal(length(OLD), length(NEW))

  ## check:  last chance
  paste0(the_dir,"/",OLD)
  paste0(the_dir,"/",NEW)

	##	
	file_rename  <- function(OLD,NEW){
		## retruns T if 
		file.rename(from = paste0(the_dir,"/",OLD), 
              to= paste0(the_dir,"/",NEW))
	}

	###	rename
	if(F){
		file_rename(OLD,NEW)
		tinytest::expect_equal(OLD,NEW) 
	}


	## need to get updated the_files?
	##
	the_files  <- get_files(the_dir)
	the_files
  )
}

##-----------------------
##			L E G A C Y
##-----------------------

##	LEGACY, removed from above code (use dt or glue)
##  Put into data.table

{
    dt  <- get_file_names()
		str(dt)
		dt |> head()
}


##	order in decreasing size
{
	dt1  <- setkey(dt, size)
	str(dt1)
	tables()
	#View(dt1[order(-size)])
	dt1 |> head()
}

### Use data.table
  {
  #  as data.table, returns only rows that match pattern
  View(dt[d.1  <- grepl(x=the_files, pattern="_NA_")])
  dt[, .(new = sub(x=name, pattern="_NA_", replacement="_"))]

  # add new col with change:
  f  <- function(e) sub(x=e, pattern="_NA_", replacement="_")
  dt[, .(name,new = sapply(name, f))] |> View()


  
  dt[grepl(x=the_files, pattern= "^[[:digit:]]{5}_")]
  }  

#	GLUE does not work
	#problems("^_") %>% glue::glue("Total files with this problem  {length(.)}") 
