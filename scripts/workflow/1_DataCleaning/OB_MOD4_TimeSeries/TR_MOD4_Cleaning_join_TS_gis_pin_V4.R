##Purpose:
  #Cleaning up MOD4 data and integrating time series
  #Obtaining improvement value and sale prices for use in analysis


getwd()
setwd("C:/Users/lgero/Box/Research/NJSG/Tradeoff_Analysis/V4/")

#libraries####
library(data.table)
library(dplyr)
library(stringr)

options(scipen=999)

##Loading Raw HMA data####

#ob_m4_2020 <- read.csv('./Data/NJ/MOD_IV/Produced/OB_m4_2020.csv')
ob_m4_res_2011 <- read.csv('./data/BaselineData/OB_MOD4_Produced/FromGIS/OB_Cad_parcel_M4_2011_Res.csv')
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
tr_m4_2011 <- read.csv('./data/DataDownloads/TomsRiver/TR_MOD4/TR_2010_2022/mod_iv_data/mod_iv_2011.csv')
tr_m4_2010 <- read.csv('./data/DataDownloads/TomsRiver/TR_MOD4/TR_2010_2022/mod_iv_data/mod_iv_2010.csv')


#
names(tr_m4_2020)
head(tr_m4_2020$gis_pin)

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


#cleaning M4 2022####
names(tr_m4_2022)
head(tr_m4_2022)
table(tr_m4_2022$property_class) 
tr_m4_2022_res <- subset(tr_m4_2022, property_class=="2") #sub-setting to '2'= 'Residential (four families or less)'
names(tr_m4_2022_res)
table(tr_m4_2022_res$property_class_code_name)
tr_m4_2022_res1 <- tr_m4_2022_res[,c("gis_pin",
                                     "street_address", 
                                     "property_class",
                                     "property_class_code_name",
                                     "sale_price",
                                     "sale_assessment",
                                     "land_value",
                                     "improvement_value",
                                     "net_taxable_value")]

names(tr_m4_2022_res1)
colSums(is.na(tr_m4_2022_res1))
range(tr_m4_2022_res1$sale_price)
see0s <- subset(tr_m4_2022_res1, sale_price==0) #2990
range(tr_m4_2022_res1$improvement_value)
see0s <- subset(tr_m4_2022_res1, improvement_value==0) #5

#renaming 2022 column headers####
original_cols <- colnames(tr_m4_2022_res1)
print(original_cols)
#adding prefix using the paste funding in R
colnames(tr_m4_2022_res1)<- paste("y22", original_cols, sep="_")
names(tr_m4_2022_res1)

names(tr_m4_2022_res1)[names(tr_m4_2022_res1)=="y22_gis_pin"] <- "gis_pin"
#names(tr_m4_2022_res1)[names(tr_m4_2022_res1)=="y20_old_property_id"] <- "old_property_id"


##joining M4_2022 to OB Base on GIS PIN####
#seeking dimensions 1855 
OB_m4_res_v0 <- left_join(OB_ResBase, tr_m4_2022_res1, by="gis_pin", copy=F)
colSums(is.na(OB_m4_res_v0)) #missing data on 110  buildings.

Seey22NAs<- OB_m4_res_v0[rowSums(is.na(OB_m4_res_v0))>0,] #110


###############


#cleaning M4 2021####
names(tr_m4_2021)
head(tr_m4_2021)
table(tr_m4_2021$property_class) 
tr_m4_2021_res <- subset(tr_m4_2021, property_class=="2") #sub-setting to '2'= 'Residential (four families or less)'
names(tr_m4_2021_res)
table(tr_m4_2021_res$property_class_code_name)
tr_m4_2021_res1 <- tr_m4_2021_res[,c("gis_pin",
                                     "street_address", 
                                     "property_class",
                                     "property_class_code_name",
                                     "sale_price",
                                     "sale_assessment",
                                     "land_value",
                                     "improvement_value",
                                     "net_taxable_value")]

names(tr_m4_2021_res1)
colSums(is.na(tr_m4_2021_res1))
range(tr_m4_2021_res1$sale_price)
see0s <- subset(tr_m4_2021_res1, sale_price==0) #3281
range(tr_m4_2021_res1$improvement_value)
see0s <- subset(tr_m4_2021_res1, improvement_value==0) #47

