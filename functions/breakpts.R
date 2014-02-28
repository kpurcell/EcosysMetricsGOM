# Function code for breakpoint analysis
# Based on break point method from R book
# KM Purcell
# updated: 2014-2-11

breakpt.fun <- function(df,t,v,C,R){
  stats<-c("S", "d",	"J",	"shan",	"simp",	"N1",	"N2")  #bull shit to help make a data.fram for a dynamic table
  mods<-c("sum.la", "sum.tx", "fall.la", "fall.tx")
  stat<-stats[C]  #create a variable naming the diversity metric being examined
  mod<-mods[R] #pull the region and season for the data
  
  y<-df[[v]]
  x<-df[[t]]
  
  breaks <- x[which(x >= 1990 & x <= 2010)]
  
  mse <- numeric(length(breaks))
  for(i in 1:length(breaks)){
    piecewise1 <- lm(y ~ x*(x < breaks[i]) + x*(x>=breaks[i]))
    mse[i] <- summary(piecewise1)[6]
  }
  mse <- as.numeric(mse)
  
  z<-breaks[which(mse==min(mse))] #creates a varible = break point
  
  print(paste("Break point =", z, sep=" ")) #Print break point year
  
  par(mfrow=c(1,2))  #create a visual for the analysis
  plot(y ~ x, pch=16,
       ylab=bquote(.(stat)))
  plot(mse~breaks)
  mselabel = bquote(italic(bp) == .(format(z, digits = 3)))
  #text(x = 19, y = 2.5, labels = mylabel)
  legend('topright', legend=mselabel, bty='n')
  
  
  piecewise2 <- lm(y ~ x*(x < z) + x*(x > z))
  
  print(summary(piecewise2))
  
  alpha<-print(z)
  p.Val<-anova(piecewise2)$'Pr(>F)'[1]
  r.Sqr<-summary(piecewise2)$r.squared
  new.DF<-data.frame(mod, stat, alpha, p.Val, r.Sqr)
  #paste(mod,stat,sep="_")<<-new.DF
  assign(paste(mod,stat,sep="_"),new.DF, envir=globalenv())
}