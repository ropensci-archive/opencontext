base_url <- function() {
  "http://146.148.79.138/"
}

#' @export
filter_.oc_dataframe <- function(data, ...) {
  oc_dataframe(NextMethod())
}

# A constructor function for the OC data frame
oc_dataframe <- function(x) {
  class(x) <- c("oc_dataframe", class(x))
  x
}

if(getRversion() >= "2.15.1") {
  utils::globalVariables(".")
}