#renaming 2021 column headers####
original_cols <- colnames(tr_m4_2021_res1)
print(original_cols)
#adding prefix using the paste funding in R
colnames(tr_m4_2021_res1)<- paste("y21", original_cols, sep="_")
names(tr_m4_2021_res1)

names(tr_m4_2021_res1)[names(tr_m4_2021_res1)=="y21_gis_pin"] <- "gis_pin"
#names(tr_m4_2021_res1)[names(tr_m4_2021_res1)=="y20_old_property_id"] <- "old_property_id"


##joining M4_2021 to OB Base on GIS PIN####
#seeking dimensions 1765 by 36
OB_m4_res_v1 <- left_join(OB_m4_res_v0, tr_m4_2021_res1, by="gis_pin", copy=F)
colSums(is.na(OB_m4_res_v1)) #missing data on 127  buildings.

Seey20NAs<- OB_m4_res_v1[rowSums(is.na(OB_m4_res_v1))>0,]


###############


#cleaning M4 2020####
names(tr_m4_2020)
head(tr_m4_2020)
table(tr_m4_2020$property_class) 
tr_m4_2020_res <- subset(tr_m4_2020, property_class=="2") #sub-setting to '2'= 'Residential (four families or less)'
names(tr_m4_2020_res)
table(tr_m4_2020_res$property_class_code_name)
tr_m4_2020_res1 <- tr_m4_2020_res[,c("gis_pin",
                                    "street_address", 
                                    "property_class",
                                    "property_class_code_name",
                                    "sale_price",
                                    "sale_assessment",
                                    "land_value",
                                    "improvement_value",
                                    "net_taxable_value")]

names(tr_m4_2020_res1)
colSums(is.na(tr_m4_2020_res1))
range(tr_m4_2020_res1$sale_price)
see0s <- subset(tr_m4_2020_res1, sale_price==0) #3496
range(tr_m4_2020_res1$improvement_value)
see0s <- subset(tr_m4_2020_res1, improvement_value==0) #4

#renaming 2020 column headers####
original_cols <- colnames(tr_m4_2020_res1)
print(original_cols)
#adding prefix using the paste funding in R
colnames(tr_m4_2020_res1)<- paste("y20", original_cols, sep="_")
names(tr_m4_2020_res1)

names(tr_m4_2020_res1)[names(tr_m4_2020_res1)=="y20_gis_pin"] <- "gis_pin"
#names(tr_m4_2020_res1)[names(tr_m4_2020_res1)=="y20_old_property_id"] <- "old_property_id"


##joining M4_2020 to OB Base on GIS PIN####
#seeking dimensions 1765 by 36
OB_m4_res_v1 <- left_join(OB_m4_res_v1, tr_m4_2020_res1, by="gis_pin", copy=F)
colSums(is.na(OB_m4_res_v1)) #missing data on 149  buildings.

Seey20NAs<- OB_m4_res_v1[rowSums(is.na(OB_m4_res_v1))>0,]



##########################

#cleaning M4 2019####
names(tr_m4_2019)
head(tr_m4_2019)
table(tr_m4_2019$property_class) 
tr_m4_2019_res <- subset(tr_m4_2019, property_class=="2") #sub-setting to '2'= 'Residential (four families or less)'
tr_m4_2019_res1 <- tr_m4_2019_res[,c("gis_pin",
                                     "street_address", 
                                     "property_class",
                                     "property_class_code_name",
                                     "sale_price",
                                     "sale_assessment",
                                     "land_value",
                                     "improvement_value",
                                     "net_taxable_value")]
names(tr_m4_2019_res1)
colSums(is.na(tr_m4_2019_res1))

#renaming 2019 column headers####
original_cols <- colnames(tr_m4_2019_res1)
print(original_cols)
#adding prefix using the paste funding in R
colnames(tr_m4_2019_res1)<- paste("y19", original_cols, sep="_")
names(tr_m4_2019_res1)

names(tr_m4_2019_res1)[names(tr_m4_2019_res1)=="y19_gis_pin"] <- "gis_pin"

