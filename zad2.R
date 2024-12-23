# Вторая задача
# Строить картосхему обилия (шт) деревьев родов Рябина и Тополь
# с высотой более 4 и 10 метров, соответственно.

# род Рябина

library(dplyr)
library(tidyr)
library(sf)
library(readr)
library(ggplot2)
greendb = read_csv("greendb.csv")
spec = greendb$species_ru
genus = stringr::str_split(spec, pattern = " ", simplify = T)[,1]

data  = greendb %>% mutate(Genus = genus)
data = data %>% group_by(Genus, adm_region) %>%
  filter(Genus=="Рябина" & height_m>4)%>%
  summarise(min_height = min(height_m, na.rm = T)) 

map = sf::read_sf("moscow.geojson")

map = map %>% mutate(adm_region = NAME)
data= pivot_wider(data, names_from =Genus, values_from = min_height)
names(data)=c("adm_region","RYABINA")
map = left_join(map, data, by="adm_region")

ggplot(map)+geom_sf(aes(fill=RYABINA))+ theme()

# род Тополь

greendb = read_csv("greendb.csv")
spec = greendb$species_ru
genus = stringr::str_split(spec, pattern = " ", simplify = T)[,1]

data  = greendb %>% mutate(Genus = genus)
data = data %>% group_by(Genus, adm_region) %>%
  filter(Genus=="Тополь" & height_m>10)%>%
  summarise(min_height = min(height_m, na.rm = T)) 

map = sf::read_sf("moscow.geojson")

map = map %>% mutate(adm_region = NAME)
data= pivot_wider(data, names_from =Genus, values_from = min_height)
names(data)=c("adm_region","TOPOL")
map = left_join(map, data, by="adm_region")

ggplot(map)+geom_sf(aes(fill=TOPOL))+ theme()



