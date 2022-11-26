rotating_text <- function(x, align = "center") {
  glue::glue('
<div style="overflow: hidden; height: 1.2em;">
<ul class="content__container__list {align}" style="text-align: {align}">
<li class="content__container__list__item">{x[1]}</li>
<li class="content__container__list__item">{x[2]}</li>
<li class="content__container__list__item">{x[3]}</li>
<li class="content__container__list__item">{x[4]}</li>
</ul>
</div>')
}

fa_list <- function(x, incremental = FALSE) {
  icons <- names(x)
  fragment <- ifelse(incremental, "fragment", "")
  items <- glue::glue('<li class="{fragment}"><span class="fa-li"><i class="{icons}"></i></span> {x}</li>')
  paste('<ul class="fa-ul">',
        paste(items, collapse = "\n"),
        "</ul>", sep = "\n")
}

knitr::opts_chunk$set(fig.align = "center")
