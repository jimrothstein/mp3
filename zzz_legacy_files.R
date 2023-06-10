#  LEGACY FILES
#   file <- "/home/jim/code/mp3/R/zzz_legacy_files.R#"

#' @title get_RMD_files
#'
#' @description  Given a path and pattern, return char vector of file names.
#' Ignores files that begin with '_'
#' @param path  Directory to query. 
#' @param pattern regex pattern to match files 
#' @return full file name (with directory)
#' @keywords internal
#' @export
   get_RMD_files  <- function (path = ".", pattern = NULL, recursive = FALSE) {
     #
     #rmd_pattern  <- '[.][Rr](md|markdown)$'
     # md_pattern  <- '[.][Rr]?(md|markdown)$'
     #
     files  <- list.files(path  =  path, pattern = pattern, recursive = recursive)
     # exclude files begin with _
     files  <- files[!grepl('^_', basename(files)) | 
                     !grepl('^_index[.]', basename(files)) ]
     files  <- paste0(path,"/", files)
   }


#' replace_pattern
#'
#' @description
#'   Given a character vector, find and replace all matching patterns.
#' @details
#'    This is stub.   It will replace numerous files (below) that remove
#'    prefix, generate new prefix and attach the new prefix.
#' @param the_files  character vector
#' @param pattern  Regex pattern to match
#' @param replace  Text to replace matched pattern.
#' @keywords internal
#' @export
#'  
  replace_pattern  <- function(the_files, pattern, replace) {
  }
    
