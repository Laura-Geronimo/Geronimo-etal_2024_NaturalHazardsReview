##Assigning damages and claims data based on:
    #first street water depths during sandy, 
    #MOD-IV building characteristics
    #HAZUS depth Damage gunctions
    #NFIP claims data


#Setup
getwd()
setwd('C:/Users/lgero/Box/Research/NJSG/Tradeoff_Analysis/V4')

library(dplyr)
library(data.table)

#import data
OB1 <- read.csv('H:/My Drive/Scarlet/Academic/Research/Data/Firststreet/NJ/Produced/OB_v3_Cad_parcel_m4_2011_Res_FSFM.csv') ##licensed First Street data
myHazus1<- read.csv('./data/DataDownloads/HAZUS/Produced/myHazus1.csv')

ob_11_sp <- read.csv('./data/BaselineData/OB_MOD4_Produced/TimeSeries/S1/OB_2011_SalesPrice.csv')
Adjust <- read.csv('./data/BaselineData/InflationAdjusters.csv')

S3_OB <- read.csv('./data/BaselineData/OB_MOD4_Produced/FromGIS/ClusterInfo/S3_Cluster1_gispin.csv')
S4_OB <- read.csv('./data/BaselineData/OB_MOD4_Produced/FromGIS/ClusterInfo/S4_ClusterBay_gispin.csv')


# explore / clean#
names(OB1)
head(OB1)

myHazus1 <- myHazus1[,c(-1)]
ob_11_sp <- ob_11_sp[,c(-1)]

#examining building data
##Extracting stories #####
table(OB1$building_description)
OB1$Floors_LG <- NA

#less certain
OB1$Floors_LG[OB1$building_description %like% "3G"] <- "3"
OB1$Floors_LG[OB1$building_description %like% "1B"] <- "1"

#more certain (will overwrite above)

OB1$Floors_LG[OB1$building_description %like% "1F"] <- "1"
OB1$Floors_LG[OB1$building_description %like% "1.5F"] <- "1.5"
OB1$Floors_LG[OB1$building_description %like% "1CB"] <- "1"
OB1$Floors_LG[OB1$building_description %like% "1.5CB"] <- "1.5"
OB1$Floors_LG[OB1$building_description %like% "2CB"] <- "2"
OB1$Floors_LG[OB1$building_description %like% "2S"] <- "2"
OB1$Floors_LG[OB1$building_description %like% "2.5F"] <- "2.5"
OB1$Floors_LG[OB1$building_description %like% "2.5S"] <- "2.5"
OB1$Floors_LG[OB1$building_description %like% "2F"] <- "2"
OB1$Floors_LG[OB1$building_description %like% "2.F"] <- "2"
OB1$Floors_LG[OB1$building_description %like% "3F"] <- "3"

table(OB1$Floors_LG)
table(is.na(OB1$Floors_LG))

seeNAs <- OB1[is.na(OB1$Floors_LG),]
table(seeNAs$building_description)  #assiging 1 to rest

OB1$Floors_LG[is.na(OB1$Floors_LG)] <-1


##assigning HAZUS curve based on floors (assuming no basement)####
  #DmgFnId=="107"| #two floors no basement, A-zone
  #DmgFnId=="109" |  #three or more floors, no basement A-zone
  #DmgFnId=="114"| # one floor w/ basement V-zone (note: no curve for 1 floor w/out basement)
  #DmgFnId=="115"| #two floors, no basement V-zone
  #DmgFnId=="117"| #three or more floors, no basement, V-zone

table(OB1$Floors_LG)
OB1$hazusCurve <- NA
OB1$hazusCurve[OB1$Floors_LG==1] <- 114
OB1$hazusCurve[OB1$Floors_LG==1.5] <- 114
OB1$hazusCurve[OB1$Floors_LG==2] <- 115
OB1$hazusCurve[OB1$Floors_LG==2.5] <- 115
OB1$hazusCurve[OB1$Floors_LG==3] <- 117


####processing Sandy water depths for OB from FSFM####

table(is.na(OB1$hist1_depth)) #30. Assigning median depth.

summary(OB1$hist1_depth,na.rm=T) #median = 126

#creating new depth var and assiging median to nulls
OB1$hist1_depthB <-OB1$hist1_depth
OB1$hist1_depthB[is.na(OB1$hist1_depthB)]<-126
hist(OB1$hist1_depthB)

