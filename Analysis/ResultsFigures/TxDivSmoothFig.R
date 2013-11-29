# Texas Loess Smooth Figures

windows(width=14,height=8,record=T)
par(mfrow=c(2,4),oma=c(0,0,3,1))

plot(sum.tx.agg$YR, sum.tx.agg$S, 
     type="p", 
     pch=21,
     xlab="Year",
     ylab="# of Species")
lines(fall.tx.agg$YR, fall.tx.agg$S,
      type="p",
      pch=24)
lines(lowess(sum.tx.agg$S~sum.tx.agg$YR), lty=1)
lines(lowess(fall.tx.agg$S~fall.tx.agg$YR), lty=2)
grid(col="gray")
legend("topright",lty=c(1,2), pch=c(21,24),legend=c("Summer","Fall"), bty="n")

plot(sum.tx.agg$YR, sum.tx.agg$d, 
     type="p", 
     pch=21,
     xlab="Year",
     ylab="Margalef's d (richness)",
     ylim=c(4.3,5.6))
lines(fall.tx.agg$YR, fall.tx.agg$d,
      type="p",
      pch=24)
lines(lowess(sum.tx.agg$d~sum.tx.agg$YR), lty=1)
lines(lowess(fall.tx.agg$d~fall.tx.agg$YR), lty=2)
grid(col="gray")
legend("topright",lty=c(1,2), pch=c(21,24),legend=c("Summer","Fall"), bty="n")

plot(sum.tx.agg$YR, sum.tx.agg$J, 
     type="p", 
     pch=21,
     xlab="Year",
     ylab="Pielou's J (eveness)")
lines(fall.tx.agg$YR, fall.tx.agg$J,
      type="p",
      pch=24)
lines(lowess(sum.tx.agg$J~sum.tx.agg$YR), lty=1)
lines(lowess(fall.tx.agg$J~fall.tx.agg$YR), lty=2)
grid(col="gray")
legend("bottomright",lty=c(1,2), pch=c(21,24),legend=c("Summer","Fall"), bty="n")

plot(sum.tx.agg$YR, sum.tx.agg$shan, 
     type="p", 
     pch=21,
     xlab="Year",
     ylab="Shannon's Diversity")
lines(fall.tx.agg$YR, fall.tx.agg$shan,
      type="p",
      pch=24)
lines(lowess(sum.tx.agg$shan~sum.tx.agg$YR), lty=1)
lines(lowess(fall.tx.agg$shan~fall.tx.agg$YR), lty=2)
grid(col="gray")
legend("bottomright",lty=c(1,2), pch=c(21,24),legend=c("Summer","Fall"), bty="n")

plot(sum.tx.agg$YR, sum.tx.agg$simp, 
     type="p", 
     pch=21,
     xlab="Year",
     ylab="Simpson's Index")
lines(fall.tx.agg$YR, fall.tx.agg$simp,
      type="p",
      pch=24)
lines(lowess(sum.tx.agg$simp~sum.tx.agg$YR), lty=1)
lines(lowess(fall.tx.agg$simp~fall.tx.agg$YR), lty=2)
grid(col="gray")
legend("bottomright",lty=c(1,2), pch=c(21,24),legend=c("Summer","Fall"), bty="n")

plot(sum.tx.agg$YR, sum.tx.agg$N1, 
     type="p", 
     pch=21,
     xlab="Year",
     ylab="Hill's N1",
     ylim=c(10,27))
lines(fall.tx.agg$YR, fall.tx.agg$N1,
      type="p",
      pch=24)
lines(lowess(sum.tx.agg$N1~sum.tx.agg$YR), lty=1)
lines(lowess(fall.tx.agg$N1~fall.tx.agg$YR), lty=2)
grid(col="gray")
legend("topright",lty=c(1,2), pch=c(21,24),legend=c("Summer","Fall"), bty="n")

plot(sum.tx.agg$YR, sum.tx.agg$N2, 
     type="p", 
     pch=21,
     xlab="Year",
     ylab="Hill's N2")
lines(fall.tx.agg$YR, fall.tx.agg$N2,
      type="p",
      pch=24)
lines(lowess(sum.tx.agg$N2~sum.tx.agg$YR), lty=1)
lines(lowess(fall.tx.agg$N2~fall.tx.agg$YR), lty=2)
grid(col="gray")
legend("topright",lty=c(1,2), pch=c(21,24),legend=c("Summer","Fall"), bty="n")

mtext("Texas Smooths", side=3, line=1, outer=T, cex=2, font=2)
###
###
###