#purpose: Generating information for alternative scenarios
#cleaning clusters to gis pin only for easy use

getwd()
setwd("C:/Users/lgero/Box/Research/NJSG/Tradeoff_Analysis/V4/")

#libraries####
library(data.table)
library(dplyr)
library(stringr)

ob_m4_TS <- read.csv('./data/BaselineData/OB_MOD4_Produced/TimeSeries/S1/OB_m4_res_TS2.csv')
S3_OB <- read.csv('./data/BaselineData/OB_MOD4_Produced/FromGIS/ClusterInfo/S3_Cluster_OB_M4_2011_Res.csv')
S4_OB <- read.csv('./data/BaselineData/OB_MOD4_Produced/FromGIS/ClusterInfo/S4_ClusterBay_OB_M4_2011_Res.csv')


#explore####
names(ob_m4_TS)
names(S3_OB)
names(S4_OB)

#extracting gis pin for S3
S3_OBb <- S3_OB[,c("mod_iv_2011.csv.gis_pin")]
names(S3_OBb)[names(S3_OBb)=="mod_iv_2011.csv.gis_pin"]<-"gis_pin"
S3_OBb <- as.data.frame(S3_OBb)
names(S3_OBb)[names(S3_OBb)=="S3_OBb"]<-"gis_pin"

#extracting gis pin for S4
S4_OBb <- S4_OB[,c("GIS_PIN")]
S4_OBb <- as.data.frame(S4_OBb)
names(S4_OBb)[names(S4_OBb)=="S4_OBb"]<-"gis_pin"

#Extracting Assessed value sums ####
#S3 ####
names(ob_m4_TS)
names(S3_OBb)

S3_OBc <- left_join(S3_OBb,ob_m4_TS,by="gis_pin", copy=F)
sum(S3_OBc$y10_improvement_value, na.rm=T)
table(is.na(S3_OBc$y10_improvement_value))

sum(S3_OBc$y11_improvement_value, na.rm=T)
table(is.na(S3_OBc$y11_improvement_value))

sum(S3_OBc$y12_improvement_value, na.rm=T)
table(is.na(S3_OBc$y12_improvement_value))

sum(S3_OBc$y13_improvement_value, na.rm=T)
table(is.na(S3_OBc$y13_improvement_value))

sum(S3_OBc$y14_improvement_value, na.rm=T)
table(is.na(S3_OBc$y14_improvement_value))

sum(S3_OBc$y15_improvement_value, na.rm=T)
table(is.na(S3_OBc$y15_improvement_value))

sum(S3_OBc$y16_improvement_value, na.rm=T)
table(is.na(S3_OBc$y16_improvement_value))

sum(S3_OBc$y17_improvement_value, na.rm=T)
table(is.na(S3_OBc$y17_improvement_value))

sum(S3_OBc$y18_improvement_value, na.rm=T)
table(is.na(S3_OBc$y18_improvement_value))

sum(S3_OBc$y19_improvement_value, na.rm=T)
table(is.na(S3_OBc$y19_improvement_value))

sum(S3_OBc$y20_improvement_value, na.rm=T)
table(is.na(S3_OBc$y20_improvement_value))

sum(S3_OBc$y21_improvement_value, na.rm=T)
table(is.na(S3_OBc$y21_improvement_value))

sum(S3_OBc$y22_improvement_value, na.rm=T)
table(is.na(S3_OBc$y22_improvement_value))

#S4 ####
names(ob_m4_TS)
names(S4_OBb)

S4_OBc <- left_join(S4_OBb,ob_m4_TS,by="gis_pin", copy=F)
sum(S4_OBc$y10_improvement_value, na.rm=T)
table(is.na(S4_OBc$y10_improvement_value))

sum(S4_OBc$y11_improvement_value, na.rm=T)
table(is.na(S4_OBc$y11_improvement_value))

sum(S4_OBc$y12_improvement_value, na.rm=T)
table(is.na(S4_OBc$y12_improvement_value))

sum(S4_OBc$y13_improvement_value, na.rm=T)
table(is.na(S4_OBc$y13_improvement_value))

sum(S4_OBc$y14_improvement_value, na.rm=T)
table(is.na(S4_OBc$y14_improvement_value))

sum(S4_OBc$y15_improvement_value, na.rm=T)
table(is.na(S4_OBc$y15_improvement_value))

sum(S4_OBc$y16_improvement_value, na.rm=T)
table(is.na(S4_OBc$y16_improvement_value))

sum(S4_OBc$y17_improvement_value, na.rm=T)
table(is.na(S4_OBc$y17_improvement_value))

sum(S4_OBc$y18_improvement_value, na.rm=T)
table(is.na(S4_OBc$y18_improvement_value))

sum(S4_OBc$y19_improvement_value, na.rm=T)
table(is.na(S4_OBc$y19_improvement_value))

sum(S4_OBc$y20_improvement_value, na.rm=T)
table(is.na(S4_OBc$y20_improvement_value))

sum(S4_OBc$y21_improvement_value, na.rm=T)
table(is.na(S4_OBc$y21_improvement_value))

sum(S4_OBc$y22_improvement_value, na.rm=T)
table(is.na(S4_OBc$y22_improvement_value))

#writing out files ####
path1 <- 'C:/Users/lgero/Box/Research/NJSG/Tradeoff_Analysis/V4/data/BaselineData/OB_MOD4_Produced/FromGIS/ClusterInfo/'
write.csv(S3_OBb, file.path(path1, "S3_Cluster1_gispin.csv"), row.names=TRUE)
write.csv(S4_OBb, file.path(path1, "S4_ClusterBay_gispin.csv"), row.names=TRUE)

path1 <- 'C:/Users/lgero/Box/Research/NJSG/Tradeoff_Analysis/V4/data/BaselineData/OB_MOD4_Produced/TimeSeries/'
write.csv(S3_OBc, file.path(path1, "S3/OB_S3_MOD4_TimeSeries.csv"), row.names=TRUE)
write.csv(S4_OBc, file.path(path1, "S4/OB_S4_MOD4_TimeSeries.csv"), row.names=TRUE)
