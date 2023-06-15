#### Table of contents

- [ShinyMultiome.UiO for Multiome Data Visualization.](#shinymultiomeuio-for-multiome-data-visualization)
- [Downsampled tutorial data](#downsampled-tutorial-data)
- [Installation](#installation)
- [Running ShinyMultiome.UiO](#running-shinymultiomeuio)
- [ShinyMultiome.UiO Visualization and Functionalities.](#shinymultiomeuio-visualization-and-functionalities)
- [Frequently Asked Questions](#frequently-asked-questions)
- [Citations information](#citations-information)
- [Acknowledgements](#acknowledgements)
- [License](#license)

## ShinyMultiome.UiO for Multiome Data Visualization.

[ShinyMultiome.UiO](https://cancell.medisin.uio.no/ShinyMultiome.UiO)(ShinyMultiome User interface Open) is a user-friendly, integrative, and open-source shiny-based web app using R programming for visualization of jointly analyzed massive single-cell chromatin accessibility data (scATAC-seq) and single-cell RNA-seq(scRNA-seq) from same cells using based on [Signac](https://stuartlab.org/signac/articles/pbmc_multiomic.html) ([Stuart et al, 2021](https://www.nature.com/articles/s41592-021-01282-5)).
An example of web interface on the tutorial dataset is available at [ShinyMultiome.UiO](https://cancell.medisin.uio.no/ShinyMultiome.UiO). 


## Downsampled tutorial data
We utilized a publicly available 10x Genomic Multiome dataset for human PBMCs for analysis using [Signac](https://stuartlab.org/signac/articles/pbmc_multiomic.html) and transcription factor footprinting using [Cicero](https://stuartlab.org/signac/articles/footprint.html). The analysis performed on a test dataset of PBMC cells using Signac [Signac](https://stuartlab.org/signac/articles/pbmc_multiomic.html) on a test dataset of PBMC cells can be applied to users' datasets. 

We utilized a publicly available 10x Genomic Multiome dataset of human PBMCs for analysis, employing Signac for cell clustering and identification of cell types. Additionally, we utilized Cicero for transcription factor footprinting. The analysis performed on a test dataset of PBMC cells using Signac can be applied to users' own datasets.

## Installation

#### 1. Download ShinyMultiome.UiO Source Code  
  +  Download ShinyMultiome.UiO from the [https://github.com/EskelandLab/ShinyMultiomeUiO](https://github.com/EskelandLab/ShinyMultiomeUiO).

      OR
  +   ```r 
      git clone https://github.com/EskelandLab/ShinyMultiome.UiO.git
      ```

#### 2. Installation of mandatory packages  
  + Open the R environment or R GUI of your choice and run the following code:
    
     ```r 
     #check for devtools
     if (!requireNamespace("devtools", quietly = TRUE)) install.packages("devtools")
    
    #Installing Required packages 
    install.packages(c("Seurat", "Signac", "patchwork", "ggplot2", "viridis", "shiny", "shinybusy", "shinyBS", "BSgenome.Hsapiens.UCSC.hg38"))

    ```

 + Alternatively, execute the following commands in the command line interface:


     ```r 
     #Installs devtools
     Rscript -e 'install.packages("devtools",repos="http://cran.r-project.org")'
     
     #Installs BiocManager
     Rscript -e 'install.packages("BiocManager",repos="http://cran.r-project.org")'
     
     #Installs required packages 
     Rscript -e 'install.packages(c("shiny","magick","hexbin","Seurat","shinybusy","gridExtra", "grid","shinycssloaders"))' 
     ``` 

#### 3. Setting up parameters  
To begin, open the `global.R` file in a text editor and edit the following parameters:


* `seuratObject`: Provide the file path to the Seurat object RDS formatted file obtained after analysis in the variable named `seuratObject`.
   ```r
    seuratObject="path/to/seurat-object.RDS"
  ```

*  `fragFilePath`: ShinyMultiome.UiO also requires the path to the files <b>fragments.tsv.gz</b> and <b>fragments.tsv.gz.tbi</b> for the scATAC-seq data. Therefore, please provide the file path of <b>fragments.tsv.gz</b> in the  `fragFilePath` variable. Additionally, ensure that <b>fragments.tsv.gz.tbi</b> is available in the same folder as <b>fragments.tsv.gz</b>.

Note: Make sure to save the changes after modifying the parameters in the `global.R` file.



## Running ShinyMultiome.UiO  
  +  #### Using Commandline
     Navigate to the folder that contains the ShinyMultiome.UiO source code and execute the following command:
    
       ```r  
       R -e "shiny::runApp('ShinyMultiomeUiO',launch.browser =TRUE)" 
       ```
  +  #### Using R GUI 
      ```r 
      shiny::runApp('ShinyMultiomeUiO')
      ```
     
## ShinyMultiome.UiO Visualization and Functionalities.

ShinyMultiome.UiO offers various visualization plots after jointly analyzing single-cell chromatin accessibility data and single-cell RNA sequencing (scRNA-seq) multiome data from the same cell. 

#### 1. Clustering Tab

The Clustering tab provides a platform to visualize clustering results and investigate the relationships between cells.   
  +  ##### Plots
      - <u> Plot 1 </u>: The plot displays the relationship between the selected cell information and the chosen dimensionality reduction method. 
        <img width="605" alt="Screenshot 2023-06-14 at 22 28 22" src="https://github.com/EskelandLab/ShinyMultiomeUiO/assets/32255128/8083cf15-435a-45df-b135-962a148e601b">

      - <u>Plot 2</u>: Another plot showing the relationship between different cell information and the chosen dimensionality reduction method.

         ![Plot 2](/images/plot2.png)



#### 2. Feature of Interest

The Feature of Interest section allows you to explore specific features in the scRNA-seq data.

  +  ##### Plots

     - <u>Plot 1</u>: A plot visualizing the chosen feature using the selected plot type (Ridge, Violin, or UMAP).
     
       ![Plot 3](/images/plot3.png)
     
     - <u>Plot 2</u>: Another plot visualizing a different feature using the selected plot type.
     
       ![Plot 4](/images/plot4.png)


#### 3. Coverage Plot

The Coverage Plot section allows you to visualize the coverage of specific genomic regions or features.

  +  ##### Plot
     - Coverage Plot: A plot showing the coverage of the selected region or feature.
    
       ![Plot 5](/images/plot5.png)


#### 4. Footprint Plot

The Footprint Plot section allows you to analyze transcription factor binding motifs in the scRNA-seq data.

  +  ##### Plot

     - <u>Footprint Plot</u>: A plot showing the footprints of selected motifs.
     
       ![Plot 6](/images/plot6.png)

#### 5. Downloading Plots
 
Within the interface, users have the flexibility to download the plots in various formats such as PDF, PNG, and TIFF. They can accomplish this by simply clicking on the <b>Download Plot</b> button. Additionally, users are able to customize the dimensions of the plots during both the plotting and downloading processes. This can be achieved by modifying the <b>width</b> and <b>height</b> values in the respective input area.

## Frequently Asked Questions 
Q: Which version of R programming is required?
* R version 4.0.0  and over is recommended.  


Q: Specification of ShinyMultiome.UiO server?

```r 
RHEL system and we use SElinux, nginx, and SSL
Model name:	Intel(R) Xeon(R) Platinum 8168 CPU @ 2.70GHz
Architecture:	 x86_64
CPU op-mode(s):	32-bit, 64-bit
CPU(s):	4
CPU family:	6
RAM:	31Gi
Icon name:	computer-vm
Virtualization:	VMware
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

