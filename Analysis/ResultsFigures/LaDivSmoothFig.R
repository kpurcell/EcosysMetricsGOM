# Louisiana Loess Smooth Figures

windows(width=14,height=8,record=T)
par(mfrow=c(2,4),oma=c(0,0,3,1))

plot(sum.la.agg$YR, sum.la.agg$S, 
     type="p", 
     pch=21,
     xlab="Year",
     ylab="# of Species")
lines(fall.la.agg$YR, fall.la.agg$S,
      type="p",
      pch=24)
lines(lowess(sum.la.agg$S~sum.la.agg$YR), lty=1)
lines(lowess(fall.la.agg$S~fall.la.agg$YR), lty=2)
grid(col="gray")
legend("bottomleft",lty=c(1,2), pch=c(21,24),legend=c("Summer","Fall"), bty="n")

plot(sum.la.agg$YR, sum.la.agg$d, 
     type="p", 
     pch=21,
     xlab="Year",
     ylab="Margalef's d (richness)")
lines(fall.la.agg$YR, fall.la.agg$d,
      type="p",
      pch=24)
lines(lowess(sum.la.agg$d~sum.la.agg$YR), lty=1)
lines(lowess(fall.la.agg$d~fall.la.agg$YR), lty=2)
grid(col="gray")
legend("topright",lty=c(1,2), pch=c(21,24),legend=c("Summer","Fall"), bty="n")

plot(sum.la.agg$YR, sum.la.agg$J, 
     type="p", 
     pch=21,
     xlab="Year",
     ylab="Pielou's J (eveness)")
lines(fall.la.agg$YR, fall.la.agg$J,
      type="p",
      pch=24)
lines(lowess(sum.la.agg$J~sum.la.agg$YR), lty=1)
lines(lowess(fall.la.agg$J~fall.la.agg$YR), lty=2)
grid(col="gray")
legend("topright",lty=c(1,2), pch=c(21,24),legend=c("Summer","Fall"), bty="n")

plot(sum.la.agg$YR, sum.la.agg$shan, 
     type="p", 
     pch=21,
     xlab="Year",
     ylab="Shannon's Diversity")
lines(fall.la.agg$YR, fall.la.agg$shan,
      type="p",
      pch=24)
lines(lowess(sum.la.agg$shan~sum.la.agg$YR), lty=1)
lines(lowess(fall.la.agg$shan~fall.la.agg$YR), lty=2)
grid(col="gray")
legend("topright",lty=c(1,2), pch=c(21,24),legend=c("Summer","Fall"), bty="n")

plot(sum.la.agg$YR, sum.la.agg$simp, 
     type="p", 
     pch=21,
     xlab="Year",
     ylab="Simpson's Index")
lines(fall.la.agg$YR, fall.la.agg$simp,
      type="p",
      pch=24)
lines(lowess(sum.la.agg$simp~sum.la.agg$YR), lty=1)
lines(lowess(fall.la.agg$simp~fall.la.agg$YR), lty=2)
grid(col="gray")
legend("topright",lty=c(1,2), pch=c(21,24),legend=c("Summer","Fall"), bty="n")

plot(sum.la.agg$YR, sum.la.agg$N1, 
     type="p", 
     pch=21,
     xlab="Year",
     ylab="Hill's N1")
lines(fall.la.agg$YR, fall.la.agg$N1,
      type="p",
      pch=24)
lines(lowess(sum.la.agg$N1~sum.la.agg$YR), lty=1)
lines(lowess(fall.la.agg$N1~fall.la.agg$YR), lty=2)
grid(col="gray")
legend("topright",lty=c(1,2), pch=c(21,24),legend=c("Summer","Fall"), bty="n")

plot(sum.la.agg$YR, sum.la.agg$N2, 
     type="p", 
     pch=21,
     xlab="Year",
     ylab="Hill's N2")
lines(fall.la.agg$YR, fall.la.agg$N2,
      type="p",
      pch=24)
lines(lowess(sum.la.agg$N2~sum.la.agg$YR), lty=1)
lines(lowess(fall.la.agg$N2~fall.la.agg$YR), lty=2)
grid(col="gray")
legend("topleft",lty=c(1,2), pch=c(21,24),legend=c("Summer","Fall"), bty="n")

mtext("Louisiana Smooths", side=3, line=1, outer=T, cex=2, font=2)
###
###
###