library(knitr)
library(kableExtra)
library(dplyr)
library(tidyr)

dd <- read.table("content/semana/cronograma.csv", header = TRUE,
                 sep = ";", check.names = FALSE)
str(dd)

dd |>
    dplyr::select(Hora, Atividade) |>
    kable(col.names = NULL) |>
    kable_styling(bootstrap_options = c("striped", "bordered", "responsive")) |>
    ## kable_material(c("striped", "hover")) |>
    pack_rows("Segunda-feira (13/09)", 1, 3, color = "3f3f3f", background = "lightgrey") |>
    pack_rows("Terça-feira (14/09)", 4, 4, color = "3f3f3f", background = "lightgrey") |>
    pack_rows("Quarta-feira (15/09)", 5, 7, color = "3f3f3f", background = "lightgrey") |>
    pack_rows("Quinta-feira (16/09)", 8, 10, color = "3f3f3f", background = "lightgrey") |>
    pack_rows("Sexta-feira (17/09)", 11, 13, color = "3f3f3f", background = "lightgrey") |>
    column_spec(1:2, color = "3f3f3f") |>
    save_kable("content/semana/crono.html")
