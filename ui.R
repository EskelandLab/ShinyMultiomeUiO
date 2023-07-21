####################################
##       ShinyMultiome.UiO        ##
####################################
# Authors: Ankush Sharma and Akshay Akshay
# Note:  If you find this code useful and utilize any part of it, 
#        we kindly request that you acknowledge its usage by citing the ShinyMultiomeUiO preprint.



###########################################################
#                        about                          ##
###########################################################

about_panel <- tabPanel(
  titlePanel(h5("About")),
  tabsetPanel(
    
    # General info.
    tabPanel(
      "Overview",
      tags$h3("Scope"),
      tags$p(HTML("ShinyMultiome.UiO is a user-friendly, integrative, open-source web app for single cell multiome data. ShinyMultiome.UiO use R Shiny framework for visualization of jointly analyzed chromatin accessibility (scATAC-seq) and gene expression (scRNA-seq) data using <a href=\"https://stuartlab.org/signac/articles/pbmc_multiomic.html\" target=\"_blank\">Signac</a> (Stuart et al., 2021).")),
      tags$h3("Approach"),

      tags$p(HTML(" The Seurat objects is saved as RDS file along with Fragment.tsv.gz and indexed Fragment.tsv.gz.tbi are used for input in ShinyMultiome.")),
      tags$h5("Data Visualization of ShinyMultiome.UiO:"),
      tags$ul(
        tags$li(HTML("Multi dimensional reduction plots on different modalities is shown on Clustering tab")),
        tags$li(HTML("The Coverage Plot tab shows peaks for scATAC-seq modality on different clusters and adjacent violin plot shows gene expression level of the gene of interest in clusters on scRNA-seq modality")),
        tags$li(HTML("The Feature of Interest tab visualizes nucleosomal signals and peaks for ATAC and peak assay, respectively using ridge plot, violin plot and UMAPS. Furthermore RNA and SCT assays shows gene expression. Selected celltypes in Cell Types panel can be plotted using ridge plot and violin plot.")),
        tags$li(HTML("The TF Footprinting tab shows transcription factor footprinting plots for selected celltypes")),
        tags$li(HTML("The About us section details about the contribution and citation information")),

      )
    ),
    
    # About us .
    tabPanel(
      "About us ",
      tags$h3("Contributions and Citation info"),
      tags$p(HTML("ShinyMultiome.UiO software is developed at <a href=\"https://www.med.uio.no/cancell/english/groups/chromatin-biology\" target=\"_blank\">Chromatin Biology</a> Lab at <a href=\"https://www.uio.no\" target=\"_blank\">University of Oslo</a>, as an open-source project mainly under the GPL license version 3 (see source code for details).")),
      tags$p(HTML("For demonstration, we utilized the 10X Genomics 10k Human PBMCs, Multiome v1.0, Chromium X <a href=\"https://www.10xgenomics.com\"  target=\"_blank\">10XGenomics</a> ")),
      tags$p(HTML("If ShinyMultiome.UiO in any way helps you in visualizing and sharing your research work such that it warrants a citation, please cite the ShinyMultiome.UiO preprint in BioRXiv or the final publication.")),
            ),
    
    # Contact
    tabPanel(
      "Contact",
      br(),br(),
      sidebarPanel(tags$h3("Prof. Dr. Ragnhild Eskeland"),
                  
                   fluidRow(
                     column(1,img(src='re.jpeg', align = "left")),
                     column(3), 
                     column(8,
                            tags$h4(HTML("Associate Professor")),
                            tags$h5(HTML("<a href=\"https://www.med.uio.no/imb/personer/vit/ragnhesk/index.html\" target=\"_blank\">Chromatin Biology Group</a>")),
                            tags$h5(HTML("<a href=\"https://www.uio.no\" target=\"_blank\">University of Oslo</a>")),
                            tags$h5(HTML("Email : <a href=\"mailto:ragnhild.eskeland@medisin.uio.no\" target=\"_blank\">ragnhild.eskeland@medisin.uio.no</a>")),
                     )
                   ),
                   width = 6),
      
      sidebarPanel(tags$h3("Dr. Ankush Sharma"),
                   
                   fluidRow(
                     column(1,img(src='as.jpg', align = "left",
                                  height="200px",style="object-fit:contain")),
                     column(3), 
                     column(7,
                            tags$h4(HTML("Researcher (Bioinformatics)")),
                            tags$h5(HTML("Chromatin Biology Group")),
                            tags$h5(HTML("<a href=\"https://www.uio.no\" target=\"_blank\">University of Oslo</a>")),
                            tags$h5(HTML("Email : <a href=\"mailto:ankush.sharma@medisin.uio.no\" target=\"_blank\">ankush.sharma@medisin.uio.no</a>")),
                     )
                   ),
                   width = 6),
      
      sidebarPanel(tags$h3("Akshay Suhag"),
                   
                   fluidRow(
                     column(1,img(src='aa.png', align = "left",
                                  width="150px",style="object-fit:contain")),
                     column(3), 
                     column(7,
                            tags$h4(HTML("Doctoral Researcher (Bioinformatics)")),
                            tags$h5(HTML("<a href=\"https://www.urofun.ch\" target=\"_blank\">Functional Urology Group</a>")),
                            tags$h5(HTML("<a href=\"https://www.dbmr.unibe.ch/about_us/staff/personenpool_index/akshay_akshay/index_eng.html\" target=\"_blank\">University of Bern</a>")),
                            tags$h5(HTML("Email : <a href=\"mailto:akshay.akshay@unibe.ch\" target=\"_blank\">akshay.akshay@unibe.ch</a>")),
                     )
                   ),
                     width = 6))

  )

)


