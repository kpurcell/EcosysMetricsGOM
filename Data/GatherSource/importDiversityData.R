###Data Import and prep Diversity calcs downstream analysis
# KM Purcell
# updated: 2014-2-11


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

envrec.dat <- read.csv("C:/Users/kevin.purcell/Documents/seamap_2013/ENVREC.csv")
envrec.dat <- envrec.dat[,c(1:31)]

invrec.dat <- read.csv("C:/Users/kevin.purcell/Documents/seamap_2013/INVREC.csv")
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