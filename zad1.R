
# Первая задача

# Басманного района-докажите что диаметр стволов родов Рябина и Тополь пирамидальная
# значимо отличаются

library(readr)
library(dplyr)

greendb = read.csv("greendb.csv")
spec = greendb$species_ru
genus = stringr::str_split(spec, pattern = " ", simplify = T)[,1]

data  = greendb %>% mutate(Genus = genus) 
data = data %>% filter(Genus %>% c("Рябина","Тополь")) %>%
                filter(adm_region=="район Басманный")
greendb$Genus %>% unique()
greendb$adm_region %>% unique()

data.aov <- aov(d_trunk_m ~ Genus, data = data)

summary(data.aov)
TukeyHSD(data.aov)

