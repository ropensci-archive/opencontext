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
oc_get_countries <- function(country, type = c("projects", "locations",
                                               "descriptions")) {
  type <- match.arg(type)
  oc_get_records(country, type, category = "countries")
}

#' Retrieve the names of projects in a given Country and Location
#'
#' @param country A country name
#' @param locations A character vector of locations in that country
#' @examples
#' oc_get_locations("Turkey", "Ulucak")
#' @export
oc_get_locations <- function(country, locations, type = c("projects", "descriptions")){
  type <- match.arg(type)
  oc_get_countries(country, type = "locations") %>%
  filter_(~label %in% locations) %>%
  oc_get_records(type)
}

#' Retrieve data given an Open Context project name
#'
#' @param project A character vector of project names
#' @return A data frame of resources associated with the projects.
#' @examples
#' oc_get_projects("Kenan Tepe")
#' @export
oc_get_projects <- function(project) {
  oc_get_records(project, type = "projects", category = "projects")
}

oc_get_records <- function(field, type, category) {
  UseMethod("oc_get_records")
}

oc_get_records.oc_dataframe <- function(field, type, category) {

  result <- field %>%
              rowwise() %>%
              do(get_row(., type = type)) %>%
              ungroup()

  oc_dataframe(result)

}

oc_get_records.character <- function(field, type, category) {

  oc_browse(type = category) %>%
    filter_(~tolower(label) %in% tolower(field)) %>%
    oc_get_records(type = type)

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

