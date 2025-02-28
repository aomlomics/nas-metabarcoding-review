
#Keyword Co-occurrence (Network) Analysis

library(tidyverse)
library(tidygraph)
library(ggraph)
library(igraph)
library(ggplot2)
library(cowplot)

setwd("/Users/aholmes/Desktop/github/ais-metabarcoding-review")

keywords_by_paper <- read.csv("keywords_normalized.csv", stringsAsFactors = FALSE)

colnames(keywords_by_paper) <- c("ID", "DE")  # "ID" for document identifier, "DE" for keywords

#keywords into long format
keyword_edges <- keywords_by_paper %>%
  separate_rows(DE, sep = ",") %>%
  mutate(DE = trimws(DE)) %>%
  distinct()

keyword_long <- keywords_by_paper %>%
  separate_rows(DE, sep = ",") %>%
  mutate(DE = trimws(DE)) %>%
  distinct()

# Create edges by linking papers with shared keywords
edges <- keyword_long %>%
  inner_join(keyword_long, by = "ID") %>%
  filter(DE.x != DE.y) %>%
  count(DE.x, DE.y, sort = TRUE) %>%
  rename(from = DE.x, to = DE.y, weight = n)

#calculate keyword frequency
keyword_counts <- keyword_long %>%
  count(DE, name = "freq")

#identify top 20 keywords by occurrence
top_keywords <- keyword_long %>%
  count(DE, sort = TRUE) %>%
  top_n(20, n) %>%
  pull(DE)

graph <- as_tbl_graph(edges)
#filter edges to only include top keywords
filtered_graph <- graph %>%
  filter(name %in% top_keywords)

filtered_graph <- filtered_graph %>%
  activate(nodes) %>%
  left_join(keyword_counts, by = c("name" = "DE")) %>%
  mutate(freq = replace_na(freq, 1)) 

#plot network
network_plot <-ggraph(filtered_graph, layout = "stress") +
  geom_edge_link(aes(edge_alpha = weight), show.legend = FALSE) +
  geom_node_point(aes(size = freq), color = "dodgerblue") +  # Scale size by frequency
  geom_node_text(aes(label = name), repel = TRUE, size = 5) +
  scale_size(range = c(2, 10), breaks = c(10, 50, 100)) +  #adjust node size range
  theme_void()+
  theme(panel.background = element_rect(fill = "white", color = NA)) #set white background

network_plot <- network_plot + 
  theme(
    plot.margin = margin(10, 50, 10, 10),
    panel.background = element_rect(fill = "white", color = NA),  # Make plot background white
    plot.background = element_rect(fill = "white", color = NA),  # Ensure no gray framing
    legend.background = element_rect(fill = "white", color = NA),  # White legend background
    legend.key = element_rect(fill = "white")  # White background behind legend keys
  )

save_plot("keyword_network_plot.png", network_plot, base_height = 6, base_width = 8, dpi = 300)
