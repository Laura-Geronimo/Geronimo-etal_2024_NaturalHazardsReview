##Purpose:
#getting sales values for Ortley Beach properties and cenarios 


getwd()
setwd("C:/Users/lgero/Box/Research/NJSG/Tradeoff_Analysis/V4/")

#libraries####
library(data.table)
library(dplyr)
library(stringr)

options(scipen=999)

##Loading Raw HMA data####

ob_m4_res_2011 <- read.csv('./data/BaselineData/OB_MOD4_Produced/FromGIS/OB_Cad_parcel_M4_2011_Res.csv')
S3_OB <- read.csv('./data/BaselineData/OB_MOD4_Produced/FromGIS/ClusterInfo/S3_Cluster1_gispin.csv')
S4_OB <- read.csv('./data/BaselineData/OB_MOD4_Produced/FromGIS/ClusterInfo/S4_ClusterBay_gispin.csv')

tr_m4_2022 <- read.csv('./data/DataDownloads/TomsRiver/TR_MOD4/TR_2010_2022/mod_iv_data/mod_iv_2022.csv')
tr_m4_2021 <- read.csv('./data/DataDownloads/TomsRiver/TR_MOD4/TR_2010_2022/mod_iv_data/mod_iv_2021.csv')
tr_m4_2020 <- read.csv('./data/DataDownloads/TomsRiver/TR_MOD4/TR_2010_2022/mod_iv_data/mod_iv_2020.csv')
tr_m4_2019 <- read.csv('./data/DataDownloads/TomsRiver/TR_MOD4/TR_2010_2022/mod_iv_data/mod_iv_2019.csv')
tr_m4_2018 <- read.csv('./data/DataDownloads/TomsRiver/TR_MOD4/TR_2010_2022/mod_iv_data/mod_iv_2018.csv')
tr_m4_2017 <- read.csv('./data/DataDownloads/TomsRiver/TR_MOD4/TR_2010_2022/mod_iv_data/mod_iv_2017.csv')
tr_m4_2016 <- read.csv('./data/DataDownloads/TomsRiver/TR_MOD4/TR_2010_2022/mod_iv_data/mod_iv_2016.csv')
tr_m4_2015 <- read.csv('./data/DataDownloads/TomsRiver/TR_MOD4/TR_2010_2022/mod_iv_data/mod_iv_2015.csv')
tr_m4_2014 <- read.csv('./data/DataDownloads/TomsRiver/TR_MOD4/TR_2010_2022/mod_iv_data/mod_iv_2014.csv')
tr_m4_2013 <- read.csv('./data/DataDownloads/TomsRiver/TR_MOD4/TR_2010_2022/mod_iv_data/mod_iv_2013.csv')
tr_m4_2012 <- read.csv('./data/DataDownloads/TomsRiver/TR_MOD4/TR_2010_2022/mod_iv_data/mod_iv_2012.csv')


#cleaning OB 2011  to serve as base####
head(ob_m4_res_2011)
names(ob_m4_res_2011)
colSums(is.na(ob_m4_res_2011))
table(ob_m4_res_2011$property_class) #all residential from clip in argis


OB_ResBase <- ob_m4_res_2011[,c("PAMS_PIN",
                                "GIS_PIN",
                                "gis_pin_1")]
head(OB_ResBase)
names(OB_ResBase)[names(OB_ResBase)=="GIS_PIN"]<- "gis_pin"
#names(OB_ResBase)[names(OB_ResBase)=="OLD_PROPID"]<- "old_property_id"


#reducing all to residential
tr_m4_2022_res <- subset(tr_m4_2022, property_class=="2") #sub-setting to '2'= 'Residential (four families or less)'
tr_m4_2021_res <- subset(tr_m4_2021, property_class=="2") 
tr_m4_2020_res <- subset(tr_m4_2020, property_class=="2") 
tr_m4_2019_res <- subset(tr_m4_2019, property_class=="2") 
tr_m4_2018_res <- subset(tr_m4_2018, property_class=="2") 
tr_m4_2017_res <- subset(tr_m4_2017, property_class=="2") 
tr_m4_2016_res <- subset(tr_m4_2016, property_class=="2") 
tr_m4_2015_res <- subset(tr_m4_2015, property_class=="2") 
tr_m4_2014_res <- subset(tr_m4_2014, property_class=="2") 
tr_m4_2013_res <- subset(tr_m4_2013, property_class=="2") 
tr_m4_2012_res <- subset(tr_m4_2012, property_class=="2") 