##joining M4_2019 to OB Base####
#seeking dimensions 1765 
OB_m4_res_v2 <- left_join(OB_m4_res_v1, tr_m4_2019_res1, by="gis_pin", copy=F)
colSums(is.na(OB_m4_res_v2)) #missing data on 182 buildings

##########################

#cleaning M4 2018####
names(tr_m4_2018)
head(tr_m4_2018)
table(tr_m4_2018$property_class) 
tr_m4_2018_res <- subset(tr_m4_2018, property_class=="2") #sub-setting to '2'= 'Residential (four families or less)'
tr_m4_2018_res1 <- tr_m4_2018_res[,c("gis_pin",
                                     "street_address", 
                                     "property_class",
                                     "property_class_code_name",
                                     "sale_price",
                                     "sale_assessment",
                                     "land_value",
                                     "improvement_value",
                                     "net_taxable_value")]
names(tr_m4_2018_res1)
colSums(is.na(tr_m4_2018_res1))

#renaming 2018 column headers####
original_cols <- colnames(tr_m4_2018_res1)
print(original_cols)
#adding prefix using the paste funding in R
colnames(tr_m4_2018_res1)<- paste("y18", original_cols, sep="_")
names(tr_m4_2018_res1)

names(tr_m4_2018_res1)[names(tr_m4_2018_res1)=="y18_gis_pin"] <- "gis_pin"

##joining M4_2018 to OB Base####
#seeking dimensions 1765 
OB_m4_res_v3 <- left_join(OB_m4_res_v2, tr_m4_2018_res1, by="gis_pin", copy=F)
colSums(is.na(OB_m4_res_v3)) #missing data on 229 buildings

##########################

#cleaning M4 2017####
names(tr_m4_2017)
head(tr_m4_2017)
table(tr_m4_2017$property_class) 
tr_m4_2017_res <- subset(tr_m4_2017, property_class=="2") #sub-setting to '2'= 'Residential (four families or less)'
tr_m4_2017_res1 <- tr_m4_2017_res[,c("gis_pin",
                                     "street_address", 
                                     "property_class",
                                     "property_class_code_name",
                                     "sale_price",
                                     "sale_assessment",
                                     "land_value",
                                     "improvement_value",
                                     "net_taxable_value")]
names(tr_m4_2017_res1)
colSums(is.na(tr_m4_2017_res1))

#renaming 2017 column headers####
original_cols <- colnames(tr_m4_2017_res1)
print(original_cols)
#adding prefix using the paste funding in R
colnames(tr_m4_2017_res1)<- paste("y17", original_cols, sep="_")
names(tr_m4_2017_res1)

names(tr_m4_2017_res1)[names(tr_m4_2017_res1)=="y17_gis_pin"] <- "gis_pin"

##joining M4_2017 to OB Base####
#seeking dimensions 1765 
OB_m4_res_v4 <- left_join(OB_m4_res_v3, tr_m4_2017_res1, by="gis_pin", copy=F)
colSums(is.na(OB_m4_res_v4)) #missing data on 286 buildings


##########################

#cleaning M4 2016####
names(tr_m4_2016)
head(tr_m4_2016)
table(tr_m4_2016$property_class) 
tr_m4_2016_res <- subset(tr_m4_2016, property_class=="2") #sub-setting to '2'= 'Residential (four families or less)'
tr_m4_2016_res1 <- tr_m4_2016_res[,c("gis_pin",
                                     "street_address", 
                                     "property_class",
                                     "property_class_code_name",
                                     "sale_price",
                                     "sale_assessment",
                                     "land_value",
                                     "improvement_value",
                                     "net_taxable_value")]
names(tr_m4_2016_res1)
colSums(is.na(tr_m4_2016_res1))

#renaming 2016 column headers####
original_cols <- colnames(tr_m4_2016_res1)
print(original_cols)
#adding prefix using the paste funding in R
colnames(tr_m4_2016_res1)<- paste("y16", original_cols, sep="_")
names(tr_m4_2016_res1)

names(tr_m4_2016_res1)[names(tr_m4_2016_res1)=="y16_gis_pin"] <- "gis_pin"

