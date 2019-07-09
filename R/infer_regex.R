#' Infer the regular expression (regex) and other features of a string
#'
#' @param x a string
#'
#' @return a data frame
#' @export
#'
#' @examples
#' library(purrr)
#' regex_df <- map_dfr(rownames(mtcars), infer_regex))
#' all(map2_lgl(regex_df$string, regex_df$regex, ~grepl(.y, .x)))
infer_regex <- function(x) {

  stopifnot(is.character(x))
  r <- vector(mode = "character")
  r_out <- vector(mode = "character")
  s <- strsplit(x, "")[[1]]
  purrr::walk(s, ~{
    if (grepl("[a-z]", .x)) {
      r <<- c(r, "l")
    } else if (grepl("[A-Z]", .x)) {
      r <<- c(r, "L")
    } else if (.x %in% as.character(0:9)) {
      r <<- c(r, "d")
    } else if (.x == " ") {
      r <<- c(r, "w")
    } else if (.x %in% c("[", "]", "^")) {
      r <<- c(r, .x)
    } else {
      r <<- c(r, .x)
    }
  })

  nchars <- length(r)
  nlower <- sum(grepl("l", r))
  nupper <- sum(grepl("L", r))
  ndigits <- sum(grepl("d", r))
  nwhite <- sum(grepl("w", r))
  rl <- rle(r)

  purrr::walk2(rl$values, rl$lengths, ~{
    if (.x == "l") {
      r_out <<- paste0(r_out, sprintf("[a-z]{%d}", .y))
    } else if (.x == "L") {
      r_out <<- paste0(r_out, sprintf("[A-Z]{%d}", .y))
    } else if (.x == "d") {
      r_out <<- paste0(r_out, sprintf("\\d{%d}", .y))
    } else if (.x == "w") {
      r_out <<- paste0(r_out, sprintf("\\s{%d}", .y))
    } else if (.x %in% c("[", "]", "^")) {
      r_out <<- paste0(r_out, "\\", .x)
    } else {
      r_out <<- paste0(r_out, .x)
    }
  })

  r_out <- paste0("^", gsub("\\{1}", "", r_out), "$")
  out <- data.frame(string = x,
             regex = r_out,
             nchars,
             nlower,
             nupper,
             ndigits,
             nwhite,
             stringsAsFactors = FALSE
             )
  out
}
