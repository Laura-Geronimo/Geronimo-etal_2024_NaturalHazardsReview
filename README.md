[![DOI](https://zenodo.org/badge/265254045.svg)](https://zenodo.org/doi/10.5281/zenodo.10442485)


# Geronimo-etal_2024_RiskAnalysis

**Federal transfers backstop municipal funding gaps post-disaster, enabling rebuilding in repetitive loss regions: a New Jersey case study. (once published, include a link to the text)**

Dr. Laura Geronimo<sup>1\*</sup>, Dr. Clint Andrews<sup>2</sup>, Dr. Robert E. Kopp<sup>3</sup>,  Dr. William B. Payne<sup>4</sup> and Dr. Elisabeth Gilmore<sup>5</sup>

<sup>1 </sup>Postdoctoral Associate, Department of Earth and Planetary Sciences, Rutgers University, New Brunswick, NJ, USA

<sup>2 </sup> Distinguished Professor, E.J. Bloustein School of Planning & Public Policy; Rutgers University,  New Brunswick, NJ, USA

<sup>3 </sup> Distinguished Professor, Department of Earth and Planetary Sciences; Rutgers University, New Brunswick, NJ, USA

<sup>4 </sup> Assistant Professor, E.J. Bloustein School of Planning & Public Policy; Rutgers University, New Brunswick, NJ, USA

<sup>5 </sup> Associate Professor, Department of Civil and Environmental Engineering, Carleton University, Ontario, Canada

\* corresponding author: laura.geronimo@rutgers.edu

## Abstract
ABSTRACT: 
Coastal impacts from climate-induced sea level rise and storm surge are straining finances at federal, local, and household levels, elevating debates on resource distribution for adaptation. In the U.S., cost-sharing agreements create expectations for federal aid after flood disasters. However, the continued use of federal funds to backstop the cost of disasters may become unsustainable. We focus on the neighborhood of Ortley Beach in the municipality of Toms River, New Jersey, to evaluate the  efficiency and distribution of costs after Superstorm Sandy. Findings demonstrate how intergovernmental transfers soften local budget constraints and incentivize rebuilding. We propose alternative response scenarios and apply a conservative economic analysis to identify the most cost-effective policies over 50 years. Results vary with discount rates and assumptions about home values, protection costs, and residual risk. At a 2 percent discount rate, buyout costs breakeven with the costs of rebuilding and elevating homes if the market value of homes is deflated by approximately 35 percent, or if the residual risk and protection estimates are approximately doubled. Clustered buyouts of the most exposed homes would likely have been optimal post-Sandy. This case study presents methods for evaluating distributional and efficiency outcomes of adaptation pathways relevant to other regions.


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

## Reproduce my figures
Use the scripts found in the `figures` directory to reproduce Figure 5 used in this publication.
The other figures were created in GIS, Excel, or powerpoint (see Figures power point)




