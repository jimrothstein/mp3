##  00_main.R
##
## PURPOSE:  Use Base R functions to clean prefix and replace with new order.
##
# -----------------------
## TODO:
# -----------------------
# -----------------------
#### base:: comands REF
# -----------------------
{
    if (F) {
        list.files(".")
        file.rename()
        file.create()
        basename()
        dirname()
        list.dirs()
        dir()
    }
}


# -----------------------
the_dir = "."
f1 = list.files(the_dir)
f1


##  save
old = new.env()
old$f1 = f1


# --------------------------------
###   ways to find problem files
# --------------------------------
{

## char[]
f1[grep(x= f1, pattern="^[[:digit:]]")]
pattern = "^test"
f1[grep(x= f1, pattern=pattern)]


## grap files each time
list.files(path=".", all.files=F, pattern="^[[:digit:]]")
list.files(path=".", all.files=F, pattern="^[m]")

the_pattern="^[0-9]{2,4}"
the_pattern="^test"

list.files(path=getwd(), 
        pattern=the_pattern,
        all.files = F 
        )
}


## Use char[]
f2 = sub(f1, pattern = "^test_", replacement="" )

f2
f3 = sub(f2, pattern = "^[[:digit:]]{2,6}_", replacement = "")
f3


## Keep only R files 
f4 = f3[grep(f3, pattern="\\.R$")]
f4

original = f1[grep(f1, pattern="\\.R$")]
original
    
##}
remove_prefix(files=the_files,pattern= "^test_")  
remove_prefix(files=the_files,pattern= "^[[:digit:]]{2,6}_")



## new prefix, uses length of f3
prefix = seq_along(f4) * 10
 prefix  <- sprintf("%04i_", prefix) 
prefix 
f5 = paste0(prefix, f4)
f5




file.rename(from= original  to = f5)
