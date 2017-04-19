
########################################
#######    Script - SLIDES       #######
#######    Introduction to R   #########
########################################

# 1. Installing and Configuring R Studio
# --------------------------------------

A<-1
B<-2
A+B

R.version

getwd()
# Session - Set Working Directory - Choose Directory
# ctrl + shift + H
# or
setwd("C:/My Documents/My.Docs")
# or
setwd("C:\\My Documents\\My.Docs")
getwd()

help.start()
help(sqrt)
?sqrt
# Go to HELP window and type 'sqrt'

# Pacakges window - Install - type 'laticce'
library(Laticce)


# 2. Basic Operations
# --------------------

# Simple Calculations

3+7
89*1234
67/4
3^4
log(2)
log10(34)  # or log(34,base=10)
exp(5)
sin(pi)
cos(pi)
tan(pi/4)
sqrt(36)+4^(1/2)

# Function seq()

seq(1:10)
seq(from=1,to=10)
seq(to=10,from=1)
seq(1,5,by=0.5)
seq(from=2.3,by=0.2,length=20)

# Logical Vectors

x<-190
cholesterol <- x<200
cholesterol
mode(cholesterol)
y <- x>150
y
y&cholesterol
y|cholesterol

# Alphanumeric vectors

paste("A",1:10)
paste(c("A","B"),1:10,sep="")
paste("Today is",date(),1:3,sep=",")


# 3. Vectors, Matrices and Data Frames
# ------------------------------------

# Creating vectors

x<-1
mode(x)
length(x)
A <- "Iron Level"
compar<-TRUE
z<-1i
mode(A); mode(compar); mode(z)

# Vectors

v<-c(3,7,9,15) 
v 
length(v) 
mode(v) 
s<-c("Name","Blood type","Pathology") 
s 
mode(s)

y<-c(35,56,NA,18,65)
y
y[3]
y[4]<-70
y

y[6]<-76 
y
y<-c(y[2],y[4]) 
y
v<-c(1,2,3,4,5,6) 
x<-sqrt(v) 
x 
v1<-c(1,2,3) 
v2<-c(4,5,6) 
v1+v2

x<-c(0,-3,2,7,9,15,20,-2,-1) 
x 
x>0 
y<-x>0 
x[y] # or x[x>0] 
x[x<=-2|x>5] 
x[x<15 & x>2] 
x[c(3,7)] 
x[1:3] 
x[-c(2,8)] 
x[-(1:3)]


# Factors

p<-c("sick","notsick","sick","notsick","sick", "sick","sick","notsick","sick","sick")
p
p<-factor(p)
p
gender.p<-factor(c("f","f","f","f","f","f","f","f","f","f"),
levels=c("f","m")) 
gender.p

table(p)
table(gender.p) 
table(p,gender.p) 
t<-table(p,gender.p) 
margin.table(t,1) 
margin.table(t,2) 
prop.table(t) 
100 * prop.table(t)

province<-c("tmd","bl","min","rib","rib","ba","alt","alt","min","alg","rib","alg","min","min","ba")
province
province.f<-factor(province)
province.f
levels(province.f)
length(province.f)

nr.patients<-c(60,49,40,61,64,60,59,62,69,70,42,56,61,61,58)
length(nr.patients)
mean.patients<-tapply(nr.patients,province.f,mean)
mean.patients

# Matrices

y<-1:12; y
dim(y)<-c(4,3);y 
# or 
y<-1:12 
x<-matrix(y,ncol=3);x
# or 
z<-matrix(y,nrow=4) ;z 
# or 
m<-matrix(c(1,2,3,4,5,6,7,8,9,10,11,12),4,3);m

colnames(m)<-c("c1","c2","c3") 
rownames(m)<-c("r1","r2","r3","r4") 
m

m[2,2] 
# or 
m["r2","c2"]

A<-matrix(c(5,3,4,8,9,10,2,5,4),3,3);A 
B<-matrix(c(-1,3,-2,7,0,4,-2,4,5),3,3);B 
A+B 
A%*%B

t(B) 
det(A)
solve(B)
diag(A) 
rowMeans(A)

# Lists

lt<-list(name="Mary",marital.status="married",nr.kids=3,age.kids=c(4,7,9))
lt
length(lt)
mode(lt)
names(lt)

lt[[1]]
lt[[3]]
# or
lt$name
lt$nr.kids

names(lt)<-c("name","m.state","chil.nr","child.age")
names(lt)
lt$age<-35 
lt$parents<-c("Paul","Susan") 
names(lt)
lt.2<-list(blood.type="A",sex="F")
lt.3<-c(lt,lt.2)

# Data frames

a<-c(3124,2136,2157,3589,1980)
b<-c("obese","normal","normal","obese","normal")
c<-c("m","f","m","f","f")
patients.inform<-data.frame(cal.cons=a,group=b,gender=c)
patients.inform

patients.inform[2,2]
patients.inform$group

patients.inform[patients.inform$cal.cons<3000,]
patients.inform[patients.inform$cal.cons<3000,"group"]
patients.inform[patients.inform$gender=="f",c("cal.cons","group")]

attach(patients.inform)
patients.inform[cal.cons<3000,]
group
detach(patients.inform)
gender

nrow(patients.inform)
ncol(patients.inform)
patients.inform$weight<-c(100,62,80,75,55)
patients.inform

other.df<-data.frame()
other.df<-edit(other.df)
other.df


# 4. Import and export files
# ---------------------------

# Access to a specific package

data()
data(package="Biobase")
data(geneCov,package="Biobase")

library(Biobase) 
data()
data(geneCov)


# 5. Graphical functions
# -----------------------

demo(graphics)

# Function plot()

data(CO2)
names(CO2)
attach(CO2)
plot(Type)

plot(uptake)

plot(Type,conc)

# Multiple graphic in one device

 
library(MASS)
data(Animals)
names(Animals)
attach(Animals)
par(mfrow=c(2,2),pch=16)
plot(body, brain)
plot(sqrt(body),sqrt(brain))
plot((body)^0.1,(brain)^0.1)
plot(log(body),log(brain))

layout(matrix(1:2, 2, 1), heights = c(2, 1))
layout.show(2)

par(mfrow=c(1,1),pch=1)
plot(1,1, xlim=c(1, 7.5), ylim=c(0,5), type="n")
points(1:7, rep(4.5, 7), cex=1:7, col=1:7, pch=0:6)
text(1:7,rep(3.5, 7), labels=paste(0:6), cex=1:7, col=1:7)
points(1:7,rep(2,7), pch=7:13)
text((1:7)+0.25, rep(2,7), paste(7:13))
points(1:7,rep(1,7), pch=(14:20))
text(1.25:7.25, rep(1,7), paste(14:20))


# Loops and Functions
# --------------------

# Function for()

x<-c(3,5,6,1,2,4)
z <- NULL
for(i in 1:length(x)) {
if(x[i] < 5) z <- c(z, x[i] - 1)
else z <- c(z, 100) }
z

# Function while()

z <- 0
while(z < 5) {
z <- z + 2
print(z) }

# Function repeat()

z <- 0
repeat { z <- z + 1
print(z)
if(z > 2) break() }

# 

func <- function(x1, x2=5) {
z1 <- x1/x2
z2 <- x1*x2
vec <- c(z1, z2)
return(vec) 
}
func

func(x1=2, x2=5) 
func(2,5)
func(2)