###########################################################
#             Clustering tab                            ##
###########################################################
clustering <- tabPanel(
  titlePanel(h5("Clustering")),
sidebarPanel(
  
  selectizeInput(inputId ="dimRed",
                 label ="Dimension Reduction Type",
              choices = names(pbmc@reductions),
              selected = "umap"),

  hr(style = "border-color: black"),
  h4(''),
  br(),
  selectizeInput(inputId ="cellInfo",
                 label ="Cell information 1",
                 choices = colnames(pbmc@meta.data),
                 selected = colnames(pbmc@meta.data)[2]),

  hr(style = "border-color: #F5F5F5"),
  h4(''),

  selectizeInput(inputId ="cellInfo2",
                 label ="Cell information 2",
                 choices = colnames(pbmc@meta.data),
                 selected = colnames(pbmc@meta.data)[3]),


  hr(style = "border-color: black"),
  h4(''),
  br(),

  splitLayout(cellWidths = c("30%","30%","40%"),
              numericInput("clust_Width1", "Width", min = 0, max = 250, value = 6),
              numericInput("clust_height1", "Height", min = 0, max = 250, value = 4),
              selectizeInput(
                'plot_choice_download_clust1',
                label = "Format",
                choices = c(".pdf",".png",".tiff"),
                selected = ".pdf"),
              tags$head(tags$style(HTML("
                              .shiny-split-layout > div {
                                overflow: visible;}")))
  ),

  uiOutput("download_clust1_ui"),

  br(),
  br(),
  br(),

  splitLayout(cellWidths = c("30%","30%","40%"),
              numericInput("clust_Width2", "Width", min = 0, max = 250, value = 6),
              numericInput("clust_height2", "Height", min = 0, max = 250, value = 4),
              selectizeInput(
                'plot_choice_download_clust2',
                label = "Format",
                choices = c(".pdf",".png",".tiff"),
                selected = ".pdf"),
              tags$head(tags$style(HTML("
                              .shiny-split-layout > div {
                                overflow: visible;}")))
  ),

  uiOutput("download_clust2_ui"),

  width = 3

),
mainPanel(

  fluidRow(
    column(11,offset=2,h3(tags$b("MDS plot 1"),style = "border-color: black"))),

  fluidRow(
    column(12,offset=2,uiOutput("dimRed_plot"))
),

  fluidRow(
    column(8,offset=2,hr(style = "border-color: black"))
),

  fluidRow(
    column(11,offset=2,h3(tags$b("MDS plot 2"),style = "border-color: black"))),

  fluidRow(
    column(12,offset=2,uiOutput("dimRed_plot2"))
  )

)
)


###########################################################
#             Feature of Interest UMAPs                  ##
###########################################################
featUmap <- tabPanel(
  titlePanel(h5("Feature of Interest")),
  sidebarPanel(

    selectInput("assayType",
                "Choose Assay Type",
                choices = sort(names(pbmc@assays)),
                selected = sort(names(pbmc@assays))[1]),

    hr(style = "border-color: #F5F5F5"),

    selectInput("plotType",
                "Choose Plot Type",
                choices = c("Ridge","Violin","UMAP"),
                selected = "Violin"),

    hr(style = "border-color: black"),

    br(),
    selectInput("feature1",
                "Feature Name 1",
                choices = NULL),
    hr(style = "border-color: #F5F5F5"),

    selectInput("feature2",
                "Feature Name 2",
                choices = NULL),

    hr(style = "border-color: #F5F5F5"),

    selectInput("identFOI",
                "Cell Types",
                multiple = TRUE,
                choices = NULL),
    bsTooltip(id = "identFOI",
              title = "Applicable to Ridge and Violin plots."),


    hr(style = "border-color: black"),
    h4(''),
    br(),

    splitLayout(cellWidths = c("30%","30%","40%"),
                numericInput("feat_Width1", "Width", min = 0, max = 250, value = 6),
                numericInput("feat_height1", "Height", min = 0, max = 250, value = 4),
                selectizeInput(
                  'plot_choice_download_feat1',
                  label = "Format",
                  choices = c(".pdf",".png",".tiff"),
                  selected = ".pdf"),
                tags$head(tags$style(HTML("
                              .shiny-split-layout > div {
                                overflow: visible;}")))
    ),

    uiOutput("download_feat1_ui"),
    br(),
    br(),
    br(),
    splitLayout(cellWidths = c("30%","30%","40%"),
                numericInput("feat_Width2", "Width", min = 0, max = 250, value = 6),
                numericInput("feat_height2", "Height", min = 0, max = 250, value = 4),
                selectizeInput(
                  'plot_choice_download_feat2',
                  label = "Format",
                  choices = c(".pdf",".png",".tiff"),
                  selected = ".pdf"),
                tags$head(tags$style(HTML("
                              .shiny-split-layout > div {
                                overflow: visible;}")))
    ),

    uiOutput("download_feat2_ui"),
    width = 3

  ),

  mainPanel(
    fluidRow(
      column(11,offset=2,h3(tags$b("MDS plot 1"),style = "border-color: black"))),

    fluidRow(
      column(12,offset=2,uiOutput("feature1_plot"))
      ),
    
    fluidRow(
      column(9,offset=2,hr(style = "border-color: black"))
      ),

    fluidRow(
      column(11,offset=2,h3(tags$b("MDS plot 2"),style = "border-color: black"))),

    fluidRow(
      column(12,offset=2,uiOutput("feature2_plot"))
    )

  ))


###########################################################
#                    Plot Footprints                     ##
###########################################################
covPlot <- tabPanel(
  titlePanel(h5("Coverage Plot")),
  sidebarPanel(
    selectInput("identCov",
                "Cell Types",
                multiple = TRUE,
                choices =levels(pbmc),
                selected = levels(pbmc)[1:6]),

    selectInput("regionCov",
                "Gene Symbol",
                choices = NULL),

    hr(style = "border-color: black"),
    h4(''),
    
    textInput("regionCov_text", "Genomic Coordinates", value = "", placeholder = "Example: chr17-7660000-7690000"),

    h5('AND',style = "text-align: center"),

    selectInput("featCov",
                "RNA Feature",
                choices =NULL),
    hr(style = "border-color: black"),
    h4(''),

    hr(style = "border-color: #F5F5F5"),
    h4('Number of bases to extend the region'),
    splitLayout(cellWidths = c("50%","50%"),
                numericInput("range_min_1", "Upstream (kb) :", min = -250, max = 250, value = -50),
                numericInput("range_max_1", "Downstream (kb) :", min = -250, max = 250, value = 50)
    ),

    hr(style = "border-color: black"),
    h4(''),
    br(),

    splitLayout(cellWidths = c("30%","30%","40%"),
                numericInput("cov_Width", "Width", min = 0, max = 250, value = 9),
                numericInput("cov_height", "Height", min = 0, max = 250, value = 9),
                selectizeInput(
                  'plot_choice_download_cov',
                  label = "Format",
                  choices = c(".pdf",".png",".tiff"),
                  selected = ".pdf"),
                tags$head(tags$style(HTML("
                              .shiny-split-layout > div {
                                overflow: visible;}")))
    ),

    uiOutput("download_cov_ui"),
    width = 3
  ),

  mainPanel(
    fluidRow(
      column(12,uiOutput("cov_plot"))
    ),
  ))

###########################################################
#                      Coverage plot                     ##
###########################################################
fpPlot <- tabPanel(
  titlePanel(h5("TF Footprinting")),
  sidebarPanel(

    selectInput("featFP",
                "Feature",
                choices =NULL),

    selectInput("identFP",
                "Cell Types",
                multiple = TRUE,
                choices =levels(pbmc),
                selected = levels(pbmc)[1:6]),

    hr(style = "border-color: black"),
    h4(''),
    br(),

    splitLayout(cellWidths = c("30%","30%","40%"),
                numericInput("FP_Width", "Width", min = 0, max = 250, value = 10),
                numericInput("FP_height", "Height", min = 0, max = 250, value = 6),
                selectizeInput(
                  'plot_choice_download_FP',
                  label = "Format",
                  choices = c(".pdf",".png",".tiff"),
                  selected = ".pdf"),
                tags$head(tags$style(HTML("
                              .shiny-split-layout > div {
                                overflow: visible;}")))
    ),

    uiOutput("download_FP_ui"),
    width = 3
  ),

  mainPanel(
    fluidRow(
      column(12,uiOutput("FP_plot"))
    ),
  ))


###########################################################
#                      Combine all tabs                  ##
###########################################################
ui <- shinyUI(fluidPage(
  add_busy_spinner(spin = "radar", color = "#CCCCCC", onstart = TRUE, height = "55px", width = "55px"),
  navbarPage(
    clustering,
    covPlot,
    featUmap,

    fpPlot,
    about_panel,
    title ="ShinyMultiome.UiO",
    tags$head(tags$style(".shiny-output-error{color: grey;}"))
  ),
  tags$footer(HTML("<p><i>This webpage was made using</i> <a href='https://github.com/EskelandLab/ShinyMultiomeUiO' target=\"_blank\">ShinyMultiome.UiO</a>.</p>"),
              align = "left", style = "
              position:relative;
              bottom:0;
              color: black;
              padding: 10px;
              z-index: 1000;")
)
)

####################################
##       End of file    		      ##
####################################
