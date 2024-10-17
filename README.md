[![DOI](https://zenodo.org/badge/265254045.svg)](https://zenodo.org/doi/10.5281/zenodo.10442485)


# XXX-etal_2024_NaturalHazardsReview

**Tradeoff Analysis of Recovery Pathways post Superstorm Sandy: a New Jersey Case Study. (once published, include a link to the text)**


## Abstract
ABSTRACT: 
Coastal impacts from climate-induced sea level rise and storm surge are straining public and household finances, elevating debates about resource distribution for adaptation. In the U.S., cost-sharing agreements create expectations for federal aid after flood disasters. However, the full costs of rebuilding repetitive loss regions—and how these compare to alternatives like relocation—are poorly understood. Focusing on the barrier-island neighborhood of Ortley Beach, New Jersey, we reconstruct the historical record to evaluate the costs of rebuilding after Superstorm Sandy and their distribution. Findings demonstrate how intergovernmental transfers soften local budget constraints and incentivize rebuilding. We propose alternative response scenarios—including property buyouts—and apply a conservative economic analysis to identify the most cost-effective policies over 50 years. Results vary with discount rates and assumptions about home values, protection costs, and residual risk. At a 2 percent discount rate, buyout costs breakeven with rebuilding costs if the market value of homes is deflated by approximately 35 percent, or if the residual risk and protection estimates are approximately doubled. Clustered buyouts of the most exposed homes would likely have been optimal post-Sandy. This case study presents innovative methods for evaluating distributional and efficiency outcomes of adaptation pathways relevant to other regions.


## Journal reference
_your journal reference_

## Data reference

### Input data
Input data is obtained from various public or third party sources. 

You can find the publicly available input data [here](https://zenodo.org/deposit/13835761). The dataset will be available upon publication.

### Output data

You can find the output data [here](https://zenodo.org/deposit/13835761). The dataset will be available upon publication.


## Reproduce my experiment
Fill in detailed info here or link to other documentation to thoroughly walkthrough how to use the contents of this repository to reproduce your experiment. Below is an example.

1. Download and install the supporting input-data required to conduct the experiment.
2. Run the scripts in the `workflow` directory to re-create this experiment in the numbered order that they appear. Prior to running each script, adjust the working directory to your local directory where the you stored the 'data' folder.

# Scripts Overview
## 1 - Data Cleaning
### Folder location: scripts/workflow/1_DataCleaning/1_NJSandyTransparency
Cleans data from the New Jersey Sandy Transparency database, subsets data to Toms River, separates federal (and local) cost share by year, CPI adjusts dollar values to USD2020.
| Script Name      | Description                                                                                                                  | Link to Source Data                                                                                   |
|------------------|------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------|
| `CDL.rmd`        | Processes data from FEMA's Community Disaster Loan program (CDL). Subsets to Toms River and separates federal cost share by year. CPI adjust dollar values to USD2020 | [Sandy CDL Master Data](https://data.nj.gov/Government-Finance/Sandy-CDL-Master-Data/4va7-qk4z/about_data) |
| `DCA.rmd`        | Processes data from the NJ Department of Community Affairs (DCA) / HUD. Subsets to Toms River and separates federal cost share by year. CPI adjust dollar values to USD2020 | [Sandy DCA Master Data](https://data.nj.gov/Human-Services/Sandy-DCA-Master-Data/j9i2-jh6f)               |
| `DOT.rmd`        | Processes data from the US DOT. Subsets to Toms River and separates federal cost share by year. CPI adjust dollar values to USD2020. Subsets to projects impacting Ortley Beach based on text analysis of projects and mile markers | [Sandy DOT Master Data](https://data.nj.gov/Transportation/Sandy-DOT-Master-Data/5ray-pv63)              |
| `DOT_Local.rmd`  | Processes data from the US DOT Division of Local Aid. Subsets to Toms River and separates federal cost share by year. CPI adjust dollar values to USD2020. Subsets to projects impacting Ortley Beach based on text analysis of projects and mile markers | [Sandy DOT Local Aid Master Data](https://data.nj.gov/Transportation/Sandy-DOT-Local-Aid-Master-Data/fiv5-rhia/about_data) |
| `HMGP.rmd`       | Processes data from FEMA's Hazard Mitigation Grant Program. Subsets to Toms River and separates federal cost and local share by year. CPI adjust dollar values to USD2020. | [Sandy HMGP Master Data](https://data.nj.gov/Government-Finance/Sandy-HMGP-Master-Data/udub-d3ap)        |
| `IA.rmd`         | Processes data from FEMA's Individual Assistance Program. Subsets to Toms River and separates federal cost share by year. CPI adjust dollar values to USD2020. | [Sandy IA Master Data](https://data.nj.gov/Government-Finance/Sandy-IA-Master-Data/y3np-36s4)           |
| `PA.rmd`         | Processes data from FEMA's Public Assistance Program. Subsets to Toms River and separates federal and local cost share by year. CPI adjust dollar values to USD2020. | [Sandy PA Master Data](https://data.nj.gov/Government-Finance/Sandy-PA-Master-Data/j356-d76p/about_data) |

### Folder location: scripts/workflow/1_DataCleaning/2_HAZUS_DDFs
Identifies damage function IDs recommended in HAZUS 5.1 Flood Model Technical Manual p.5.8 Coastal A & V zone
| Script Name      | Description                                                                                                                  | Link to Source Data                                                                                |
|------------------|------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------|
| `OB_HazusDDF_CoastalARes.rmd`        | Processes depth damage functions (DDFs) from HAZUS 5.1 Flood Model Technical Manual p.5.8 Coastal A & V zone. Reduces to DDFs for residential structures in A and C zones that match building characteristics in Ortley Beach. Extracts and plosts DDF curves and prepares for integration with Ortley Beach hazards and building data. | https://zenodo.org/records/10027236|

### Folder location: scripts/workflow/1_DataCleaning/3_OB_MOD4_TimeSeries
Identifies damage function IDs recommended in HAZUS 5.1 Flood Model Technical Manual p.5.8 Coastal A & V zone
| Script Name      | Description                                                                                                                  | Link to Source Data                                                                                |
|------------------|------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------|
| `1_TR_MOD4_Cleaning_join_TS_gis_pin.rmd`        | Processes MOD-IV time series tax assessor data for Ortley Beach (2011-2022). Uses 2011 residential building data as a base and applies a 'frozen city' model, assuming no new development. Obtains improvement value and sales value by year, among other parcel level characteristics | [https://zenodo.org/records/10027236](https://modiv.rutgers.edu/)|
| `2_OB_S3_S4_MOD4_TimeSeries.rmd`        | Produces subset of time series data for Scenario 3 and 4 (S3 & S4) based on gis_pin for the parcels in these clusters. Obtains improvement value and sales value by year, among other parcel level characteristics | [https://zenodo.org/records/10027236](https://modiv.rutgers.edu/)|
| `3_OB_S1_S3_S4_2011_2022_Sales_Value.rmd`        | Estimates sales price by year for Ortley Beach properties by estimating the sales price per square foot for homes that sold that year, and multiplying by total square footage across properties. Extracts estimated 2011 sales price for properties in S1, S3, and S4 to estimate buyout cost | [https://zenodo.org/records/10027236](https://modiv.rutgers.edu/)|

### Folder location: scripts/workflow/1_DataCleaning/4_NFIP/Claims
Processes National Flood Insurance Claims data
| Script Name      | Description                                                                                                                  | Link to Source Data                                                                                |
|------------------|------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------|
| `1_NFIP_Claims_Cleaning_OB.rmd`        | Processes OpenFEMA NFIP Redacted Claims (V2) dataset. Reduces to residential claims (building claims, contents claims, and increased cost of compliance claims for ZCTA 08751 (Inclusive of Ortley Beach). CPI adjust to USD2020 |https://www.fema.gov/api/open/v2/FimaNfipClaims |
| `2_OB_AssigningNFIPClaims.rmd`        | Assigns Sandy flood damages estimates and claims data based on First Street estimates of water depths during Sandy, MOD-IV building characteristics, HAZUS depth damage functions, and NFIP claims data. Estimates hidden costs to households, or the difference between damages and claims. Produces estimates for rebuild scenarios (S1, S3, S4) | Multiple (First Street, MOD-IV, HAZUS, NFIP -- see prior worksheets)|

### Folder location: scripts/workflow/1_DataCleaning/5_NFIP/Policies
Processes National Flood Insurance Policies data
| Script Name      | Description                                                                                                                  | Link to Source Data                                                                                |
|------------------|------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------|
| `1_NFIP_rfema_Data_Pull_OB.rmd`        | Pulls NFIP policies data for ZCTA 08751 (inclusive of Ortley Beach) for years 2010:2020. | https://www.fema.gov/api/open/v2/FimaNfipPolicies |
| `2_NFIP_rfema_clean_stitch_OB.rmd`        | Stitches NFIP policy data for years 2010-2020 | https://www.fema.gov/api/open/v2/FimaNfipPolicies|

## 2 - Scenario Inputs
### Folder location: scripts/workflow/2_ScenarioInputs/1_Retrospective/1_MuniCostFrom_OB
Generates Municipal cost estimates (2012-2022) associated with the different Ortley Beach scenarios, based on simplifying assumptions descriped in the manuscript and SI.
| Script Name      | Description                                                                                                                          |
|------------------|------------------------------------------------------------------------------------------------------------------------------|
| `a_S1_MuniCostsFrom_OB_byYear_Preprocessing.rmd`        | Estimates the costs to Toms River municipality of maintaining properties on Ortley Beach for Scenario 1 (rebuild Ortley Beach), for 2012-2022, based on scenario assumptions. Downscales data to Ortley Beach| 
| `b_S1_MuniCostsFrom_OB.rmd`        | Estimates the NPV for costs to Toms River for Scenario 1. Discounts the costs and groups them into buckets for analysis |
| `c_S0_MuniCostsFrom_OB.rmd`        | Estimates the NPV for costs to Toms River for Scenario 0. Discounts the costs and groups them into buckets for analysis |
| `d_S2_MuniCostsFrom_OB.rmd`        | Estimates the NPV for costs to Toms River for Scenario 2. Discounts the costs and groups them into buckets for analysis |
| `e_S3_MuniCostsFrom_OB.rmd`        | Estimates the NPV for costs to Toms River for Scenario 3. Discounts the costs and groups them into buckets for analysis |
| `f_S4_MuniCostsFrom_OB.rmd`        | Estimates the NPV for costs to Toms River for Scenario 4. Discounts the costs and groups them into buckets for analysis |

### Folder location: scripts/workflow/2_ScenarioInputs/1_Retrospective/2_MuniRevFrom_OB
Generates Municipal revenues estimates (2012-2022) associated with the different Ortley Beach scenarios, based on simplifying assumptions descriped in the manuscript and SI.
| Script Name      | Description                                                                                                                          |
|------------------|------------------------------------------------------------------------------------------------------------------------------|
| `a_S1_MuniCostsFrom_OB_byYear_Preprocessing.rmd`        | Estimates the costs to Toms River municipality of maintaining properties on Ortley Beach for Scenario 1 (rebuild Ortley Beach), for 2012-2022, based on scenario assumptions. Downscales data to Ortley Beach| 
| `b_S1_MuniRevFrom_OB.rmd`        | Estimates the NPV for revenue to Toms River for Scenario 1. Discounts the revenues and groups them into buckets for analysis |
| `c_S0_MuniRevFrom_OB.rmd`        | Estimates the NPV for revenue to Toms River for Scenario 0. Discounts the revenues and groups them into buckets for analysis |
| `d_S2_MuniRevFrom_OB.rmd`        | Estimates the NPV for revenue to Toms River for Scenario 2. Discounts the revenues and groups them into buckets for analysis |
| `e_S3_MuniRevFrom_OB.rmd`        | Estimates the NPV for revenue to Toms River for Scenario 3. Discounts the revenues and groups them into buckets for analysis |
| `f_S4_MuniRevFrom_OB.rmd`        | Estimates the NPV for revenue to Toms River for Scenario 4. Discounts the revenues and groups them into buckets for analysis |

### Folder location: scripts/workflow/2_ScenarioInputs/1_Retrospective/3_FedCostFrom_OB
Generates Federal Cost estimates (2012-2022) associated with the different Ortley Beach scenarios, based on simplifying assumptions descriped in the manuscript and SI.
| Script Name      | Description                                                                                                                          |
|------------------|------------------------------------------------------------------------------------------------------------------------------|
| `a_S1_FedCostsFrom_OB_byYear_Preprocessing.rmd`        | Estimates the costs to the Federal Government of maintaining properties on Ortley Beach for Scenario 1 (rebuild Ortley Beach), for 2012-2022, based on scenario assumptions. Downscales data to Ortley Beach| 
| `b_S1_FedCostsFrom_OB.rmd`        | Estimates the NPV for costs to the Federal Governmentfor Scenario 1. Discounts the costs and groups them into buckets for analysis |
| `c_S0_FedCostsFrom_OB.rmd`        | Estimates the NPV for costs to the Federal Government for Scenario 0. Discounts the costs and groups them into buckets for analysis |
| `d_S2_FedCostsFrom_OB.rmd`        | Estimates the NPV for costs to the Federal Governmentfor Scenario 2. Discounts the costs and groups them into buckets for analysis |
| `e_S3_FedCostsFrom_OB.rmd`        | Estimates the NPV for costs to the Federal Governmentfor Scenario 3. Discounts the costs and groups them into buckets for analysis |
| `f_S4_FedCostsFrom_OB.rmd`        | Estimates the NPV for costs to the Federal Governmentfor Scenario 4. Discounts the costs and groups them into buckets for analysis |

### Folder location: scripts/workflow/2_ScenarioInputs/1_Retrospective/4_FedRevFrom_OB
Generates Federal revenue estimates (2012-2022) associated with the different Ortley Beach scenarios, based on simplifying assumptions descriped in the manuscript and SI. 
| Script Name      | Description                                                                                                                          |
|------------------|------------------------------------------------------------------------------------------------------------------------------|
| `a_S1_FedRevFrom_OB_byYear_Preprocessing.rmd`        | Estimates the revenues to the Federal Government of maintaining properties on Ortley Beach for Scenario 1 (rebuild Ortley Beach), for 2012-2022, based on scenario assumptions. Downscales data to Ortley Beach| 
| `b_S1_FedRevFrom_OB.rmd`        | Estimates the NPV for revenue to the Federal Government for Scenario 1. Discounts the revenues and groups them into buckets for analysis |
| `c_S0_FedRevFrom_OB.rmd`        | Estimates the NPV for revenue to the Federal Government for Scenario 0. Discounts the revenues and groups them into buckets for analysis |
| `d_S2_FedRevFrom_OB.rmd`        | Estimates the NPV for revenue to the Federal Government for Scenario 2. Discounts the revenues and groups them into buckets for analysis |
| `e_S3_FedRevFrom_OB.rmd`        | Estimates the NPV for revenue to the Federal Government for Scenario 3. Discounts the revenues and groups them into buckets for analysis |
| `f_S4_FedRevFrom_OB.rmd`        | Estimates the NPV for revenue to the Federal Government for Scenario 4. Discounts the revenues and groups them into buckets for analysis |

### Folder location: scripts/workflow/2_ScenarioInputs/2_Prospective/BeachNourishment_Estimated
Generates prospective estimates (2023-2062) of protection costs associated with Beach Nourishment for rebuild scenarios, based on simplifying assumptions descriped in the manuscript and SI. 
| Script Name      | Description                                                                                                                          |
|------------------|------------------------------------------------------------------------------------------------------------------------------|
| `OB_BeachNourish_Interpolation_Discounting_ProtectionCost_Estimates.rmd`        | Estimate Beach Nourishment costs for scenarios with properties remaining on the island, based on historical analysis of Beach nourishment investments and three scenarios (low, mid, high)| 

### Folder location: scripts/workflow/2_ScenarioInputs/2_Prospective/FirstStreet_ResidualRiskEstimates
Generates prospective estimates (2023-2062) of residual risk for rebuild scenarios, based on simplifying assumptions descriped in the manuscript and SI. 
| Script Name      | Description                                                                                                                          |
|------------------|------------------------------------------------------------------------------------------------------------------------------|
| `1_OB_AAL_Estimates.rmd`        | Processes First Street Average Annual Loss (AAL) parcel level data for low, mid, and high climate scenarios for 2021 and 2051. Estimates total AAL by cluster (S1, S3, S4) for years 2021 and 2051, from Licensed First Street Data.  | 
| `2_OB_AAL_Interpolation_Discounting_ResidualRisk_Estimates.rmd`        | For each scenario, we take the total AAL for the properties in the scenario, and do linear interpolation to estimate the values for years 2012:2062. We then discount the AAL values at 2%, 3%, and 7%, and sum to obtain NPV by scenario. We call this the residual risk estimate.| 

## 3 Scenario Analsyis
### Folder location: scripts/workflow/3_ScenarioAnalysis
Generates estimates of retrospective a) retrospective policy cost, b) prospective beach nourishment / protection cost and c) residual risk costs associated with each scenario, by discount rate and assumption (low, mid, high). Compares costs accross scenarios.

| Script Name      | Description                                                                                                                          |
|------------------|------------------------------------------------------------------------------------------------------------------------------|
| `S0_ScenarioAnalysis.rmd`        | Estimates and analyzes costs for S0 | 
| `S1_ScenarioAnalysis.rmd`        | Estimates and analyzes for S1 | 
| `S2_ScenarioAnalysis.rmd`        | Estimates and analyzes for S2 | 
| `S3_ScenarioAnalysis.rmd`        | Estimates and analyzes for S3 | 
| `S4_ScenarioAnalysis.rmd`        | Estimates and analyzes for S4 | 
| `ScenarioCompares.rmd`        | Compares total costs across scenarios by cost type, discount rate, and assumptions, and summarized information in a graphic and table | 

## Reproduce my figures
Use the scripts found in the `figures` directory to reproduce Figure 5 used in this publication.
The other figures were created in GIS, Excel, or powerpoint (see Figures power point)




