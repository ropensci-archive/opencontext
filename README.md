<!-- README.md is generated from README.Rmd. Please edit that file -->
opencontext: An R API client for the Open Context archeological database
------------------------------------------------------------------------

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

The result is a data table that include the names of the countries in `countries$labels`, and URLs that we can use to get more information about what projects, etc. are avialable for each country in `countries$id`

Browse locations
----------------

To browse the locations for one country:

``` r
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> 
#> The following object is masked from 'package:stats':
#> 
#>     filter
#> 
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
locations <- oc_browse(type = "countries") %>%
   filter(label == "Turkey") %>%
   oc_get_countries(type = "location")
#> Getting data for Turkey
```

To browse the locations that have archaeological data in Turkey, run `locations$label`

Browse projects
---------------

To inspect the projects available for a location in a country, for example Ulucak:

``` r
oc_get_locations("Turkey", "Ulucak")
#> Getting data for Turkey
#> Getting data for Ulucak
#>                                                                                      id
#> 1 http://146.148.79.138/sets/Turkey/Ulucak?=&proj=37-zooarchaeology-of-neolithic-ulucak
#> 2           http://146.148.79.138/sets/Turkey/Ulucak?=&proj=11-aegean-archaeomalacology
#>                                                                                         json
#> 1 http://146.148.79.138/sets/Turkey/Ulucak.json?=&proj=37-zooarchaeology-of-neolithic-ulucak
#> 2           http://146.148.79.138/sets/Turkey/Ulucak.json?=&proj=11-aegean-archaeomalacology
#>                                                       rdfs:isDefinedBy
#> 1 http://opencontext.org/projects/99BDB878-6411-44F8-2D7B-A99384A6CA21
#> 2 http://opencontext.org/projects/B1DAC335-4DC6-4A57-622E-75BF28BA598D
#>                                label count
#> 1 Zooarchaeology of Neolithic Ulucak 10472
#> 2           Aegean Archaeomalacology   296
#>                                    slug
#> 1 37-zooarchaeology-of-neolithic-ulucak
#> 2           11-aegean-archaeomalacology
```

------------------------------------------------------------------------

[![ropensci\_footer](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
