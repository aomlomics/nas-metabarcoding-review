#show platform and number of papers by year for NAS detection using eDNA metabarcoding

library(ggplot2)
library(dplyr)
library(tidyr)
library(cowplot)

#results of the search: aquatic AND "eDNA metabarcoding" plus NAS/NAS terms
#2 papers used 3 platforms, 1 paper used 2 platforms; all the rest used 1 platform
#total 192 papers (and 197 records if counting papers using multiple platforms more than once)
NAS_eDNA_HTS_platforms <- read.csv("Fig_2_NAS_eDNA_HTS_platforms.csv")

NAS_platform_summary <- NAS_eDNA_HTS_platforms %>%
  group_by(year, platform) %>%
  summarise(count = n(), .groups = "drop")

NAS_platform_summary$platform <- factor(NAS_platform_summary$platform, levels = c(
  # Illumina platforms first
  "Illumina iSeq (SBS)",
  "Illumina MiSeq (SBS)",
  "Illumina NextSeq (SBS)",
  "Illumina HiSeq (SBS or SBS + ExAmp)",
  "Illumina NovaSeq (SBS + ExAmp or XLEAP-SBS)",
  "Illumina, unspecified",
  "BGI/MGI (DNBSEQ)",
  "ONT (nanopore)",
  "Ion Torrent (semiconductor)",
  "Roche 454 (pyrosequencing)",
  "Multiple platforms"))

#results of the search: aquatic AND "eDNA metabarcoding" without NAS/NAS terms
paper_count_year <- read.csv("Fig_2_total_aquatic_eDNA_year.csv")

cols <- c("#9ecae1", #iseq
          "#1f78b4", #miseq
          "navy", #nextseq
          "blue", #hiseq
          "turquoise2", #novaseq
          "#bdbdbd", #Illumina unspecified
          "#e41a1c", #bgi/mgi
          "#66a61e", #ont
          "#ffcc00", #ion
          "#d95f02", #roche
          "#333333") #multiple

#plot1 
ggplot(NAS_platform_summary) +
  geom_bar(aes(x = factor(year), y = count, fill = platform), 
           position = "stack", stat = "identity") +
  theme_bw()+
  xlab("Year published")+
  ylab("Number of papers")+
  scale_fill_manual(values=cols)

#plot2
ggplot(paper_count_year, aes(x = year, y = count)) +
  geom_line(color = "lightgray", size = 1) +   # Add line with color and thickness
  geom_point(color = "darkgray", size = 3) +  # Add dots with color and size
  theme_bw()+
  scale_x_continuous(breaks = 2015:2024, 
                     labels = 2015:2024) 

#combine plots
p1 <- ggplot() +
  geom_bar(data = NAS_platform_summary, #bar chart layer
         aes(x = factor(year), y = count, fill = platform), 
         position = "stack", stat = "identity") +
  geom_line(data = paper_count_year, #line plot layer with connected points
          aes(x = factor(year), y = count / 27, group = 1),  
          color = "black", size = 1, linetype = "dashed") +  
  geom_point(data = paper_count_year, 
           aes(x = factor(year), y = count / 27), 
           color = "black", size = 3) +
  geom_label(data = paper_count_year, #add text labels to the points on the line plot
           aes(x = factor(year), y = count / 27, label = count), 
           vjust = -0.2,  #move text slightly upward
           hjust = 1.2,  #move text to the left
           color = "black", 
           size = 4,
           fill = "white",  #white box behind text
           label.size = 0.25) +  #border around text box
  theme_bw() + #labels, themes, and scales
  xlab("Year published") +
  ylab("Papers reporting NAS/NAS") +  #Y-axis for bar chart values
  scale_fill_manual(values = cols) +  #cstom fill colors for bar chart
  scale_x_discrete(breaks = 2015:2024, labels = 2015:2024) +
  scale_y_continuous(name = "Number of eDNA metabarcoding studies reporting NAS/NAS",
                     breaks = seq(10, 60, by = 10), 
                     labels = seq(10, 60, by = 10),
                     sec.axis = sec_axis(transform = ~ . * 26, 
                                         name = "Total number of aquatic eDNA metabarcoding papers")) +
  theme(axis.title.y = element_text(color = "black", size = 14),
      axis.text.y = element_text(color = "black", size = 12),
      axis.title.x = element_text(color = "black", size = 14),
      axis.text.x = element_text(color = "black", size = 12),
      legend.title = element_blank(),
      legend.position = c(0.05, 0.95), 
      legend.justification = c(0,1),
      legend.background = element_rect(fill = "white", color = "black", linewidth = 0.25),
      legend.box.background = element_rect(color = "black", linewidth = 0.25))

p1

save_plot("Figure_2_platform_summary_plot.png", 
          p1,
          base_width = 9,
          base_height = 8,
          dpi=300)
                