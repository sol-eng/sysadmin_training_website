# if (blogdown::hugo_version() != "0.24") warning("You must use hugo version 0.24\n\n")
#

suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
  library(glue)
})

source_dat <- "../pro_admin_training/pres/curriculum.csv"
if (file.exists(source_dat)) {
  local({
    z <- file.copy(source_dat, "curriculum.csv", overwrite = TRUE)
  })
}

dat <- read_csv("curriculum.csv", col_types = cols()) %>%
  filter(!is.na(rmd_filename)) %>%
  mutate(
    weight = 10 * seq_len(n()),
    id = tolower(gsub(" ", "_", Topic)),
    rmd_url = gsub(".Rmd$", ".html", rmd_filename),
    Product = tolower(Product),
    hugo_chapter = paste(match(hugo_chapter, unique(hugo_chapter)), hugo_chapter, sep = "-")
  )
# dat
txt <- readLines("R/template.md") %>%
  paste(collapse = "\n")
# txt

i <- 1
# dat$hugo_chapter
for (i in seq_len(nrow(dat))) {
  new <- glue_data(dat[i, ], txt, .open = "<<", .close = ">>")
  dir <- glue_data(dat[i, ], "content/{hugo_chapter}")
  if (!dir.exists(dir)) dir.create(dir)
  writeLines(new, sprintf("content/%s/auto_%03d.md", dat$hugo_chapter[i],  dat$weight[i]))
}
