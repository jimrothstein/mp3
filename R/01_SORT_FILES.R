# TAGS:     sprintf, regex, mp3, DT,
#
#
# PURPOSE:   Sort mp3 file names, by name, by size
# USE CASE:  Find dupicate files, histogram by size.
#
# THIS FILE:
#   "tests/testthat/test_01_SORT_FILES.R#"
{
    #load_all()
    library(data.table)
    library(kableExtra)
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


# ------------------- STOP HERE---------------------

# I# sort on size (displays all columns)
{
    dt[order(-size)] |> View()
    dt[order(size)] |> View()

    setorder(dt, -size, name)
    dt

    ## large files
    dt[, .N]
    dt[size > 50, .N]
    dt[size > 20, .N]

    dt[size > 50] %>% head(10L)

    ##  most <10 MB
    hist(dt$size)
}

## sort on name
{
    setorder(dt, name, -size)
    dt |> head()
    View(dt) ## <C-Q>
}

## find files with SAME MB (and > 5MB) - BUG - need same NAME and MB
##
uniqueN(dt, by = c("size")) ## 3795 < 4707, so many with same size

### this is it!
dt[, .N, by = size][order(-N) && N > 1, ]

### working, but not what i want.
dt[order(size), .SD, by = size] |> View()
dt[order(size), .SD[.N], by = size]

dt[order(size), .(nrow(.SD)), by = size]
dt[order(size), .N, by = size]


#    TODO - document w/ DT
### closer

duplicated(dt)
duplicated(x = dt, by = c("size"))

## return all dup rows
dt[duplicated(x = dt, by = c("size"))]

dt[, .(name, .N), by = size][N > 1] |> head()
dt[, .(name, .N), by = size][N > 1] |> View()
dt[, .(name), by = size] |> View()

### return int
uniqueN(dt, by = c("size"))

### return dt, unique values of size
u_dt <- unique(dt, by = "size")
u_dt

### inner join
join_dt <- merge(u_dt, dt, by.x = c("size"), by.y = c("size"))
join_dt[order(-size)] |> View()


dt[, .N, by = .(size)]

dt[, .N, by = .(size)][order(size)]

dt[, .N, by = size]
