context("Classes for Open Context")

library(dplyr, warn.conflicts = FALSE)

test_that("a data frame can get an oc_dataframe class", {
  expect_is(oc_dataframe(mtcars), "oc_dataframe")
})

test_that("a data frame maintains its classes through dplyr verbs", {
  countries <- oc_browse("countries")
  expect_is(countries, "oc_dataframe")
  countries_filtered <- countries %>% filter(label == "Turkey")
  expect_is(countries_filtered, "oc_dataframe")
})
