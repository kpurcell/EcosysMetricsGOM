#Clear the junk
graphics.off()
rm(list=ls(all=TRUE))


#load packages
library(reshape)
library(lattice)
library(MASS)
library(vegan)
library(doBy)
library(gplots)
library(segmented)
library(pander)
###Data Import and limiting source files########
starec.dat <- read.csv("C:/Users/kevin.purcell/Documents/seamap_2013/STAREC.csv")

#create a yr and month variable
starec.dat$date<-starec.dat$MO_DAY_YR
starec.dat$date<-as.Date(starec.dat$date, "%m/%d/%Y")
starec.dat$month<-format(starec.dat$date, format="%m")
starec.dat$YR<-format(starec.dat$date, format="%Y")
starec.dat$YR<-as.numeric(starec.dat$YR)
starec.dat$month<-as.numeric(starec.dat$month)

starec.dat <- starec.dat[,c(1:7, 14:17, 24:33, 36:40, 42:51)]  #ditch the columns that screw stuff up.
starec.dat$STAT_ZONE[starec.dat$STAT_ZONE==(-9)]=NA
starec.dat<- subset(starec.dat, starec.dat$STAT_ZONE!='NA') #ditch NAs for min fish
starec.dat<- subset(starec.dat, starec.dat$STAT_ZONE>=1&starec.dat$STAT_ZONE<=21)
starec.dat<- subset(starec.dat, starec.dat$YR>=1987&starec.dat$YR<=2011)
summary(starec.dat)

envrec.dat <- read.csv("C:/Users/kevin.purcell/Documents/seamap_2013/ENVREC.csv")
names(envrec.dat)
envrec.dat <- envrec.dat[,c(1:31)]

invrec.dat <- read.csv("C:/Users/kevin.purcell/Documents/seamap_2013/INVREC.csv")
names(invrec.dat)
invrec.dat <- invrec.dat[,c(2,11)]

bgsrec.dat<- read.csv("C:/Users/kevin.purcell/Documents/seamap_2013/BGSREC.csv")

specinfo.dat<-read.csv("C:/Users/kevin.purcell/Documents/comm_analysis/spec_info_summary.csv")
colnames(specinfo.dat)[1]<-'BIO_BGS'

# This is the fish we want to focus on
jkc.fish<-read.csv("C:/Users/kevin.purcell/Documents/comm_analysis/seamap_keepers_comm_analysis.csv")  #list of species of importance

info.dat<-merge(jkc.fish, specinfo.dat, by="BIO_BGS")

shrcom.agg<-read.csv("C:/Users/kevin.purcell/Documents/comm_analysis/DiversityMetrics/metrics_v2/offshore_6011.csv")

hypox.area=read.table("C:/Users/kevin.purcell/Documents/NOAA_SpatialEffort_MS/analysis/hypoxia_metrics.csv", sep=",",header=T)
colnames(hypox.area)[1]<-'YR'



#####
# Take the bgs record and merge with jkc.fish to narrow to only species of interest
bgsrec.dat2<-merge(bgsrec.dat, jkc.fish, by="BIO_BGS") #merge with the list of keepers
bgsrec.dat2<-merge(bgsrec.dat2, specinfo.dat, by="BIO_BGS") #tags each bsg record as p or d
bgsrec.dat2<-merge(bgsrec.dat2, invrec.dat, by=intersect(names(bgsrec.dat2), names(invrec.dat)))
bgsrec.dat2<-merge(bgsrec.dat2, starec.dat, by=intersect(names(bgsrec.dat2), names(starec.dat)))
#table<-merge(jkc.fish, specinfo.dat, by="BIO_BGS")
#write.table(table,"spec_list_review.csv",sep=",",row.names=T,col.names=T,quote=F) #changed this to row.names TRUE



bgsrec.dat2<-subset(bgsrec.dat2, bgsrec.dat2$VESSEL_SPD!='NA') #ditch NAs for spd
bgsrec.dat2<-subset(bgsrec.dat2, bgsrec.dat2$VESSEL_SPD<30) # ditch the vessel speed marked as 30
bgsrec.dat2<-subset(bgsrec.dat2, bgsrec.dat2$VESSEL_SPD>0)

# might want to standardize to a standard tow duration 

#relabel min_fish -9 to NA
bgsrec.dat2$MIN_FISH[bgsrec.dat2$MIN_FISH==(-9)]=NA
bgsrec.dat2<- subset(bgsrec.dat2, bgsrec.dat2$MIN_FISH!='NA') #ditch NAs for min fish

#calculate median tow time
st.tow<-median(bgsrec.dat2$MIN_FISH)

