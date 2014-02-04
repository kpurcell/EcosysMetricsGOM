# Global fishery imports and Eutrophication: synergistic effects on community dynamics
**K.M. Purcell**, J.K. Craig
Beaufort Laboratory.  
National Marine Fisheries Service.   
Beaufort, NC, USA.  
[kevin@kevin.purcell.com](mailto:kevin@kevin-purcell.com)

RH: Fish imports eutrophication effects community dynamics	

## Abstract 
(words target)



 
##Introduction: (5 paragraphs)
Paragraph One
Introduce some large theoretical frame work for ecosystem response to disturbance.  Not hysteresis but improvement or maturation something.  

Effort trends and the relationship with global shrimp imports

Paragraph Two
There are three mechanisms driving disturbance within the northwestern Gulf of Mexico: eutrophication, commercial fishing harvest, especially shrimp trawling which has a significant impact on the demersal fish assemblages, and finally coastal marsh loss.  Two of these three primary disturbance mechanisms, eutrophication and harvest, have a disproportionately strong effect on the demersal fish community through coastal hypoxia and physical stress of harvest.  

Paragraph Three
Introduce community level effects of hypoxia and fishing, and introduce metrics used to calculate them in an evaluation framework.

Paragraph Four
Paragraph 5 (Questions)
The objective of this study was to evaluate spatial and temporal variation in community diversity metrics within the northwestern Gulf of Mexico.  The nwGOM is a highly disturbed environment experiencing eutrophication, intense patterns of harvest over the last 30 years.  










