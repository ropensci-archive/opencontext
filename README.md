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
#>                                                                        id
#> 1                              http://146.148.79.138/sets/United+States?=
#> 2                                     http://146.148.79.138/sets/Turkey?=
#> 3                                     http://146.148.79.138/sets/Jordan?=
#> 4                                      http://146.148.79.138/sets/Italy?=
#> 5                                       http://146.148.79.138/sets/Iran?=
#> 6                                    http://146.148.79.138/sets/Germany?=
#> 7                                     http://146.148.79.138/sets/Cyprus?=
#> 8                                     http://146.148.79.138/sets/Israel?=
#> 9                             http://146.148.79.138/sets/United+Kingdom?=
#> 10                     http://146.148.79.138/sets/Palestinian+Authority?=
#> 11                                      http://146.148.79.138/sets/Iraq?=
#> 12                               http://146.148.79.138/sets/Philippines?=
#> 13                                     http://146.148.79.138/sets/India?=
#> 14                                     http://146.148.79.138/sets/Egypt?=
#> 15                  http://146.148.79.138/sets/Northern+Mariana+Islands?=
#> 16                                  http://146.148.79.138/sets/Malaysia?=
#>                                                                           json
#> 1                              http://146.148.79.138/sets/United+States.json?=
#> 2                                     http://146.148.79.138/sets/Turkey.json?=
#> 3                                     http://146.148.79.138/sets/Jordan.json?=
#> 4                                      http://146.148.79.138/sets/Italy.json?=
#> 5                                       http://146.148.79.138/sets/Iran.json?=
#> 6                                    http://146.148.79.138/sets/Germany.json?=
#> 7                                     http://146.148.79.138/sets/Cyprus.json?=
#> 8                                     http://146.148.79.138/sets/Israel.json?=
#> 9                             http://146.148.79.138/sets/United+Kingdom.json?=
#> 10                     http://146.148.79.138/sets/Palestinian+Authority.json?=
#> 11                                      http://146.148.79.138/sets/Iraq.json?=
#> 12                               http://146.148.79.138/sets/Philippines.json?=
#> 13                                     http://146.148.79.138/sets/India.json?=
#> 14                                     http://146.148.79.138/sets/Egypt.json?=
#> 15                  http://146.148.79.138/sets/Northern+Mariana+Islands.json?=
#> 16                                  http://146.148.79.138/sets/Malaysia.json?=
#>                                                        rdfs:isDefinedBy
#> 1  http://opencontext.org/subjects/2A1B75E6-8C79-49B9-873A-A2E006669691
#> 2                      http://opencontext.org/subjects/1_Global_Spatial
#> 3  http://opencontext.org/subjects/D9AE02E5-C3F3-41D0-EB3A-39798F63GGGG
#> 4  http://opencontext.org/subjects/B66A08F2-5D96-4DD4-1AB1-32880C9A8D9D
#> 5   http://opencontext.org/subjects/9FC763F1-F606-B389-6CC285B7BCFE26A8
#> 6                      http://opencontext.org/subjects/2_Global_Germany
#> 7  http://opencontext.org/subjects/67D9F00D-14E6-4A1B-3A61-EC92FC774098
#> 8                       http://opencontext.org/subjects/3_Global_Israel
#> 9  http://opencontext.org/subjects/4A7C4A4A-FC66-411A-CDF4-870D153375F3
#> 10                   http://opencontext.org/subjects/4_global_Palestine
#> 11                    http://opencontext.org/subjects/GHF1SPA0000077840
#> 12 http://opencontext.org/subjects/A659B68E-EC36-4477-0C79-D48B370118FC
#> 13                       http://opencontext.org/subjects/6_global_India
#> 14 http://opencontext.org/subjects/A2257E54-3B4F-4DA5-0E50-A428ECEB47A2
#> 15 http://opencontext.org/subjects/32B3883A-B007-405D-C4E0-ED129C587DFA
#> 16 http://opencontext.org/subjects/251C032B-684D-445E-156B-5710AA407B11
#>                       label  count                     slug
#> 1             United States 376919          united-states-1
#> 2                    Turkey 350009                   turkey
#> 3                    Jordan 128702                   jordan
#> 4                     Italy  41820                    italy
#> 5                      Iran  32487                     iran
#> 6                   Germany  20389                  germany
#> 7                    Cyprus  14510                   cyprus
#> 8                    Israel  10247                   israel
#> 9            United Kingdom   2906           united-kingdom
#> 10    Palestinian Authority   1478    palestinian-authority
#> 11                     Iraq   1034                     iraq
#> 12              Philippines    870              philippines
#> 13                    India    522                    india
#> 14                    Egypt    483                    egypt
#> 15 Northern Mariana Islands    351 northern-mariana-islands
#> 16                 Malaysia    216                 malaysia
#>  [ reached getOption("max.print") -- omitted 11 rows ]
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
#>                                                                                                  id
#> 1                             http://146.148.79.138/sets/Turkey?=&proj=34-catalhoyuk-zooarchaeology
#> 2                                            http://146.148.79.138/sets/Turkey?=&proj=22-kenan-tepe
#> 3                               http://146.148.79.138/sets/Turkey?=&proj=36-ilipinar-zooarchaeology
#> 4                                  http://146.148.79.138/sets/Turkey?=&proj=1-domuztepe-excavations
#> 5                     http://146.148.79.138/sets/Turkey?=&proj=35-catalhoyuk-area-tp-zooarchaeology
#> 6                    http://146.148.79.138/sets/Turkey?=&proj=37-zooarchaeology-of-neolithic-ulucak
#> 7               http://146.148.79.138/sets/Turkey?=&proj=33-erbaba-hoyuk-and-suberde-zooarchaeology
#> 8                              http://146.148.79.138/sets/Turkey?=&proj=11-aegean-archaeomalacology
#> 9                                http://146.148.79.138/sets/Turkey?=&proj=32-kosk-hoyuk-faunal-data
#> 10                       http://146.148.79.138/sets/Turkey?=&proj=27-zooarchaeology-of-okuzini-cave
#> 11                      http://146.148.79.138/sets/Turkey?=&proj=26-zooarchaeology-of-karain-cave-b
#> 12                          http://146.148.79.138/sets/Turkey?=&proj=31-barcin-hoyuk-zooarchaeology
#> 13                           http://146.148.79.138/sets/Turkey?=&proj=2-pinarbasi-1994-animal-bones
#> 14                        http://146.148.79.138/sets/Turkey?=&proj=30-cukurici-hoyuk-zooarchaeology
#> 15                                        http://146.148.79.138/sets/Turkey?=&proj=21-rough-cilicia
#> 16 http://146.148.79.138/sets/Turkey?=&proj=39-ceramics-trade-provenience-and-geology-cyprus-in-the
#>                                                                                                     json
#> 1                             http://146.148.79.138/sets/Turkey.json?=&proj=34-catalhoyuk-zooarchaeology
#> 2                                            http://146.148.79.138/sets/Turkey.json?=&proj=22-kenan-tepe
#> 3                               http://146.148.79.138/sets/Turkey.json?=&proj=36-ilipinar-zooarchaeology
#> 4                                  http://146.148.79.138/sets/Turkey.json?=&proj=1-domuztepe-excavations
#> 5                     http://146.148.79.138/sets/Turkey.json?=&proj=35-catalhoyuk-area-tp-zooarchaeology
#> 6                    http://146.148.79.138/sets/Turkey.json?=&proj=37-zooarchaeology-of-neolithic-ulucak
#> 7               http://146.148.79.138/sets/Turkey.json?=&proj=33-erbaba-hoyuk-and-suberde-zooarchaeology
#> 8                              http://146.148.79.138/sets/Turkey.json?=&proj=11-aegean-archaeomalacology
#> 9                                http://146.148.79.138/sets/Turkey.json?=&proj=32-kosk-hoyuk-faunal-data
#> 10                       http://146.148.79.138/sets/Turkey.json?=&proj=27-zooarchaeology-of-okuzini-cave
#> 11                      http://146.148.79.138/sets/Turkey.json?=&proj=26-zooarchaeology-of-karain-cave-b
#> 12                          http://146.148.79.138/sets/Turkey.json?=&proj=31-barcin-hoyuk-zooarchaeology
#> 13                           http://146.148.79.138/sets/Turkey.json?=&proj=2-pinarbasi-1994-animal-bones
#> 14                        http://146.148.79.138/sets/Turkey.json?=&proj=30-cukurici-hoyuk-zooarchaeology
#> 15                                        http://146.148.79.138/sets/Turkey.json?=&proj=21-rough-cilicia
#> 16 http://146.148.79.138/sets/Turkey.json?=&proj=39-ceramics-trade-provenience-and-geology-cyprus-in-the
#>                                                        rdfs:isDefinedBy
#> 1  http://opencontext.org/projects/1B426F7C-99EC-4322-4069-E8DBD927CCF1
#> 2  http://opencontext.org/projects/3DE4CD9C-259E-4C14-9B03-8B10454BA66E
#> 3  http://opencontext.org/projects/D297CD29-50CA-4B2C-4A07-498ADF3AF487
#> 4                                     http://opencontext.org/projects/3
#> 5  http://opencontext.org/projects/02594C48-7497-40D7-11AE-AB942DC513B8
#> 6  http://opencontext.org/projects/99BDB878-6411-44F8-2D7B-A99384A6CA21
#> 7  http://opencontext.org/projects/CDD40C27-62ED-4966-AF3D-E781DD0D4846
#> 8  http://opencontext.org/projects/B1DAC335-4DC6-4A57-622E-75BF28BA598D
#> 9  http://opencontext.org/projects/05F5B702-2967-49B1-FEAA-9B2AA0184513
#> 10 http://opencontext.org/projects/8894EEC0-DC96-4304-1EFC-4572FD91717A
#> 11 http://opencontext.org/projects/731B0670-CE2A-414A-8EF6-9C050A1C60F5
#> 12 http://opencontext.org/projects/74749949-4FD4-4C3E-C830-5AA75703E08E
#> 13                    http://opencontext.org/projects/TESTPRJ0000000004
#> 14 http://opencontext.org/projects/BC90D462-6639-4087-8527-6BB9E528E07D
#> 15 http://opencontext.org/projects/295B5BF4-0F44-4698-80CD-7A39CB6F133D
#> 16 http://opencontext.org/projects/ABABD13C-A69F-499E-CA7F-5118F3684E4D
#>                                                                      label
#> 1                                                Çatalhöyük Zooarchaeology
#> 2                                                               Kenan Tepe
#> 3                                                  Ilıpınar Zooarchaeology
#> 4                                                    Domuztepe Excavations
#> 5                                        Çatalhöyük Area TP Zooarchaeology
#> 6                                       Zooarchaeology of Neolithic Ulucak
#> 7                                  Erbaba Höyük and Suberde Zooarchaeology
#> 8                                                 Aegean Archaeomalacology
#> 9                                                   Köşk Höyük Faunal Data
#> 10                                          Zooarchaeology of Öküzini Cave
#> 11                                         Zooarchaeology of Karain Cave B
#> 12                                             Barçın Höyük Zooarchaeology
#> 13                                            Pınarbaşı 1994: Animal Bones
#> 14                                           Çukuriçi Höyük Zooarchaeology
#> 15                                                           Rough Cilicia
#> 16 Ceramics, Trade, Provenience and Geology: Cyprus in the Late Bronze Age
#>     count                                                    slug
#> 1  127716                            34-catalhoyuk-zooarchaeology
#> 2   78404                                           22-kenan-tepe
#> 3   38211                              36-ilipinar-zooarchaeology
#> 4   29095                                 1-domuztepe-excavations
#> 5   19926                    35-catalhoyuk-area-tp-zooarchaeology
#> 6   10472                   37-zooarchaeology-of-neolithic-ulucak
#> 7    9072              33-erbaba-hoyuk-and-suberde-zooarchaeology
#> 8    8218                             11-aegean-archaeomalacology
#> 9    7942                               32-kosk-hoyuk-faunal-data
#> 10   6483                       27-zooarchaeology-of-okuzini-cave
#> 11   5155                      26-zooarchaeology-of-karain-cave-b
#> 12   3748                          31-barcin-hoyuk-zooarchaeology
#> 13   3390                           2-pinarbasi-1994-animal-bones
#> 14   1579                        30-cukurici-hoyuk-zooarchaeology
#> 15    552                                        21-rough-cilicia
#> 16     46 39-ceramics-trade-provenience-and-geology-cyprus-in-the
```

To browse the locations that have archaeological data in Turkey, run `locations$label`

Browse projects
---------------

To inspect the projects available for a location in a country, for example Ulucak in Turkey:

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
