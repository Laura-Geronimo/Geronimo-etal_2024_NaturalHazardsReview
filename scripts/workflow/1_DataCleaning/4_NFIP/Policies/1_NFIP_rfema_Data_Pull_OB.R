#Purpose: pull data on NFIP policies for Zip Code encompassing Ortley Beach

#Setup
setwd('C:/Users/lgero/Box/Research/NJSG/Tradeoff_Analysis/V4')

Packages <- c("dplyr", "rfema")
lapply(Packages, library, character.only = TRUE)

#Get rfema info
datasets <- fema_data_sets()
#all the datafields in the datset
datafields <- fema_data_fields("FimaNfipPolicies")

# the filterable datafields in the dataset
filter_datafields <-valid_parameters("fimanfippolicies")

# a little more info on a specific parameter, like the date
   ###parameter_values(data_set = "fimanfippolicies",data_field = "policyEffectiveDate") LAURA: this is getting 503 error

# define a list of filters to apply
# County: Ocean County, NJ, FIPS: 34029
filterList_OC <- list(countyCode = "34029", policyEffectiveDate = ">= 2020-01-01", policyEffectiveDate = "< 2021-01-01")

#defining filters for Ortley
filterList_OB22 <- list(reportedZipCode = "08751", policyEffectiveDate = ">= 2022-01-01", policyEffectiveDate = "< 2023-01-01")
filterList_OB21 <- list(reportedZipCode = "08751", policyEffectiveDate = ">= 2021-01-01", policyEffectiveDate = "< 2022-01-01")
filterList_OB20 <- list(reportedZipCode = "08751", policyEffectiveDate = ">= 2020-01-01", policyEffectiveDate = "< 2021-01-01")
filterList_OB19 <- list(reportedZipCode = "08751", policyEffectiveDate = ">= 2019-01-01", policyEffectiveDate = "< 2020-01-01")
filterList_OB18 <- list(reportedZipCode = "08751", policyEffectiveDate = ">= 2018-01-01", policyEffectiveDate = "< 2019-01-01")
filterList_OB17 <- list(reportedZipCode = "08751", policyEffectiveDate = ">= 2017-01-01", policyEffectiveDate = "< 2018-01-01")
filterList_OB16 <- list(reportedZipCode = "08751", policyEffectiveDate = ">= 2016-01-01", policyEffectiveDate = "< 2017-01-01")
filterList_OB15 <- list(reportedZipCode = "08751", policyEffectiveDate = ">= 2015-01-01", policyEffectiveDate = "< 2016-01-01")
filterList_OB14 <- list(reportedZipCode = "08751", policyEffectiveDate = ">= 2014-01-01", policyEffectiveDate = "< 2015-01-01")
filterList_OB13 <- list(reportedZipCode = "08751", policyEffectiveDate = ">= 2013-01-01", policyEffectiveDate = "< 2014-01-01")
filterList_OB12 <- list(reportedZipCode = "08751", policyEffectiveDate = ">= 2012-01-01", policyEffectiveDate = "< 2013-01-01")
filterList_OB11 <- list(reportedZipCode = "08751", policyEffectiveDate = ">= 2011-01-01", policyEffectiveDate = "< 2012-01-01")
filterList_OB10 <- list(reportedZipCode = "08751", policyEffectiveDate = ">= 2010-01-01", policyEffectiveDate = "< 2011-01-01")


filterList_OB <- list(reportedZipCode = "08751",policyEffectiveDate = ">= 2010-01-01") #trying over 2010


# Make the API call using the `open_fema` function. The function will output a 
# status message to the console letting you monitor the progress of the data retrieval.
#pull for all of Ocean County
#y20_OC <- rfema::open_fema(data_set = "FimaNfipPolicies", select=c("policyCost","policyEffectiveDate","elevatedBuildingIndicator"), filters = filterList_OC) #etimated 46 api calls at 7.31 min (5hrs)

#attempting pull for Ortley Beach ZCTA for all years over 2010
OB <- rfema::open_fema(data_set = "FimaNfipPolicies", select=c("policyEffectiveDate", "policyCost","totalInsurancePremiumOfThePolicy","elevatedBuildingIndicator"), filters = filterList_OB) 


############CHUNK PULLS############

#attempting pull for Ortley Beach ZCTA for 2022
y22_OB <- rfema::open_fema(data_set = "FimaNfipPolicies", select=c("policyEffectiveDate", "policyCost","totalInsurancePremiumOfThePolicy","elevatedBuildingIndicator"), filters = filterList_OB22) 
#3 calls at 3.77 seconds. Actually took 1min30sec (30x estimated time)

y21_OB <- rfema::open_fema(data_set = "FimaNfipPolicies", select=c("policyEffectiveDate", "policyCost","totalInsurancePremiumOfThePolicy","elevatedBuildingIndicator"), filters = filterList_OB21) 
#3 calls at 3.77 seconds. Actually took 1min30sec (30x estimated time)

