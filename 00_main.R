##  00_main.R
##
## TODO:
## -    Functions should return char[]
## -    Create col in dt as separate step
{
    # load_all()
    library(data.table)
    library(kableExtra)
    source("./90_find_replace_patterns.R")
}
#### base:: comands REF
{
    if (F) {
        file.rename()
        file.create()
        basename()
        dirname()
        list.dirs()
        dir()

        # list.files(<dir>)
    }
}


#### Return dt with file name and siz (default = ".")
{
    dt <- get_file_names()
    #    str(dt)
    #    dput(dt)
    #    dput(dt, control = c(NULL)) ## return as list
    dt[, .N]
    dt |> head() # [1] 4077
}


#### List files with a given prefix
###
{
#list.files(path=".", all.files=F, pattern="^[:digit:]")
list.files(path=".", all.files=F, pattern="^[m]")
the_pattern="^[0-9]{2,4}"
the_pattern="^test"

list.files(path=getwd(), 
        pattern=the_pattern,
        all.files = F 
        )
}

###     Given a prefix, return vector of names without prefix. 
{
(the_files = basename(dt$name))
    
## remove_prefix <- function(files = NULL, pattern = NULL) {
##    sub(pattern = pattern, replace = "", x = files)
##}
remove_prefix(files=the_files,pattern= "^test_")  
remove_prefix(files=the_files,pattern= "^[[:digit:]]{2,6}_")

# not work !
# the_files |> remove_prefix(pattern="^text")

}