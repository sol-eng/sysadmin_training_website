# Sys admin training website

This is the website used for RStudio Team sys-admin training.

It uses:

* `blogdown` with Hugo
* The `techdocs` theme


Important:

* This site uses scripts to automatically build all the content in `/content`
* Put any content that is persistent, but not auto-generated, in `/content_template`
* Assume that all content in `/content` can be deleted at any time!
* The `/R/build.R` script copies all of `/content_template` into `/content` on every `blogdown::build_site()` or `blogdown::serve_site()`

Automatic building

* The `R\build.R` file contains the build script for automatically generating the pages.

Iframe resizing

* The exercise pages embed content via an iframe. The iframe content gets automatically resized, using the `iframe-resizer` [JS library by David J Bradshaw](https://github.com/davidjbradshaw/iframe-resizer).

* This library has two components, one to embed in the host page (this website) and the second to embed in the iframed page (the `learnr` content).

Page templates:

* `R\template-xaringan.md` for presentation pages, embedding the `xaringan` presentations
* `R\template-learnr.md` for exercise pages that embed the `learnr` docs.
* `R\template-rmarkdown.md` for pages that embed a standard `.Rmd` docs.  These pages don't call the iframe-resizer, to keep the TOC functioning (by keeping the content area to the current viewport to prevent double scroll bars).


Customized `techdocs` theme:

* `layouts/edit-page.html` is blanked out, to remove the "edit on github" link
* `layouts/head.html` adds a loop to include custom css in `static/css/*.css`
* `layout/powered.html` is blanked out, to remove the "powered by ... "

Ideas for fontawesome icons:


* Work in progress <i class="fas fa-tools"></i>, 
* Something new <i class="fas fa-star"></i>
* Optional <i class="far fa-question-circle"></i>
* Exercise <i class="fas fa-dumbbell"></i>