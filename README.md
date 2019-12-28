# RStudio Solutions

Learn more about using RStudio with your production systems

This is the source code for [solutions.rstudio.com](http://solutions.rstudio.com/).

# Building the site using blogdown

To preview the site/post use:

```r
blogdown::serve_site()
```

Important: you must use Hugo version 0.24, since later versions of Hugo broke the theme.

```r
blogdown::install_hugo(version = "0.24")
```

Notes on reverting off of a newer version of Hugo:

- If you have a newer version of Hugo installed, you may need to provide these additional arguments to install the earlier version: `blogdown::install_hugo(version = "0.24", force = TRUE, use_brew = FALSE)`
- Restart R
- Verify that you have the correct version before proceeding: `blogdown::hugo_version()`
