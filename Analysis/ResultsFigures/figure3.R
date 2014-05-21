#plotting a 4 panel graphic
# w/o points for each univariate metric
# but with lowess smoothed lines
source("C:\\Users\\Kevin.Purcell\\Documents\\GitHub\\EcosysMetricsGOM\\functions\\divNorm.R")
#calculate the indicies
sum.la.agg2<-divNorm(sum.la.agg)
sum.tx.agg2<-divNorm(sum.tx.agg)
fall.la.agg2<-divNorm(fall.la.agg)
fall.tx.agg2<-divNorm(fall.tx.agg)
# add a group column for ggplot data frame
sum.la.agg2$group<-"Louisiana Summer"
sum.tx.agg2$group<-"Texas Summer"
fall.la.agg2$group<-"Louisiana Fall"
fall.tx.agg2$group<-"Texas Fall"

# combine data to a single frame
fig3.dat<-rbind(sum.la.agg2, sum.tx.agg2, fall.la.agg2, fall.tx.agg2)
#drop indicators not being used
fig3.dat$N1.norm<-NULL
fig3.dat$N2.norm<-NULL

# load packages
library(reshape)
library(ggplot2)

# reshape data to long form
fig3.dat<-melt(fig3.dat, id=c("YR", "group"))

# Generate figure 3
fig3<-ggplot(fig3.dat, aes(YR, value, color=variable)) +
        labs(y="Normalized Values", x="Year") +
        ylim(0.6, 1.2) +
        #geom_point() +
        geom_smooth(fill=NA, size=1, aes(linetype=variable)) +
        facet_grid(.~group) +
        #facet_grid(group ~ .) +
        #theme_bw()
        theme_minimal()
ggsave(file="figure3.pdf", fig3, width=12, height=3)