#######################
#New workflow####

## reduce data for all years ####
tr_m4_2022_res1 <- tr_m4_2022_res[,c("gis_pin",
                                     "last_trans_date_MMDDYY", 
                                     "deed_date_MMDDYY",
                                     "sale_price",
                                     "building_description")]
tr_m4_2021_res1 <- tr_m4_2021_res[,c("gis_pin",
                                     "last_trans_date_MMDDYY", 
                                     "deed_date_MMDDYY",
                                     "sale_price",
                                     "building_description")]
tr_m4_2020_res1 <- tr_m4_2020_res[,c("gis_pin",
                                     "last_trans_date_MMDDYY", 
                                     "deed_date_MMDDYY",
                                     "sale_price",
                                     "building_description")]
tr_m4_2019_res1 <- tr_m4_2019_res[,c("gis_pin",
                                     "last_trans_date_MMDDYY", 
                                     "deed_date_MMDDYY",
                                     "sale_price",
                                     "building_description")]
tr_m4_2018_res1 <- tr_m4_2018_res[,c("gis_pin",
                                     "last_trans_date_MMDDYY", 
                                     "deed_date_MMDDYY",
                                     "sale_price",
                                     "building_description")]
tr_m4_2017_res1 <- tr_m4_2017_res[,c("gis_pin",
                                     "last_trans_date_MMDDYY", 
                                     "deed_date_MMDDYY",
                                     "sale_price",
                                     "building_description")]
tr_m4_2016_res1 <- tr_m4_2016_res[,c("gis_pin",
                                     "last_trans_date_MMDDYY", 
                                     "deed_date_MMDDYY",
                                     "sale_price",
                                     "building_description")]
tr_m4_2015_res1 <- tr_m4_2015_res[,c("gis_pin",
                                     "last_trans_date_MMDDYY", 
                                     "deed_date_MMDDYY",
                                     "sale_price",
                                     "building_description")]
tr_m4_2014_res1 <- tr_m4_2014_res[,c("gis_pin",
                                     "last_trans_date_MMDDYY", 
                                     "deed_date_MMDDYY",
                                     "sale_price",
                                     "building_description")]
tr_m4_2013_res1 <- tr_m4_2013_res[,c("gis_pin",
                                     "last_trans_date_MMDDYY", 
                                     "deed_date_MMDDYY",
                                     "sale_price",
                                     "building_description")]
tr_m4_2012_res1 <- tr_m4_2012_res[,c("gis_pin",
                                     "last_trans_date_MMDDYY", 
                                     "deed_date_MMDDYY",
                                     "sale_price",
                                     "building_description")]

## join data to OB Base & obtain NAs ####

##joining M4 to OB Base on GIS PIN
OB_m4_res_22 <- left_join(OB_ResBase, tr_m4_2022_res1, by="gis_pin", copy=F)
colSums(is.na(OB_m4_res_22)) #missing data on 110  buildings. Does this mean there are 110 fewer buildings? assuming so
OB_m4_res_22 <- na.omit(OB_m4_res_22)

OB_m4_res_21 <- left_join(OB_ResBase, tr_m4_2021_res1, by="gis_pin", copy=F)
colSums(is.na(OB_m4_res_21)) #missing data on 127  buildings. Assuming fewer buildings
OB_m4_res_21 <- na.omit(OB_m4_res_21)

OB_m4_res_20 <- left_join(OB_ResBase, tr_m4_2020_res1, by="gis_pin", copy=F)
colSums(is.na(OB_m4_res_20)) #missing data on 149  buildings. Assuming fewer buildings
OB_m4_res_20 <- na.omit(OB_m4_res_20)

OB_m4_res_19 <- left_join(OB_ResBase, tr_m4_2019_res1, by="gis_pin", copy=F)
colSums(is.na(OB_m4_res_19)) #missing data on 149  buildings. Assuming fewer buildings
OB_m4_res_19 <- na.omit(OB_m4_res_19)

