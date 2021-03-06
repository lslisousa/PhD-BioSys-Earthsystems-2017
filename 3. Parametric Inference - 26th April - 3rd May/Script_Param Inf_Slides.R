#######################################
#######      Script - SLIDES    #######
#######    Parametic Inference  #######
#######################################

# Statistics and their Sampling Distributions
# -------------------------------------------

# Example 1

DNA<-factor(c("A","C","G","T"))
p<-c(0.15,0.15,0.50,0.20)  # for example
N<-10000

#success happens when A,C,T occurs, hence the probability of success is 1-P(G)=0.5

data<-sample(DNA,N,replace=T,prob=p) 
# simulates a string of DNA of length N according to the specified probabilities in p
data[1:30] # first thirty elements

loc<-which(data!="G") # finds the locations where a success occurs
loc[1:10]

x<-c(loc[1]-1,diff(loc)-1) # calculates the number of runs of G
x[1:10]

Mean_run<-sum(x)/length(x) 
# calculates the mean value of the number of runs of G; should be around to P(G)/(1-P(G))
Mean_run

rel.freq<-round(table(x)/length(x),5) # gives the relative frequency of the number of runs
rel.freq

plot(rel.freq,"h",xlab="X=number of consecutive runs of G",ylab="relative frequency of X",main="Geometric Model")
lines(0:13,dgeom(0:13,0.5),col=2,"h") #p.m.f. of the geometric distribution
legend(3,0.4,legend=c("observed frequencies", "theoretical frequencies"),col=1:2,lty=1,cex=0.8)


# Example 2 (variation)

na<-725
nb<-258
nab<-72
n0<-1073
n<-na+nb+nab+n0

library(maxLik)
f<-function(p)
(na+nab)*log(p[1])+na*log(2-p[1]-2*p[2])+(nb+nab)*log(p[2])+nb*log(2-p[2]-2*p[1])+nab*log(2)+2*n0*log(1-p[1]-p[2])
summary(maxNR(f,start=c(0.6,0.3)))


# Confidence Intervals
# --------------------

# Ex CI for mu

x<-c(32.81,37.04,37.21,31.15,26.97,26.58,31.85,30.09,28.63,25.12,31.67,28.26,28.57,37.39,30.55,32.98,24.52,28.28,27.37,26.35)
t.test(x,alternative="two.sided",conf.level=0.99)$conf.int

# Ex CI for sigma_x^2/sigma_y^2

y<-c(38.14, 39.07, 37.29, 41.20, 40.31, 39.07, 34.99, 36.82, 35.23, 37.97, 36.21, 45.13, 35.98, 36.55, 37.45,
40.23, 38.45, 45.01, 36.94, 42.09)
var.test(x,y)$conf.int

# Ex CI for mu1-mu2 (var-equal)

t.test(x,y,alternative="two.sided",var.equal=T)$conf.int  # default: paired=F


# Hypothesis Testing
# ------------------

### Ex ANOVA

a<-c(30.28,27.58,27.91,29.33)
b<-c(34.26,32.55,21.78,25.59,35.08,26.86)
c<-c(39.47,30.15,33.40,27.38,30.39,25.85,29.11,26.22)
d<-c(33.54,30.40,29.60,28.82,30.70,30.83,33.84)
observ<-c(a,b,c,d)
treatm<-factor(rep(c("a","b","c","d"),c(4,6,8,7)))

bartlett.test(observ,treatm) # p=0.02994

data<-data.frame(treatm,observ)
aov(observ~treatm)
summary(aov(observ~treatm)) # p=0.759

### Ex HT for p1-p2 

## Example 8 calculations:

x1<-25
x2<-27
n<-100

# estimates
p1.hat<-x1/100; p1.hat
p2.hat<-x2/100; p2.hat
p.hat<-(x1+x2)/(n+n); p.hat
sigma.hat<-sqrt(2*p.hat*(1-p.hat)/n); sigma.hat # 0.06203225

z.obs<-(p1.hat-p2.hat)/sigma.hat; z.obs # -0.3224129

x1<-c(rep(1,25),rep(0,75))
x2<-c(rep(1,27),rep(0,73))
sd<-sqrt((var(x1)+var(x2))/100); sd # 0.06232855

## Ex. 8: t.test (approx. Normal)
# The sd of the test statistics is not the same as before
# The sampling distribution is t(~198), which is approx. Normal
# However, allows the calculation of an approximate value to z.obs

t.test(x1,x2)
t.test(x1,x2)$statistic  # t.obs=-0.3208802 ~ z.obs

## Ex. 8: Z.test (Normal)
# The sd of the the populations should be known
# However, allows the calculation of an approcximate 
# value to z.obs just by substituting sd by the empirical ones

library(BSDA)

zt<-z.test(x1,x2,sigma.x=sqrt(var(x1)),sigma.y=sqrt(var(x2)))
zt
zt$statistic # -0.3208802 = t.obs


## Ex. 8: Prop.test (Qui-Sq distr.)

suc<-c(sum(x1),sum(x2)) # vector - total successes per group
trials<-c(100,100)      # vector - total trials per group
prop.test(suc,trials)

# or

unsuc<-100-suc              # vector - total unsuccesses per group
x<-matrix(c(suc,unsuc),2,2) # contingency table
prop.test(x)

