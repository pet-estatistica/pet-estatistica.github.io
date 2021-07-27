library(knitr)
library(kableExtra)
library(dplyr)
library(tidyr)

dd <- read.table("content/semana/cronograma.csv", header = TRUE,
                 sep = ";", check.names = FALSE)
str(dd)

dd |>
    mutate(across(everything(), ~replace_na(.x, ""))) |>
    kable() |>
    kable_styling(bootstrap_options = c("striped", "bordered")) |>
    save_kable("content/semana/crono.html")

# column_spec(1, bold = TRUE) |>
# row_spec(c(4, 10, 18, 22), background = "lightgray")