OB_m4_res_18 <- left_join(OB_ResBase, tr_m4_2018_res1, by="gis_pin", copy=F)
colSums(is.na(OB_m4_res_18)) #missing data on 229  buildings. Assuming fewer buildings
OB_m4_res_18 <- na.omit(OB_m4_res_18)

OB_m4_res_17 <- left_join(OB_ResBase, tr_m4_2017_res1, by="gis_pin", copy=F)
colSums(is.na(OB_m4_res_17)) #missing data on 286  buildings. Assuming fewer buildings
OB_m4_res_17 <- na.omit(OB_m4_res_17)

OB_m4_res_16 <- left_join(OB_ResBase, tr_m4_2016_res1, by="gis_pin", copy=F)
colSums(is.na(OB_m4_res_16)) #missing data on 357  buildings. Assuming fewer buildings
OB_m4_res_16 <- na.omit(OB_m4_res_16)

OB_m4_res_15 <- left_join(OB_ResBase, tr_m4_2015_res1, by="gis_pin", copy=F)
colSums(is.na(OB_m4_res_15)) #missing data on 434  buildings. Assuming fewer buildings
OB_m4_res_15 <- na.omit(OB_m4_res_15)

OB_m4_res_14 <- left_join(OB_ResBase, tr_m4_2014_res1, by="gis_pin", copy=F)
colSums(is.na(OB_m4_res_14)) #missing data on 5  buildings. Assuming fewer buildings
OB_m4_res_14 <- na.omit(OB_m4_res_14)

OB_m4_res_13 <- left_join(OB_ResBase, tr_m4_2013_res1, by="gis_pin", copy=F)
colSums(is.na(OB_m4_res_13)) #missing data on 12  buildings. Assuming fewer buildings
OB_m4_res_13 <- na.omit(OB_m4_res_13)

OB_m4_res_12 <- left_join(OB_ResBase, tr_m4_2012_res1, by="gis_pin", copy=F)
colSums(is.na(OB_m4_res_12)) #missing data on 12  buildings. Assuming fewer buildings
OB_m4_res_12 <- na.omit(OB_m4_res_12)


## number of NAs on sqft, finding median, and interpolating ####

#2022 sqft####
##Extracting sqft #
head(OB_m4_res_22$building_description)
OB_m4_res_22$sqft <- sub("^\\S+\\s+", '', OB_m4_res_22$building_description)
head(OB_m4_res_22$sqft)
table(OB_m4_res_22$sqft)

OB_m4_res_22$sqft <- as.numeric(OB_m4_res_22$sqft)

#recoding outlier as NA
hist(OB_m4_res_22$sqft)
plot(OB_m4_res_22$sqft)
OB_m4_res_22$sqft[OB_m4_res_22$sqft > 13600000] <- NA

table(is.na(OB_m4_res_22$sqft)) #105. For these, median

summary(OB_m4_res_22$sqft) #base it on median

#interpolating missing sqft based on median
OB_m4_res_22$sqft[is.na(OB_m4_res_22$sqft)] <- 1699

#obtaining total square feet
sum(OB_m4_res_22$sqft)


#2021 sqft ####
##Extracting sqft #
head(OB_m4_res_21$building_description)
OB_m4_res_21$sqft <- sub("^\\S+\\s+", '', OB_m4_res_21$building_description)
head(OB_m4_res_21$sqft)
table(OB_m4_res_21$sqft)

OB_m4_res_21$sqft <- as.numeric(OB_m4_res_21$sqft)

#recoding outlier as NA
hist(OB_m4_res_21$sqft)
plot(OB_m4_res_21$sqft)
OB_m4_res_21$sqft[OB_m4_res_21$sqft > 6000000] <- NA

table(is.na(OB_m4_res_21$sqft)) #

summary(OB_m4_res_21$sqft) #base it on median

#interpolating missing sqft based on median 
OB_m4_res_21$sqft[is.na(OB_m4_res_21$sqft)] <- 1696

#obtaining total square feet
sum(OB_m4_res_21$sqft)


#2020 sqft ####
##Extracting sqft #
head(OB_m4_res_20$building_description)
OB_m4_res_20$sqft <- sub("^\\S+\\s+", '', OB_m4_res_20$building_description)
head(OB_m4_res_20$sqft)
table(OB_m4_res_20$sqft)

