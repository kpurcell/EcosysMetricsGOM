# Code for making mansucript figure 1
# Description:  Figure summarizes 4 key analysis variables abundance & biomass CPUE
#               as well as two ecosystem drivers fishing effort and hypoxia
#
# KM Purcell
# updated: 2014-2-11

# pdf(file="C:\\Users\\Kevin.Purcell\\Documents\\GitHub\\EcosysMetricsGOM\\Presentation\\Article\\figure1.pdf",
#     width = 4.86, height = 9.19,   
#     onefile = FALSE)

### Figure 1 code
par(mar=c(4,4,1,1)+0.2,mfrow=c(2,2))
plot(biomass.dat$cpue~biomass.dat$YR,
     ylab="Biomass CPUE",
     xlab="")
#grid(col="black")
lines(lowess(biomass.dat$cpue~biomass.dat$YR, f=.5))
text(2011.3, .046, "A", cex=1,font=2)

plot(abundance.dat$catch_cpue~abundance.dat$YR,
     ylab="Abundance CPUE",
     xlab="")
#grid(col="black")
lines(lowess(abundance.dat$catch_cpue~abundance.dat$YR, f=.5))
text(2011.3, 2.33, "B", cex=1,font=2)

plot(shrcom.agg2$effort~shrcom.agg2$yr,
     ylab="Daysfished",
     xlab="")
#grid(col="black")
lines(lowess(shrcom.agg2$effort~shrcom.agg2$yr, f=.5))
text(2011.3, 235500, "C", cex=1,font=2)

plot(hypox.area$areaNR~hypox.area$YR,
     ylab=expression(paste("Area of Hypoxia"~ (km^{2}))),
     xlab="")
#grid(col="black")
lines(lowess(hypox.area$areaNR~hypox.area$YR, f=.5))
text(2011.3, 21620, "D", cex=1,font=2)

# dev.off()