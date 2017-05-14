#############################################
#######    Script - EXERCISES         #######
#######    Normaliz Meth Microarray   #######
#############################################


# -------------Ex 1----------------

source("http://bioconductor.org/biocLite.R")
biocLite("limma")
library(limma)

# -------------Ex 2----------------

# http://bioinf.wehi.edu.au/limma/
# go to the end of the webpage
# download the Zebrafish data - zip.file
# working directory - swirl
# Chip: 4x4 blocks, 22 rows and 24 col, each

setwd("C:/.../swirl")

swirl <- readTargets("SwirlSample.txt")
swirl
RG <- read.maimages(swirl$FileName, source="spot")
RG
RG$genes <- readGAL("fish.gal")
head(RG$genes)
RG$printer <- getLayout(RG$genes)
RG$printer

# -------------Ex 3----------------

# Visualize background intensities (Red and Green) for each array
# Array 1 (slide 81)
par(mfrow=c(1,2))
imageplot(RG$Gb[,1], RG$printer, low="white", high="green",main="Slide1 Green Background")
imageplot(RG$Rb[,1], RG$printer, low="white", high="red",main="Slide1 Red Background")
# etc

par(mfrow=c(1,1))
plotMA(RG[,4])
plotPrintTipLoess(RG[,2])

MA.raw <- normalizeWithinArrays(RG,method="none")
boxplot(MA.raw$M,names=colnames(MA.raw$M),col=rainbow(4))

# -------------Ex 4----------------

RG.bg.correct<-backgroundCorrect(RG,method="sub")

# -------------Ex 5----------------

MA.with <- normalizeWithinArrays(RG.bg.correct,method="printtiploess")
boxplot(MA.with$M,names=colnames(MA.with$M),col=rainbow(6))

# -------------Ex 6----------------

MA.bet <- normalizeBetweenArrays(MA.with,method="scale")
boxplot(MA.bet$M,names=colnames(MA.bet$M),col=rainbow(8))
