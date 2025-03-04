#show platform and number of papers by year for AIS detection using eDNA metabarcoding

library(ggplot2)
library(dplyr)
library(cowplot)
setwd("/Users/ann.holmes/Desktop/github/ais-metabarcoding-review")

#results of the search: aquatic AND "eDNA metabarcoding" plus AIS/NAS terms
#2 papers used 3 platforms, 1 paper used 2 platforms; all the rest used 1 platform
#total 192 papers (and 197 records if counting papers using multiple platforms more than once)
paper_count_AIS_platform_year <- read.csv("AIS_aquatic_eDNAmb_platform_count_year.csv")

#results of the search: aquatic AND "eDNA metabarcoding" without AIS/NAS terms
paper_count_year <- read.csv("total_aquatic_eDNAmb_year.csv")

cols <- c("red4", "green3", "gold1", "turquoise2", 
          "darkgreen","orange", "purple", "lightblue", "royalblue3",
          "lightgray", "navy", "red", "plum","darkolivegreen4")

#plot1 
ggplot(paper_count_AIS_platform_year) +
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
  geom_bar(data = paper_count_AIS_platform_year, #bar chart layer
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
  ylab("Papers reporting AIS/NAS") +  #Y-axis for bar chart values
  scale_fill_manual(values = cols) +  #cstom fill colors for bar chart
  scale_x_discrete(breaks = 2015:2024, labels = 2015:2024) +
  scale_y_continuous(name = "Papers reporting AIS/NAS",
                     breaks = seq(10, 60, by = 10), 
                     labels = seq(10, 60, by = 10),
                     sec.axis = sec_axis(transform = ~ . * 26, 
                                         name = "Total aquatic eDNA metabarcoding papers")) +
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

save_plot("AIS_eDNAmb_papers_platform_by_year_plot.jpg", 
          p1,
          base_width = 9,
          base_height = 8,
          dpi=300)


                