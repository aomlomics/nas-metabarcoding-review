
#convert list of publications reviewed to markdown

setwd("/Users/ann.holmes/Desktop/github/ais-metabarcoding-review")
library(readr)
library(knitr)

df <- read.csv("final_pub_list_for_md.csv")

#covert to markdown table
md_table <- kable (df, format="markdown")

writeLines(md_table, "publications_reviewed_AIS_eDNA_mb.md")

#convert word doc of figure and table legends to markdown
library(rmarkdown)

input_file <- "AIS_review_legends.txt"
output_file <- "AIS_review_legends.md"
   
render(input_file, output_format = "md_document", output_file = output_file)
