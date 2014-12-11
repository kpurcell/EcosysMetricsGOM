# Matrix plot of species abundance
# 2013-5-21
# Script objective: To import SEAMAP data, calculate cpue (biomass)
# plot a color matrix of abundance and species(in trophic order)


#Clear the junk
graphics.off()
rm(list=ls(all=TRUE))

#Change working directory to the project folder
setwd("C:/Users/kevin.purcell/Documents/comm_analysis/matrix_plot_update")

#load packages
library(reshape)
library(lattice)
library(MASS)

###Data Import and limiting source files########
starec.dat <- read.csv("C:/Users/kevin.purcell/Documents/seamap_2013/STAREC.csv")

#create a yr and month variable
starec.dat$date<-starec.dat$MO_DAY_YR
starec.dat$date<-as.Date(starec.dat$date, "%m/%d/%Y")
starec.dat$month<-format(starec.dat$date, format="%m")
starec.dat$YR<-format(starec.dat$date, format="%Y")
starec.dat$YR<-as.numeric(starec.dat$YR)
starec.dat$month<-as.numeric(starec.dat$month)

#ditch the columns that screw stuff up.
starec.dat <- starec.dat[,c(1:7, 14:17, 24:33, 36:40, 42:51)]  
starec.dat$STAT_ZONE[starec.dat$STAT_ZONE==(-9)]=NA
starec.dat<- subset(starec.dat, starec.dat$STAT_ZONE!='NA') #ditch NAs for min fish
starec.dat<- subset(starec.dat, starec.dat$STAT_ZONE>=1&starec.dat$STAT_ZONE<=21)
summary(starec.dat)

# envrec.dat <- read.csv("C:/Users/kevin.purcell/Documents/seamap_2013/ENVREC.csv")
# names(envrec.dat)
# envrec.dat <- envrec.dat[,c(1:31)]

invrec.dat <- read.csv("C:/Users/kevin.purcell/Documents/seamap_2013/INVREC.csv")
names(invrec.dat)
invrec.dat <- invrec.dat[,c(2,11)]

bgsrec.dat<- read.csv("C:/Users/kevin.purcell/Documents/seamap_2013/BGSREC.csv")

specinfo.dat<-read.csv("C:/Users/kevin.purcell/Documents/comm_analysis/spec_info_summary.csv")
colnames(specinfo.dat)[1]<-'BIO_BGS'

bycatch.dat<-read.csv("C:/Users/kevin.purcell/Documents/comm_analysis/bycatch_status.csv")
bycatch.dat$TAXONOMIC<-NULL
bycatch.dat$common_name<-NULL
specinfo.dat<-merge(specinfo.dat, bycatch.dat, by="BIO_BGS", all.x=T)

# This is the fish we want to focus on
jkc.fish<-read.csv("C:/Users/kevin.purcell/Documents/comm_analysis/seamap_keepers_comm_analysis.csv")  #list of species of importance

info.dat<-merge(jkc.fish, specinfo.dat, by="BIO_BGS")
write.csv(info.dat, file="C:/Users/kevin.purcell/Documents/comm_analysis/matrix_plot/infoDat.csv")

#####
# Take the bgs record and merge with jkc.fish to narrow to only species of interest
bgsrec.dat2<-merge(bgsrec.dat, jkc.fish, by="BIO_BGS") #merge with the list of keepers
bgsrec.dat2<-merge(bgsrec.dat2, specinfo.dat, by="BIO_BGS") #tags each bsg record as p or d
bgsrec.dat2<-merge(bgsrec.dat2, invrec.dat, by=intersect(names(bgsrec.dat2), names(invrec.dat)))
bgsrec.dat2<-merge(bgsrec.dat2, starec.dat, by=intersect(names(bgsrec.dat2), names(starec.dat)))
# table<-merge(jkc.fish, specinfo.dat, by="BIO_BGS")
# write.table(table,"spec_list_review.csv",sep=",",row.names=T,col.names=T,quote=F) #changed this to row.names TRUE


# Limit data sets
bgsrec.dat2<-subset(bgsrec.dat2, bgsrec.dat2$VESSEL_SPD!='NA') #ditch NAs for spd
bgsrec.dat2<-subset(bgsrec.dat2, bgsrec.dat2$VESSEL_SPD<30) # ditch the vessel speed marked as 30
bgsrec.dat2<-subset(bgsrec.dat2, bgsrec.dat2$VESSEL_SPD>0)
bgsrec.dat2<-subset(bgsrec.dat2, bgsrec.dat2$YR>=1987&bgsrec.dat2$YR<=2011)  #focus on good data years
# might want to standardize to a standard tow duration 

#relabel min_fish -9 to NA
bgsrec.dat2$MIN_FISH[bgsrec.dat2$MIN_FISH==(-9)]=NA
bgsrec.dat2<- subset(bgsrec.dat2, bgsrec.dat2$MIN_FISH!='NA') #ditch NAs for min fish
bgsrec.dat2<- subset(bgsrec.dat2, bgsrec.dat2$MIN_FISH<=200)

#calculate median tow time
st.tow<-median(bgsrec.dat2$MIN_FISH)

#calculate effort vector for each catch entry
bgsrec.dat2$effort<-(bgsrec.dat2$MIN_FISH*bgsrec.dat2$VESSEL_SPD)

bgsrec.dat2$wt_per_min<-(bgsrec.dat2$SELECT_BGS/bgsrec.dat2$MIN_FISH)
bgsrec.dat2$c_per_min<-(bgsrec.dat2$CNTEXP/bgsrec.dat2$MIN_FISH)
bgsrec.dat2$ST_SELECT_BGS<-(bgsrec.dat2$wt_per_min*st.tow)
bgsrec.dat2$ST_CNTEXP<-(bgsrec.dat2$c_per_min*st.tow)

#make proportions??

#calculate effort vector for each catch entry
# biomass based cpue
bgsrec.dat2$cpue<-bgsrec.dat2$ST_SELECT_BGS/bgsrec.dat2$effort
# abundance based cpue
bgsrec.dat2$catch_cpue<-bgsrec.dat2$ST_CNTEXP/bgsrec.dat2$effort
names(bgsrec.dat2)
length(unique(bgsrec.dat2$BIO_BGS))

bgsrec.dat2$label<- paste(bgsrec.dat2$Trophic_Level, bgsrec.dat2$TAXONOMIC, sep=".")
 
save.image(file="matrix_data_2013-7-3.RData")