#calculate effort vector for each catch entry
bgsrec.dat2$effort<-(bgsrec.dat2$MIN_FISH*bgsrec.dat2$VESSEL_SPD)

bgsrec.dat2$wt_per_min<-(bgsrec.dat2$SELECT_BGS/bgsrec.dat2$MIN_FISH)
bgsrec.dat2$c_per_min<-(bgsrec.dat2$CNTEXP/bgsrec.dat2$MIN_FISH)
bgsrec.dat2$ST_SELECT_BGS<-(bgsrec.dat2$wt_per_min*st.tow)
bgsrec.dat2$ST_CNTEXP<-(bgsrec.dat2$c_per_min*st.tow)
#calculate effort vector for each catch entry
bgsrec.dat2$cpue<-bgsrec.dat2$ST_SELECT_BGS/bgsrec.dat2$effort

bgsrec.dat2$catch_cpue<-bgsrec.dat2$ST_CNTEXP/bgsrec.dat2$effort
names(bgsrec.dat2)
length(unique(bgsrec.dat2$BIO_BGS))

bgsrec.dat2$taxid<-paste(bgsrec.dat2$Genus, bgsrec.dat2$Species, sep=".")

complete.dat<-bgsrec.dat2
#====================================================================
library(pander)
# Complete table
cnt.tab<-aggregate(ST_CNTEXP ~ TAXONOMIC + common_name, data=complete.dat, FUN=sum)
bio.tab<-aggregate(ST_SELECT_BGS ~ TAXONOMIC , data=complete.dat, FUN=sum)
complete.tab<-merge(cnt.tab, bio.tab, by.x="TAXONOMIC")
test<-pandoc.table(complete.tab)

# Create seperate dataframes for Regions and seasons
sum.dat<-subset(complete.dat, complete.dat$month>=6&complete.dat$month<=8)
sum.la.dat<-subset(sum.dat, sum.dat$STAT_ZONE>=13&sum.dat$STAT_ZONE<=17)
sum.tx.dat<-subset(sum.dat, sum.dat$STAT_ZONE>=18&sum.dat$STAT_ZONE<=21)

fall.dat<-subset(complete.dat, complete.dat$month>=9&complete.dat$month<=11)
fall.la.dat<-subset(fall.dat, fall.dat$STAT_ZONE>=13&fall.dat$STAT_ZONE<=17)
fall.tx.dat<-subset(fall.dat, fall.dat$STAT_ZONE>=18&fall.dat$STAT_ZONE<=21)



# Summer Louisiana Timeseries
sum.la.tab<-aggregate(ST_CNTEXP ~ YR + TAXONOMIC, data=sum.la.dat, FUN=sum)
sum.la.tab<-reshape(sum.la.tab, idvar="YR", timevar="TAXONOMIC", direction="wide")
sum.la.tab[is.na(sum.la.tab)]<-0
names(sum.la.tab) <- gsub("ST_CNTEXP.", "", names(sum.la.tab))  #removes the var name from reshape
YR<-sum.la.tab$YR
sum.la.tab$YR<-NULL

# Summer Texas Timeseries  
sum.tx.tab<-aggregate(ST_CNTEXP ~ YR + TAXONOMIC, data=sum.tx.dat, FUN=sum)
sum.tx.tab<-reshape(sum.tx.tab, idvar="YR", timevar="TAXONOMIC", direction="wide")
sum.tx.tab[is.na(sum.tx.tab)]<-0
names(sum.tx.tab) <- gsub("ST_CNTEXP.", "", names(sum.tx.tab))  #removes the var name from reshape
YR<-sum.tx.tab$YR
sum.tx.tab$YR<-NULL

# Fall Louisiana Timeseries
fall.la.tab<-aggregate(ST_CNTEXP ~ YR + TAXONOMIC, data=fall.la.dat, FUN=sum)
fall.la.tab<-reshape(fall.la.tab, idvar="YR", timevar="TAXONOMIC", direction="wide")
fall.la.tab[is.na(fall.la.tab)]<-0
names(fall.la.tab) <- gsub("ST_CNTEXP.", "", names(fall.la.tab))  #removes the var name from reshape
YR<-fall.la.tab$YR
fall.la.tab$YR<-NULL

# Fall Texas Timeseries  
fall.tx.tab<-aggregate(ST_CNTEXP ~ YR + TAXONOMIC, data=fall.tx.dat, FUN=sum)
fall.tx.tab<-reshape(fall.tx.tab, idvar="YR", timevar="TAXONOMIC", direction="wide")
fall.tx.tab[is.na(fall.tx.tab)]<-0
names(fall.tx.tab) <- gsub("ST_CNTEXP.", "", names(fall.tx.tab))  #removes the var name from reshape
YR<-fall.tx.tab$YR
fall.tx.tab$YR<-NULL
#==================================================


