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
# Generate total counts for each species and common name
cnt.tab<-aggregate(ST_CNTEXP ~ TAXONOMIC + common_name, data=complete.dat, FUN=sum)

# Generate total biomass for each taxonomic name
bio.tab<-aggregate(ST_SELECT_BGS ~ TAXONOMIC , data=complete.dat, FUN=sum)

# Generate a number of years present perhaps add a row total to cnt.tab

# Calculate of percentage of total biomass 
# Calculate a percentage of stations??? trick this far down stream???

# Abbreviated habitat designator (Benthic Pelagic Invert) Do we need to include??



complete.tab<-merge(cnt.tab, bio.tab, by.x="TAXONOMIC")
table<-orderBy(~-ST_SELECT_BGS, data=complete.tab)
pandoc.table(table)
head(table)