##joining M4_2016 to OB Base####
#seeking dimensions 1765 
OB_m4_res_v5 <- left_join(OB_m4_res_v4, tr_m4_2016_res1, by="gis_pin", copy=F)
colSums(is.na(OB_m4_res_v5)) #missing data on 357 buildings, 




##########################

#cleaning M4 2015####
names(tr_m4_2015)
head(tr_m4_2015)
table(tr_m4_2015$property_class) 
tr_m4_2015_res <- subset(tr_m4_2015, property_class=="2") #sub-setting to '2'= 'Residential (four families or less)'
tr_m4_2015_res1 <- tr_m4_2015_res[,c("gis_pin",
                                     "street_address", 
                                     "property_class",
                                     "property_class_code_name",
                                     "sale_price",
                                     "sale_assessment",
                                     "land_value",
                                     "improvement_value",
                                     "net_taxable_value")]
names(tr_m4_2015_res1)
colSums(is.na(tr_m4_2015_res1))

#renaming 2015 column headers####
original_cols <- colnames(tr_m4_2015_res1)
print(original_cols)
#adding prefix using the paste funding in R
colnames(tr_m4_2015_res1)<- paste("y15", original_cols, sep="_")
names(tr_m4_2015_res1)

names(tr_m4_2015_res1)[names(tr_m4_2015_res1)=="y15_gis_pin"] <- "gis_pin"

##joining M4_2015 to OB Base####
#seeking dimensions 1765 
OB_m4_res_v6 <- left_join(OB_m4_res_v5, tr_m4_2015_res1, by="gis_pin", copy=F)
colSums(is.na(OB_m4_res_v6)) #missing data on 434 buildings,



##########################

#cleaning M4 2014####
names(tr_m4_2014)
head(tr_m4_2014)
table(tr_m4_2014$property_class) 
tr_m4_2014_res <- subset(tr_m4_2014, property_class=="2") #sub-setting to '2'= 'Residential (four families or less)'
tr_m4_2014_res1 <- tr_m4_2014_res[,c("gis_pin",
                                     "street_address", 
                                     "property_class",
                                     "property_class_code_name",
                                     "sale_price",
                                     "sale_assessment",
                                     "land_value",
                                     "improvement_value",
                                     "net_taxable_value")]
names(tr_m4_2014_res1)
colSums(is.na(tr_m4_2014_res1))

#renaming 2014 column headers####
original_cols <- colnames(tr_m4_2014_res1)
print(original_cols)
#adding prefix using the paste funding in R
colnames(tr_m4_2014_res1)<- paste("y14", original_cols, sep="_")
names(tr_m4_2014_res1)

names(tr_m4_2014_res1)[names(tr_m4_2014_res1)=="y14_gis_pin"] <- "gis_pin"

##joining M4_2014 to OB Base####
#seeking dimensions 1765 
OB_m4_res_v7 <- left_join(OB_m4_res_v6, tr_m4_2014_res1, by="gis_pin", copy=F)
colSums(is.na(OB_m4_res_v7)) #missing data on 5 buildings, 



##########################

#cleaning M4 2013####
names(tr_m4_2013)
head(tr_m4_2013)
table(tr_m4_2013$property_class) 
tr_m4_2013_res <- subset(tr_m4_2013, property_class=="2") #sub-setting to '2'= 'Residential (four families or less)'
tr_m4_2013_res1 <- tr_m4_2013_res[,c("gis_pin",
                                     "street_address", 
                                     "property_class",
                                     "property_class_code_name",
                                     "sale_price",
                                     "sale_assessment",
                                     "land_value",
                                     "improvement_value",
                                     "net_taxable_value")]
names(tr_m4_2013_res1)
colSums(is.na(tr_m4_2013_res1))

#renaming 2013 column headers####
original_cols <- colnames(tr_m4_2013_res1)
print(original_cols)
#adding prefix using the paste funding in R
colnames(tr_m4_2013_res1)<- paste("y13", original_cols, sep="_")
names(tr_m4_2013_res1)

names(tr_m4_2013_res1)[names(tr_m4_2013_res1)=="y13_gis_pin"] <- "gis_pin"

##joining M4_2013 to OB Base####
#seeking dimensions 1765 
OB_m4_res_v8 <- left_join(OB_m4_res_v7, tr_m4_2013_res1, by="gis_pin", copy=F)
colSums(is.na(OB_m4_res_v8)) #missing data on 12 buildings, 



