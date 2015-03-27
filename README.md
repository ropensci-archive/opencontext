<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Travis-CI Build Status](https://travis-ci.org/ropensci/opencontext.png?branch=master)](https://travis-ci.org/ropensci/opencontext)

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
countries
#> Source: local data frame [27 x 6]
#> 
#>                                                    id
#> 1          http://146.148.79.138/sets/United+States?=
#> 2                 http://146.148.79.138/sets/Turkey?=
#> 3                 http://146.148.79.138/sets/Jordan?=
#> 4                  http://146.148.79.138/sets/Italy?=
#> 5                   http://146.148.79.138/sets/Iran?=
#> 6                http://146.148.79.138/sets/Germany?=
#> 7                 http://146.148.79.138/sets/Cyprus?=
#> 8                 http://146.148.79.138/sets/Israel?=
#> 9         http://146.148.79.138/sets/United+Kingdom?=
#> 10 http://146.148.79.138/sets/Palestinian+Authority?=
#> ..                                                ...
#> Variables not shown: json (chr), rdfs:isDefinedBy (chr), label (chr),
#>   count (int), slug (chr)
```

The result is a data table that include the names of the countries in `countries$labels`, and URLs that we can use to get more information about what projects, etc. are avialable for each country in `countries$id`

Browse locations
----------------

To browse the locations for one country:

``` r
library("dplyr", warn.conflicts = FALSE)
locations <- oc_browse(type = "countries") %>%
   filter(label == "Turkey") %>%
   oc_get_countries(type = "location")
#> Getting data for Turkey
```

Alternatively:

``` r
oc_get_countries("Turkey")
#> Getting data for Turkey
#> Source: local data frame [16 x 6]
#> 
#>                                                                             id
#> 1        http://146.148.79.138/sets/Turkey?=&proj=34-catalhoyuk-zooarchaeology
#> 2                       http://146.148.79.138/sets/Turkey?=&proj=22-kenan-tepe
#> 3          http://146.148.79.138/sets/Turkey?=&proj=36-ilipinar-zooarchaeology
#> 4             http://146.148.79.138/sets/Turkey?=&proj=1-domuztepe-excavations
#> 5  http://146.148.79.138/sets/Turkey?=&proj=35-catalhoyuk-area-tp-zooarchaeolo
#> 6  http://146.148.79.138/sets/Turkey?=&proj=37-zooarchaeology-of-neolithic-ulu
#> 7  http://146.148.79.138/sets/Turkey?=&proj=33-erbaba-hoyuk-and-suberde-zooarc
#> 8         http://146.148.79.138/sets/Turkey?=&proj=11-aegean-archaeomalacology
#> 9           http://146.148.79.138/sets/Turkey?=&proj=32-kosk-hoyuk-faunal-data
#> 10  http://146.148.79.138/sets/Turkey?=&proj=27-zooarchaeology-of-okuzini-cave
#> 11 http://146.148.79.138/sets/Turkey?=&proj=26-zooarchaeology-of-karain-cave-b
#> 12     http://146.148.79.138/sets/Turkey?=&proj=31-barcin-hoyuk-zooarchaeology
#> 13      http://146.148.79.138/sets/Turkey?=&proj=2-pinarbasi-1994-animal-bones
#> 14   http://146.148.79.138/sets/Turkey?=&proj=30-cukurici-hoyuk-zooarchaeology
#> 15                   http://146.148.79.138/sets/Turkey?=&proj=21-rough-cilicia
#> 16 http://146.148.79.138/sets/Turkey?=&proj=39-ceramics-trade-provenience-and-
#> Variables not shown: json (chr), rdfs:isDefinedBy (chr), label (chr),
#>   count (int), slug (chr)
```

To browse the locations that have archaeological data in Turkey, run `locations$label`

Browse projects
---------------

To inspect the projects available for a location in a country, for example Ulucak in Turkey:

``` r
oc_get_locations("Turkey", "Ulucak")
#> Getting data for Turkey
#> Getting data for Ulucak
#> Source: local data frame [2 x 6]
#> 
#>                                                                            id
#> 1 http://146.148.79.138/sets/Turkey/Ulucak?=&proj=37-zooarchaeology-of-neolit
#> 2 http://146.148.79.138/sets/Turkey/Ulucak?=&proj=11-aegean-archaeomalacology
#> Variables not shown: json (chr), rdfs:isDefinedBy (chr), label (chr),
#>   count (int), slug (chr)
```

------------------------------------------------------------------------

[![ropensci\_footer](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