#attempting pull for Ortley Beach ZCTA for 2020
y20_OB <- rfema::open_fema(data_set = "FimaNfipPolicies", select=c("policyEffectiveDate", "policyCost","totalInsurancePremiumOfThePolicy","elevatedBuildingIndicator"), filters = filterList_OB20) 
  #3 calls at 3.77 seconds. Actually took 1min30sec (30x estimated time)


#attempting pull for Ortley Beach ZCTA for 2019 
#y19_OB <- rfema::open_fema(data_set = "FimaNfipPolicies", select=c("policyEffectiveDate", "policyCost","totalInsurancePremiumOfThePolicy","elevatedBuildingIndicator"), filters = filterList_OB19) 

#attempting pull for Ortley Beach ZCTA for 2017 
#y17_OB <- rfema::open_fema(data_set = "FimaNfipPolicies", select=c("policyEffectiveDate", "policyCost","totalInsurancePremiumOfThePolicy","elevatedBuildingIndicator"), filters = filterList_OB17) 

#attempting pull for Ortley Beach ZCTA for 2016 
#y16_OB <- rfema::open_fema(data_set = "FimaNfipPolicies", select=c("policyEffectiveDate", "policyCost","totalInsurancePremiumOfThePolicy","elevatedBuildingIndicator"), filters = filterList_OB16) 

#attempting pull for Ortley Beach ZCTA for 2015 
#y15_OB <- rfema::open_fema(data_set = "FimaNfipPolicies", select=c("policyEffectiveDate", "policyCost","totalInsurancePremiumOfThePolicy","elevatedBuildingIndicator"), filters = filterList_OB15) 

#attempting pull for Ortley Beach ZCTA for 2013
#y13_OB <- rfema::open_fema(data_set = "FimaNfipPolicies", select=c("policyEffectiveDate", "policyCost","totalInsurancePremiumOfThePolicy","elevatedBuildingIndicator"), filters = filterList_OB13) 


#FAILED:
#attempting pull for Ortley Beach ZCTA for 2018 
#y18_OB <- rfema::open_fema(data_set = "FimaNfipPolicies", select=c("policyEffectiveDate", "policyCost","totalInsurancePremiumOfThePolicy","elevatedBuildingIndicator"), filters = filterList_OB18) 

#attempting pull for Ortley Beach ZCTA for 2014 
#y14_OB <- rfema::open_fema(data_set = "FimaNfipPolicies", select=c("policyEffectiveDate", "policyCost","totalInsurancePremiumOfThePolicy","elevatedBuildingIndicator"), filters = filterList_OB14) 

#attempting pull for Ortley Beach ZCTA for 2012
#y12_OB <- rfema::open_fema(data_set = "FimaNfipPolicies", select=c("policyEffectiveDate", "policyCost","totalInsurancePremiumOfThePolicy","elevatedBuildingIndicator"), filters = filterList_OB12) 

#attempting pull for Ortley Beach ZCTA for 2011
#y11_OB <- rfema::open_fema(data_set = "FimaNfipPolicies", select=c("policyEffectiveDate", "policyCost","totalInsurancePremiumOfThePolicy","elevatedBuildingIndicator"), filters = filterList_OB11) 

#attempting pull for Ortley Beach ZCTA for 2010
#y10_OB <- rfema::open_fema(data_set = "FimaNfipPolicies", select=c("policyEffectiveDate", "policyCost","totalInsurancePremiumOfThePolicy","elevatedBuildingIndicator"), filters = filterList_OB10) 



##Writing out files
path1 <- 'C:/Users/lgero/Box/Research/NJSG/Tradeoff_Analysis/V4/data/DataDownloads/NFIP/Policies/produced/ZCTA_08571'
#write.csv(y22_OB, file.path(path1, "y22_ZCTA_08571.csv"), row.names=TRUE)
#write.csv(y21_OB, file.path(path1, "y21_ZCTA_08571.csv"), row.names=TRUE)
#write.csv(y20_OB, file.path(path1, "y20_ZCTA_08571.csv"), row.names=TRUE)
#write.csv(y19_OB, file.path(path1, "y19_ZCTA_08571.csv"), row.names=TRUE)
#write.csv(y18_OB, file.path(path1, "y18_ZCTA_08571.csv"), row.names=TRUE)
#write.csv(y17_OB, file.path(path1, "y17_ZCTA_08571.csv"), row.names=TRUE)
#write.csv(y16_OB, file.path(path1, "y16_ZCTA_08571.csv"), row.names=TRUE)
#write.csv(y15_OB, file.path(path1, "y15_ZCTA_08571.csv"), row.names=TRUE)
#write.csv(y14_OB, file.path(path1, "y14_ZCTA_08571.csv"), row.names=TRUE)
#write.csv(y13_OB, file.path(path1, "y13_ZCTA_08571.csv"), row.names=TRUE)
#write.csv(y12_OB, file.path(path1, "y12_ZCTA_08571.csv"), row.names=TRUE)
#write.csv(y11_OB, file.path(path1, "y11_ZCTA_08571.csv"), row.names=TRUE)
#write.csv(y10_OB, file.path(path1, "y10_ZCTA_08571.csv"), row.names=TRUE)