##########################

#cleaning M4 2012####
names(tr_m4_2012)
head(tr_m4_2012)
table(tr_m4_2012$property_class) 
tr_m4_2012_res <- subset(tr_m4_2012, property_class=="2") #sub-setting to '2'= 'Residential (four families or less)'
tr_m4_2012_res1 <- tr_m4_2012_res[,c("gis_pin",
                                     "street_address", 
                                     "property_class",
                                     "property_class_code_name",
                                     "sale_price",
                                     "sale_assessment",
                                     "land_value",
                                     "improvement_value",
                                     "net_taxable_value")]
names(tr_m4_2012_res1)
colSums(is.na(tr_m4_2012_res1))

#renaming 2012 column headers####
original_cols <- colnames(tr_m4_2012_res1)
print(original_cols)
#adding prefix using the paste funding in R
colnames(tr_m4_2012_res1)<- paste("y12", original_cols, sep="_")
names(tr_m4_2012_res1)

names(tr_m4_2012_res1)[names(tr_m4_2012_res1)=="y12_gis_pin"] <- "gis_pin"

##joining M4_2012 to OB Base####
#seeking dimensions 1765 
OB_m4_res_v9 <- left_join(OB_m4_res_v8, tr_m4_2012_res1, by="gis_pin", copy=F)
colSums(is.na(OB_m4_res_v9)) #missing data on 12 buildings, 



##########################

#cleaning M4 2011####
names(tr_m4_2011)
head(tr_m4_2011)
table(tr_m4_2011$property_class) 
tr_m4_2011_res <- subset(tr_m4_2011, property_class=="2") #sub-setting to '2'= 'Residential (four families or less)'
tr_m4_2011_res1 <- tr_m4_2011_res[,c("gis_pin",
                                     "street_address", 
                                     "property_class",
                                     "property_class_code_name",
                                     "sale_price",
                                     "sale_assessment",
                                     "land_value",
                                     "improvement_value",
                                     "net_taxable_value")]
names(tr_m4_2011_res1)
colSums(is.na(tr_m4_2011_res1))

#renaming 2011 column headers####
original_cols <- colnames(tr_m4_2011_res1)
print(original_cols)
#adding prefix using the paste funding in R
colnames(tr_m4_2011_res1)<- paste("y11", original_cols, sep="_")
names(tr_m4_2011_res1)

names(tr_m4_2011_res1)[names(tr_m4_2011_res1)=="y11_gis_pin"] <- "gis_pin"

##joining M4_2011 to OB Base####
#seeking dimensions 1765 
OB_m4_res_v10 <- left_join(OB_m4_res_v9, tr_m4_2011_res1, by="gis_pin", copy=F)
colSums(is.na(OB_m4_res_v10)) #missing data on 0 buildings, 



##########################

#cleaning M4 2010####
names(tr_m4_2010)
head(tr_m4_2010)
table(tr_m4_2010$property_class) 
tr_m4_2010_res <- subset(tr_m4_2010, property_class=="2") #sub-setting to '2'= 'Residential (four families or less)'
tr_m4_2010_res1 <- tr_m4_2010_res[,c("gis_pin",
                                     "street_address", 
                                     "property_class",
                                     "property_class_code_name",
                                     "sale_price",
                                     "sale_assessment",
                                     "land_value",
                                     "improvement_value",
                                     "net_taxable_value")]
names(tr_m4_2010_res1)
colSums(is.na(tr_m4_2010_res1))

#renaming 2010 column headers####
original_cols <- colnames(tr_m4_2010_res1)
print(original_cols)
#adding prefix using the paste funding in R
colnames(tr_m4_2010_res1)<- paste("y10", original_cols, sep="_")
names(tr_m4_2010_res1)

names(tr_m4_2010_res1)[names(tr_m4_2010_res1)=="y10_gis_pin"] <- "gis_pin"

##joining M4_2010 to OB Base####
#seeking dimensions 1765 
OB_m4_res_v11 <- left_join(OB_m4_res_v10, tr_m4_2010_res1, by="gis_pin", copy=F)
colSums(is.na(OB_m4_res_v11)) #missing data on 16 buildings


