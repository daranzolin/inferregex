
<!-- README.md is generated from README.Rmd. Please edit that file -->

# inferregex

The goal of inferregex is to infer the regular expression (regex)–along
with other features–of a string.

## Installation

You can install `inferregex` from GitHub with:

``` r
remotes::install_github("inferregex")
```

## Example 1

``` r
library(inferregex)
s <- "abcd-9999-ab9"
infer_regex(s)$regex
#> [1] "^[a-z]{4}-\\d{4}-[a-z]{2}\\d$"
```

## Example 2

``` r
library(purrr)

(regex_df <- map_dfr(rownames(mtcars), infer_regex))
#>                 string                                         regex
#> 1            Mazda RX4                 ^[A-Z][a-z]{4}\\s[A-Z]{2}\\d$
#> 2        Mazda RX4 Wag ^[A-Z][a-z]{4}\\s[A-Z]{2}\\d\\s[A-Z][a-z]{2}$
#> 3           Datsun 710                      ^[A-Z][a-z]{5}\\s\\d{3}$
#> 4       Hornet 4 Drive         ^[A-Z][a-z]{5}\\s\\d\\s[A-Z][a-z]{4}$
#> 5    Hornet Sportabout               ^[A-Z][a-z]{5}\\s[A-Z][a-z]{9}$
#> 6              Valiant                               ^[A-Z][a-z]{6}$
#> 7           Duster 360                      ^[A-Z][a-z]{5}\\s\\d{3}$
#> 8            Merc 240D                 ^[A-Z][a-z]{3}\\s\\d{3}[A-Z]$
#> 9             Merc 230                      ^[A-Z][a-z]{3}\\s\\d{3}$
#> 10            Merc 280                      ^[A-Z][a-z]{3}\\s\\d{3}$
#> 11           Merc 280C                 ^[A-Z][a-z]{3}\\s\\d{3}[A-Z]$
#> 12          Merc 450SE              ^[A-Z][a-z]{3}\\s\\d{3}[A-Z]{2}$
#> 13          Merc 450SL              ^[A-Z][a-z]{3}\\s\\d{3}[A-Z]{2}$
#> 14         Merc 450SLC              ^[A-Z][a-z]{3}\\s\\d{3}[A-Z]{3}$
#> 15  Cadillac Fleetwood               ^[A-Z][a-z]{7}\\s[A-Z][a-z]{8}$
#> 16 Lincoln Continental              ^[A-Z][a-z]{6}\\s[A-Z][a-z]{10}$
#> 17   Chrysler Imperial               ^[A-Z][a-z]{7}\\s[A-Z][a-z]{7}$
#> 18            Fiat 128                      ^[A-Z][a-z]{3}\\s\\d{3}$
#> 19         Honda Civic               ^[A-Z][a-z]{4}\\s[A-Z][a-z]{4}$
#> 20      Toyota Corolla               ^[A-Z][a-z]{5}\\s[A-Z][a-z]{6}$
#> 21       Toyota Corona               ^[A-Z][a-z]{5}\\s[A-Z][a-z]{5}$
#> 22    Dodge Challenger               ^[A-Z][a-z]{4}\\s[A-Z][a-z]{9}$
#> 23         AMC Javelin                    ^[A-Z]{3}\\s[A-Z][a-z]{6}$
#> 24          Camaro Z28                 ^[A-Z][a-z]{5}\\s[A-Z]\\d{2}$
#> 25    Pontiac Firebird               ^[A-Z][a-z]{6}\\s[A-Z][a-z]{7}$
#> 26           Fiat X1-9                ^[A-Z][a-z]{3}\\s[A-Z]\\d-\\d$
#> 27       Porsche 914-2                  ^[A-Z][a-z]{6}\\s\\d{3}-\\d$
#> 28        Lotus Europa               ^[A-Z][a-z]{4}\\s[A-Z][a-z]{5}$
#> 29      Ford Pantera L       ^[A-Z][a-z]{3}\\s[A-Z][a-z]{6}\\s[A-Z]$
#> 30        Ferrari Dino               ^[A-Z][a-z]{6}\\s[A-Z][a-z]{3}$
#> 31       Maserati Bora               ^[A-Z][a-z]{7}\\s[A-Z][a-z]{3}$
#> 32          Volvo 142E                 ^[A-Z][a-z]{4}\\s\\d{3}[A-Z]$
#>    nchars nlower nupper ndigits nwhite
#> 1       9      4      3       1      1
#> 2      13      6      4       1      2
#> 3      10      5      1       3      1
#> 4      14      9      2       1      2
#> 5      17     14      2       0      1
#> 6       7      6      1       0      0
#> 7      10      5      1       3      1
#> 8       9      3      2       3      1
#> 9       8      3      1       3      1
#> 10      8      3      1       3      1
#> 11      9      3      2       3      1
#> 12     10      3      3       3      1
#> 13     10      3      3       3      1
#> 14     11      3      4       3      1
#> 15     18     15      2       0      1
#> 16     19     16      2       0      1
#> 17     17     14      2       0      1
#> 18      8      3      1       3      1
#> 19     11      8      2       0      1
#> 20     14     11      2       0      1
#> 21     13     10      2       0      1
#> 22     16     13      2       0      1
#> 23     11      6      4       0      1
#> 24     10      5      2       2      1
#> 25     16     13      2       0      1
#> 26      9      3      2       2      1
#> 27     13      6      1       4      1
#> 28     12      9      2       0      1
#> 29     14      9      3       0      2
#> 30     12      9      2       0      1
#> 31     13     10      2       0      1
#> 32     10      4      2       3      1
all(map2_lgl(regex_df$string, regex_df$regex, ~grepl(.y, .x)))
#> [1] TRUE
```
