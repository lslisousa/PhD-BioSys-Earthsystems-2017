
############################################
# Read data Swirl (cDNA) and CF (Affymetrix)
############################################

# -----  Swirl  -------- v. 2.9.2

library(limma)
setwd("C:/.../Swirl")

swirl<-readTargets("SwirlSample.txt")
dir()

RG <- read.maimages(swirl$FileName, source="spot")
show(RG)
summary(RG$R)

RG$genes <- readGAL("fish.gal")
RG$printer <- getLayout(RG$genes)

MA<-backgroundCorrect(RG,method="sub")
MA <- normalizeWithinArrays(MA,method="printtiploess")
MA <- normalizeBetweenArrays(MA,method="scale")


#############
# limma Swirl
#############

design <- c(-1,1,-1,1)
# -1 corresponds to dye-swap
fit <- lmFit(MA,design)
fit <- eBayes(fit)

# rank of the top genes according to B-stat
# determine the up and down from log_FC

table<-topTable(fit,number=20,adjust="BH")
table
write.table(table,"out.txt")
volcanoplot(fit,highlight=20,main="Swirl vs WT")
abline(4.7,0)
write.table(table,"out_limma_swirl.txt")

# MA Plot
#plotMA(fit)
#ord <- order(fit$lods,decreasing=TRUE)
#top30 <- ord[1:30]
#text(fit$Amean[top30],fit$coef[top30],labels=fit$genes[top30,"Name"],cex=0.8,col="blue")


#############
# RankProd Swirl
#############

source("http://bioconductor.org/biocLite.R")
biocLite("RankProd")
library(RankProd)

# Normalize data as in limma

MA$M[,2]<- (-1)*MA$M[,2]
MA$M[,4]<-(-1)*MA$M[,4]
data<-MA$M

# The number of replicates.
k <- ncol(data)
k

# Associate number "1" to each replicate, meaning that the data is paired (ratios)
v<-c(rep(1,k))
v

RP.out<-RP(data,v,num.perm=100,logged=TRUE)
length(RP.out$pfp[RP.out$pfp<0.001])

plotRP(RP.out,cutoff=0.001)

tablerp<-topGene(RP.out,cutoff=0.001,logged=TRUE,logbase=2,method="pfp")
# Represente the TOPx genes
tablerp<-topGene(RP.out,num.gene=20,logged=TRUE,logbase=2,method="pfp")

# Visualize the list of down-regulated genes
tablerp$Table1

# Visualize the list of up-regulated genes
tablerp$Table2

write.table(tablerp$Table1,"out_rpd_swirl.txt")
write.table(tablerp$Table2,"out_rpu_swirl.txt")

