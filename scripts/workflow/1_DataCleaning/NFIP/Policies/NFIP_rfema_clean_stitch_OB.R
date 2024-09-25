#Purpose:
#cleaning and joining policy data together####

##Setup####
getwd()
setwd('C:/Users/lgero/Box/Research/NJSG/Tradeoff_Analysis/V4')

##Libraries
library(dplyr)
library(stringr)
library(Hmisc)
library(tidycensus)
library(data.table)


##importing data ####
y10_Pol <- read.csv('./data/DataDownloads/NFIP/Policies/produced/ZCTA_08571/y10_ZCTA_08571.csv')
y11_Pol <- read.csv('./data/DataDownloads/NFIP/Policies/produced/ZCTA_08571/y11_ZCTA_08571.csv')
y12_Pol <- read.csv('./data/DataDownloads/NFIP/Policies/produced/ZCTA_08571/y12_ZCTA_08571.csv')
y13_Pol <- read.csv('./data/DataDownloads/NFIP/Policies/produced/ZCTA_08571/y13_ZCTA_08571.csv')
y14_Pol <- read.csv('./data/DataDownloads/NFIP/Policies/produced/ZCTA_08571/y14_ZCTA_08571.csv')
y15_Pol <- read.csv('./data/DataDownloads/NFIP/Policies/produced/ZCTA_08571/y15_ZCTA_08571.csv')
y16_Pol <- read.csv('./data/DataDownloads/NFIP/Policies/produced/ZCTA_08571/y16_ZCTA_08571.csv')
y17_Pol <- read.csv('./data/DataDownloads/NFIP/Policies/produced/ZCTA_08571/y17_ZCTA_08571.csv')
y18_Pol <- read.csv('./data/DataDownloads/NFIP/Policies/produced/ZCTA_08571/y18_ZCTA_08571.csv')
y19_Pol <- read.csv('./data/DataDownloads/NFIP/Policies/produced/ZCTA_08571/y19_ZCTA_08571.csv')
y20_Pol <- read.csv('./data/DataDownloads/NFIP/Policies/produced/ZCTA_08571/y20_ZCTA_08571.csv')

#cleaning ####
head(y10_Pol)
y10_Pol <- y10_Pol[c(-1)]
y11_Pol <- y11_Pol[c(-1)]
y12_Pol <- y12_Pol[c(-1)]
y13_Pol <- y13_Pol[c(-1)]
y14_Pol <- y14_Pol[c(-1)]
y15_Pol <- y15_Pol[c(-1)]
y16_Pol <- y16_Pol[c(-1)]
y17_Pol <- y17_Pol[c(-1)]
y18_Pol <- y18_Pol[c(-1)]
y19_Pol <- y19_Pol[c(-1)]
y20_Pol <- y20_Pol[c(-1)]

table(y10_Pol$elevatedBuildingIndicator)
table(y11_Pol$elevatedBuildingIndicator)
table(y12_Pol$elevatedBuildingIndicator)
table(y13_Pol$elevatedBuildingIndicator)
table(y14_Pol$elevatedBuildingIndicator)
table(y15_Pol$elevatedBuildingIndicator)
table(y16_Pol$elevatedBuildingIndicator)
table(y17_Pol$elevatedBuildingIndicator)
table(y18_Pol$elevatedBuildingIndicator)
table(y19_Pol$elevatedBuildingIndicator)
table(y20_Pol$elevatedBuildingIndicator)

CPI <-c(1.19,1.17,1.14,1.12,1.10,1.10,1.09,1.06,1.04,1.02,1.00)
Year <- c(2010:2020)
CPI  <- data.frame(Year, CPI)

#creating annual dataframe, adjusting for inflation, and finding average per house####
PolSum <- data.frame(policyEffectiveYear=c(2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020),
                     numberOfPolicies=c(nrow(y10_Pol),nrow(y11_Pol),nrow(y12_Pol),nrow(y13_Pol),nrow(y14_Pol),nrow(y15_Pol),nrow(y16_Pol),nrow(y17_Pol),nrow(y18_Pol),nrow(y19_Pol),nrow(y20_Pol)),
                     sumOfPolicyCost=c(sum(y10_Pol$policyCost),sum(y11_Pol$policyCost),sum(y12_Pol$policyCost),sum(y13_Pol$policyCost),sum(y14_Pol$policyCost),sum(y15_Pol$policyCost),sum(y16_Pol$policyCost),sum(y17_Pol$policyCost),sum(y18_Pol$policyCost),sum(y19_Pol$policyCost),sum(y20_Pol$policyCost)),
                     sumOftotalInsurancePremiumOfThePolicy=c(sum(y10_Pol$totalInsurancePremiumOfThePolicy),sum(y11_Pol$totalInsurancePremiumOfThePolicy),sum(y12_Pol$totalInsurancePremiumOfThePolicy),sum(y13_Pol$totalInsurancePremiumOfThePolicy),sum(y14_Pol$totalInsurancePremiumOfThePolicy),
                                                                   sum(y15_Pol$totalInsurancePremiumOfThePolicy),sum(y16_Pol$totalInsurancePremiumOfThePolicy),sum(y17_Pol$totalInsurancePremiumOfThePolicy),sum(y18_Pol$totalInsurancePremiumOfThePolicy),sum(y19_Pol$totalInsurancePremiumOfThePolicy),sum(y20_Pol$totalInsurancePremiumOfThePolicy)),
                     sumOfelevatedBuildingIndicator=c(914,1018,1067,1102,1139,1252,1331,1363,1403,1398,1442),
                     CPI=c(1.19,1.17,1.14,1.12,1.10,1.10,1.09,1.06,1.04,1.02,1.00))
                            
PolSum$sumOfPolicyCostAdj <- PolSum$sumOfPolicyCost * PolSum$CPI
PolSum$sumOftotalInsurancePremiumOfThePolicyAdj <- PolSum$sumOftotalInsurancePremiumOfThePolicy * PolSum$CPI
PolSum$AvePolicyCostAdj <- PolSum$sumOfPolicyCostAdj / PolSum$numberOfPolicies

##selecting vars ####
names(PolSum)
PolSum2 <- PolSum[,c("policyEffectiveYear",
                     "numberOfPolicies",
                     "sumOfPolicyCost",
                     "sumOfPolicyCostAdj",
                     "AvePolicyCostAdj" ,
                     "sumOftotalInsurancePremiumOfThePolicyAdj",
                     "sumOfelevatedBuildingIndicator")]

sum(PolSum2$sumOfPolicyCostAdj)

#writing out variables ####
##Writing out files
path1 <- 'C:/Users/lgero/Box/Research/NJSG/Tradeoff_Analysis/V4/data/DataDownloads/NFIP/Policies/produced/ZCTA_08571'
write.csv(PolSum2, file.path(path1, "NFIP_PolicyData_08571.csv"), row.names=TRUE)