OB_m4_res_20$sqft <- as.numeric(OB_m4_res_20$sqft)

#recoding outlier as NA
hist(OB_m4_res_20$sqft)
plot(OB_m4_res_20$sqft)
OB_m4_res_20$sqft[OB_m4_res_20$sqft > 6000000] <- NA

table(is.na(OB_m4_res_20$sqft)) #

summary(OB_m4_res_20$sqft) #base it on median

#interpolating missing sqft based on median 
OB_m4_res_20$sqft[is.na(OB_m4_res_20$sqft)] <- 1680

#obtaining total square feet
sum(OB_m4_res_20$sqft)


#2019 sqft ####
##Extracting sqft #
head(OB_m4_res_19$building_description)
OB_m4_res_19$sqft <- sub("^\\S+\\s+", '', OB_m4_res_19$building_description)
head(OB_m4_res_19$sqft)
table(OB_m4_res_19$sqft)

OB_m4_res_19$sqft <- as.numeric(OB_m4_res_19$sqft)

#recoding outlier as NA
hist(OB_m4_res_19$sqft)
plot(OB_m4_res_19$sqft)
OB_m4_res_19$sqft[OB_m4_res_19$sqft > 6000000] <- NA

table(is.na(OB_m4_res_19$sqft)) #12. For these, median

summary(OB_m4_res_19$sqft) #base it on median

#interpolating missing sqft based on median 
OB_m4_res_19$sqft[is.na(OB_m4_res_19$sqft)] <- 1664

#obtaining total square feet
sum(OB_m4_res_19$sqft)


#2018 sqft ####
##Extracting sqft #
head(OB_m4_res_18$building_description)
OB_m4_res_18$sqft <- sub("^\\S+\\s+", '', OB_m4_res_18$building_description)
head(OB_m4_res_18$sqft)
table(OB_m4_res_18$sqft)

OB_m4_res_18$sqft <- as.numeric(OB_m4_res_18$sqft)

#recoding outlier as NA
hist(OB_m4_res_18$sqft)
plot(OB_m4_res_18$sqft)
OB_m4_res_18$sqft[OB_m4_res_18$sqft > 6000000] <- NA

table(is.na(OB_m4_res_18$sqft)) #12. For these, median

summary(OB_m4_res_18$sqft) #base it on median

#interpolating missing sqft based on median 
OB_m4_res_18$sqft[is.na(OB_m4_res_18$sqft)] <- 1632

#obtaining total square feet
sum(OB_m4_res_18$sqft)


#2017 sqft ####
##Extracting sqft #
head(OB_m4_res_17$building_description)
OB_m4_res_17$sqft <- sub("^\\S+\\s+", '', OB_m4_res_17$building_description)
head(OB_m4_res_17$sqft)
table(OB_m4_res_17$sqft)

OB_m4_res_17$sqft <- as.numeric(OB_m4_res_17$sqft)

#recoding outlier as NA
hist(OB_m4_res_17$sqft)
plot(OB_m4_res_17$sqft)
OB_m4_res_17$sqft[OB_m4_res_17$sqft > 6000000] <- NA

table(is.na(OB_m4_res_17$sqft)) #9. For these, median

summary(OB_m4_res_17$sqft) #base it on median

#interpolating missing sqft based on median 
OB_m4_res_17$sqft[is.na(OB_m4_res_17$sqft)] <- 1589

#obtaining total square feet
sum(OB_m4_res_17$sqft)



#2016 sqft ####
##Extracting sqft #
head(OB_m4_res_16$building_description)
OB_m4_res_16$sqft <- sub("^\\S+\\s+", '', OB_m4_res_16$building_description)
head(OB_m4_res_16$sqft)
table(OB_m4_res_16$sqft)

OB_m4_res_16$sqft <- as.numeric(OB_m4_res_16$sqft)

#recoding outlier as NA
hist(OB_m4_res_16$sqft)
plot(OB_m4_res_16$sqft)
OB_m4_res_16$sqft[OB_m4_res_16$sqft > 6000000] <- NA

table(is.na(OB_m4_res_16$sqft)) #

summary(OB_m4_res_16$sqft) #base it on median

#interpolating missing sqft based on median 
OB_m4_res_16$sqft[is.na(OB_m4_res_16$sqft)] <- 1536

