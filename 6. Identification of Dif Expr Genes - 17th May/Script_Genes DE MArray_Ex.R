#############################################
#######    Script - EXERCISES         #######
#######    Stat Meth Microarray Data  #######
#############################################


# -------------Ex 1----------------

# 10 columns with log intensities, normalized
# DIS (Disease) alternates with NOR (Normal)
# 1st slide: DIS

setwd("C:/.../Swirl")

dataDIS<-read.table("Disease.txt",dec=",")
dataDIS[1,]
head(dataDIS)

# -------------Ex 2----------------

# a)

library(limma)

# 1 - DIS ; 2 - NOR
code <- c(1,2,1,2,1,2,1,2,1,2)
design <- model.matrix(~ 0+factor(code))
colnames(design) <- c("DIS", "NOR")

# b)
fit <- lmFit(dataDIS,design)

contrast.matrix <- makeContrasts(DIS-NOR,levels=design)
fit <- contrasts.fit(fit, contrast.matrix)

fit <- eBayes(fit)

# c)
table<-topTable(fit,number=20,adjust="BH") 
table

# d)
table<-topTable(fit,number=dim(dataDIS)[1],adjust="BH") 
length(table$B)
#[1] 23064
length(table$B[table$B>0])

# e)
volcanoplot(fit,highlight=258,main="DIS vs NOR")
abline(0,0)


# -------------Ex 3----------------

library(RankProd)

# Calculate the nr. of replicates
kDIS <- ncol(dataDIS)
kDIS

# Calculate the number of genes
nDIS <- nrow(dataDIS)
nDIS

# a)
vDIS<-c(1,0,1,0,1,0,1,0,1,0)
length(vDIS)

# b)
RP.outDIS<- RP(dataDIS,vDIS,num.perm=100,logged=TRUE)
length(RP.outDIS$pfp[RP.outDIS$pfp<=0.001]) 
# or
sum(RP.outDIS$pfp<=0.001)

# c)
# Represent genes with FDR lower than cutoff
tablerpDIS<-topGene(RP.outDIS,cutoff=0.001,logged=TRUE,method="pfp",gene.names=rownames(dataDIS))

# d)
plotRP(RP.outDIS,cutoff=0.001)

# e)
# Visualize down-regulated for WT
tablerpDIS$Table1
dim(tablerpDIS$Table1)
# Visualize up-regulated for WT
tablerpDIS$Table2
dim(tablerpDIS$Table2)