divMetrics<- function(x){
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

sum.la.agg<-divMetrics(sum.la.tab)
sum.tx.agg<-divMetrics(sum.tx.tab)
fall.la.agg<-divMetrics(fall.la.tab)
fall.tx.agg<-divMetrics(fall.tx.tab)


names(sum.la.agg)
source("C:\\Users\\Kevin.Purcell\\Desktop\\EcosysMetricsGOM\\Analysis\\ResultsFigures\\LaDivMetricsFig.R")
source("C:\\Users\\Kevin.Purcell\\Desktop\\EcosysMetricsGOM\\Analysis\\ResultsFigures\\TxDivMetricsFig.R")
source("C:\\Users\\Kevin.Purcell\\Desktop\\EcosysMetricsGOM\\Analysis\\ResultsFigures\\LaDivSmoothFig.R")
source("C:\\Users\\Kevin.Purcell\\Desktop\\EcosysMetricsGOM\\Analysis\\ResultsFigures\\TxDivSmoothFig.R")



 
### Piecewise regression

sum.la.S<-lowess(sum.la.agg$S~sum.la.agg$YR); sum.la.S<-as.data.frame(sum.la.S)
sum.la.d<-lowess(sum.la.agg$d~sum.la.agg$YR)
sum.la.J<-lowess(sum.la.agg$J~sum.la.agg$YR)
sum.la.shan<-lowess(sum.la.agg$shan~sum.la.agg$YR)
sum.la.simp<-lowess(sum.la.agg$simp~sum.la.agg$YR)
sum.la.N1<-lowess(sum.la.agg$N1~sum.la.agg$YR)
sum.la.N2<-lowess(sum.la.agg$N2~sum.la.agg$YR)

with(sum.la.S, plot(x,y,pch=16))
sum.la.S.mod<-lm(y~x, data=sum.la.S)
sum.la.S.seg.mod<-segmented(sum.la.S.mod, seg.Z=~x, psi=c(1995,2010))
summary(sum.la.S.seg.mod)
plot(sum.la.S.seg.mod)

sum.la.S<-data.frame(sum.la.agg$S, sum.la.agg$YR)
colnames(sum.la.S)[1]<-'y'
colnames(sum.la.S)[2]<-'x'

plot(sum.la.S$x,sum.la.S$y, pch=16)
sum.la.S.mod<-lm(sum.la.S$y~sum.la.S$x)
sum.la.S.seg.mod<-segmented(sum.la.S.mod, seg.Z=~x, psi=c(1995))
  
  
## Segmented package analysis






sum.tx.S<-lowess(sum.tx.agg$S~sum.tx.agg$YR)
sum.tx.d<-lowess(sum.tx.agg$d~sum.tx.agg$YR)
sum.tx.J<-lowess(sum.tx.agg$J~sum.tx.agg$YR)
sum.tx.shan<-lowess(sum.tx.agg$shan~sum.tx.agg$YR)
sum.tx.simp<-lowess(sum.tx.agg$simp~sum.tx.agg$YR)
sum.tx.N1<-lowess(sum.tx.agg$N1~sum.tx.agg$YR)
sum.tx.N2<-lowess(sum.tx.agg$N2~sum.tx.agg$YR)

fall.la.S<-lowess(fall.la.agg$S~fall.la.agg$YR)
fall.la.d<-lowess(fall.la.agg$d~fall.la.agg$YR)
fall.la.J<-lowess(fall.la.agg$J~fall.la.agg$YR)
fall.la.shan<-lowess(fall.la.agg$shan~fall.la.agg$YR)
fall.la.simp<-lowess(fall.la.agg$simp~fall.la.agg$YR)
fall.la.N1<-lowess(fall.la.agg$N1~fall.la.agg$YR)
fall.la.N2<-lowess(fall.la.agg$N2~fall.la.agg$YR)

fall.tx.S<-lowess(fall.tx.agg$S~fall.tx.agg$YR)
fall.tx.d<-lowess(fall.tx.agg$d~fall.tx.agg$YR)
fall.tx.J<-lowess(fall.tx.agg$J~fall.tx.agg$YR)
fall.tx.shan<-lowess(fall.tx.agg$shan~fall.tx.agg$YR)
fall.tx.simp<-lowess(fall.tx.agg$simp~fall.tx.agg$YR)
fall.tx.N1<-lowess(fall.tx.agg$N1~fall.tx.agg$YR)
fall.tx.N2<-lowess(fall.tx.agg$N2~fall.tx.agg$YR)













####
####
names(shrcom.agg2)
shrcom.agg2<-aggregate(effort~ yr, data=shrcom.agg, FUN=sum)
shrcom.agg2<-subset(shrcom.agg2, shrcom.agg2$yr>=1983)

shrcom<-data.frame(shrcom.agg2$effort, shrcom.agg2$yr)
colnames(shrcom)[1]<-'y'
colnames(shrcom)[2]<-'x'

plot(shrcom$x,shrcom$y, pch=16)
shrcom.mod<-lm(shrcom$y~shrcom$x)
shrcom.seg.mod<-segmented(shrcom.mod, seg.Z=~x, psi=c(1985))
summary(shrcom.seg.mod)
plot(shrcom.seg.mod)



breaks <- shrcom.agg2$yr[which(shrcom.agg2$yr >= 1990 & shrcom.agg2$yr <= 2010)]

mse <- numeric(length(breaks))
for(i in 1:length(breaks)){
  piecewise1 <- lm(effort ~ yr*(yr < breaks[i]) + yr*(yr>=breaks[i]), data=shrcom.agg2)
  mse[i] <- summary(piecewise1)[6]
}

mse <- as.numeric(mse)
plot(mse~breaks)

breaks[which(mse==min(mse))]

eff.mod <- lm(effort ~ yr*(yr < 2003) + yr*(yr > 2003), data=shrcom.agg2)
summary(eff.mod)

###
###
names(hypox.area)

plot(hypox.area$area.hypoxic~hypox.area$YR)
grid(col="black")
lines(lowess(hypox.area$area.hypoxic~hypox.area$YR))

hypox.lo<-lowess(hypox.area$area.hypoxic~hypox.area$YR)

attach(hypox.lo)
plot(y ~ x, pch=16)                
breaks <- x[which(x >= 1995 & x <= 2005)]

mse <- numeric(length(breaks))
for(i in 1:length(breaks)){
  piecewise1 <- lm(y ~ x*(x < breaks[i]) + x*(x>=breaks[i]))
  mse[i] <- summary(piecewise1)[6]
}
mse <- as.numeric(mse)
plot(mse~breaks)

breaks[which(mse==min(mse))]

piecewise2 <- lm(y ~ x*(x < 1996) + x*(x > 1996))
summary(piecewise2)
detach(hypox.lo)

### Environmental drivers plots
par(mar=c(4,4,1,1)+0.2,mfrow=c(2,1))
plot(shrcom.agg2$effort~shrcom.agg2$yr,
     ylab="Daysfished",
     xlab="")
grid(col="black")
lines(lowess(shrcom.agg2$effort~shrcom.agg2$yr, f=.5))

plot(hypox.area$area.hypoxic~hypox.area$YR, type="b",
     ylab="Area of Hypoxia (km2)",
     xlab="")
grid(col="black")
lines(lowess(hypox.area$area.hypoxic~hypox.area$YR, f=.5))





attach(sum.la.S)
plot(y ~ x, pch=16)                
breaks <- x[which(x >= 1995 & x <= 2010)]

mse <- numeric(length(breaks))
for(i in 1:length(breaks)){
  piecewise1 <- lm(y ~ x*(x < breaks[i]) + x*(x>=breaks[i]))
  mse[i] <- summary(piecewise1)[6]
}
mse <- as.numeric(mse)
plot(mse~breaks)

breaks[which(mse==min(mse))]

piecewise2 <- lm(y ~ x*(x < 1997) + x*(x > 1997))
summary(piecewise2)
detach(sum.la.S)


attach(sum.la.J)
plot(y ~ x, pch=16)                
breaks <- x[which(x >= 1995 & x <= 2005)]

mse <- numeric(length(breaks))
for(i in 1:length(breaks)){
  piecewise1 <- lm(y ~ x*(x < breaks[i]) + x*(x>=breaks[i]))
  mse[i] <- summary(piecewise1)[6]
}
mse <- as.numeric(mse)
plot(mse~breaks)

breaks[which(mse==min(mse))]

piecewise2 <- lm(y ~ x*(x < 2000) + x*(x > 2000))
summary(piecewise2)
detach(sum.la.J)                


attach(sum.la.d)
  plot(y ~ x, pch=16)                
  breaks <- x[which(x >= 1995 & x <= 2010)]
                
  mse <- numeric(length(breaks))
  for(i in 1:length(breaks)){
      piecewise1 <- lm(y ~ x*(x < breaks[i]) + x*(x>=breaks[i]))
      mse[i] <- summary(piecewise1)[6]
      }
  mse <- as.numeric(mse)
  plot(mse~breaks)
                
  breaks[which(mse==min(mse))]
                
  piecewise2 <- lm(y ~ x*(x < 2000) + x*(x > 2000))
  summary(piecewise2)
detach(sum.la.d)


attach(sum.la.shan)
plot(y ~ x, pch=16)                
breaks <- x[which(x >= 1995 & x <= 2010)]

mse <- numeric(length(breaks))
for(i in 1:length(breaks)){
  piecewise1 <- lm(y ~ x*(x < breaks[i]) + x*(x>=breaks[i]))
  mse[i] <- summary(piecewise1)[6]
}
mse <- as.numeric(mse)
plot(mse~breaks)

breaks[which(mse==min(mse))]

piecewise2 <- lm(y ~ x*(x < 2002) + x*(x > 2002))
summary(piecewise2)
detach(sum.la.shan)


attach(sum.la.simp)
plot(y ~ x, pch=16)                
breaks <- x[which(x >= 1995 & x <= 2005)]

mse <- numeric(length(breaks))
for(i in 1:length(breaks)){
  piecewise1 <- lm(y ~ x*(x < breaks[i]) + x*(x>=breaks[i]))
  mse[i] <- summary(piecewise1)[6]
}
mse <- as.numeric(mse)
plot(mse~breaks)

breaks[which(mse==min(mse))]

piecewise2 <- lm(y ~ x*(x < 2002) + x*(x > 2002))
summary(piecewise2)
detach(sum.la.simp)


attach(sum.la.N1)
plot(y ~ x, pch=16)                
breaks <- x[which(x >= 1995 & x <= 2005)]

mse <- numeric(length(breaks))
for(i in 1:length(breaks)){
  piecewise1 <- lm(y ~ x*(x < breaks[i]) + x*(x>=breaks[i]))
  mse[i] <- summary(piecewise1)[6]
}
mse <- as.numeric(mse)
plot(mse~breaks)

breaks[which(mse==min(mse))]

piecewise2 <- lm(y ~ x*(x < 2002) + x*(x > 2002))
summary(piecewise2)
detach(sum.la.N1)


attach(sum.la.N2)
plot(y ~ x, pch=16)                
breaks <- x[which(x >= 1995 & x <= 2005)]

mse <- numeric(length(breaks))
for(i in 1:length(breaks)){
  piecewise1 <- lm(y ~ x*(x < breaks[i]) + x*(x>=breaks[i]))
  mse[i] <- summary(piecewise1)[6]
}
mse <- as.numeric(mse)
plot(mse~breaks)

breaks[which(mse==min(mse))]

piecewise2 <- lm(y ~ x*(x < 2003) + x*(x > 2003))
summary(piecewise2)
detach(sum.la.N2)

 

attach(sum.tx.S)
plot(y ~ x, pch=16)                
breaks <- x[which(x >= 1995 & x <= 2010)]

mse <- numeric(length(breaks))
for(i in 1:length(breaks)){
  piecewise1 <- lm(y ~ x*(x < breaks[i]) + x*(x>=breaks[i]))
  mse[i] <- summary(piecewise1)[6]
}
mse <- as.numeric(mse)
plot(mse~breaks)

breaks[which(mse==min(mse))]

piecewise2 <- lm(y ~ x*(x < 1999) + x*(x > 1999))
summary(piecewise2)
detach(sum.tx.S)

attach(sum.tx.N)
plot(y ~ x, pch=16)                
breaks <- x[which(x >= 1995 & x <= 2010)]

mse <- numeric(length(breaks))
for(i in 1:length(breaks)){
  piecewise1 <- lm(y ~ x*(x < breaks[i]) + x*(x>=breaks[i]))
  mse[i] <- summary(piecewise1)[6]
}
mse <- as.numeric(mse)
plot(mse~breaks)

breaks[which(mse==min(mse))]

piecewise2 <- lm(y ~ x*(x < 2003) + x*(x > 2003))
summary(piecewise2)
detach(sum.tx.N)


attach(sum.tx.J)
plot(y ~ x, pch=16)                
breaks <- x[which(x >= 1995 & x <= 2005)]

mse <- numeric(length(breaks))
for(i in 1:length(breaks)){
  piecewise1 <- lm(y ~ x*(x < breaks[i]) + x*(x>=breaks[i]))
  mse[i] <- summary(piecewise1)[6]
}
mse <- as.numeric(mse)
plot(mse~breaks)

breaks[which(mse==min(mse))]

piecewise2 <- lm(y ~ x*(x < 1999) + x*(x > 1999))
summary(piecewise2)
detach(sum.tx.J)                


attach(sum.tx.d)
plot(y ~ x, pch=16)                
breaks <- x[which(x >= 1995 & x <= 2010)]

mse <- numeric(length(breaks))
for(i in 1:length(breaks)){
  piecewise1 <- lm(y ~ x*(x < breaks[i]) + x*(x>=breaks[i]))
  mse[i] <- summary(piecewise1)[6]
}
mse <- as.numeric(mse)
plot(mse~breaks)

breaks[which(mse==min(mse))]

piecewise2 <- lm(y ~ x*(x < 2000) + x*(x > 2000))
summary(piecewise2)
detach(sum.tx.d)


attach(sum.tx.shan)
plot(y ~ x, pch=16)                
breaks <- x[which(x >= 1995 & x <= 2010)]

mse <- numeric(length(breaks))
for(i in 1:length(breaks)){
  piecewise1 <- lm(y ~ x*(x < breaks[i]) + x*(x>=breaks[i]))
  mse[i] <- summary(piecewise1)[6]
}
mse <- as.numeric(mse)
plot(mse~breaks)

breaks[which(mse==min(mse))]

piecewise2 <- lm(y ~ x*(x < 2001) + x*(x > 2001))
summary(piecewise2)
detach(sum.tx.shan)


attach(sum.tx.simp)
plot(y ~ x, pch=16)                
breaks <- x[which(x >= 1995 & x <= 2005)]

mse <- numeric(length(breaks))
for(i in 1:length(breaks)){
  piecewise1 <- lm(y ~ x*(x < breaks[i]) + x*(x>=breaks[i]))
  mse[i] <- summary(piecewise1)[6]
}
mse <- as.numeric(mse)
plot(mse~breaks)

breaks[which(mse==min(mse))]

piecewise2 <- lm(y ~ x*(x < 2000) + x*(x > 2000))
summary(piecewise2)
detach(sum.tx.simp)


attach(sum.tx.N1)
plot(y ~ x, pch=16)                
breaks <- x[which(x >= 1995 & x <= 2005)]

mse <- numeric(length(breaks))
for(i in 1:length(breaks)){
  piecewise1 <- lm(y ~ x*(x < breaks[i]) + x*(x>=breaks[i]))
  mse[i] <- summary(piecewise1)[6]
}
mse <- as.numeric(mse)
plot(mse~breaks)

breaks[which(mse==min(mse))]

piecewise2 <- lm(y ~ x*(x < 2001) + x*(x > 2001))
summary(piecewise2)
detach(sum.tx.N1)


attach(sum.tx.N2)
plot(y ~ x, pch=16)                
breaks <- x[which(x >= 1995 & x <= 2010)]

mse <- numeric(length(breaks))
for(i in 1:length(breaks)){
  piecewise1 <- lm(y ~ x*(x < breaks[i]) + x*(x>=breaks[i]))
  mse[i] <- summary(piecewise1)[6]
}
mse <- as.numeric(mse)
plot(mse~breaks)

breaks[which(mse==min(mse))]

piecewise2 <- lm(y ~ x*(x < 1999) + x*(x > 1999))
summary(piecewise2)
detach(sum.tx.N2)



attach(fall.la.S)
plot(y ~ x, pch=16)                
breaks <- x[which(x >= 1995 & x <= 2010)]

mse <- numeric(length(breaks))
for(i in 1:length(breaks)){
  piecewise1 <- lm(y ~ x*(x < breaks[i]) + x*(x>=breaks[i]))
  mse[i] <- summary(piecewise1)[6]
}
mse <- as.numeric(mse)
plot(mse~breaks)

breaks[which(mse==min(mse))]

piecewise2 <- lm(y ~ x*(x < 2001) + x*(x > 2001))
summary(piecewise2)
detach(fall.la.S)


attach(fall.la.N)
plot(y ~ x, pch=16)                
breaks <- x[which(x >= 1995 & x <= 2010)]

mse <- numeric(length(breaks))
for(i in 1:length(breaks)){
  piecewise1 <- lm(y ~ x*(x < breaks[i]) + x*(x>=breaks[i]))
  mse[i] <- summary(piecewise1)[6]
}
mse <- as.numeric(mse)
plot(mse~breaks)

breaks[which(mse==min(mse))]

piecewise2 <- lm(y ~ x*(x < 1998) + x*(x > 1998))
summary(piecewise2)
detach(fall.la.N)


attach(fall.la.J)
plot(y ~ x, pch=16)                
breaks <- x[which(x >= 1995 & x <= 2005)]

mse <- numeric(length(breaks))
for(i in 1:length(breaks)){
  piecewise1 <- lm(y ~ x*(x < breaks[i]) + x*(x>=breaks[i]))
  mse[i] <- summary(piecewise1)[6]
}
mse <- as.numeric(mse)
plot(mse~breaks)

breaks[which(mse==min(mse))]

piecewise2 <- lm(y ~ x*(x < 1999) + x*(x > 1999))
summary(piecewise2)
detach(fall.la.J)                


attach(fall.la.d)
plot(y ~ x, pch=16)                
breaks <- x[which(x >= 1995 & x <= 2010)]

mse <- numeric(length(breaks))
for(i in 1:length(breaks)){
  piecewise1 <- lm(y ~ x*(x < breaks[i]) + x*(x>=breaks[i]))
  mse[i] <- summary(piecewise1)[6]
}
mse <- as.numeric(mse)
plot(mse~breaks)

breaks[which(mse==min(mse))]

piecewise2 <- lm(y ~ x*(x < 2001) + x*(x > 2001))
summary(piecewise2)
detach(fall.la.d)


attach(fall.la.shan)
plot(y ~ x, pch=16)                
breaks <- x[which(x >= 1995 & x <= 2005)]

mse <- numeric(length(breaks))
for(i in 1:length(breaks)){
  piecewise1 <- lm(y ~ x*(x < breaks[i]) + x*(x>=breaks[i]))
  mse[i] <- summary(piecewise1)[6]
}
mse <- as.numeric(mse)
plot(mse~breaks)

breaks[which(mse==min(mse))]

piecewise2 <- lm(y ~ x*(x < 2003) + x*(x > 2003))
summary(piecewise2)
detach(fall.la.shan)


attach(fall.la.simp)
plot(y ~ x, pch=16)                
breaks <- x[which(x >= 1995 & x <= 2005)]

mse <- numeric(length(breaks))
for(i in 1:length(breaks)){
  piecewise1 <- lm(y ~ x*(x < breaks[i]) + x*(x>=breaks[i]))
  mse[i] <- summary(piecewise1)[6]
}
mse <- as.numeric(mse)
plot(mse~breaks)

breaks[which(mse==min(mse))]

piecewise2 <- lm(y ~ x*(x < 2002) + x*(x > 2002))
summary(piecewise2)
detach(fall.la.simp)


attach(fall.la.N1)
plot(y ~ x, pch=16)                
breaks <- x[which(x >= 1995 & x <= 2005)]

mse <- numeric(length(breaks))
for(i in 1:length(breaks)){
  piecewise1 <- lm(y ~ x*(x < breaks[i]) + x*(x>=breaks[i]))
  mse[i] <- summary(piecewise1)[6]
}
mse <- as.numeric(mse)
plot(mse~breaks)

breaks[which(mse==min(mse))]

piecewise2 <- lm(y ~ x*(x < 2003) + x*(x > 2003))
summary(piecewise2)
detach(fall.la.N1)


attach(fall.la.N2)
plot(y ~ x, pch=16)                
breaks <- x[which(x >= 1995 & x <= 2005)]

mse <- numeric(length(breaks))
for(i in 1:length(breaks)){
  piecewise1 <- lm(y ~ x*(x < breaks[i]) + x*(x>=breaks[i]))
  mse[i] <- summary(piecewise1)[6]
}
mse <- as.numeric(mse)
plot(mse~breaks)

breaks[which(mse==min(mse))]

piecewise2 <- lm(y ~ x*(x < 2002) + x*(x > 2002))
summary(piecewise2)
detach(fall.la.N2)



attach(fall.tx.S)
plot(y ~ x, pch=16)                
breaks <- x[which(x >= 1995 & x <= 2005)]

mse <- numeric(length(breaks))
for(i in 1:length(breaks)){
  piecewise1 <- lm(y ~ x*(x < breaks[i]) + x*(x>=breaks[i]))
  mse[i] <- summary(piecewise1)[6]
}
mse <- as.numeric(mse)
plot(mse~breaks)

breaks[which(mse==min(mse))]

piecewise2 <- lm(y ~ x*(x < 2001) + x*(x > 2001))
summary(piecewise2)
detach(fall.tx.S)

attach(fall.tx.N)
plot(y ~ x, pch=16)                
breaks <- x[which(x >= 1995 & x <= 2010)]

mse <- numeric(length(breaks))
for(i in 1:length(breaks)){
  piecewise1 <- lm(y ~ x*(x < breaks[i]) + x*(x>=breaks[i]))
  mse[i] <- summary(piecewise1)[6]
}
mse <- as.numeric(mse)
plot(mse~breaks)

breaks[which(mse==min(mse))]

piecewise2 <- lm(y ~ x*(x < 2005) + x*(x > 2005))
summary(piecewise2)
detach(fall.tx.N)


attach(fall.tx.J)
plot(y ~ x, pch=16)                
breaks <- x[which(x >= 1995 & x <= 2010)]

mse <- numeric(length(breaks))
for(i in 1:length(breaks)){
  piecewise1 <- lm(y ~ x*(x < breaks[i]) + x*(x>=breaks[i]))
  mse[i] <- summary(piecewise1)[6]
}
mse <- as.numeric(mse)
plot(mse~breaks)

breaks[which(mse==min(mse))]

piecewise2 <- lm(y ~ x*(x < 1998) + x*(x > 1998))
summary(piecewise2)
detach(fall.tx.J)                


attach(fall.tx.d)
plot(y ~ x, pch=16)                
breaks <- x[which(x >= 1995 & x <= 2010)]

mse <- numeric(length(breaks))
for(i in 1:length(breaks)){
  piecewise1 <- lm(y ~ x*(x < breaks[i]) + x*(x>=breaks[i]))
  mse[i] <- summary(piecewise1)[6]
}
mse <- as.numeric(mse)
plot(mse~breaks)

breaks[which(mse==min(mse))]

piecewise2 <- lm(y ~ x*(x < 2000) + x*(x > 2000))
summary(piecewise2)
detach(fall.tx.d)


attach(fall.tx.shan)
plot(y ~ x, pch=16)                
breaks <- x[which(x >= 1995 & x <= 2010)]

mse <- numeric(length(breaks))
for(i in 1:length(breaks)){
  piecewise1 <- lm(y ~ x*(x < breaks[i]) + x*(x>=breaks[i]))
  mse[i] <- summary(piecewise1)[6]
}
mse <- as.numeric(mse)
plot(mse~breaks)

breaks[which(mse==min(mse))]

piecewise2 <- lm(y ~ x*(x < 2000) + x*(x > 2000))
summary(piecewise2)
detach(fall.tx.shan)


attach(fall.tx.simp)
plot(y ~ x, pch=16)                
breaks <- x[which(x >= 1995 & x <= 2005)]

mse <- numeric(length(breaks))
for(i in 1:length(breaks)){
  piecewise1 <- lm(y ~ x*(x < breaks[i]) + x*(x>=breaks[i]))
  mse[i] <- summary(piecewise1)[6]
}
mse <- as.numeric(mse)
plot(mse~breaks)

breaks[which(mse==min(mse))]

piecewise2 <- lm(y ~ x*(x < 1999) + x*(x > 1999))
summary(piecewise2)
detach(fall.tx.simp)


attach(fall.tx.N1)
plot(y ~ x, pch=16)                
breaks <- x[which(x >= 1995 & x <= 2010)]

mse <- numeric(length(breaks))
for(i in 1:length(breaks)){
  piecewise1 <- lm(y ~ x*(x < breaks[i]) + x*(x>=breaks[i]))
  mse[i] <- summary(piecewise1)[6]
}
mse <- as.numeric(mse)
plot(mse~breaks)

breaks[which(mse==min(mse))]

piecewise2 <- lm(y ~ x*(x < 2000) + x*(x > 2000))
summary(piecewise2)
detach(fall.tx.N1)


attach(fall.tx.N2)
plot(y ~ x, pch=16)                
breaks <- x[which(x >= 1995 & x <= 2010)]

mse <- numeric(length(breaks))
for(i in 1:length(breaks)){
  piecewise1 <- lm(y ~ x*(x < breaks[i]) + x*(x>=breaks[i]))
  mse[i] <- summary(piecewise1)[6]
}
mse <- as.numeric(mse)
plot(mse~breaks)

breaks[which(mse==min(mse))]

piecewise2 <- lm(y ~ x*(x < 1999) + x*(x > 1999))
summary(piecewise2)
detach(fall.tx.N2)


#package methods

library(segmented)

lin.mod<-lm(y~x, data=sum.la.S)
segmented.mod<-segmented(lin.mod, seg.Z=~x, psi=1999)

plot(y ~ x, data=sum.la.S, pch=16) 
plot(segmented.mod$fitted.values~segmented.mod$coefficients)