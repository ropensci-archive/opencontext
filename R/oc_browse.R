#' Browse the Open Context archeological database
#'
#' This function returns a data frame of certain types of top level data from
#' Open Context. You can get either a data frame of countries for which Open
#' Context has data, project names that have data on Open Context, or a list of
#' descriptions (Common Standards) of data attributes that are widely used in
#' Open Context datasets.
#'
#' @param type The kind of to be returned. You can chose either
#'   \code{'countries'} to get a data frame of names of countries that have Open
#'   Context datasets, or \code{'projects'} to get a data frame project names,
#'   or \code{'descriptions'} to get a data frame of data attributes that are
#'   widely used in Open Context data sets.
#' @param print_url Whether or not to display a message with the URL of the
#'   query. You can navigate to this URL to see the web interface's version of
#'   the data returned by the API.
#' @param ... Additional arguments passed to \code{\link[httr]{GET}}.
#' @return A data frame with additional class \code{oc_dataframe}.
#' @examples
#' oc_browse("countries")
#' oc_browse("projects")
#' @export
oc_browse <- function(type = c("countries", "projects", "descriptions"),
                      print_url = FALSE, ...) {

  type <- match.arg(type)

  url <- paste0(base_url(), "sets/")
  if (print_url) message(url)

  req <- GET(url, query = list(), accept_json(), ...)
  warn_for_status(req)

  response <- content(req, as = "text")

  if (identical(response, "")) stop("")
  result <- fromJSON(response)

  result <- switch(type,
         "countries" = result$`oc-api:has-facets`$`oc-api:has-id-options`[[1]],
         "projects"  = result$`oc-api:has-facets`$`oc-api:has-id-options`[[2]],
         "descriptions"  = result$`oc-api:has-facets`$`oc-api:has-id-options`[[3]]
  )

  oc_dataframe(result)

}