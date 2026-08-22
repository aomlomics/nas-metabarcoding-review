#NAS/AIS eDNA metabarcoding paper
#Code for graphical abstract derived from Table 4 Best Practices

# load packages
library(ggplot2)
library(grid)
library(cowplot)

# define schematic of categories that are read from left to right
categories <- data.frame(
  label = c("Study design", "Bioinformatics", "Interpretation", "Sharing"),
  x_center = c(2, 5, 8, 11),  # Column centers spaced evenly by 3 units
  y_center = rep(4, 4),       # Locked on the same horizontal baseline row
  fill = c("#1D9E75", "#378ADD", "#7F77DD", "#D85A30"),
  text_col = c("#085041", "#0C447C", "#3C3489", "#712B13")
)

guidelines <- data.frame(
  label = c(
    "1. Assess\ncontamination risks", 
    "2. Sequence and\nevaluate negative\ncontrols", 
    "3. Use exact sequence\napproaches (ASVs)", 
    "4. Tailor read\ndetection thresholds", 
    "5. Evaluate\ndetections in context", 
    "6. Consider impact of\nmethodological\nlimitations", 
    "7. Include sequences\nof species reported", 
    "8. Archive raw\nsequencing data\nwith metadata"
  ),
  # synced to match the categories in 4 columns but stacked vertically
  x = c(2, 2, 5, 5, 8, 8, 11, 11),
  y_center = c(4.6, 2.4, 4.6, 2.4, 4.6, 2.4, 4.6, 2.4), # top and bottom row guidelines
  fill = c(
    "#9FE1CB", "#9FE1CB", "#B5D4F4", "#B5D4F4", 
    "#CECBF6", "#CECBF6", "#F5C4B3", "#F5C4B3"
  ),
  text_col = c(
    "#085041", "#085041", "#0C447C", "#0C447C", 
    "#3C3489", "#3C3489", "#712B13", "#712B13"
  )
)

# Geometry Tuning Matrix
phase_w  <- 1.35  # half width of large column background card (Total width = 2.7)
phase_h  <- 3.0   # half height of large column background card
box_w    <- 1.15  # half width of inner text bubble guidelines
box_h    <- 0.85  # half height of inner text bubble guidelines

# plot horizontal graphical_abstract
graphical_abstract <- ggplot() +
  
  # tall blocks for each category
  geom_rect(
    data = categories, 
    aes(xmin = x_center - phase_w, xmax = x_center + phase_w, 
        ymin = y_center - phase_h, ymax = y_center + phase_h, fill = fill), 
    color = NA, alpha = 0.15
  ) +
  
  # category title headers (top of each column block)
  geom_text(
    data = categories, 
    aes(x = x_center, y = y_center + phase_h - 0.4, label = label, color = text_col), 
    fontface = "bold", size = 3.6, hjust = 0.5, vjust = 1, lineheight = 0.9
  ) +
  
  # guidelines in inner boxes (stacked vertically)
  geom_rect(
    data = guidelines, 
    aes(xmin = x - box_w, xmax = x + box_w, ymin = y_center - box_h, ymax = y_center + box_h, fill = fill), 
    color = "white", linewidth = 0.8
  ) +
  
  # text labels inside guideline boxes
  geom_text(
    data = guidelines, 
    aes(x = x, y = y_center, label = label, color = text_col), 
    size = 2.3, hjust = 0.5, vjust = 0.5, fontface = "bold", lineheight = 1.0
  ) +
  
  # arrows running left to right between columns
  annotate("segment", 
           x = c(3.38, 6.38, 9.38), xend = c(3.62, 6.62, 9.62), 
           y = 4.0, yend = 4.0, 
           arrow = arrow(length = unit(0.22, "cm"), type = "closed"), 
           color = "grey40", linewidth = 1.4
  ) +
  
  # centralized footer note
  annotate("text", 
           x = 6.5, y = 0.4, 
           label = "Implement as many as possible", 
           size = 3.0, color = "grey40", hjust = 0.5, fontface = "italic"
  ) +
  
  # centralized title at top
  annotate("text", 
           x = 6.5, y = 7.7, 
           label = "Recommended practices for reporting NAS detected using eDNA metabarcoding", 
           size = 3.8, color = "grey20", hjust = 0.5, fontface = "bold"
  ) +
  
  # formatting settings and dimensions grid boundaries
  scale_fill_identity() +
  scale_color_identity() +
  coord_cartesian(xlim = c(0.2, 12.8), ylim = c(0.0, 8.2)) +
  theme_void()

# output
ggdraw(graphical_abstract)

#save
save_plot("eDNA_mb_NAS_graphical_abstract.jpg", 
          graphical_abstract, 
          base_width = 7,
          base_height = 4,
          dpi=300)
