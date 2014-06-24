#!/usr/bin/Rscript

args <- commandArgs(trailingOnly = TRUE)
print(args)
src <- args[1]

# filter missing values
#data <- read.table(src, na.strings = "NA", fill = TRUE, header=1)
data <- read.table(src, na.strings = "NA", fill = TRUE)

# replace missing values to zero
data[is.na(data)] <- 0
print(data)

data <- t(data)
print(data)

#pngfile = paste0(src, ".png")
pngfile = paste(src, sep = "", ".png")
png(pngfile)

boxplot(data)