#converting cm to feet
OB1$hist1_depth_ft <- OB1$hist1_depthB * 0.0328084
hist(OB1$hist1_depth_ft)

#rounding to nearest foot
OB1$hist1_depth_ftr <- round(OB1$hist1_depth_ft, digits=0)


#assigning damage percent to buildings based on both the selecetd damage curve based on building characteristics, and FSFM Sandy depth####
names(OB1)
table(OB1$hist1_depth_ftr, OB1$hazusCurve)

OB1$damage_pct <- NA
table(OB1$damage_pct)
OB1$damage_pct[OB1$hist1_depth_ftr=="1" & OB1$hazusCurve=="114"] <- 21
OB1$damage_pct[OB1$hist1_depth_ftr=="2" & OB1$hazusCurve=="114"] <- 29
OB1$damage_pct[OB1$hist1_depth_ftr=="3" & OB1$hazusCurve=="114"] <- 34
OB1$damage_pct[OB1$hist1_depth_ftr=="4" & OB1$hazusCurve=="114"] <- 38
OB1$damage_pct[OB1$hist1_depth_ftr=="5" & OB1$hazusCurve=="114"] <- 43
OB1$damage_pct[OB1$hist1_depth_ftr=="6" & OB1$hazusCurve=="114"] <- 47

OB1$damage_pct[OB1$hist1_depth_ftr=="1" & OB1$hazusCurve=="115"] <- 9
OB1$damage_pct[OB1$hist1_depth_ftr=="2" & OB1$hazusCurve=="115"] <- 13
OB1$damage_pct[OB1$hist1_depth_ftr=="3" & OB1$hazusCurve=="115"] <- 18
OB1$damage_pct[OB1$hist1_depth_ftr=="4" & OB1$hazusCurve=="115"] <- 20
OB1$damage_pct[OB1$hist1_depth_ftr=="5" & OB1$hazusCurve=="115"] <- 22
OB1$damage_pct[OB1$hist1_depth_ftr=="6" & OB1$hazusCurve=="115"] <- 24

OB1$damage_pct[OB1$hist1_depth_ftr=="1" & OB1$hazusCurve=="117"] <- 8
OB1$damage_pct[OB1$hist1_depth_ftr=="2" & OB1$hazusCurve=="117"] <- 12
OB1$damage_pct[OB1$hist1_depth_ftr=="3" & OB1$hazusCurve=="117"] <- 17
OB1$damage_pct[OB1$hist1_depth_ftr=="4" & OB1$hazusCurve=="117"] <- 19
OB1$damage_pct[OB1$hist1_depth_ftr=="5" & OB1$hazusCurve=="117"] <- 22
OB1$damage_pct[OB1$hist1_depth_ftr=="6" & OB1$hazusCurve=="117"] <- 24

#reducing data ####
names(OB1)
OB2 <- OB1[,c("GIS_PIN",
              "building_description",
              "Floors_LG", 
              "hist1_depth_ft",
              "hist1_depth_ftr", 
              "hazusCurve",
              "avm",
              "damage_pct")]



#joining Sales Price ####
names(OB2)
names(ob_11_sp)
sum(ob_11_sp$SalesPrice_LG_W)
ob_11_sp <- ob_11_sp[,c(1,2,4)]

OB3 <- left_join(OB2,ob_11_sp, by="GIS_PIN",copy=F)



#assigning damage amount based on sales price #####
table(is.na(OB3$damage_pct))
range(OB3$damage_pct)
OB3$damage_pct <- OB3$damage_pct/100
table(is.na(OB3$SalesPrice_LG_W)) #none

OB3$SandyDmg11USD <- OB3$damage_pct * OB3$SalesPrice_LG_W
hist(OB3$SandyDmg11USD)
plot(OB3$SandyDmg11USD)
sum(OB3$SandyDmg11USD) #214,646,389

OB3SandyDmgAVM <- OB3$damage_pct * OB3$avm
table(is.na(OB3$avm))
sum(OB3SandyDmgAVM, na.rm = T) #235,449,376

#sanity check####
sum(OB3$avm, na.rm=T) #754,538,717
sum(OB3$SalesPrice_LG) #920,882,210
#test <- 560000*1800 #1,038,800,000. Note about 750M to 1B in property value on the island, depending on estimate


