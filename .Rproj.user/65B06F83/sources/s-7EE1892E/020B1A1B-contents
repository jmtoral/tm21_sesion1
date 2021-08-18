# Primera sesión ACT: stringr y Expresiones regulares ----

# Autor: MT
# Fecha:


#Cuando se enfrentan a un problema, algunas personas piensan “Lo sé, usaré expresiones regulares.” Ahora tienen dos problemas.
# Jamie Zawinski

if(!require(pacman)) install.packages("pacman")

pacman::p_load(tidyverse,
               tidytext,
               here)


#https://regexr.com/

# Capítulo 14 R4DS https://r4ds.had.co.nz/strings.html

## Cadenas de texto de ejemplo ----------

# Probemos con estos tres textos.


txt1 <- "Vine a Comala porque me dijeron que acá vivía mi padre, 
un tal Pedro Páramo. Mi madre me lo dijo. Y yo le prometí que vendría a verlo 
en cuanto ella muriera. Le apreté sus manos en señal de que lo haría, pues ella 
estaba por morirse y yo en un plan de prometerlo todo. 'No dejes de ir a visitarlo 
—me recomendó. Se llama de este modo y de este otro. 
Estoy segura de que le dará gusto conocerte.'"

txt2 <- "Huehxolotl, huehcho huan totolin (Latintlahtolli: (Meleagris gallopavo) 
huan caxtillantlahtolli guajolote nozo pavo), occe itoca palach ompa Cuextecapan, 
ce cuextecatlahtolcopa palats. Huexolomeh ce tototl itechpahuic totolin icenyeliz. 
Ce tototl motenehua huehxolotl nozo tecuantotolin chanti ompa Ixachitlan Mictlampan, 
totolpixca ipan occequin tlacatiyan ompa centlacticpac, nouhqui occe totolin, itoca 
xiuhcozcatotolin, ce tototl chanti ompa Yucatán tlalyacatl ihuan Petén cuauhtlah. 
Tlacameh huehxolomeh tlacuah inaca ihuan itotoltehuan, inon totolin ca ica 
macehualtlacatl itechcopa achtocahuitl quemeh tlapixcayotl ipan ichan. "
  
txt3 <- "Odebrecht has admitted to paying $29 million in bribes to public officials in Peru between 2005 and 2014 in exchange for $12.5 billion in contracts."

## Comandos ---------------

str_length() 
str_c() 
str_sub() 
str_view() 
str_extract() 
str_detect() 
str_replace()



## Ejercicios ------------------

  str_view_all(txt3, "(..)", match = TRUE)

txt3 %>%
  str_extract_all("\\S*? (?=(million|billion))", simplify = TRUE) %>%
  str_trim()
