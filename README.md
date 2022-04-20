# epitutorials

<!-- badges: start -->
<!-- badges: end -->

This package hosts the code for the Applied Epi's public-facing R tutorials.  

## How to use this package


1. Clone this repository locally
2. To install the package from Rstudio go to the Build pane, and click _Install and Restart_
3. To run tutorials *AND TEST ANY CHANGES* perform a new install, and then run your tutorial via the following:

``` r
learnr::run_tutorial("...", "epitutorial")
```

4. Create a new tutorial folder via the following:

``` r
usethis::use_tutorial("lesson1", "Your First Lesson", open = interactive())
```

## Structure

The structure of this repo requires developers to package each tutorial in a separate folder within `inst/tutorials`.
We also have a shared "dat" folder which can be accessed by all tutorials.  

* Do **not** use `here()` commands. Instead use `rio::import()` on `system.file()`. See the code near the top of one of the existing tutorials for an example.

For example:  

``` r
linelist_raw <- rio::import(system.file("data/linelist_raw.xlsx", package = "epitutorials"))
```

* Load packages with `library()` only, and list them all at the top.  
* If you add a package, add it to the DESCRIPTION file as well, then run `devtools::document()`  
* Delete all HTML renders from the tutorial folders before pushing  
* EACH tutorial needs its own "images" folder  



## Adding tutorials

Place your tutorial and associated documents under the new tutorials folder you have added. Note that you should not attach HTML files, or any large files not require to *COMPILE* the RMD. Also note that data is shared between tutorials for the sake of reducing package size


Data can be read using the following code:

``` r
linelist_raw <- rio::import(system.file("data/linelist_raw.xlsx", package = "epitutorial"))
```

For the rest of files included refer to file paths as if the learnr tutorial is in the working directory. Do *NOT* use `here` so as not to generate multiple `.here` files across the directory.


LICENSE:  

These tutorial are produced by Applied Epi Incorporated and their code may not be repurposed or copied with out explicit permission.  


