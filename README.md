# ShinyMultiome.UiO for Multiome data Visualization.

[ShinyMultiome.UiO](https://cancell.medisin.uio.no/ShinyMultiome.UiO)(ShinyMultiome User interface Open) is a user-friendly, integrative, and open-source shiny-based web app using R programming for visualization of jointly analyzed massive single-cell chromatin accessibility data (scATAC-seq) and single-cell RNA-seq(scRNA-seq)from same cells using based on [Signac](https://stuartlab.org/signac/articles/pbmc_multiomic.html), ([Stuart et al, 2021](https://www.nature.com/articles/s41592-021-01282-5)).
Example of web interface on tutorial dataset is available at [ShinyMultiome.UiO](https://cancell.medisin.uio.no/ShinyMultiome.UiO) . 
 
## Downsampled tutorial data
We utilized the a publicly available 10x Genomic Multiome dataset for human PBMCs for analysis using [Signac](https://stuartlab.org/signac/articles/pbmc_multiomic.html) and transcription factor footprinting using [Cicero](https://stuartlab.org/signac/articles/footprint.html).

## Getting Started


## Table of Contents and Additional Tutorials
### This readme is divided into the following sections:
* [Installation](https://github.com/EskelandLab/ShinyMultiomeUiO#installation)
* [Quick Start Guide to rapidly deploy a ShinyMultiome.UiO](https://github.com/EskelandLab/ShinyMultiomeUiO#quick-start-guide)
* [Frequently Asked Questions](https://github.com/EskelandLab/ShinyMultiomeUiO#frequently-asked-questions)
* [Citation and additional info](https://github.com/EskelandLab/ShinyMultiomeUiO#additional-info)

## Installation:

 Download ShinyMultiome.UiO from github.com/EskelandLab/ShinyMultiome.UiO  
 or 
 ```r 
 git clone https://github.com/EskelandLab/ShinyMultiome.UiO.git
```
## Quick Start guide
  The analysis performed as shown in the [Signac](https://stuartlab.org/signac/articles/pbmc_multiomic.html) on a test dataset of 
  PBMC cells can be applied to users' datasets.  

### Installation of mandatory packages
Open R environment or R GUI of your choice and run the following code:
```r 
#check for devtools
if (!requireNamespace("devtools", quietly = TRUE)) install.packages("devtools")
```

#Installing Required packages  
```R
install.packages(c("Seurat", "Signac", "patchwork", "ggplot2", "viridis", "shiny", "shinybusy", "shinyBS", "BSgenome.Hsapiens.UCSC.hg38"))
```

On command Line: 

```r 
#Installs devtools
Rscript -e 'install.packages("devtools",repos="http://cran.r-project.org")'
#Installs BiocManager
Rscript -e 'install.packages("BiocManager",repos="http://cran.r-project.org")'

#Installs required packages 
Rscript -e 'install.packages(c("shiny","magick","hexbin","Seurat","shinybusy","gridExtra", "grid","shinycssloaders"))' 
``` 

#### Setting up parameters
* Open **global.R** file in a file editor and specify the following parameters:  
Update 
* Provide the path to the `seuratObject` variable in `global.R` with the name of the Seurat object RDS formatted file after analysis.

*  ShinyMultiome.UiO also requires (`fragments.tsv.gz` and `fragments.tsv.gz.tbi`) for the scATAC-seq data. Save both the files in same folder. Update the `fragFilePath` variable in `global.R` with the path to the `fragments.tsv.gz.tbi` fragment index files.

```r
  seuratObject="PBMCShinySeuratwithcicero.RDS"
```

```r
  fragFilePath="pbmc_granulocyte_sorted_10k_atac_fragments.tsv.gz"
```
  
Save the global.R file.

### Running ShinyMultiome.UiO on Commandline

Navigate to the folder containing ShinyMultiomeUiO.  

```r  
    R -e "shiny::runApp('ShinyMultiomeUiO',launch.browser =TRUE)" 
```
### Running ShinyMultiome.UiO on R GUI 
```r 
    shiny::runApp('ShinyMultiomeUiO')
```
# ShinyMultiome.UiO Visualization and Functionalities.


This ShinyMultiome.UiO that provides various visualization plots after jointly analyzed single-cell chromatin accessibility data and single-cell RNA sequencing (scRNA-seq) multiome data from the same cell.

## Clustering Tab

The Clustering tab allows you to visualize clustering results and explore the relationships between cells.

### Plots
- Plot 1: A plot showing the relationship between selected cell information and the chosen dimensionality reduction method.
<img width="605" alt="Screenshot 2023-06-14 at 22 28 22" src="https://github.com/EskelandLab/ShinyMultiomeUiO/assets/32255128/8083cf15-435a-45df-b135-962a148e601b">

- Plot 2: Another plot showing the relationship between a different cell information and the chosen dimensionality reduction method.

![Plot 2](/images/plot2.png)



## Feature of Interest

The Feature of Interest section allows you to explore specific features in the scRNA-seq data.

### Plots

- Plot 1: A plot visualizing the chosen feature using the selected plot type (Ridge, Violin, or UMAP).

![Plot 3](/images/plot3.png)

- Plot 2: Another plot visualizing a different feature using the selected plot type.

![Plot 4](/images/plot4.png)


## Coverage Plot

The Coverage Plot section allows you to visualize the coverage of specific genomic regions or features.

### Plot

- Coverage Plot: A plot showing the coverage of the selected region or feature.

![Plot 5](/images/plot5.png)


## Footprint Plot

The Footprint Plot section allows you to analyze transcription factor binding motifs in the scRNA-seq data.

### Plot

- Footprint Plot: A plot showing the footprints of selected motifs.

![Plot 6](/images/plot6.png)

### Downloading Plots

You can download the plots in different formats (PDF, PNG, TIFF) by clicking on the "Download Plot" button.

## Frequently Asked Questions 
Q: Which version of R programming is required?
* R version 4.0.0  and over is recommended.  


Q: Specification of ShinyArchR.UiO server ?

```r 
RHEL system and we use SElinux, nginx and SSL
Model name:	Intel(R) Xeon(R) Platinum 8168 CPU @ 2.70GHz
Architecture:	 x86_64
CPU op-mode(s):	32-bit, 64-bit
CPU(s):	4
CPU family:	6
RAM:	31Gi
Icon name:	computer-vm
Virtualization:	vmware
Operating System:	Red Hat Enterprise Linux 8.4 (Ootpa)
CPE OS Name:	cpe:/o:redhat:enterprise_linux:8.4:GA
Kernel:	Linux 4.18.0-305.el8.x86_64
```

## Citations information
Please cite **ShinyMultiome.UiO** article preprinted in **[BiorXiV preprint](link to preprint).**

Contributors
Ankush Sharma, Akshay Akshay, Ragnhild Eskeland, 


## Acknowledgements

This Shiny app was developed using the [shiny](https://shiny.rstudio.com/) package in R and makes use of various other R packages for data analysis and visualization.



## License

This project is licensed under the [GNU GPL3 License](LICENSE).

