#plotting a 4 panel graphic
# w/o points for each univariate metric
# but with lowess smoothed lines
source("C:\\Users\\Kevin.Purcell\\Documents\\GitHub\\EcosysMetricsGOM\\functions\\divNorm.R")

sum.la.agg2<-divNorm(sum.la.agg)
sum.tx.agg2<-divNorm(sum.tx.agg)
fall.la.agg2<-divNorm(fall.la.agg)
fall.tx.agg2<-divNorm(fall.tx.agg)

#plot
#la summer
par(mfrow=c(2,2))
plot(sum.la.agg2$S.norm~sum.la.agg2$YR, pch="",
     main="Louisiana Summer",
     xlab="Year",
     ylab="Normalized value",
     ylim=c(0.5,1.2))
#points(sum.la.agg2$N.norm.mean~sum.la.agg2$YR, type="p", pch=2)
lines(lowess(sum.la.agg2$d.norm~sum.la.agg2$YR), lty=1, col=26, lwd=1.8)
lines(lowess(sum.la.agg2$J.norm~sum.la.agg2$YR), lty=2, col=51, lwd=1.8)
lines(lowess(sum.la.agg2$shan.norm~sum.la.agg2$YR), lty=3, col=76, lwd=1.8)
lines(lowess(sum.la.agg2$simp.norm~sum.la.agg2$YR), lty=4, col=101, lwd=1.8)
lines(lowess(sum.la.agg2$N1.norm~sum.la.agg2$YR), lty=5, col=126, lwd=1.8)
lines(lowess(sum.la.agg2$N2.norm~sum.la.agg2$YR), lty=6, col=151, lwd=1.8)
grid(col="lightgrey")

#la fall
plot(fall.la.agg2$S.norm~fall.la.agg2$YR, pch="",
     main="Louisiana Fall",
     xlab="Year",
     ylab="Normalized value",
     ylim=c(0.2,1.5))
#points(fall.la.agg2$N.norm.mean~fall.la.agg2$YR, type="p", pch=2)
lines(lowess(fall.la.agg2$d.norm~fall.la.agg2$YR), lty=1, col=26, lwd=1.8)
lines(lowess(fall.la.agg2$J.norm~fall.la.agg2$YR), lty=2, col=51, lwd=1.8)
lines(lowess(fall.la.agg2$shan.norm~fall.la.agg2$YR), lty=3, col=76, lwd=1.8)
lines(lowess(fall.la.agg2$simp.norm~fall.la.agg2$YR), lty=4, col=101, lwd=1.8)
lines(lowess(fall.la.agg2$N1.norm~fall.la.agg2$YR), lty=5, col=126, lwd=1.8)
lines(lowess(fall.la.agg2$N2.norm~fall.la.agg2$YR), lty=6, col=151, lwd=1.8)
grid(col="lightgrey")
# abline(v=2003,col=4,lty=2)
# abline(v=1996,col=9,lty=2) #hypoxia
# rect(1998,0,2003,2, density=20, col="grey",
#      angle=-30, border="transparent") 

#tx summer
plot(sum.tx.agg2$S.norm~sum.tx.agg2$YR, pch="",
     main="Texas Summer",
     xlab="Year",
     ylab="Normalized value",
     ylim=c(0.6,1.2))
#points(sum.tx.agg2$N.norm.mean~sum.tx.agg2$YR, type="p", pch=2)
lines(lowess(sum.tx.agg2$d.norm~sum.tx.agg2$YR), lty=1, col=26, lwd=1.8)
lines(lowess(sum.tx.agg2$J.norm~sum.tx.agg2$YR), lty=2, col=51, lwd=1.8)
lines(lowess(sum.tx.agg2$shan.norm~sum.tx.agg2$YR), lty=3, col=76, lwd=1.8)
lines(lowess(sum.tx.agg2$simp.norm~sum.tx.agg2$YR), lty=4, col=101, lwd=1.8)
lines(lowess(sum.tx.agg2$N1.norm~sum.tx.agg2$YR), lty=5, col=126, lwd=1.8)
lines(lowess(sum.tx.agg2$N2.norm~sum.tx.agg2$YR), lty=6, col=151, lwd=1.8)
grid(col="lightgrey")
# abline(v=2003,col=4,lty=2)
# abline(v=1996,col=9,lty=2) #hypoxia
# rect(1999,0,2003,2, density=20, col="grey",
#      angle=-30, border="transparent") 

#tx fall
plot(fall.tx.agg2$S.norm~fall.tx.agg2$YR, pch="",
     main="Texas Fall",
     xlab="Year",
     ylab="Normalized value",
     ylim=c(0.6,1.2))
#points(fall.tx.agg2$N.norm.mean~fall.tx.agg2$YR, type="p", pch=2)
lines(lowess(fall.tx.agg2$d.norm~fall.tx.agg2$YR), lty=1, col=26, lwd=1.8)
lines(lowess(fall.tx.agg2$J.norm~fall.tx.agg2$YR), lty=2, col=51, lwd=1.8)
lines(lowess(fall.tx.agg2$shan.norm~fall.tx.agg2$YR), lty=3, col=76, lwd=1.8)
lines(lowess(fall.tx.agg2$simp.norm~fall.tx.agg2$YR), lty=4, col=101, lwd=1.8)
lines(lowess(fall.tx.agg2$N1.norm~fall.tx.agg2$YR), lty=5, col=126, lwd=1.8)
lines(lowess(fall.tx.agg2$N2.norm~fall.tx.agg2$YR), lty=6, col=151, lwd=1.8)
grid(col="lightgrey")
# abline(v=2003,col=4,lty=2)
# abline(v=1996,col=9,lty=2) #hypoxia
# rect(1998,0,2005,2, density=20, col="grey",
#      angle=-30, border="transparent") 