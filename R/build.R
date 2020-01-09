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
})

source_dat <- "../pro_admin_training/pres/curriculum-2.csv"
if (file.exists(source_dat)) {
  local({
    z <- file.copy(source_dat, "curriculum-2.csv", overwrite = TRUE)
  })
}

dat <- read_csv("curriculum-2.csv", col_types = cols()) %>%
  filter(!is.na(rmd_filename)) %>%
  mutate(
    weight = 10 * seq_len(n()),
    id = tolower(gsub(" ", "_", Topic)),
    rmd_url = gsub(".Rmd$", ".html", rmd_filename),
    Product = tolower(Product),
    hugo_chapter = paste(match(hugo_chapter, unique(hugo_chapter)) - 1, hugo_chapter, sep = "-") %>% 
      tolower() %>% gsub(" ", "-", .),
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
  switch(
    dat$Type[i], 
    rmarkdown = {
      # out_file <- sprintf("auto_%03d_rmd.md", dat$weight[i])
      template <- template_r
    },
    xaringan = {
      # out_file <- sprintf("auto_%03d_x.md", dat$weight[i])
      template <- template_x
      
    },
    learnr = {
      # out_file <- sprintf("auto_%03d_ex.md", dat$weight[i])
      template <- template_l
    }
  )
  new <- glue_data(dat[i, ], template, .open = "<<", .close = ">>")
  dir <- glue_data(dat[i, ], "content/{hugo_chapter}")
  if (!dir.exists(dir)) dir.create(dir)
  writeLines(new, sprintf("content/%s/%s", dat$hugo_chapter[i],  out_file))
  
  # if (!is.na(dat$ex_vanity_url[i])) {
  #   new <- glue_data(dat[i, ], ext, .open = "<<", .close = ">>")
  #   dir <- glue_data(dat[i, ], "content/{hugo_chapter}")
  #   writeLines(new, sprintf("content/%s/auto_%03d_ex.md", dat$hugo_chapter[i],  dat$weight[i]))
  #   
  # }
  
}
