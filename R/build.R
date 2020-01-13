# if (blogdown::hugo_version() != "0.24") warning("You must use hugo version 0.24\n\n")
#

suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
  library(glue)
})

# Copy content_template directory

local({
  z <- file.copy(
    list.files("content_template", include.dirs = TRUE, recursive = FALSE, full.names = TRUE),
    "content", 
    recursive = TRUE,
    overwrite = TRUE
  )
  
  rmds <- list.files("content_template", pattern = ".Rmd$", include.dirs = TRUE, recursive = TRUE, full.names = TRUE)
  
  
  rmds %>%
    gsub("^content_template/", "content/", .) %>%
    gsub(".Rmd$", ".html", .) %>%
    file.remove()
  
  rmds %>% 
    gsub("^content_template/", "content/", .) %>% 
    Sys.setFileTime(Sys.time())

})

source_dat <- "../pro_admin_training/pres/curriculum.csv"
if (file.exists(source_dat)) {
  local({
    z <- file.copy(source_dat, "static/curriculum.csv", overwrite = TRUE)
  })
}

# local({
#   z <- file.copy("curriculum.csv", "content/curriculum.csv", overwrite = TRUE)
# })

dat <- read_csv("static/curriculum.csv", col_types = cols()) %>%
  filter(
    !is.na(rmd_filename),
    Session > 0
    ) %>%
  mutate(
    weight = 10 * seq_len(n()),
    id = tolower(gsub(" ", "_", Topic)),
    rmd_url = gsub(".Rmd$", ".html", rmd_filename),
    Product = tolower(Product),
    ## match(hugo_chapter, unique(hugo_chapter)) - 1,
    hugo_chapter = hugo_chapter %>% tolower() %>% gsub(" ", "-", .),
    hugo_session = if_else(
      !is.na(Subsession), 
      paste(Session, Subsession, sep = "."), 
      paste0(Session, ".")
    )
  )

# View(dat)

template_r <- readLines("R/template-rmarkdown.md") %>% paste(collapse = "\n")
template_x <- readLines("R/template-xaringan.md") %>% paste(collapse = "\n")
template_l <- readLines("R/template-learnr.md") %>% paste(collapse = "\n")

i <- 1

for (i in seq_len(nrow(dat))) {
  out_file <- paste0(basename(dat$vanity_url[i]), ".md")
  template <- switch(
    dat$Type[i], 
    rmarkdown = template_r,
    xaringan  = template_x,
    learnr    = template_l
  )
  new <- glue_data(dat[i, ], template, .open = "{{", .close = "}}")
  dir <- glue_data(dat[i, ], "content/{hugo_chapter}")
  if (!dir.exists(dir)) dir.create(dir)
  writeLines(new, sprintf("content/%s/%s", dat$hugo_chapter[i],  out_file))
  
  
}
