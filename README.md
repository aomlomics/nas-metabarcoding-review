# Review of NAS detected in eDNA metabarcoding studies

This repository contains data, analysis scripts, and figure outputs for a systematic review of non-indigenous aquatic species (NAS) detections reported in environmental DNA (eDNA) metabarcoding studies.

This work is part of the USGS-funded project "Development of eDNA metabarcoding and data standards through community networks to support the USGS Nonindigenous Aquatic Species database".

## Repository structure

- code: R scripts used for analysis and figure generation, plus intermediate CSV files used by plotting scripts.
- data: primary CSV files used by figure-generation scripts.
- docs: supplementary spreadsheets and conversion notes.
- figures: pre-publication figure files generated from scripts.
- markdown: manuscript-support markdown files (research questions, results stub, and publication list).

## Main analysis scripts and outputs

- code/Fig_1_NAS_studies_map.R: generates Figure_1_NAS_studies_map.png (map and continent/habitat summaries).
- code/Fig_2_NAS_sequencing_platform.R: generates Figure_2_platform_summary_plot.png (platform by year with total-paper trend overlay).
- code/NAS_eDNA_mb_keyword_network.R: generates NAS_eDNA_mb_keyword_network_plot.png (keyword co-occurrence network).
- code/Fig_4_NAS_review_data_models_plots.R: generates Figure_4_metadata_barplots.png (metadata reporting and methods summary).
- code/PieDonutCustom.R: generates marker pie-donut figures (fish, invertebrate, and plant/macroalgae marker summaries).

## Reproducibility notes

Several scripts were developed with local paths and legacy filenames. To rerun analyses in a new environment, update file paths and (where needed) harmonize filenames.

Examples of script/file mismatches currently present:

- Fig_1_NAS_studies_map.R reads NAS_continent_map.csv, while data currently includes Fig_1_NAS_continent_map.csv.
- NAS_eDNA_mb_keyword_network.R reads keywords_normalized.csv and sets an absolute working directory.
- Fig_4_NAS_review_data_models_plots.R reads Appendix_4_ais_edna_review_data.csv (not currently present in this repository).
- NAS_taxa_and_marker_summary_plots.R and PieDonutCustom.R include absolute paths and mixed naming variants for Asia/non-Asia marker files.

## Software requirements

R packages used across scripts include:

- dplyr
- ggplot2
- tidyr
- tidyverse
- readr
- cowplot
- sf
- rnaturalearth
- rnaturalearthdata
- tidygraph
- ggraph
- igraph
- ape
- rotl
- moonBook
- RColorBrewer
- webr

## Current figure files in this repository

- figures/Figure_1_NAS_studies_map.png
- figures/Figure_2_platform_summary_plot.png
- figures/Figure_2_keyword_network_plot.png
- figures/Figure_4_metadata_barplots.png
- figures/NAS_eDNA_mb_papers_platform_by_year_plot.jpg
