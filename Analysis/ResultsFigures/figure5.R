# Script for making Warwick statistics plot (Figure 5)
# KM Purcell
# update: 2014-2-11
dat <-read.csv("C:/Users/kevin.purcell/Documents/GitHub/EcosysMetricsGOM/Data/warwick_plot.csv")

dat<-subset(dat, dat$yr>=1987)

library(ggplot2)
fig5.dat<-dat
fig5.dat$shrimp_effort<-NULL

fig5.dat<-melt(fig5.dat, id="yr")

colnames(fig5.dat)[1]<-"Year"

levels(fig5.dat$variable)[match("LA_W",levels(fig5.dat$variable))] <- "Louisiana"
levels(fig5.dat$variable)[match("TX_W",levels(fig5.dat$variable))] <- "Texas"
colnames(fig5.dat)[2]<-"Region"

fig5<-ggplot(fig5.dat, aes(Year, value)) +
        geom_point(aes(shape=Region)) +
        scale_shape(solid=FALSE) +
        labs(y="W Statistic", x="Year") +
        geom_smooth(fill=NA, colour="black",size=0.5, aes(linetype=Region)) +
        #theme_bw()
        theme_minimal()
ggsave(file="C:\\Users\\Kevin.Purcell\\Documents\\GitHub\\EcosysMetricsGOM\\Presentation\\Article\\Figures\\figure5.pdf",
       fig5, width=8, height=8)




# pdf(file="C:\\Users\\Kevin.Purcell\\Documents\\GitHub\\EcosysMetricsGOM\\Presentation\\Article\\figure5.pdf")
# 
# par(mar=c(5,4,4,5)+.1)
# plot(dat$yr,dat$LA_W, type="p", pch=0,
#      ylim=c(-0.2,0.35),
#      xlab="Year",
#      ylab="W-statistic")
# #grid(col="black")
# points(dat$yr,dat$TX_W, type="p", pch=17, add=TRUE)
# abline(h=0, col="lightgray")
# lines(lowess(dat$yr,dat$LA_W), lty=2) #dashed
# lines(lowess(dat$yr,dat$TX_W), lty=1) #solid
# par(new=TRUE)
# plot(dat$yr,dat$shrimp_effort, type="l", col="gray", pch=16,xaxt="n",yaxt="n",xlab="",ylab="")
# axis(4)
# mtext("Fishing Effort (Days fished)",side=4,line=3)
# 
# dev.off()

