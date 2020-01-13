#!/usr/bin/Rscript

require(scales)
require(ggplot2)
require(grid)
require(png)
require(gridExtra)
require(reshape2)


args <- commandArgs(TRUE)
onCMDLine <- !is.na(args[1])

if ( onCMDLine ) {
  file <- args[1]
  sample_id <- args[2]
  gene <- args[3]
}

cnv = read.csv(file,sep="\t",header=T,check.names=FALSE)


affected_samples = c(sample_id)

std_columns = c("#chr","start","end")

affected <- melt(subset(cnv, select=names(cnv) %in% c(std_columns,affected_samples)),id=std_columns)

melted_all <- melt(cnv,id=std_columns)
plot.title = sprintf("%s", gene)
file.out = sprintf("%s.pdf", sample_id)

q <- ggplot(melted_all,aes(x=start/1000,y=exp(value))) + geom_line(aes(group = variable),color="lightgrey")
q <- q + geom_line(data=affected,aes(x=start/1000,y=exp(value),group = variable),color="blue")
q <- q + geom_point(data=affected,aes(x=start/1000,y=exp(value),group = variable),color="black") + theme_bw()
q <- q + scale_y_continuous("Estimated Copy Number", limits=c(0,4)) + scale_x_continuous("Position (kb)")
q <- q + ggtitle(plot.title)

pdf(file.out)
print(q)
dev.off()