#obtaining total square feet
sum(OB_m4_res_16$sqft)


#2015 sqft ####
##Extracting sqft #
head(OB_m4_res_15$building_description)
OB_m4_res_15$sqft <- sub("^\\S+\\s+", '', OB_m4_res_15$building_description)
head(OB_m4_res_15$sqft)
table(OB_m4_res_15$sqft)

OB_m4_res_15$sqft <- as.numeric(OB_m4_res_15$sqft)

#recoding outlier as NA
hist(OB_m4_res_15$sqft)
plot(OB_m4_res_15$sqft)
#OB_m4_res_15$sqft[OB_m4_res_15$sqft > 6000000] <- NA

table(is.na(OB_m4_res_15$sqft)) #8. For these, median

summary(OB_m4_res_15$sqft) #base it on median

#interpolating missing sqft based on median 
OB_m4_res_15$sqft[is.na(OB_m4_res_15$sqft)] <- 1456

#obtaining total square feet
sum(OB_m4_res_15$sqft)


#2014 sqft ####
##Extracting sqft #
head(OB_m4_res_14$building_description)
OB_m4_res_14$sqft <- sub("^\\S+\\s+", '', OB_m4_res_14$building_description)
head(OB_m4_res_14$sqft)
table(OB_m4_res_14$sqft)

OB_m4_res_14$sqft <- as.numeric(OB_m4_res_14$sqft)

#recoding outlier as NA
hist(OB_m4_res_14$sqft)
plot(OB_m4_res_14$sqft)
#OB_m4_res_14$sqft[OB_m4_res_14$sqft > 6000000] <- NA

table(is.na(OB_m4_res_14$sqft)) #8. For these, median

summary(OB_m4_res_14$sqft) #base it on median

#interpolating missing sqft based on median 
OB_m4_res_14$sqft[is.na(OB_m4_res_14$sqft)] <- 1293

#obtaining total square feet
sum(OB_m4_res_14$sqft)



#2013 sqft ####
##Extracting sqft #
head(OB_m4_res_13$building_description)
OB_m4_res_13$sqft <- sub("^\\S+\\s+", '', OB_m4_res_13$building_description)
head(OB_m4_res_13$sqft)
table(OB_m4_res_13$sqft)

OB_m4_res_13$sqft <- as.numeric(OB_m4_res_13$sqft)

#recoding outlier as NA
hist(OB_m4_res_13$sqft)
plot(OB_m4_res_13$sqft)
#OB_m4_res_13$sqft[OB_m4_res_13$sqft > 6000000] <- NA

table(is.na(OB_m4_res_13$sqft)) #8. For these, median

summary(OB_m4_res_13$sqft) #base it on median

#interpolating missing sqft based on median 
OB_m4_res_13$sqft[is.na(OB_m4_res_13$sqft)] <- 1280

#obtaining total square feet
sum(OB_m4_res_13$sqft)


#2012 sqft ####
##Extracting sqft #
head(OB_m4_res_12$building_description)
OB_m4_res_12$sqft <- sub("^\\S+\\s+", '', OB_m4_res_12$building_description)
head(OB_m4_res_12$sqft)
table(OB_m4_res_12$sqft)

OB_m4_res_12$sqft <- as.numeric(OB_m4_res_12$sqft)

#recoding outlier as NA
hist(OB_m4_res_12$sqft)
plot(OB_m4_res_12$sqft)
#OB_m4_res_12$sqft[OB_m4_res_12$sqft > 6000000] <- NA

table(is.na(OB_m4_res_12$sqft)) #8. For these, median

summary(OB_m4_res_12$sqft) #base it on median

#interpolating missing sqft based on median 
OB_m4_res_12$sqft[is.na(OB_m4_res_12$sqft)] <- 1275

#obtaining total square feet
sum(OB_m4_res_12$sqft)


#2011 sqft ####
##Extracting sqft #
head(ob_m4_res_2011$building_description)
ob_m4_res_2011$sqft <- sub("^\\S+\\s+", '', ob_m4_res_2011$building_description)
head(ob_m4_res_2011$sqft)
table(ob_m4_res_2011$sqft)

ob_m4_res_2011$sqft <- as.numeric(ob_m4_res_2011$sqft)

