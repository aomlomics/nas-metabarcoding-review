#A systematic review of environmental DNA metabarcoding detection of aquatic invasive species: 
#Guidelines to increase robustness and reproducibility

#temporal trends in negative controls and FAIR data
#models and plots

library(dplyr)
library(readr)
library(ggplot2)
library(tidyverse)
library(cowplot)

#read CSV file
#Appendix 1. NAS eDNA review studies metadata
review_data <- read_csv("Appendix_4_ais_edna_review_data.csv")

review_data %>% group_by(platform_detail) %>% summarize(count = n())

#proportion that included negative controls, sequenced negative controls, and open access scripts and raw data
colMeans(review_data[c("neg_control", "neg_control_results", 
                       "bioinformatics_scripts", "raw_data")] == "yes")
#neg controls: 0.8994709 and 0.5820106
#FAIR data: 0.1851852 (scripts) and 0.5132275 (raw data)

#GUI for bioinformatics (not yes/no)
colMeans(review_data[c("bioinformatics_scripts")] == "GUI") #0.06349206 

#exact sequence approaches vs clustering (threshold and dynamic)
colMeans(review_data[c("method_sequences")] == "exact") #0.4867725 
colMeans(review_data[c("method_sequences")] == "dynamic") #0.1058201 
colMeans(review_data[c("method_sequences")] == "threshold") #0.4074074 

#create binary columns for models
review_data <- review_data %>%
  mutate(
    neg_control_bin = if_else(neg_control == "yes", 1, 0),
    neg_control_results_bin = if_else(neg_control_results == "yes", 1, 0),
    bioinformatics_scripts_bin = if_else(bioinformatics_scripts == "yes", 1, 0), #GUI = no
    raw_data_bin = if_else(raw_data == "yes", 1, 0)
  ) %>%
  #exact = 1, dynamic/threshold = 0; remove unclear
  filter(!method_sequences %in% c("unclear", "both")) %>%
  mutate(
    exact_sequence_bin = if_else(method_sequences == "exact", 1, 0)
  )

#negative controls included?
nc_model <- glm(neg_control_bin ~ year, data = review_data, family = binomial)

#negative controls sequenced?
nc_seq_model <- glm(neg_control_results_bin ~ year, data = review_data, family = binomial)

#exact sequence methods used?
sequences_model <- glm(exact_sequence_bin ~ year, data = review_data, family = binomial)

#raw data available
raw_data_model <- glm(raw_data_bin ~ year, data = review_data, family = binomial)

nc_model
summary(nc_model)
nc_seq_model
summary(nc_seq_model)
sequences_model
summary(sequences_model)
raw_data_model
summary(raw_data_model)


#plots
#relative abundance bar plots

#reformat and filter data
long_data <- review_data %>%
  select(neg_control, neg_control_results, method_sequences,
         bioinformatics_scripts, raw_data) %>%
  pivot_longer(cols = everything(), names_to = "variable", values_to = "value") %>%
  # remove unwanted levels in method_sequences
  filter(!(variable == "method_sequences" & value %in% c("both", "unclear"))) %>%
  filter(!is.na(value))

#factor levels for variables
variable_levels <- c("neg_control", "neg_control_results", "method_sequences",
                     "bioinformatics_scripts", "raw_data")

#names for bars
variable_labels <- c("Negative control included",
                     "Negative control sequenced",
                     "Sequence method",
                     "Scripts available",
                     "Raw data available")

#order of legend values
value_levels <- c("yes", "no", "GUI", "exact", "dynamic", "threshold")

#colors for values
value_colors <- c(
  "yes" = "green3", 
  "no" = "firebrick",     
  "GUI" = "purple", 
  "exact" = "gold",     
  "dynamic" = "orchid",   
  "threshold" = "dodgerblue")        

#variables and values to factors with specified order
plot_data <- long_data %>%
  mutate(
    variable = factor(variable, levels = variable_levels),
    value = factor(value, levels = value_levels)
  ) %>%
  group_by(variable, value) %>%
  summarise(n = n(), .groups = "drop") %>%
  group_by(variable) %>%
  mutate(percent = n / sum(n) * 100) %>%
  ungroup()

#x axis labels with descriptive names
variable_labels_df <- tibble(variable = factor(variable_levels, levels = variable_levels),
                             label = variable_labels)

#join to add labels
plot_data <- plot_data %>%
  left_join(variable_labels_df, by = "variable")

#plot
metadata_barplots <-ggplot(plot_data, aes(x = label, y = percent, fill = value)) +
  geom_col(width = 0.6) +
  scale_fill_manual(values = value_colors, drop = FALSE) +
  labs(x = NULL, y = "% of studies", fill = "Variable") +
  theme_bw() +
  theme(
    axis.text.x = element_text(angle = 30, hjust = 1),
    panel.grid.major.x = element_blank())

save_plot("Figure_4_metadata_barplots.png", 
          metadata_barplots, 
          dpi = 300,
          base_height = 5, #height in inches
          base_width = 8, #width in inches
          bg = "white")

#old script for temporal trends

#remove 2015 (only 1 study so it causes a problem for trends)
filtered_data <- raw_data %>% filter(year > 2015)

#plot trend
ggplot(yearly_summary_filtered, aes(x = year, y = prop_available)) +
  geom_line() +
  geom_point(size = 2) +
  labs(
    title = "Proportion of Studies with Raw Data Available (2016–2024)",
    x = "Year",
    y = "Proportion with Raw Data") +
  scale_y_continuous(
    labels = scales::percent_format(accuracy = 1),
    limits = c(0, 1)) +
  theme_minimal()

