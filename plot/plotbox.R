#!/usr/bin/Rscript

args <- commandArgs(trailingOnly = TRUE)
print(args)
src <- args[1]

# figure size in pixel
fheight = 300
fwidth = 400

# filter missing values
#data <- read.table(src, na.strings = "NA", fill = TRUE, header=1)
data <- read.table(src, na.strings = "NA", fill = TRUE)

# replace missing values to zero
data[is.na(data)] <- 0
print(data)

# transpose
data <- t(data)
print(data)

require(devEMF)

genplot <- function (type) {
        #rm(list = ls())      # Clear all variables
        #graphics.off()    # Close graphics windows

        if(type == "png") {
                #type(paste0(prefix, sep = ".", type))
                png(paste0(prefix, ".png"), height=fheight, width=fwidth)
                #png(paste0(prefix, ".png"), height=300, width=400)
        #       png(paste0(prefix, ".png"))
        } else if (type == "pdf") {
                pdf(paste0(prefix, ".pdf"), height=1.5*fheight/100.0, width=1.5*fwidth/100.0)
        } else if (type == "eps") {
                #png("aapl.png")
                #postscript(paste0(prefix, ".eps"), res = resolution)
                postscript(paste0(prefix, ".eps"))
        } else if (type == "emf") {
                #postscript("aapl.eps")
                emf(paste0(prefix, ".emf"), height=1.5*fheight/100.0, width=1.5*fwidth/100.0)
                #emf('aapl.emf')
        }

#pngfile = paste0(src, ".png")
pngfile = paste(src, sep = "", ".png")
png(pngfile)

boxplot(data)

}

genplot("png")
genplot("pdf")
genplot("emf")
