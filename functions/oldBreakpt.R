# Function code for breakpoint analysis of environmental variables
# Based on break point method from R book
# KM Purcell
# updated: 2014-2-14

oldBreakpt <- function(df,t,v){
  
  df2<-as.data.frame(lowess(df[[v]]~df[[t]]))
  y<-df2$y
  x<-df2$x
  
  breaks <- x[which(x >= 1995 & x <= 2010)]
  
  mse <- numeric(length(breaks))
  for(i in 1:length(breaks)){
    piecewise1 <- lm(y ~ x*(x < breaks[i]) + x*(x>=breaks[i]))
    mse[i] <- summary(piecewise1)[6]
  }
  mse <- as.numeric(mse)
  
  z<-breaks[which(mse==min(mse))] #creates a varible = break point
  
  print(paste("Break point =", z, sep=" ")) #Print break point year
  
  par(mfrow=c(1,2))  #create a visual for the analysis
  plot(y ~ x, pch=16)
  plot(mse~breaks)
  mselabel = bquote(italic(bp) == .(format(z, digits = 3)))
  #text(x = 19, y = 2.5, labels = mylabel)
  legend('topright', legend=mselabel, bty='n')
  
  
  piecewise2 <- lm(y ~ x*(x < z) + x*(x > z))
  
  print(summary(piecewise2))
  
}