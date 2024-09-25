#Cleaning downloaded NFIP data and subsetting to  

getwd()
setwd('C:/Users/lgero/Box/Research/NJSG/Tradeoff_Analysis/V4')

##Libraries
library(dplyr)
library(stringr)
library(data.table)
library(httr)
library(jsonlite)
library(tidyverse)
library(tidycensus)
library(dplyr)
library(stringr)
library(rjson)
library(httr)
library(sqldf)
library(tibble)


# importing NFIP Data####
NFIP <- fread('./data/DataDownloads/NFIP/Claims/FimaNfipClaims.csv', header=TRUE)
Adjust <- read.csv('./data/BaselineData/InflationAdjusters.csv')

#subsetting to Zip Code encompassing Ortley Beach ####
NFIP$reportedZipcode <- str_pad(NFIP$reportedZipcode, 5, pad="0")
ZOB_NFIP <- subset(NFIP, reportedZipcode=="08751")

#subsetting to data range 2012-2022 ####
ZOB_NFIP <- subset(ZOB_NFIP, yearOfLoss >2011 & yearOfLoss < 2023)


#Examining housing types
table(ZOB_NFIP$primaryResidence)
table(ZOB_NFIP$occupancyType)

#One-digit code: 
  #1: Single family residence; 
  #2: 2 to 4 unit residential building; 
  #3: Residential building with more than 4 units; 
  #4: Non-residential building; 
  #6: Non Residential - Business; 
  #11: Single-family residential building with the exception of a mobile home or a single residential unit within a multi-unit building; 
  #12: A residential non-condo building with 2, 3, or 4 units seeking insurance on all units; 
  #13: A residential non-condo building with 5 or more units seeking insurance on all units; 
  #14: Residential mobile/manufactured home; 
  #15: Residential condo association seeking coverage on a building with one or more units; 
  #16: Single residential unit within a multi-unit building; 
  #17: Non-residential mobile/manufactured home; 
  #18: A non-residential building;
  #19: A non-residential unit within a multi-unit building

#subsetting to residential ####
ZOB_NFIP2 <- subset(ZOB_NFIP, occupancyType!=4 &
                      occupancyType!=6  &
                      occupancyType!=17 &
                      occupancyType!=18 &
                      occupancyType!=19)
colSums(is.na(ZOB_NFIP2))

ZOB_NFIP3 <- subset(ZOB_NFIP2, houseWorship==0)

#Aggregating claims by yearOfLoss ####
ZOB_Tot_amountPaidOnContentsClaim <-  ZOB_NFIP3 %>%
  group_by(yearOfLoss) %>%
  summarise(ZOB_Tot_amountPaidOnContentsClaim = sum(amountPaidOnContentsClaim, na.rm=T)) 

ZOB_Tot_amountPaidOnBuildingClaim <-  ZOB_NFIP3 %>%
  group_by(yearOfLoss) %>%
  summarise(ZOB_Tot_amountPaidOnBuildingClaim = sum(amountPaidOnBuildingClaim, na.rm=T)) 

ZOB_Tot_amountPaidOnIncreasedCostOfComplianceClaim <-  ZOB_NFIP3 %>%
  group_by(yearOfLoss) %>%
  summarise(ZOB_Tot_amountPaidOnIncreasedCostOfComplianceClaim = sum(amountPaidOnIncreasedCostOfComplianceClaim, na.rm=T)) 

##Joining ZCTA claims data ####
ZOB_NFIP_Claims <- left_join(ZOB_Tot_amountPaidOnBuildingClaim, ZOB_Tot_amountPaidOnContentsClaim, by="yearOfLoss")
ZOB_NFIP_Claims <- left_join(ZOB_NFIP_Claims, ZOB_Tot_amountPaidOnIncreasedCostOfComplianceClaim, by="yearOfLoss")

#Adjusting claims for inflation #### 

#selecting multipliers
Adjust <- Adjust %>% select(
  "Year",
  "CPI_Multiplier_USD2020",
)

ZOB_NFIP_Claims <- left_join(ZOB_NFIP_Claims, Adjust, by=c("yearOfLoss"="Year"))

#adjusting claims data
ZOB_NFIP_Claims$NFIP_BuildingsClaims_adj <- ZOB_NFIP_Claims$ZOB_Tot_amountPaidOnBuildingClaim * ZOB_NFIP_Claims$CPI_Multiplier_USD2020

ZOB_NFIP_Claims$NFIP_ContentsClaims_adj <- ZOB_NFIP_Claims$ZOB_Tot_amountPaidOnContentsClaim * ZOB_NFIP_Claims$CPI_Multiplier_USD2020

ZOB_NFIP_Claims$NFIP_ICCClaims_adj <- ZOB_NFIP_Claims$ZOB_Tot_amountPaidOnIncreasedCostOfComplianceClaim * ZOB_NFIP_Claims$CPI_Multiplier_USD2020

#retaining CPI adjusted data
ZOB_NFIP_Claims <- ZOB_NFIP_Claims %>% select(
  yearOfLoss,
  NFIP_BuildingsClaims_adj,
  NFIP_ContentsClaims_adj,
  NFIP_ICCClaims_adj
)

names(ZOB_NFIP_Claims)[names(ZOB_NFIP_Claims)=="yearOfLoss"] <- "Year"

##Writing out files
path1 <- './data/DataDownloads/NFIP/Claims/produced'
write.csv(ZOB_NFIP_Claims, file.path(path1, "ZCTA_OB_NFIP_Claims.csv"), row.names=TRUE)
