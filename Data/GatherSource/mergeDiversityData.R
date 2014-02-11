# Script for merging datasets for Diversity analysis and limiting full data.frame
# KM Purcell
# updated: 2014-2-11


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