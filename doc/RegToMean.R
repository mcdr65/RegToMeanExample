## ----setup, cache=FALSE, include=FALSE--------------------------------------------------------------------------------
# set up some global options for the document
options(width = 120, show.signif.stars = FALSE)
# also set up global chunk options
library(knitr)
opts_chunk$set(dev="pdf",echo=FALSE,fig.path="figures/",fig.align="center",
               background="transparent",out.width="0.49\\linewidth",warning=FALSE,message=FALSE,tidy=TRUE)
knit_theme$get()##choose a theme
knit_theme$set("kellys")

## ----echo=FALSE,results="hide"----------------------------------------------------------------------------------------
n <- 1000
mu <- 90
delta<-10
sT <- 8
sE <- 5
set.seed(4)
T1 <- rnorm(n/2,mu,sT)
T2 <- rnorm(n/2,mu+delta,sT)
X1 <- rnorm(n/2,T1,sE)
X2 <- rnorm(n/2,T2,sE)
Delta <- T2-T1
D <- X2-X1
(reliab <- sT^2/(sT^2+sE^2))
cor(T1,X1)

## ----fig.show="hold"--------------------------------------------------------------------------------------------------
matplot(rbind(mean(T2)-mean(T1),Delta),type="l",axes=FALSE,main=expression(paste("E[D|",Delta,"=",delta,"]=",delta)),ylab="quantity of interest")
axis(1,1:2,c(expression(paste("True(",Delta,")",sep="")),"Observed (D)"),col.axis="blue")
axis(2)
matplot(rbind(Delta,D),type="l",axes=FALSE,main=expression(paste("E[",Delta,"|D=d]<d")),ylab="quantity of interest")
axis(1,1:2,c(expression(paste("True(",Delta,")",sep="")),"Observed (D)"),col.axis="blue")
axis(2)
plot(Delta,D,xlab=expression(Delta),cex=.2)
abline(lm(D~Delta),col="red")
lines(D,D,lty=2,col="blue")
plot(D,Delta,ylab=expression(Delta),cex=.2)
abline(lm(Delta~D),col="red")
lines(Delta,Delta,lty=2,col="blue")

## ----fig.show="hold",results="hide"-----------------------------------------------------------------------------------
n<-1000
library(RegToMeanExample)
DBP.RTM(n=n,show.plot=FALSE)[c(1:5,7)]

## ----fig.show="hold"--------------------------------------------------------------------------------------------------
b <- DBP.RTM(n=n,show.plot=TRUE)

## ----fig.show="hold",results="hide"-----------------------------------------------------------------------------------
DBP.RTM(n=n,r=0,show.plot=TRUE)[c(1:5,7)]

## ----fig.show="hold",results="hide"-----------------------------------------------------------------------------------
DBP.RTM(n=n,r=0.8,TrueChange=-10,show.plot=TRUE)[c(1:5,7)]

## ----fig.show="hold",results="hide"-----------------------------------------------------------------------------------
DBP.RTM(n=n,r=.4,TrueChange=-10,show.plot=TRUE)[c(1:5,7)]

## ----fig.show="hold",results="hide"-----------------------------------------------------------------------------------
DBP.RTM(n=n,r=1,TrueChange=0,show.plot=TRUE)[c(1:5,7)]

