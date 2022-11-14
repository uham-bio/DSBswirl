
<!-- README.md is generated from README.Rmd. Please edit that file -->

# DSBswirl

<!-- [![R-CMD-check](https://github.com/saskiaotto/UHHformats/actions/workflows/check-standard.yaml/badge.svg)](https://github.com/saskiaotto/UHHformats/actions/workflows/check-standard.yaml) -->

This R package provides the swirl courses including an installation
function developed for the DSB (Data Science in Biology) program within
the biology department of the University of Hamburg (UHH).

The following swirl courses (in German) are currently included:

-   DSB-01: Basics in R (R Grundlagen)
-   DSB-02: Data exploration with R (Datenexploration mit R)
-   DSB-03: Data warangling and introduction to tidyverse
    (Datenaufbereitung oder per Anleitung durchs Tidyversum)
-   DSB-04: Data visualization with ggplot2 (Datenvisualisierung mit
    ggplot2)
-   DSB-05: Handling of special data types (Handling spezieller
    Datentypen)

## Package installation

``` r
if (!require("remotes")) install.packages("remotes")
remotes::install_github("uham-bio/DSBswirl")
```

## Course installations

``` r
# Install all courses (default)
DSBswirl::install_dsb_courses()
# Install only course DSB-01 (R basics)
DSBswirl::install_dsb_courses(courses = "DSB-01")
# Install the course DSB-01, DSB-04, and DSB-05
DSBswirl::install_dsb_courses(courses = c("DSB-01", "DSB-04", "DSB-05"))
```
