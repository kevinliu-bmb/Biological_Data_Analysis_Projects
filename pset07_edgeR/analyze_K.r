library(edgeR)
x = read.table("mydata.tbl", sep = "	", row.names = 1)
y = DGEList(counts = x, group = factor(c(1, 1, 1, 2, 2, 2)))
y = y[rowSums(cpm(y)>=100)>=2,]
y = calcNormFactors(y)
y = estimateDisp(y)
et = exactTest(y)
tab = topTags(et, nrow(x))
write.table(tab, file = "myresult.out")
