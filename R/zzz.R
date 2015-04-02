base_url <- function() {
  "http://146.148.79.138/"
}

#' @export
filter_.oc_dataframe <- function(data, ...) {
  oc_dataframe(NextMethod())
}

# A constructor function for the OC data frame
oc_dataframe <- function(x) {
  x <- tbl_df(x)
  class(x) <- c("oc_dataframe", class(x))
  x
}

if(getRversion() >= "2.15.1") {
  utils::globalVariables(".")
}




##### Ben's scratchpad ######
#
# # drill down a bit more in a specific project...
#
#
# # get data on a specific project...
# Çatalhöyük_Zooarchaeology <- oc_get_projects("Çatalhöyük Zooarchaeology")
#
#
# # seems to work as expected, to drill down into that project...
# oc_get_data <- function(project_dataframe, description){
#
#   project_dataframe %>%
#     filter_(~label %in% description) %>%
#     oc_get_records( type = "locations", category = "locations")
#
# }
#
#
# # filter the available data...
# Çatalhöyük_Zooarchaeology_data <- oc_get_data(Çatalhöyük_Zooarchaeology, "Anatomical measurement")
#
# # seems to work as expected, to drill down into that project...
# oc_get_data_types <- function(project_dataframe, description, type){
#
#   project_dataframe %>%
#     filter_(~label %in% description) %>%
#     oc_get_records( type = type, category = "locations")
#
# }
#
# # drilling down by what data are available...
# Çatalhöyük_Zooarchaeology_data_vdd <- oc_get_data_types(Çatalhöyük_Zooarchaeology_data, "Von den Driesch (1976) Bone Measurement", "four")
#
# # further, find out what elements we have...
# Çatalhöyük_Zooarchaeology_data_vdd_elements <- oc_get_data_types(Çatalhöyük_Zooarchaeology_data_vdd, "Element", "locations")
#
# # fidn out what we can get about tibia measurements...
#
# # seems to work, gives back a lot of data...
# oc_get_data_lists <- function(project_dataframe,  description){
#
#   row <- project_dataframe %>%
#     filter_(~label %in% description)
#
#
#   req <- GET(row$id, accept_json())
#   warn_for_status(req)
#   response <- content(req, as = "text")
#   if (identical(response, "")) stop("")
#   result <- fromJSON(response)
#
#   one <-  result$`oc-api:has-facets`$`oc-api:has-id-options`[[1]]
#
#   two <-  result$`oc-api:has-facets`$`oc-api:has-id-options`[[2]]
#
#   three <-  result$`oc-api:has-facets`$`oc-api:has-id-options`[[3]]
#
#   four <-  result$`oc-api:has-facets`$`oc-api:has-id-options`[[4]]
#
#   features <- result$features
#
#   return(list(one, two, three, four, features = features))
#
# }
#
# Çatalhöyük_Zooarchaeology_data_vdd_elements_Tibia <- oc_get_data_lists(Çatalhöyük_Zooarchaeology_data_vdd_elements, "Tibia")
# # gives a list
#
# # here's the first 20 bones
# Çatalhöyük_Zooarchaeology_data_vdd_elements_Tibia$features
#
# # here's a function to get the data for each of those bones....
# oc_get_data_lists2 <- function(project_dataframe){
#
#   row <- na.omit(project_dataframe$properties$href)
#   result <- NULL
#
#   for(i in seq_along(row)){
#
#     message("Getting data for ", row[i])
#
#     req <- GET(paste0(row[i], ".json"), accept_json())
#     warn_for_status(req)
#     response <- content(req, as = "text")
#     if (identical(response, "")) stop("")
#     result[[i]] <- fromJSON(response)
#
#   }
#
#   return(result)
#
# }
#
# # Can we get the Bd measurement from each of these 20 bone?
# Çatalhöyük_Zooarchaeology_data_vdd_elements_Tibia_measuments <- oc_get_data_lists2(Çatalhöyük_Zooarchaeology_data_vdd_elements_Tibia$features)
#
# # they do seem to be in there...
#
# class(Çatalhöyük_Zooarchaeology_data_vdd_elements_Tibia_measuments)
#
# xx <- Çatalhöyük_Zooarchaeology_data_vdd_elements_Tibia_measuments[[2]]$`oc-gen:has-obs`
#
# df <- list()
# for(i in seq_along(Çatalhöyük_Zooarchaeology_data_vdd_elements_Tibia_measuments)[-1]){
#   df[[i]] <- (Çatalhöyük_Zooarchaeology_data_vdd_elements_Tibia_measuments[[i]]$`oc-gen:has-obs`)
# }
# my_data <- bind_rows(df)
# # and there is a table of 20 bones with actual measurement data...
