library(knitr)
library(kableExtra)
library(dplyr)
library(tidyr)

## Cronograma

dd <- read.table("content/semana/cronograma.csv", header = TRUE,
                 sep = ";", check.names = FALSE)
str(dd)

dd |>
    dplyr::select(Hora, Atividade) |>
    kable(col.names = NULL) |>
    kable_styling(bootstrap_options = c("striped", "bordered", "responsive")) |>
    ## kable_material(c("striped", "hover")) |>
    pack_rows("Segunda-feira (13/09)", 1, 3, color = "3f3f3f", background = "lightgrey") |>
    pack_rows("Terça-feira (14/09)", 4, 5, color = "3f3f3f", background = "lightgrey") |>
    pack_rows("Quarta-feira (15/09)", 6, 8, color = "3f3f3f", background = "lightgrey") |>
    pack_rows("Quinta-feira (16/09)", 9, 11, color = "3f3f3f", background = "lightgrey") |>
    pack_rows("Sexta-feira (17/09)", 12, 14, color = "3f3f3f", background = "lightgrey") |>
    column_spec(1:2, color = "3f3f3f") |>
    save_kable("content/semana/crono.html")

## Prazos

dp <- read.table("content/semana/prazos.csv", header = TRUE,
                 sep = ";", check.names = FALSE)
str(dp)

dp |>
    kable(col.names = NULL) |>
    kable_styling(bootstrap_options = c("striped", "bordered", "responsive")) |>
    column_spec(1:2, color = "3f3f3f") |>
    save_kable("content/semana/prazos.html")

## Apresentações

db <- read.table("content/semana/apresentacoes.csv", header = TRUE,
                 sep = ",", check.names = FALSE)
str(db)

db |>
    dplyr::select(!Dia) |>
    kable() |>
    kable_styling(bootstrap_options = c("striped", "bordered", "responsive")) |>
    ## kable_material(c("striped", "hover")) |>
    pack_rows("Segunda-feira (13/09)", 1, 6, color = "3f3f3f", background = "lightgrey") |>
    pack_rows("Terça-feira (14/09)", 7, 11, color = "3f3f3f", background = "lightgrey") |>
    column_spec(1:6, color = "3f3f3f") |>
    save_kable("content/semana/apresentacoes.html")