#recoding outlier as NA
hist(ob_m4_res_2011$sqft)
plot(ob_m4_res_2011$sqft)
#ob_m4_res_2011$sqft[ob_m4_res_2011$sqft > 200000] <- NA

table(is.na(ob_m4_res_2011$sqft)) #17. For these, median

summary(ob_m4_res_2011$sqft) #base it on median

#interpolating missing sqft based on median 
ob_m4_res_2011$sqft[is.na(ob_m4_res_2011$sqft)] <- 1260.0

#obtaining total square feet
sum(ob_m4_res_2011$sqft)


## obtaining number sold and sales price from next years data #
## 2022 sales ####
## Subsetting to 2022 Sales #
names(OB_m4_res_22)
table(is.na(OB_m4_res_22))
OB_sales_22 <- subset(OB_m4_res_22, last_trans_date_MMDDYY %like% "2022")
OB_sales_22 <- subset(OB_sales_22, sale_price > 100) #61

#getting price per square foot
OB_sales_22$SalePricePerSqFt <- OB_sales_22$sale_price / OB_sales_22$sqft
summary(OB_sales_22$SalePricePerSqFt) #median = 280.733
hist(OB_sales_22$SalePricePerSqFt)

#Now going back to all 2022 OB data and applying median sales price per
sum(OB_m4_res_22$sqft)
OB_m4_res_22$SalesPrice_LG <- OB_m4_res_22$sqft * 280.733
sum(OB_m4_res_22$SalesPrice_LG)



# 2021 sales ####

## Subsetting to 2022 data to 2021 Sales #
OB_sales_21 <- subset(OB_m4_res_22, last_trans_date_MMDDYY %like% "2021")
OB_sales_21 <- subset(OB_sales_21, sale_price > 100) #272

#getting price per square foot
OB_sales_21$SalePricePerSqFt <- OB_sales_21$sale_price / OB_sales_21$sqft
summary(OB_sales_21$SalePricePerSqFt) #median = 276.3678 
hist(OB_sales_21$SalePricePerSqFt)

#Now going back to all 2021 OB data and applying median sales price per
sum(OB_m4_res_21$sqft)
OB_m4_res_21$SalesPrice_LG <- OB_m4_res_21$sqft * 276.3678
sum(OB_m4_res_21$SalesPrice_LG)



# 2020 sales ####
## Subsetting to 2021 data to 2020 Sales #
OB_sales_20 <- subset(OB_m4_res_21, last_trans_date_MMDDYY %like% "2020")
OB_sales_20 <- subset(OB_sales_20, sale_price > 100) #301

#getting price per square foot
OB_sales_20$SalePricePerSqFt <- OB_sales_20$sale_price / OB_sales_20$sqft
summary(OB_sales_20$SalePricePerSqFt) #median = 263.736
hist(OB_sales_20$SalePricePerSqFt)

#Now going back to all 2020 OB data and applying median sales price per
sum(OB_m4_res_20$sqft)
OB_m4_res_20$SalesPrice_LG <- OB_m4_res_20$sqft * 263.736
sum(OB_m4_res_20$SalesPrice_LG)


# 2019 sales ####
## Subsetting to 2020 data to 2019 Sales #
OB_sales_19 <- subset(OB_m4_res_20, last_trans_date_MMDDYY %like% "2019")
OB_sales_19 <- subset(OB_sales_19, sale_price > 100) #505

#getting price per square foot
OB_sales_19$SalePricePerSqFt <- OB_sales_19$sale_price / OB_sales_19$sqft
summary(OB_sales_19$SalePricePerSqFt) #median = 182.2157
hist(OB_sales_19$SalePricePerSqFt)

#Now going back to all 2019 OB data and applying median sales price per
sum(OB_m4_res_19$sqft)
OB_m4_res_19$SalesPrice_LG <- OB_m4_res_19$sqft * 182.2157
sum(OB_m4_res_19$SalesPrice_LG)

# 2018 sales ####
## Subsetting to 2019 data to 2018 Sales #
OB_sales_18 <- subset(OB_m4_res_19, last_trans_date_MMDDYY %like% "2018")
OB_sales_18 <- subset(OB_sales_18, sale_price > 100) #258

#getting price per square foot
OB_sales_18$SalePricePerSqFt <- OB_sales_18$sale_price / OB_sales_18$sqft
summary(OB_sales_18$SalePricePerSqFt) #median = 232.474
hist(OB_sales_18$SalePricePerSqFt)

