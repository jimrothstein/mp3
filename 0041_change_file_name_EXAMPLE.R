##  EXAMPLE:   if file name is of form dddd and lead d is 0, cut it.   ie  0123 becomes 123;  but 4123 is left alone

# -----------------
#   current setup
# -----------------
dir <- "~/code/try_things_here/BASE/"
list.files(dir)

# ------------------------------------------------
#   files to be changed (0 followed by 4 digits)
# ------------------------------------------------
pat <- "^0[0-9]{3}"
# L= list.files(dir, pattern = pat, full.names=T)
L <- list.files(dir, pattern = pat)

# ----------------------------------------------------------------------
#   for each such file, make this change (here:  remove leading  zero)
# ----------------------------------------------------------------------
pat <- "^0"
M <- gsub(x = L, pattern = pat, replacement = "")

# ------------------------
#   add directory prefix
# ------------------------
L1 <- paste0(dir, L)
M1 <- paste0(dir, M)

L1
M1

# ------------------------
#* file.rename(old, new)
# ------------------------
file.rename(L1, M1)
