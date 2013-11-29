#Texas Metrics Figure


windows(width=12,height=8,record=T)
par(mfrow=c(2,4),oma=c(0,0,3,1))
#1  
plot(sum.tx.agg$YR, sum.tx.agg$S,
     lty=1, 
     type="b", 
     pch=21,
     xlab="Year",
     ylab="# of Species")
lines(fall.tx.agg$YR, fall.tx.agg$S,
      lty=2,
      type="b",
      pch=24)
legend("bottomleft",lty=c(1,2), pch=c(21,24),legend=c("Fall","Summer"), bty="n")
#2  
plot(sum.tx.agg$YR, sum.tx.agg$d,
     lty=1, 
     type="b", 
     pch=21,
     xlab="Year",
     ylab="Margalef's d (richness)",
     ylim=c(4,5.5))
lines(fall.tx.agg$YR, fall.tx.agg$d,
      lty=2,
      type="b",
      pch=24)
legend("bottomleft",lty=c(1,2), pch=c(21,24),legend=c("Fall","Summer"), bty="n")
#3  
plot(sum.tx.agg$YR, sum.tx.agg$J,
     lty=1, 
     type="b", 
     pch=21,
     xlab="Year",
     ylab="Eveness",
     ylim=c(0.3,0.9))
lines(fall.tx.agg$YR, fall.tx.agg$J,
      lty=2,
      type="b",
      pch=24)
legend("bottomleft",lty=c(1,2), pch=c(21,24),legend=c("Fall","Summer"), bty="n")
#4  
plot(sum.tx.agg$YR, sum.tx.agg$shan,
     lty=1, 
     type="b", 
     pch=21,
     xlab="Year",
     ylab="Shannon",
     ylim=c(1,4))
lines(fall.tx.agg$YR, fall.tx.agg$shan,
      lty=2,
      type="b",
      pch=24)
legend("bottomleft",lty=c(1,2), pch=c(21,24),legend=c("Fall","Summer"), bty="n")
#5  
plot(sum.tx.agg$YR, sum.tx.agg$simp,
     lty=1, 
     type="b", 
     pch=21,
     xlab="Year",
     ylab="Simp",
     ylim=c(0.5,1))
lines(fall.tx.agg$YR, fall.tx.agg$simp,
      lty=2,
      type="b",
      pch=24)
legend("bottomleft",lty=c(1,2), pch=c(21,24),legend=c("Fall","Summer"), bty="n")
#6  
plot(sum.tx.agg$YR, sum.tx.agg$N1,
     lty=1, 
     type="b", 
     pch=21,
     xlab="Year",
     ylab="Hill's N1",
     ylim=c(4,26))
lines(fall.tx.agg$YR, fall.tx.agg$N1,
      lty=2,
      type="b",
      pch=24)
legend("bottomleft",lty=c(1,2), pch=c(21,24),legend=c("Fall","Summer"), bty="n")
#7  
plot(sum.tx.agg$YR, sum.tx.agg$N2,
     lty=1, 
     type="b", 
     pch=21,
     xlab="Year",
     ylab="Hill's N2",
     ylim=c(1,2))
lines(fall.tx.agg$YR, fall.tx.agg$N2,
      lty=2,
      type="b",
      pch=24)
legend("topleft",lty=c(1,2), pch=c(21,24),legend=c("Fall","Summer"), bty="n")


mtext("Texas", side=3, line=1, outer=T, cex=2, font=2)
###
###
###