# # pdf(file="C:\\Users\\Kevin.Purcell\\Documents\\GitHub\\EcosysMetricsGOM\\Presentation\\Article\\figure1.pdf")   
# 
# #plot
# #la summer
# par(mfrow=c(2,2))
# plot(sum.la.agg2$S.norm~sum.la.agg2$YR, pch="",
#      #main="Louisiana Summer",
#      xlab="Year",
#      ylab="Normalized value",
#      ylim=c(0.6,1.2))
# rect(2000,0.6,2004,1.2, col="grey", border="transparent")
# points(sum.la.agg2$d.norm~sum.la.agg2$YR, type="p", pch=0)
# points(sum.la.agg2$J.norm~sum.la.agg2$YR, type="p", pch=1)
# points(sum.la.agg2$shan.norm~sum.la.agg2$YR, type="p", pch=2)
# points(sum.la.agg2$simp.norm~sum.la.agg2$YR, type="p", pch=5)
# 
# 
# lines(lowess(sum.la.agg2$d.norm~sum.la.agg2$YR), lty=1, col=26, lwd=1.8)
# lines(lowess(sum.la.agg2$J.norm~sum.la.agg2$YR), lty=2, col=51, lwd=1.8)
# lines(lowess(sum.la.agg2$shan.norm~sum.la.agg2$YR), lty=3, col=76, lwd=1.8)
# lines(lowess(sum.la.agg2$simp.norm~sum.la.agg2$YR), lty=4, col=101, lwd=1.8)
# #lines(lowess(sum.la.agg2$N1.norm~sum.la.agg2$YR), lty=5, col=126, lwd=1.8)
# #lines(lowess(sum.la.agg2$N2.norm~sum.la.agg2$YR), lty=6, col=151, lwd=1.8)
# grid(col="lightgrey")
# # abline(v=2003,col=4,lty=2)
# # abline(v=1996,col=9,lty=2) #hypoxia
# text(2011.3, 1.2, "A", cex=1,font=2)
# 
# #la fall
# plot(fall.la.agg2$S.norm~fall.la.agg2$YR, pch="",
#      #main="Louisiana Fall",
#      xlab="Year",
#      ylab="Normalized value",
#      ylim=c(0.6,1.45))
# rect(2000,0,2004,2, col="grey", border="transparent") 
# 
# points(fall.la.agg2$d.norm~fall.la.agg2$YR, type="p", pch=0)
# points(fall.la.agg2$J.norm~fall.la.agg2$YR, type="p", pch=1)
# points(fall.la.agg2$shan.norm~fall.la.agg2$YR, type="p", pch=2)
# points(fall.la.agg2$simp.norm~fall.la.agg2$YR, type="p", pch=5)
# #points(fall.la.agg2$N.norm.mean~fall.la.agg2$YR, type="p", pch=2)
# 
# lines(lowess(fall.la.agg2$d.norm~fall.la.agg2$YR), lty=1, col=26, lwd=1.8)
# lines(lowess(fall.la.agg2$J.norm~fall.la.agg2$YR), lty=2, col=51, lwd=1.8)
# lines(lowess(fall.la.agg2$shan.norm~fall.la.agg2$YR), lty=3, col=76, lwd=1.8)
# lines(lowess(fall.la.agg2$simp.norm~fall.la.agg2$YR), lty=4, col=101, lwd=1.8)
# #lines(lowess(fall.la.agg2$N1.norm~fall.la.agg2$YR), lty=5, col=126, lwd=1.8)
# #lines(lowess(fall.la.agg2$N2.norm~fall.la.agg2$YR), lty=6, col=151, lwd=1.8)
# grid(col="lightgrey")
# # abline(v=2003,col=4,lty=2)
# # abline(v=1996,col=9,lty=2) #hypoxia
# text(2011.3, 1.45, "B", cex=1,font=2)
# 
# #tx summer
# plot(sum.tx.agg2$S.norm~sum.tx.agg2$YR, pch="",
#      #main="Texas Summer",
#      xlab="Year",
#      ylab="Normalized value",
#      ylim=c(0.6,1.2))
# rect(2002,0,2003,2, col="grey", border="transparent") 
# 
# points(sum.tx.agg2$d.norm~sum.tx.agg2$YR, type="p", pch=0)
# points(sum.tx.agg2$J.norm~sum.tx.agg2$YR, type="p", pch=1)
# points(sum.tx.agg2$shan.norm~sum.tx.agg2$YR, type="p", pch=2)
# points(sum.tx.agg2$simp.norm~sum.tx.agg2$YR, type="p", pch=5)
# #points(sum.tx.agg2$N.norm.mean~sum.tx.agg2$YR, type="p", pch=2)
# lines(lowess(sum.tx.agg2$d.norm~sum.tx.agg2$YR), lty=1, col=26, lwd=1.8)
# lines(lowess(sum.tx.agg2$J.norm~sum.tx.agg2$YR), lty=2, col=51, lwd=1.8)
# lines(lowess(sum.tx.agg2$shan.norm~sum.tx.agg2$YR), lty=3, col=76, lwd=1.8)
# lines(lowess(sum.tx.agg2$simp.norm~sum.tx.agg2$YR), lty=4, col=101, lwd=1.8)
# #lines(lowess(sum.tx.agg2$N1.norm~sum.tx.agg2$YR), lty=5, col=126, lwd=1.8)
# #lines(lowess(sum.tx.agg2$N2.norm~sum.tx.agg2$YR), lty=6, col=151, lwd=1.8)
# grid(col="lightgrey")
# # abline(v=2003,col=4,lty=2)
# # abline(v=1996,col=9,lty=2) #hypoxia
# text(2011.3, 1.2, "C", cex=1,font=2)
# 
# #tx fall
# plot(fall.tx.agg2$S.norm~fall.tx.agg2$YR, pch="",
#      #main="Texas Fall",
#      xlab="Year",
#      ylab="Normalized value",
#      ylim=c(0.6,1.2))
# 
# rect(1995,0,2000,2, col="grey", border="transparent") 
# 
# points(fall.tx.agg2$d.norm~fall.tx.agg2$YR, type="p", pch=0)
# points(fall.tx.agg2$J.norm~fall.tx.agg2$YR, type="p", pch=1)
# points(fall.tx.agg2$shan.norm~fall.tx.agg2$YR, type="p", pch=2)
# points(fall.tx.agg2$simp.norm~fall.tx.agg2$YR, type="p", pch=5)
# #points(fall.tx.agg2$N.norm.mean~fall.tx.agg2$YR, type="p", pch=2)
# lines(lowess(fall.tx.agg2$d.norm~fall.tx.agg2$YR), lty=1, col=26, lwd=1.8)
# lines(lowess(fall.tx.agg2$J.norm~fall.tx.agg2$YR), lty=2, col=51, lwd=1.8)
# lines(lowess(fall.tx.agg2$shan.norm~fall.tx.agg2$YR), lty=3, col=76, lwd=1.8)
# lines(lowess(fall.tx.agg2$simp.norm~fall.tx.agg2$YR), lty=4, col=101, lwd=1.8)
# #lines(lowess(fall.tx.agg2$N1.norm~fall.tx.agg2$YR), lty=5, col=126, lwd=1.8)
# #lines(lowess(fall.tx.agg2$N2.norm~fall.tx.agg2$YR), lty=6, col=151, lwd=1.8)
# grid(col="lightgrey")
# # abline(v=2003,col=4,lty=2)
# # abline(v=1996,col=9,lty=2) #hypoxia
# text(2011.3, 1.2, "D", cex=1,font=2)
# 
# #dev.off()