test <- 214646389/920882210 #about 23% of property value damaged if using 2011 sales price
test <- 235449376/754538717 #about 31.2% of property value damaged if using FS AVM



#distributing NFIP claims and extracting hidden costs of rebuilding #####
#the total NFIP claims I have for 2012 for Ortley Beach is $71,624,093, CPI adjusted (see Fed Costs sheet. Sum of building content, and ICC)
#Distributed Based on percent of total damages

OB3$propdmg_as_pct_of_all_dmg <- OB3$SandyDmg11USD / 214646389
sum(OB3$propdmg_as_pct_of_all_dmg) #1 good

OB3$Sandy_NFIP_Claims_LG <- OB3$propdmg_as_pct_of_all_dmg * 71624093
sum(OB3$Sandy_NFIP_Claims_LG) #71624093 good

hist(OB3$Sandy_NFIP_Claims_LG) #good histogram.
range(OB3$Sandy_NFIP_Claims_LG)

## Final estimates ####

###S1 CLUSTER ####
names(OB3)
table(is.na(OB3$Sandy_NFIP_Claims_LG))
S1_Sandy_NFIP_Claims <- sum(OB3$Sandy_NFIP_Claims_LG) # 71,624,093 = claims for cluster
S1_Sandy_damages  <- sum(OB3$SandyDmg11USD) # 214,646,389 = damages to cluster
S1_Sandy_hiddenHHcosts <- S1_Sandy_damages - S1_Sandy_NFIP_Claims #143,022,296 in hidden Households costs

###S3 CLUSTER ####
names(OB3)
names(S3_OB)[names(S3_OB)=="gis_pin"]<-"GIS_PIN"
S3_OB_nfip <- left_join(S3_OB, OB3, by="GIS_PIN")
table(is.na(S3_OB_nfip$Sandy_NFIP_Claims_LG))
S3_Sandy_NFIP_Claims <- sum(S3_OB_nfip$Sandy_NFIP_Claims_LG) # 15,194,878 = claims for cluster
S3_Sandy_damages  <- sum(S3_OB_nfip$SandyDmg11USD) #45,536,711 = damages to cluster
S3_Sandy_hiddenHHcosts <- S3_Sandy_damages - S3_Sandy_NFIP_Claims #30,341,833 in hidden Households costs

###S4 CLUSTER ####
names(OB3)
names(S4_OB)[names(S4_OB)=="gis_pin"]<-"GIS_PIN"
S4_OB_nfip <- left_join(S4_OB, OB3, by="GIS_PIN")
table(is.na(S4_OB_nfip$Sandy_NFIP_Claims_LG))
S4_Sandy_NFIP_Claims <- sum(S4_OB_nfip$Sandy_NFIP_Claims_LG)# 38,350,3691= claims for cluster
S4_Sandy_damages <- sum(S4_OB_nfip$SandyDmg11USD) #114,930,158 = damages to cluster
S4_Sandy_hiddenHHcosts <- S4_Sandy_damages - S4_Sandy_NFIP_Claims #76,579,788 in hidden Households costs

#creating dataframe: estimated NFIP Claims and damages by Cluster
# Create the data frame with your saved objects
Est_Dmg_Claims_Sandy_byScenario <- data.frame(
  S1 = c(S1_Sandy_NFIP_Claims, S1_Sandy_damages, S1_Sandy_hiddenHHcosts),
  S3 = c(S3_Sandy_NFIP_Claims, S3_Sandy_damages, S3_Sandy_hiddenHHcosts),
  S4 = c(S4_Sandy_NFIP_Claims, S4_Sandy_damages, S4_Sandy_hiddenHHcosts),
  row.names = c("Est_NFIP_Claims", "Est_Sandy_Damages", "Est_HiddenHouseholdCosts")
)

# View the data frame
print(Est_Dmg_Claims_Sandy_byScenario)


#writing out files
#writing out relevant files####
path1 <- './data/BaselineData/OB_SandyDmgsAndClaimsEstByScenario'
write.csv(OB3, file.path(path1, "OB_HAZUS.csv"), row.names=TRUE)
write.csv(Est_Dmg_Claims_Sandy_byScenario, file.path(path1, "Est_Dmg_Claims_Sandy_byScenario.csv"), row.names=TRUE)