#####################################

##Examining Missing Data####
colSums(is.na(OB_m4_res_v11))
#
#missing lots of data for certain years
table(OB_m4_res_v11$y20_number_of_dwellings)
table(OB_m4_res_v11$y20_number_of_dwellings)

#how to interpret building description
table(OB_m4_res_v11$y20_building_description)

#subsetting out columns with lots of missing data
#y19_building_class_code
#y18_building_class_code 
#y17_building_class_code 
#y15_number_of_dwellings
#y14_number_of_dwellings
#y13_number_of_dwellings 
#y12_number_of_dwellings 
#y12_building_class_code
#y11_number_of_dwellings
#y11_building_class_code 
#y10_number_of_dwellings
#y10_building_class_code 

##seeNAs
names(OB_m4_res_v11)
ExploreNAs <- OB_m4_res_v11[rowSums(is.na(OB_m4_res_v11)) > 0, ] #632 rows have some kind of missing data. 
        #That is 33%: a lot...could be that there have been that many new houses? Check change in housing units
colSums(is.na(ExploreNAs))


##summing for data input excel ####
y20_assessedVal <- sum(OB_m4_res_v11$y20_improvement_value, na.rm=T)
y21_assessedVal <- sum(OB_m4_res_v11$y21_improvement_value, na.rm=T)
y22_assessedVal <- sum(OB_m4_res_v11$y22_improvement_value, na.rm=T)
y11_assessedVal <- sum(OB_m4_res_v11$y11_improvement_value, na.rm=T)

#obtaining change is sales value####
#sale Price ####
table(is.na(OB_m4_res_v11$y22_sale_price)) ##110
hist(OB_m4_res_v11$y22_sale_price)
y22_sale_price <- sum(OB_m4_res_v11$y22_sale_price, na.rm=T)

table(is.na(OB_m4_res_v11$y21_sale_price)) ##127
hist(OB_m4_res_v11$y21_sale_price)
y21_sale_price <- sum(OB_m4_res_v11$y21_sale_price, na.rm=T)

table(is.na(OB_m4_res_v11$y20_sale_price)) ##149
hist(OB_m4_res_v11$y20_sale_price)
y20_sale_price <- sum(OB_m4_res_v11$y20_sale_price, na.rm=T)

table(is.na(OB_m4_res_v11$y19_sale_price)) ##182
hist(OB_m4_res_v11$y19_sale_price)
y19_sale_price <- sum(OB_m4_res_v11$y19_sale_price, na.rm=T)

table(is.na(OB_m4_res_v11$y18_sale_price)) ##229
hist(OB_m4_res_v11$y18_sale_price)
y18_sale_price <- sum(OB_m4_res_v11$y18_sale_price, na.rm=T)

table(is.na(OB_m4_res_v11$y17_sale_price)) ##286
hist(OB_m4_res_v11$y17_sale_price)
y17_sale_price <- sum(OB_m4_res_v11$y17_sale_price, na.rm=T)

table(is.na(OB_m4_res_v11$y16_sale_price)) ##357
hist(OB_m4_res_v11$y16_sale_price)
y16_sale_price <- sum(OB_m4_res_v11$y16_sale_price, na.rm=T)

table(is.na(OB_m4_res_v11$y15_sale_price)) ##434
hist(OB_m4_res_v11$y15_sale_price)
y15_sale_price <- sum(OB_m4_res_v11$y15_sale_price, na.rm=T)

table(is.na(OB_m4_res_v11$y14_sale_price)) ##5
hist(OB_m4_res_v11$y14_sale_price)
y14_sale_price <- sum(OB_m4_res_v11$y14_sale_price, na.rm=T)

table(is.na(OB_m4_res_v11$y13_sale_price)) ##12
hist(OB_m4_res_v11$y13_sale_price)
y13_sale_price <- sum(OB_m4_res_v11$y13_sale_price, na.rm=T)

table(is.na(OB_m4_res_v11$y12_sale_price)) ##12
hist(OB_m4_res_v11$y12_sale_price)
y12_sale_price <- sum(OB_m4_res_v11$y12_sale_price, na.rm=T)

