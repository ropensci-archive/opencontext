#' Retrieve data in Open Context by country
#'
#' Given a character vector of one or more countries, or a data frame of
#' countries returned from \code{\link{oc_browse}}, this function retrieves data
#' related to those countries. The function can return projects, locations, or
#' descriptions.
#'
#' @param countries A character vectory of country names or a data frame
#'   returned from \code{\link{oc_browse}}.
#' @param type The type of data to return: \code{"projects"},
#'   \code{"locations"}, \code{"descriptions"}. The default is
#'   \code{"projects"}.
#' @return A data frame with the additional class \code{oc_dataframe}.
#' @examples
#' oc_get_countries("germany", type= "projects")
#'
#' library(dplyr)
#' oc_browse(type = "countries") %>%
#'   filter(label == "Turkey") %>%
#'   oc_get_countries(type = "locations")
#'
#' @export
oc_get_countries <- function(countries,
                             type = c("projects", "locations", "descriptions")) {
  UseMethod("oc_get_countries")
}

#' @export
oc_get_countries.oc_dataframe <- function(countries, type = c("projects",
                                          "locations", "descriptions")) {

  type <- match.arg(type)
  result <- countries %>%
              rowwise() %>%
              do(get_row(., type = type)) %>%
              ungroup()

  oc_dataframe(result)

}

#' @export
oc_get_countries.character <- function(countries, type = c("projects",
                                       "locations", "descriptions")) {

  type <- match.arg(type)
  oc_browse(type = "countries") %>%
    filter_(~tolower(label) %in% tolower(countries)) %>%
    oc_get_countries()

}

get_row <- function(row, type) {
  message("Getting data for ", row$label)

  req <- GET(row$id, accept_json())
  warn_for_status(req)
  response <- content(req, as = "text")
  if (identical(response, "")) stop("")
  result <- fromJSON(response)

  result <- switch(type,
         "locations" = result$`oc-api:has-facets`$`oc-api:has-id-options`[[1]],
         "projects"  = result$`oc-api:has-facets`$`oc-api:has-id-options`[[2]],
         "descriptions"  = result$`oc-api:has-facets`$`oc-api:has-id-options`[[3]]
  )

  result
}

