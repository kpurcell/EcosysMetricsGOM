# Function code for normalized diversity metrics (help make plotting on common figure poss)
# Idea for plot from JKC
# KM Purcell (coded)
# updated: 2014-2-11

divNorm<- function(x){
  #browser()
  shan.norm<-x$shan/mean(x$shan)
  simp.norm<-x$simp/mean(x$simp)
  J.norm<-x$J/mean(x$J)
  S.norm<-x$S/mean(x$S)
  d.norm<-x$d/mean(x$d)
  N1.norm<-x$N1/mean(x$N1)
  N2.norm<-x$N2/mean(x$N2)
  data.frame(YR,S.norm,d.norm,J.norm,shan.norm,simp.norm,N1.norm,N2.norm)
}