table(is.na(OB_m4_res_v11$y11_sale_price)) ##none
hist(OB_m4_res_v11$y11_sale_price)
y11_sale_price <- sum(OB_m4_res_v11$y11_sale_price, na.rm=T)

table(is.na(OB_m4_res_v11$y10_sale_price)) ##16
hist(OB_m4_res_v11$y10_sale_price)
y10_sale_price <- sum(OB_m4_res_v11$y10_sale_price, na.rm=T)


#sale assessment ####
table(is.na(OB_m4_res_v11$y22_sale_assessment)) ##110
hist(OB_m4_res_v11$y22_sale_assessment)
y22_sale_assessment <- sum(OB_m4_res_v11$y22_sale_assessment, na.rm=T)

table(is.na(OB_m4_res_v11$y21_sale_assessment)) ##127
hist(OB_m4_res_v11$y21_sale_assessment)
y21_sale_assessment <- sum(OB_m4_res_v11$y21_sale_assessment, na.rm=T)

table(is.na(OB_m4_res_v11$y20_sale_assessment)) ##149
hist(OB_m4_res_v11$y20_sale_assessment)
y20_sale_assessment <- sum(OB_m4_res_v11$y20_sale_assessment, na.rm=T)

table(is.na(OB_m4_res_v11$y19_sale_assessment)) ##182
hist(OB_m4_res_v11$y19_sale_assessment)
y19_sale_assessment <- sum(OB_m4_res_v11$y19_sale_assessment, na.rm=T)

table(is.na(OB_m4_res_v11$y18_sale_assessment)) ##229
hist(OB_m4_res_v11$y18_sale_assessment)
y18_sale_assessment <- sum(OB_m4_res_v11$y18_sale_assessment, na.rm=T)

table(is.na(OB_m4_res_v11$y17_sale_assessment)) ##286
hist(OB_m4_res_v11$y17_sale_assessment)
y17_sale_assessment <- sum(OB_m4_res_v11$y17_sale_assessment, na.rm=T)

table(is.na(OB_m4_res_v11$y16_sale_assessment)) ##357
hist(OB_m4_res_v11$y16_sale_assessment)
y16_sale_assessment <- sum(OB_m4_res_v11$y16_sale_assessment, na.rm=T)

table(is.na(OB_m4_res_v11$y15_sale_assessment)) ##434
hist(OB_m4_res_v11$y15_sale_assessment)
y15_sale_assessment <- sum(OB_m4_res_v11$y15_sale_assessment, na.rm=T)

table(is.na(OB_m4_res_v11$y14_sale_assessment)) ##5
hist(OB_m4_res_v11$y14_sale_assessment)
y14_sale_assessment <- sum(OB_m4_res_v11$y14_sale_assessment, na.rm=T)

table(is.na(OB_m4_res_v11$y13_sale_assessment)) ##12
hist(OB_m4_res_v11$y13_sale_assessment)
y13_sale_assessment <- sum(OB_m4_res_v11$y13_sale_assessment, na.rm=T)

table(is.na(OB_m4_res_v11$y12_sale_assessment)) ##12
hist(OB_m4_res_v11$y12_sale_assessment)
y12_sale_assessment <- sum(OB_m4_res_v11$y12_sale_assessment, na.rm=T)

table(is.na(OB_m4_res_v11$y11_sale_assessment)) ##none
hist(OB_m4_res_v11$y11_sale_assessment)
y11_sale_assessment <- sum(OB_m4_res_v11$y11_sale_assessment, na.rm=T)

table(is.na(OB_m4_res_v11$y10_sale_assessment)) ##16
hist(OB_m4_res_v11$y10_sale_assessment)
y10_sale_assessment <- sum(OB_m4_res_v11$y10_sale_assessment, na.rm=T)

###exporting data ####
path1 <- 'C:/Users/lgero/Box/Research/NJSG/Tradeoff_Analysis/V4/data/BaselineData/OB_MOD4_Produced/TimeSeries/S1/'
write.csv(OB_m4_res_v11, file.path(path1, "OB_m4_res_TS2.csv"), row.names=TRUE)
write.csv(ExploreNAs, file.path(path1, "SeeNAs2.csv"), row.names=TRUE)










