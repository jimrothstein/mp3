
#' save_old_names
#' @description safely save copy of original files in separate environmentt
#' @param the_files Unchanged character vector of file names as read from
#' drive.
#' @export
save_old_names  <- function(the_files = NULL) {
  e  <<- new.env()
  e$the_files  <- the_files
}

#'  get_file_names
#'  @description Returns dt, with file names and file size in MB
#'  @export
get_file_names  <- function() {
    the_dir  <- "~/mp3_files"
    the_files  <- list.files(path="~/mp3_files", full.names=T)
    ## 1MB = 2^20 (= 1,048,576) 
    dt  <- data.table(name = the_files, size = file.size(the_files)/2^20)
    }


#'  remove_prefix
#'
#' @description Remove any existing prefix according to pattern
#'  May need multiple passes
#' @param the_files character vector of all possible file names to be changed.
#' @param pattern Select the files to change.
#' @export
remove_prefix  <- function(the_files = NULL, pattern = pattern) {
  sub(pattern=pattern, replace="", x=the_files)
}


#' create_new_prefix
#' @description propose new prefix, min of digits
#' @param the_files character_vector  
#' @param digits  sprintf will nice format prefix, padding zeroes to front if
#'  necessary.
#' @export
  create_new_prefix  <- function(the_files=NULL, digits=4) {
    n  <- length(the_files)
    format  <- paste0("%0",digits,"i_")
    the_prefixs  <- sprintf(format, 1:n)
  }


#' attach_new_prefix
#' @description attach proposed prefix.
#' @param the_files character vector of file names that will receive new prefix.
#' @param prefix Proposed new prefix.
#' @export
attach_new_prefix  <- function(the_files = NULL, prefix=NULL) {
  paste0(prefix, the_files)
}



