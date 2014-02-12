# Function script for calculating common fishery diversity indicies
# KM Purcell
# updated:2014-2-11
# dependencies: Vegan package

divMetrics<- function(x){
  browser()
  N<-rowSums(x) # total individuals caught per station
  shan<- diversity(x, index="shannon") #shannon
  simp<-diversity(x, index="simpson") #simpson
  J<- shan/log(specnumber(x))
  S<-specnumber(x)
  d<-(S-1)/log(N)
  N1<-exp(shan)
  N2<-D2<-(1/simp)
  data.frame(YR,S,d,J,shan,simp,N1,N2)
}