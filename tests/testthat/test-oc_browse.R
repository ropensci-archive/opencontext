context("Browsing")

countries <- oc_browse("countries")
projects  <- oc_browse("projects")

test_that("returns correct type of object", {
  expect_is(countries, "data.frame")
  expect_is(countries, "oc_dataframe")
  expect_is(projects, "data.frame")
  expect_is(projects, "oc_dataframe")
})