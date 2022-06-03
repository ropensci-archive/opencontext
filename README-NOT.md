<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Travis-CI Build Status](https://travis-ci.org/ropensci/opencontext.png?branch=master)](https://travis-ci.org/ropensci/opencontext)

opencontext: An R API client for the Open Context archaeological data repository
--------------------------------------------------------------------------------

This packages enables browsing and downloading data from [Open Context](http://opencontext.org/) using R. Open Context reviews, edits, and publishes archaeological research data and archives data with university-backed repositories, including the California Digital Library.

Installation
------------

Install `opencontext`

``` r
install.packages("devtools")
devtools::install_github("ropensci/opencontext")
```

``` r
library("opencontext")
```

Browse countries
----------------

To browse the countries that Open Context has data on:

``` r
countries <- oc_browse("countries")
```

The result is a data frame that include the names of the countries in `countries$label`. URLs that we can use to get more information about what projects, etc. are available for each country in `countries$id`

Browse locations
----------------

To browse the locations for one country, for example, Turkey:

``` r
library("dplyr", warn.conflicts = FALSE)
locations <- oc_browse(type = "countries") %>%
   filter(label == "Turkey") %>%
   oc_get_countries(type = "location")
#> Getting data for Turkey
```

To browse the names of locations that have archaeological data in Turkey, run `locations$label`. We can see that the first location in this example is Çatalhöyük.

Browse projects
---------------

To inspect the projects available for a location in a country, for example, for Çatalhöyük in Turkey:

``` r
projects_at_Çatalhöyük_Turkey <- oc_get_locations("Turkey", "Çatalhöyük")
#> Getting data for Turkey
#> Getting data for Çatalhöyük
```

Once again, the `label` column has the names of the projects: `projects_at_Çatalhöyük_Turkey$label`.

With a little further effort we can browse excavation/survey areas within the project, and get datasets of measurements of objects collected from these areas (along with chronological and spatial data for these objects).

Get data from a specific project
--------------------------------

Now that we've identified a specific project, we can ingest data from that project into our R session.

------------------------------------------------------------------------

[![ropensci\_footer](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
