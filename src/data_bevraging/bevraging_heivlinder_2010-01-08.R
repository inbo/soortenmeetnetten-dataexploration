library(tidyverse)
library(sf)

versie <- "versie2020-01-08"

bezoeken <- read.csv2(paste("../data/", versie, "/bezoeken.csv", sep = ""), stringsAsFactors = FALSE)
status_bezoek <- bezoeken %>%
  select(visit_id, bezoek_status) %>%
  unique()

aantallen <- read.csv2(paste("../data/", versie, "/aantallen.csv", sep = ""), stringsAsFactors = FALSE)
aantallen <- aantallen %>%
  mutate(datum = as.Date(start_date, format = "%Y-%m-%d"),
         jaar = as.numeric(format(datum, "%Y")))

locaties <- st_read(paste("../data/", versie, "/meetnetten_locaties.gpkg", sep = ""),
                    "locaties", quiet = TRUE)

heivlinder_aantallen <- aantallen %>%
  left_join(status_bezoek, by = "visit_id") %>%
  filter(meetnet == "Heivlinder") %>%
  select(meetnet, protocol, locatie, sublocatie, visit_id, datum, bezoek_status, aantal)

getwd()
write.csv2(Heivlinder, ".Output/heivlinder_aantallen_sectie.csv", row.names = FALSE)

heivlinder_aantallen_bezoek <- Heivlinder %>%
  group_by(meetnet, protocol, locatie, visit_id, datum, bezoek_status) %>%
  summarise(aantal_transect = sum(aantal, na.rm = TRUE))

write.csv2(heivlinder_aantallen_bezoek, "Output/Heivlinder_aantallen_transect.csv", row.names = FALSE)
