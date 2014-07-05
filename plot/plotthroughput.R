#!/usr/bin/Rscript

# boxplot throughput in mbps
# input: throughput file
# output: throughput.mbps.png (pdf/emf)
args <- commandArgs(trailingOnly = TRUE)
print(args)
src <- args[1]
#prefix = src
prefix = paste(src, sep = ".", "mbps")

xlabel = "NUMBER OF PARALLEL STREAMS"
ylabel = "THROUGHPUT (Mbps)"
#ylabel = "AGGREGATE THROUGHPUT (Mbps)"
#ylabel = "AGGREGATE THROUGHPUT (MB/S)"
#ylabel = "LINK UTILIZATION (%)"

# figure size in pixel
fheight = 300
fwidth = 400

# filter missing values
#data <- read.table(src, na.strings = "NA", fill = TRUE, header=1)
data <- read.table(src, na.strings = "NA", fill = TRUE)

# replace missing values to zero
data[is.na(data)] <- 0
#print(data)

# transpose
data <- t(data)
#data <- t(data/8)
#print(data)

require(devEMF)

genplot <- function (type) {
        #rm(list = ls())      # Clear all variables
        #graphics.off()    # Close graphics windows

        imgfile = paste(prefix, sep = ".", type)

        if(type == "png") {
                png(imgfile, height = fheight, width = fwidth)
                #png(paste0(prefix, ".png"), height=fheight, width=fwidth)
        #       png(paste0(prefix, ".png"))
        } else if (type == "pdf") {
                pdf(imgfile, height=1.5*fheight/100.0, width=1.5*fwidth/100.0)
                #pdf(paste0(prefix, ".pdf"), height=1.5*fheight/100.0, width=1.5*fwidth/100.0)
        } else if (type == "eps") {
                postscript(imgfile)
                #postscript(paste0(prefix, ".eps"))
                #postscript(paste0(prefix, ".eps"), res = resolution)
        } else if (type == "emf") {
                emf(imgfile, height=1.5*fheight/100.0, width=1.5*fwidth/100.0)
                #emf(paste0(prefix, ".emf"), height=1.5*fheight/100.0, width=1.5*fwidth/100.0)
        }

	# c(bottom, left, top, right)
	par(mar = c(5, 5, 1, 1) + 0.1)

	# las = 2 to rotate xlabels
	#boxplot(data)
	boxplot(data, 
		las = 2, 
		xlab = xlabel,
		ylab = ylabel,
		names = c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "12", "14", "16", "18", "20", "30", 
			"40", "50", "60", "70", "80", "90", "100")
		,ylim = c(0, 1000)
	)
}

genplot("png")
genplot("pdf")
genplot("emf")