## Methods
### Data Sets:
The Southeast Area Monitoring and Assessment Program (SEAMAP) survey is a hydrographic trawl survey which has been conducted in the Gulf of Mexico (GOM) since 1982 and has operated in a standardized format since 1987 (Eldridge 1988).  The survey collects environmental and biological data for the northwestern Gulf (nwGOM) since its inception, and has recently (~2008) expanded its sampling throughout the gulf coast to the southern tip of Florida (XXXX).  In the 31 years the SEAMAP survey has operated it has utilized 2261 unique taxonomic entities representing 747 genus and 1341 species.  To more manageably examine the diversity and dynamics of this marine community we evaluated a list of 60 species and 4 genus which represent ~90% of the total sampled biomass over 25 years (1987-2011) of the SEAMAP survey.  To avoid the systematic size bias derived from a biomass metric our list was created by examining the cumulative biomass contributions of all 2261 entities divided into three primary categories: pelagic, demersal and invertebrates.  From each of these three lists approximately 20 species were chosen from each representing 88% of demersal, 95% of pelagic and 97% of invertebrate sampled biomass.  By dividing the full list of taxonomically identified entities into these three categories and choosing representatives from each category we assured that our composite list of 4 genus 60 species and was representative of both the overall environment sampled and the entirety of the biomass sampled by the SEAMAP survey.  The 4 independent genus designations (Cynoscion, Loligo, Squilla, Solenocera) were included due to their contribution to overall biomass and their prominent role as troublesome identification categories.  We examined only data post-1987 because prior to 1987 SEAMAP samplings methodologies are inconsistent in time of day with the later period of sampling (XXX).  Additionally, our analysis only considers data for the northwestern Gulf of Mexico (west of -88°), due to our interest in the relative contribution of hypoxia and fishing pressure on community dynamics and because this is the region of the Gulf most often effects by coastal hypoxia (XXXX).  While the SEAMAP database includes abundance and taxonomic specifics additional species specific habitat occupancy (pelagic, demersal) data was derived from FishBase (http://fishbase.org) (Froese and Pauly 2013).  The FishBase database is…..  A number of previous studies have utilized Fishbase data for a number of comprehensive studies including examinations of TL trends (XXXX) etc etc.  

To evaluate the relationship between community dynamics and the two primary offshore environmental disturbances (hypoxia, fishing pressure) within the northwestern Gulf region we employed data from both fishery-independent and dependent sources.  To quantify the effect of hypoxia we used data derived from the annual mid-summer shelf wide hydrographic survey cruise that has been conducted by Louisiana University Marine Consortium (LUMCON) since 1985.  A primary objective of the summer LUMCON cruise is to generate an estimate of the aerial extent of hypoxia in the northwestern Gulf during mid-summer (CITATION).  Fishing pressure, or more specifically, commercial shrimp trawling effort on the Louisiana and Texas coastal shelves were quantified using fishery landings data which are archived by the National Marine Fishery Service (NMFS) Galveston Laboratory, Texas.  This database is a fishery-dependent data set which is a summary of monthly landings and effort data for the Gulf of Mexico shrimp fishery.  Fishing effort data for the shrimp fishery is not measured directly but is estimated, based on non-random interviews conducted by NMFS port agents.  We utilized annual aggregated fishing effort along both the Louisiana and Texas shelves as a covariate and potential driver in the temporal dynamics of community dynamics.  

### Breakpoint Analysis
Our first effort was to examine the temporal dynamics in the annual estimates of both abundance and biomass of our 64 selected taxonomic groups and compare those dynamics to the two primary offshore environmental disturbances within the northwestern Gulf.  We used a breakpoint analysis to identify important temporal changes along the 25 year time series used within this analysis.  Breakpoint analysis employs piecewise regression, or "broken-stick", models to iteratively fit a series of regression models, and can be utilized to identify critical thresholds (CITS) or important change-points within a time series (XXXX).  Our analysis employed a single sharp-break linear regression approach, which identified an ideal breakpoint for each time series model (abundance, biomass, hypoxia and fishing effort) by iteratively fitting a series of piecewise models with breakpoints ranging from 1990-2010 (Citation).  Optimal models were selected based on which model had the lowest mean square error.  

### Abundance Matrix:
Abundance and biomass are clear markers of disturbance or regime change in most aquatic environments (CITATIONS).  However, due to the nature and environmental impacts of a traditional trawl fishery mean that not only are fishery target species effected but often much of the available demersal biomass is effected as well.  Bycatch within a Gulf trawl fishery is of growing concern, so much as to be mandated for examination by the Magnuson …IMPORTANCE OF BYCATCH  

To evaluate annual patterns of abundance with respect to bycatch status we classified each of our 64 taxonomic entities according to the nature of their bycatch relationship within the Gulf shrimp trawl fishery.  A recent study of observer data for both the South Atlantic and the US Gulf of Mexico Penaeid shrimp fisheries (Scott-Denton et al. 2012 Marine Fisheries Review) used observer data from > 10000 individual tows and approximately ~5200 sea days to characterize bycatch within the fishery.  We classified each of our taxonomic groups into one of four bycatch categories (target, high, rare, never) based on the proportion of biomass that species or group contributed to total bycatch biomass within the study.  The three species (F. aztecus, L. setiferus, F. duorarum) which are primary targets of the shrimp fishery in the northwestern Gulf were identified as TARGET species, within the HIGH group were any taxonomic entities represented by ≥ 0.1 percent of total biomass in the study, groups with the RARE designation consisted of \*<\* 0.1 percent of the total biomass, and finally the NEVER category consisted of species which were part of our taxonomic entities but were absent from bycatch characterization samples in the study.  To visualize these relationships we utilized the mvtsplot R package (Peng 2008) to create a 4 panel matrix plot in which high abundance is represented by green and low abundance is red, each time series is color metrically independent, and each panel represents a different category of bycatch association.  

### Pelagic to Demersal Ratio:
The proportion of pelagic relative to demersal biomass in fishery landings is considered a metric sensitive to eutrophication (Caddy 1993, de Leiva Moreno et al 2000, Hodorp et al. 2010).  Conceptually, the P:D ratio is derived from the differential response of fishery stocks to increased nutrients within a system (Caddy et al. 1998 via Hondorp).  More specifically in partially enclosed systems eutrophication will tend to degrade benthic habitat resulting in decreased demersal landings and elevated pelagic-demersal ratios (Hondorp et al 2010).  Previous studies have found positive correlations between P:D ratio and chlorophyll-a concentrations within systems in both in Europe and the Mediterranean (Caddy 2000, de Leiva Moreno et al 2000).  Additionally, a recent study by Hondorp et al (2010) examined landings composition and water quality data for 22 different ecosystems including estuaries, coastal seas, and semi-enclosed basins.  While Hondorp et al (2010) reported indications that fishery practices (gear) and management could affect patterns of landings composition, they found that systems with extensive eutrophication and hypoxia displayed high P:D ratios.  To evaluate the effect of annual hypoxia on community dynamics we examined temporal and spatial dynamics in P:D ratio within the northwestern Gulf.  Biomass data for the 64 sampled biomass time series were classified as either pelagic or demersal based on species specific habitat occupancy.  The annual P:D ratios were calculated as the quotient of the annual aggregated pelagic and demersal biomasses for all survey stations summed across both the Louisiana and Texas shelves.  We also calculated the P:D ratio as a shelfwide metric including all stations for the entire northwestern Gulf.  

### Abundance Biomass Comparison (ABC) curves:
The application of Abundance Biomass Comparison (ABC) curves to the study of disturbance within an ecosystem has an established history within marine benthic systems (Warwick 1987), especially with respect to pollution driven perturbations (XXXX).  The theoretical basis of ABC analysis is derived from principles of intermediate disturbance hypothesis (Connell 1970) and r- and k-selection theory (Pianka 1970) and has been previously reviewed (Warwick and Clarke 1994, Yemane et al. 2005).  Recently, the application of ABC cures analysis has been applied to the examination of fishing pressure and its impacts on fish assemblages (Bianchi et al 2001, Blanchard et al. 2004, DeMartini et al. 2008, Jouffre and Inejih 2005, Kaiser et al. 2000, Yemane et al. 2005).  Specifically, ABC analysis involves the comparison of two superimposed k-dominance, or cumulative ranked, curves for both abundance and biomass within a system (Clarke 1990).  The difference between the curves is calculated as the Warwick statistic (W) with negative values representing relatively disturbed systems (Warwick 1986, Yemane et al. 2005).  

In the northwestern Gulf fishing effort from the commercial shrimp fishery is widely distributed across both the Louisiana and Texas coastal shelves.  To evaluate the impact of this effort on patterns of dominance we used SEAMAP survey data on both the abundance and biomass of our previously described 64 taxonomic groups and aggregated them spatially based on their location on either the Louisiana or Texas shelf.  The value of this spatial comparison lies in the difference between the perturbation mechanisms operating on the respective coastal shelves.  While fishing effort is a consistent feature across the two coastal shelves, hypoxia is predominately a condition found in Louisiana coastal waters with limited exceptions in the northern most waters of the Texas coastal shelf (Citations).  Dominance curves were generated for each year of survey data (1987-2011) for both the Louisiana and Texas regions using the Dominance plot routines in the software package PRIMER v6 (Warwhick ??).  The difference between the two dominance curves is represented by the Warwick statistic (W) and is

### W statistics (ABC curves) (Fishing disturbance)

### Diversity metrics:
A number of recent studies have examined the correlation between metrics of community composition and diversity against a wide array of disturbances under the framework of ecosystem based management [@Fulton2005which; Link citations etc]+6.  We chose a variety of these metrics to examine the temporal patterns of change within the nwGOM and to provide a framework for association???

Diversity metrics time series, normalization and loess smooth parameters

We calculated time-series for a number of diversity metrics including Margalef's d (cit), Pielou's eveness, Shannon and Simpson diversity indicies and two of Hill's numbers N1 and N2 to better evaluate patterns of temporal variation in the diversity of the nwGOM community.  These metrics were chosen based on previous studies which indicated their associations with patterns of fishing or community disturbance Marglef's d, Pielou's eveness, both Shannon and simpson's diversity indices and two of Hill's numbers (N1,N2).  Many of these indicators 

## Results



## Discussion

Paragraph based on Paragraph from p 355 last one first column Hondorp et al2010
