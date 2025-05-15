library(dplyr)
library(ggplot2)
library(rnaturalearth)
library(rnaturalearthdata)
library(sf)
library(cowplot)

#data for map
continent_data <- read.csv("AIS_continent_map.csv")

#group by habitat type and continent
summary_data <- continent_data %>%
  group_by(continent, habitat) %>%
  summarise(count = n(), .groups = "drop")

#positions for bar placement over each continent
continent_coords <- data.frame(
  continent = c("Europe", "Asia", "North America", "South America", "Africa", "Oceania"),
  center_x = c(15, 110, -100, -60, 20, 155),      
  center_y = c(35, 20, 40, -20, 0, -30))          

#bar dimensions
habitat_spacing <- 10 
bar_width <- 10

bars <- summary_data %>%
  left_join(continent_coords, by = "continent") %>%
  mutate(
    offset = ifelse(habitat == "freshwater", -habitat_spacing/2, habitat_spacing/2),
    xmin = center_x + offset - bar_width / 2,
    xmax = center_x + offset + bar_width / 2,
    ymin = center_y,
    ymax = center_y + count,
    label_x = (center_x + offset),
    label_y = ymax + 1)
  

#plot map
world <- ne_countries(scale = "medium", returnclass = "sf")

map_plot <- ggplot() +
  geom_sf(data = world, fill = "gray95", color = "gray80") +
  geom_rect(data = bars,
            aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax, fill = habitat),
            color = "black") +
  geom_text(data = bars,
            aes(x = label_x, 
                y = label_y, label = count),
            size = 5, 
            vjust = 0,
            fontface = "bold") +
  scale_fill_manual(values = c("marine" = "blue3", "freshwater" = "aquamarine3")) +
  coord_sf(expand = FALSE) +
  theme_minimal() +
  theme(legend.position = "bottom",
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        legend.text = element_text(face = "bold", size = 14),
        legend.title = element_blank())

#save using cowplot
save_plot("Figure_1_AIS_studies_map.png", 
          map_plot, 
          base_width = 10, 
          base_height = 6, 
          bg = "white",
          dpi = 300)
