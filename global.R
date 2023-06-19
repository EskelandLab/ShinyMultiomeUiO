####################################
##       ShinyMultiome.UiO        ##
####################################
# Authors: Ankush Sharma and Akshay Akshay
# Note:  If you find this code useful and utilize any part of it, 
#        we kindly request that you acknowledge its usage by citing the ShinyMultiomeUiO preprint.



##load libraries
library(shiny)
library(Seurat)
library(Signac)
library(patchwork)
library(ggplot2)
library(viridis)
library(shinybusy)
library(shinyBS)
library(BSgenome.Hsapiens.UCSC.hg38)

####################################
##       load seurat object       ##
####################################
#path to seurat oject (rds file)

#seuratObject="PBMCShinySeuratwithcicero.RDS"
seuratObject="/Users/akshay/OneDrive - Universitaet Bern/PhD/Projetcs-extra/archR_1.0/seurat/shinyarchr/pbmc1forshiny.RDS"

#load object
pbmc=readRDS(seuratObject)

####################################
## update path for fragment files ##
####################################

#path to fragment files (fragments.tsv.gz and fragments.tsv.gz.tbi)
#fragFilePath="pbmc_granulocyte_sorted_10k_atac_fragments.tsv.gz"

fragFilePath="/Users/akshay/OneDrive - Universitaet Bern/PhD/Projetcs-extra/archR_1.0/seurat/shinyarchr/pbmc_granulocyte_sorted_10k_atac_fragments.tsv.gz"


# update fragment file path
DefaultAssay(pbmc)="peaks"
frags <- Fragments(pbmc)
frags[[1]] <- UpdatePath(frags[[1]], new.path = fragFilePath)

# assign update list of fragment objects back to the assay
Fragments(pbmc) <- NULL
Fragments(pbmc) <- frags

####################################
##       End of file    		      ##
####################################