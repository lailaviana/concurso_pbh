library(dplyr)
library(xml2)
library(rvest)
library(readr)
library(knitr)
library(lubridate)

url <- "https://prefeitura.pbh.gov.br/saude/oportunidades-de-trabalho/concurso-publico-01-2020"

r_pbh <- url |> 
  xml2::read_html() |> 
  rvest::html_nodes(xpath="//*[@class='main-content-inner']") |> 
  rvest::html_table()

r_pbh_final <- r_pbh[[1]] |> dplyr::select(1,4)
r_pbh_final |> dplyr::mutate(Data = lubridate::dmy(Data)) |> dplyr::arrange(desc(Data)) |>  readr::write_csv("pbh_table.csv")
