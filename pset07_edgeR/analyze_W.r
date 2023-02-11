# Wiggins' RNA-seq analysis script
#
# To run:
#    % Rscript analyze_W.r
#
# You need to have your data in a file called "mydata.tbl"
# This is a tab-delimited file with a header line, followed
# by one line per gene: 
#   <genename>  <counts1> <counts2> ... <counts6>
# Script assumes that there are six samples, three from one
# condition (e.g. wild type), three from another (e.g. mutant).
#
# The script generates an output file "myresult.out".
# 

library(edgeR)
infile     <- "mydata.tbl"
group      <- factor(c(1,1,1,2,2,2))     
outfile    <- "myresult.out"

x     <- read.table(infile, sep='\t', row.names=1)
y     <- DGEList(counts=x,group=group)
y     <- estimateDisp(y)
et    <- exactTest(y)
tab   <- topTags(et, nrow(x))

write.table(tab, file=outfile)