#Now going back to all 2018 OB data and applying median sales price per
sum(OB_m4_res_18$sqft)
OB_m4_res_18$SalesPrice_LG <- OB_m4_res_18$sqft * 232.474
sum(OB_m4_res_18$SalesPrice_LG)


# 2017 sales ####
## Subsetting to 2018 data to 2017 Sales #
OB_sales_17 <- subset(OB_m4_res_18, last_trans_date_MMDDYY %like% "2017")
OB_sales_17 <- subset(OB_sales_17, sale_price > 100) #184

#getting price per square foot
OB_sales_17$SalePricePerSqFt <- OB_sales_17$sale_price / OB_sales_17$sqft
summary(OB_sales_17$SalePricePerSqFt) #median = 211.9745 
hist(OB_sales_17$SalePricePerSqFt)

#Now going back to all 2017 OB data and applying median sales price per
sum(OB_m4_res_17$sqft)
OB_m4_res_17$SalesPrice_LG <- OB_m4_res_17$sqft * 211.9745 
sum(OB_m4_res_17$SalesPrice_LG)

# 2016 sales ####
## Subsetting to 2017 data to 2016 Sales #
OB_sales_16 <- subset(OB_m4_res_17, last_trans_date_MMDDYY %like% "2016")
OB_sales_16 <- subset(OB_sales_16, sale_price > 100) #310

#getting price per square foot
OB_sales_16$SalePricePerSqFt <- OB_sales_16$sale_price / OB_sales_16$sqft
summary(OB_sales_16$SalePricePerSqFt) #median = 214.5389 
hist(OB_sales_16$SalePricePerSqFt)

#Now going back to all 2016 OB data and applying median sales price per
sum(OB_m4_res_16$sqft)
OB_m4_res_16$SalesPrice_LG <- OB_m4_res_16$sqft * 214.5389  
sum(OB_m4_res_16$SalesPrice_LG)

# 2015 sales ####
## Subsetting to 2016 data to 2015 Sales #
OB_sales_15 <- subset(OB_m4_res_16, last_trans_date_MMDDYY %like% "2015")
OB_sales_15 <- subset(OB_sales_15, sale_price > 100) #346

#getting price per square foot
OB_sales_15$SalePricePerSqFt <- OB_sales_15$sale_price / OB_sales_15$sqft
summary(OB_sales_15$SalePricePerSqFt) #median = 157.1087
hist(OB_sales_15$SalePricePerSqFt)

#Now going back to all 2015 OB data and applying median sales price per
sum(OB_m4_res_15$sqft)
OB_m4_res_15$SalesPrice_LG <- OB_m4_res_15$sqft * 157.1087 
sum(OB_m4_res_15$SalesPrice_LG)

# 2014 sales ####
## Subsetting to 2015 data to 2014 Sales #
OB_sales_14 <- subset(OB_m4_res_15, last_trans_date_MMDDYY %like% "2014")
OB_sales_14 <- subset(OB_sales_14, sale_price > 100) #824

#getting price per square foot
OB_sales_14$SalePricePerSqFt <- OB_sales_14$sale_price / OB_sales_14$sqft
summary(OB_sales_14$SalePricePerSqFt) #median = 148.0260
hist(OB_sales_14$SalePricePerSqFt)

#Now going back to all 2014 OB data and applying median sales price per
sum(OB_m4_res_14$sqft)
OB_m4_res_14$SalesPrice_LG <- OB_m4_res_14$sqft * 148.0260 
sum(OB_m4_res_14$SalesPrice_LG)


# 2013 sales ####
## Subsetting to 2014 data to 2013 Sales #
OB_sales_13 <- subset(OB_m4_res_14, last_trans_date_MMDDYY %like% "2013")
OB_sales_13 <- subset(OB_sales_13, sale_price > 100) #140

#getting price per square foot
OB_sales_13$SalePricePerSqFt <- OB_sales_13$sale_price / OB_sales_13$sqft
summary(OB_sales_13$SalePricePerSqFt) #median = 231.04
hist(OB_sales_13$SalePricePerSqFt)

