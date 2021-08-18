# Primera sesión ACT: Scrapping básico ----

# Autor: MT
# Fecha:
# Título: 

if(!require(pacman)) install.packages("pacman")

pacman::p_load(tidyverse,
               tidytext,
               scrap,
               here)



url <- "https://www.barragan-foundation.org/works/list"
url_map <- "https://www.barragan-foundation.org/works/map"

yr <- read_html(url) %>% 
  html_nodes(".work-year") %>% 
  html_text()

titulo <- read_html(url) %>% 
  html_nodes(".work-title") %>% 
  html_text()

categoria <- read_html(url) %>% 
  html_nodes(".category") %>% 
  html_text()

colaboracion <- read_html(url) %>% 
  html_nodes(".meta-collab") %>% 
  html_text()

locacion <- read_html(url) %>% 
  html_nodes(".short-location") %>% 
  html_text()



lat <- read_html(url_map) %>% 
  html_nodes("section")%>% 
  html_attr("data-lat")

long <- read_html(url_map) %>% 
  html_nodes("section")%>% 
  html_attr("data-lon")

dir <- read_html(url_map) %>% 
  html_nodes("section")%>% 
  html_attr("data-addr")



barragan <- tibble(
  year = yr %>% str_squish(),
  titulo, 
  categoria = categoria %>% str_squish(),
  colaboracion=colaboracion %>% str_squish(),
  locacion=locacion %>% str_squish(),
  latitud = lat,
  longitud = long,
  direccion = dir
)

glimpse(barragan)