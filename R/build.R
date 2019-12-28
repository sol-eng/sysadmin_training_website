# if (blogdown::hugo_version() != "0.24") warning("You must use hugo version 0.24\n\n")
# 

suppressPackageStartupMessages({
library(dplyr)
library(readr)
library(glue)
})

source_dat <- "../pro_admin_training/pres/curriculum.csv"
if (file.exists(source_dat)) file.copy(source_dat, "curriculum.csv", overwrite = TRUE)

dat <- read_csv("curriculum.csv", col_types = cols()) %>% 
  filter(!is.na(rmd_filename)) %>% 
  mutate(
    weight = 10 * seq_len(n()),
    id = tolower(gsub(" ", "_", Topic)),
    rmd_url = gsub(".Rmd$", ".html", rmd_filename),
    Product = tolower(Product)
  )
# dat
txt <- readLines("content/template.txt") %>% 
  paste(collapse = "\n")
# txt

for (i in seq_len(nrow(dat))) {
  new <- glue_data(dat[i, ], txt, .open = "<<", .close = ">>")
  writeLines(new, sprintf("content/auto_%03d.md", dat$weight[i]))
}