#Now going back to all 2013 OB data and applying median sales price per
sum(OB_m4_res_13$sqft)
OB_m4_res_13$SalesPrice_LG <- OB_m4_res_13$sqft * 231.04 
sum(OB_m4_res_13$SalesPrice_LG)

# 2012 sales ####
## Subsetting to 2013 data to 2012 Sales #
OB_sales_12 <- subset(OB_m4_res_13, last_trans_date_MMDDYY %like% "2012")
OB_sales_12 <- subset(OB_sales_12, sale_price > 100) #83

#getting price per square foot
OB_sales_12$SalePricePerSqFt <- OB_sales_12$sale_price / OB_sales_12$sqft
summary(OB_sales_12$SalePricePerSqFt) #median = 253.753
hist(OB_sales_12$SalePricePerSqFt)

#Now going back to all 2012 OB data and applying median sales price per
sum(OB_m4_res_12$sqft)
OB_m4_res_12$SalesPrice_LG <- OB_m4_res_12$sqft * 253.753 
sum(OB_m4_res_12$SalesPrice_LG)

# 2011 sales ####
## Subsetting to 2012 data to 2011 Sales #
OB_sales_11 <- subset(OB_m4_res_12, last_trans_date_MMDDYY %like% "2011")
OB_sales_11 <- subset(OB_sales_11, sale_price > 100) #144

#getting price per square foot
OB_sales_11$SalePricePerSqFt <- OB_sales_11$sale_price / OB_sales_11$sqft
summary(OB_sales_11$SalePricePerSqFt) #median = 285.30
hist(OB_sales_11$SalePricePerSqFt)

#Now going back to all 2011 OB data and applying median sales price per
names(ob_m4_res_2011)
sum(ob_m4_res_2011$sqft)
ob_m4_res_2011$SalesPrice_LG <- ob_m4_res_2011$sqft * 285.30
sum(ob_m4_res_2011$SalesPrice_LG)


#Examining 2011 carefully ####
names(ob_m4_res_2011)
ob_11_SP <- ob_m4_res_2011[,c("GIS_PIN" ,
                              "sqft",
                              "SalesPrice_LG")]

plot(ob_11_SP$SalesPrice_LG) #note extreme outliers. Winsorizing to not skew buyout price.
range(ob_11_SP$SalesPrice_LG)
quantile(ob_11_SP$SalesPrice_LG, probs=c(0.01, 0.5, 0.99),na.rm=T)
ob_11_SP$SalesPrice_LG_W <- ob_11_SP$SalesPrice_LG
ob_11_SP$SalesPrice_LG_W[ob_11_SP$SalesPrice_LG_W >=1081504   ]<- 1081504 
#ob_11_SP$SalesPrice_LG_W[ob_11_SP$SalesPrice_LG_W <=25323 ]<- 25323 
range(ob_11_SP$SalesPrice_LG_W,na.rm=T)
plot(ob_11_SP$SalesPrice_LG_W)
sum(ob_11_SP$SalesPrice_LG_W)

########### S3 CLUSTER ####
names(S3_OB)
names(S3_OB)[names(S3_OB)=="gis_pin"] <- "GIS_PIN"
S3_OB <- left_join(S3_OB, ob_11_SP, by="GIS_PIN")

table(is.na(S3_OB$SalesPrice_LG_W))
sum(S3_OB$SalesPrice_LG_W)



########### S4 CLUSTER ####
names(S4_OB)
names(S4_OB)[names(S4_OB)=="gis_pin"] <- "GIS_PIN"
S4_OB <- left_join(S4_OB, ob_11_SP, by="GIS_PIN")

table(is.na(S4_OB$SalesPrice_LG_W))
sum(S4_OB$SalesPrice_LG_W)



#writing out relevant files####
path1 <- 'C:/Users/lgero/Box/Research/NJSG/Tradeoff_Analysis/V4/data/BaselineData/OB_MOD4_Produced/TimeSeries/'
write.csv(ob_11_SP , file.path(path1, "S1/OB_2011_SalesPrice.csv"), row.names=TRUE)
write.csv(S3_OB , file.path(path1, "S3/OB_S3_2011_SalesPrice.csv"), row.names=TRUE)
write.csv(S4_OB , file.path(path1, "S4/OB_S4_2011_SalesPrice.csv"), row.names=TRUE)



      