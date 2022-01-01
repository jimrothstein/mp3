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
## Assuming ~/mp3 return dt with name and siz
dt  <- get_file_names()


str(dt)
dt[, .N]
dt |> head()
# [1] 4077
#



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






