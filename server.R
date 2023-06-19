####################################
##       ShinyMultiome.UiO        ##
####################################
# Authors: Ankush Sharma and Akshay Akshay
# Note:  If you find this code useful and utilize any part of it, 
#        we kindly request that you acknowledge its usage by citing the ShinyMultiomeUiO preprint.



#extract and computes plots to be displayed in different tabs 
server <- function(input, output,session) {

  ###########################################################
  #                     Clustering tab                     ##
  ###########################################################

  # Define a function to generate plots
  generate_plot <- function(pbmc, cellInfo, dimRed) {
    if((is.factor(pbmc@meta.data[,cellInfo])==FALSE) &(is.character(pbmc@meta.data[,cellInfo])==FALSE)) {
      FeaturePlot(pbmc, features = cellInfo, reduction = dimRed,
                  pt.size = 1.2) + scale_color_viridis_c()
    } else {
      DimPlot(pbmc, label = TRUE, pt.size = 1.2,
              repel = TRUE, group.by = cellInfo, reduction = dimRed)
    }
  }

  # Define reactive expression for the plot
  plot1 <- reactive({
    req(input$dimRed, input$cellInfo, input$clust_height1, input$clust_Width1)
    generate_plot(pbmc, input$cellInfo, input$dimRed)
  })

  plot2 <- reactive({
    req(input$dimRed, input$cellInfo2, input$clust_height2, input$clust_Width2)
    generate_plot(pbmc, input$cellInfo2, input$dimRed)
  })

  # Provide the plots as an ouput
  output$plot1 <- renderPlot({ plot1() })
  output$dimRed_plot <- renderUI({ plotOutput("plot1", height = input$clust_height1*100, width = input$clust_Width1*100) })

  output$plot <- renderPlot({ plot2() })
  output$dimRed_plot2 <- renderUI({ plotOutput("plot", height = input$clust_height2*100, width = input$clust_Width2*100) })

  ########### download plots   ###########
  ## clustering plot 1
  output$download_clust1_ui <- renderUI({ downloadButton(outputId = "download_clust1", label = "Download Plot 1") })

  output$download_clust1 <- downloadHandler(
    filename = function(){
      paste0(input$cellInfo,"-",input$dimRed,input$plot_choice_download_clust1)
      
    },
    content = function(file){

      if(input$plot_choice_download_clust1==".pdf")
      {pdf(file = file,onefile=FALSE, height = input$clust_height1, width = input$clust_Width1)}

      else if(input$plot_choice_download_clust1==".png")
      {png(file = file, height = input$clust_height1, width = input$clust_Width1,units="in",res=1000)}

      else
      {tiff(file = file, height = input$clust_height1, width = input$clust_Width1,units="in",res=1000)}

      print(plot1())
      dev.off()
    }
  )


  ## clustering plot 2
  output$download_clust2_ui <- renderUI({ downloadButton(outputId = "download_clust2", label = "Download Plot 2") })

  output$download_clust2 <- downloadHandler(
    filename = function(){
      paste0(input$cellInfo2,"-",input$dimRed,input$plot_choice_download_clust2)
    },
    content = function(file){

      if(input$plot_choice_download_clust2==".pdf")
      {pdf(file = file,onefile=FALSE, height = input$clust_height2, width = input$clust_Width2)}

      else if(input$plot_choice_download_clust2==".png")
      {png(file = file, height = input$clust_height2, width = input$clust_Width2,units="in",res=1000)}

      else
      {tiff(file = file, height = input$clust_height2, width = input$clust_Width2,units="in",res=1000)}

      print(plot2())
      dev.off()
    }
  )

  ###########################################################
  #             Feature of Interest                       ##
  ###########################################################

  ## update the gene names dropdown based on assay type
  observeEvent(input$assayType, {
    DefaultAssay(pbmc) <- input$assayType
    features_RNA=names(sort(rowMeans(pbmc),decreasing=TRUE))
    updateSelectizeInput(session = session, inputId = 'feature1', choices = features_RNA, selected = features_RNA[1], server = TRUE)
    updateSelectizeInput(session = session, inputId = 'feature2', choices = features_RNA, selected = features_RNA[2], server = TRUE)
  })

  ## update the celly tpye dropdown based on ploty type
  observeEvent(input$plotType, {
    if(input$plotType=="UMAP"){
      updateSelectizeInput(session = session, inputId = 'identFOI', choices = NULL, server = TRUE)
    }else{
      updateSelectizeInput(session = session, inputId = 'identFOI', choices = levels(pbmc),selected = levels(pbmc)[1:6], server = TRUE)
    }
  })

  ## generate plot 1
  observeEvent(c(input$feature1, input$feat_height1, input$feat_Width1, input$assayType, input$plotType,input$identFOI), {
    req(input$feature1, input$feat_height1, input$feat_Width1, input$assayType)
    DefaultAssay(pbmc)=input$assayType
    output$plot3 <- renderPlot({
      plot_type <- switch(input$plotType,
                          "Ridge" = RidgePlot(pbmc, features = input$feature1,idents = input$identFOI) + NoLegend(),
                          "Violin" = VlnPlot(pbmc, features = input$feature1,idents = input$identFOI) + NoLegend(),
                          FeaturePlot(pbmc, c(input$feature1), reduction ="umap", pt.size = 1.2) & scale_color_viridis_c()
      )
      return(plot_type)
    })

    output$feature1_plot <- renderUI({
      plotOutput("plot3", height = input$feat_height1*100, width = input$feat_Width1*100)
    })
  })

  ## generate plot 2
  observeEvent(c(input$feature2, input$feat_height2, input$feat_Width2, input$assayType, input$plotType,input$identFOI), {
    req(input$feature2, input$feat_height2, input$feat_Width2, input$assayType)
    DefaultAssay(pbmc)=input$assayType

    output$plot4 <- renderPlot({
      plot_type <- switch(input$plotType,
                          "Ridge" = RidgePlot(pbmc, features = input$feature2,idents = input$identFOI) + theme(legend.position ="bottom"),
                          "Violin" = VlnPlot(pbmc, features = input$feature2,idents = input$identFOI) + theme(legend.position="bottom"),
                          FeaturePlot(pbmc, features = input$feature2, reduction ="umap",pt.size = 1.2) & scale_color_viridis_c()
      )
      return(plot_type)
    })

    output$feature2_plot <- renderUI({
      plotOutput("plot4", height = input$feat_height2*100, width = input$feat_Width2*100)
    })
  })


  ########### download plots   ###########
  ## Feature plot 1
  output$download_feat1_ui <- renderUI({ downloadButton(outputId = "download_feat1", label = "Download Plot 1") })

  output$download_feat1 <- downloadHandler(
    filename = function(){
      paste0(input$feature1,"-",input$assayType,"-",input$plotType,input$plot_choice_download_feat1)
    },
    content = function(file){

      if(input$plot_choice_download_feat1==".pdf")
      {pdf(file = file,onefile=FALSE, height = input$feat_height1, width = input$feat_Width1)}

      else if(input$plot_choice_download_feat1==".png")
      {png(file = file, height = input$feat_height1, width = input$feat_Width1,units="in",res=1000)}

      else
      {tiff(file = file, height = input$feat_height1, width = input$feat_Width1,units="in",res=1000)}

      DefaultAssay(pbmc)=input$assayType

        plot_type <- switch(input$plotType,
                            "Ridge" = RidgePlot(pbmc, features = input$feature1,idents = input$identFOI) + theme(legend.position="bottom"),
                            "Violin" = VlnPlot(pbmc, features = input$feature1,idents = input$identFOI) + theme(legend.position="bottom"),
                            FeaturePlot(pbmc, features = input$feature1, reduction ="umap",pt.size = 1.2) & scale_color_viridis_c()
        )

        print(plot_type)


      dev.off()
    }
  )

  ## Feature plot 2
  output$download_feat2_ui <- renderUI({ downloadButton(outputId = "download_feat2", label = "Download Plot 2") })

  output$download_feat2 <- downloadHandler(
    filename = function(){
      paste0(input$feature2,"-",input$assayType,"-",input$plotType,input$plot_choice_download_feat2)
    },
    content = function(file){

      if(input$plot_choice_download_feat2==".pdf")
      {pdf(file = file,onefile=FALSE, height = input$feat_height2, width = input$feat_Width2)}

      else if(input$plot_choice_download_feat2==".png")
      {png(file = file, height = input$feat_height2, width = input$feat_Width2,units="in",res=1000)}

      else
      {tiff(file = file, height = input$feat_height2, width = input$feat_Width2,units="in",res=1000)}

      DefaultAssay(pbmc)=input$assayType

      plot_type <- switch(input$plotType,
                          "Ridge" = RidgePlot(pbmc, features = input$feature2,idents = input$identFOI) + theme(legend.position="bottom"),
                          "Violin" = VlnPlot(pbmc, features = input$feature2,idents = input$identFOI) + theme(legend.position ="bottom"),
                          FeaturePlot(pbmc, features = input$feature2, reduction ="umap",pt.size = 1.2) & scale_color_viridis_c()
      )

      print(plot_type)


      dev.off()
    }
  )

  ###########################################################
  #                    Coverage Plot                       ##
  ###########################################################

  # Define reactive values for features and region
  features_RNA_reactive <- reactive({
    DefaultAssay(pbmc) <- "RNA"
    rownames(pbmc)
  })

  region_reactive <- reactive({
    if(input$regionCov_text != ""){
      input$regionCov_text
    } else {
      input$regionCov
    }
  })

  feat_reactive <- reactive({
    if(input$regionCov_text != ""){
      input$featCov
    } else {
      input$regionCov
    }
  })

  # Update dropdown values
  observeEvent(input$regionCov_text, {
    if(input$regionCov_text!="")
    {
      updateSelectizeInput(session = session, inputId = 'featCov', choices = features_RNA_reactive(), selected = features_RNA_reactive()[1], server = TRUE)
      updateSelectizeInput(session = session, inputId = 'regionCov', choices = NULL, selected = NULL, server = TRUE)

    }else{
      updateSelectizeInput(session = session, inputId = 'featCov', choices = NULL, selected = NULL, server = TRUE)
      updateSelectizeInput(session = session, inputId = 'regionCov', choices = features_RNA_reactive(), selected = features_RNA_reactive()[2], server = TRUE)

    }
  })


  # Generate plots
  observeEvent(c(input$regionCov, input$featCov, input$range_max_1, input$range_min_1, input$cov_height, input$cov_Width, input$regionCov_text,input$identCov), {

    output$plot5 <- renderCachedPlot(
      cacheKeyExpr = list(input$regionCov, input$featCov, input$range_max_1, input$range_min_1, input$cov_height, input$cov_Width, input$regionCov_text,input$identCov),
      expr = {
        DefaultAssay(pbmc) <- "peaks"

        CoveragePlot(
          object = pbmc,
          region = region_reactive(),
          features = feat_reactive(), 
          idents = input$identCov,
          extend.upstream = input$range_min_1,
          extend.downstream = input$range_max_1
        )& theme(text = element_text(size=14),
                 axis.title = element_text(size=14),
                axis.title.y.right = element_text(size = 14),
                legend.text=element_text(size=14),
                legend.title=element_text(size=14))
      }
    )

    output$cov_plot <- renderUI({
      plotOutput("plot5", height = input$cov_height*100, width = input$cov_Width*100)
    })

  })

  ########### download plot   ###########
  output$download_cov_ui <- renderUI({downloadButton(outputId = "download_cov", label = "Download Plot") })

  output$download_cov <- downloadHandler(
    filename = function(){
      paste0(region_reactive(),"-",input$featCov,"-covPlot",input$plot_choice_download_cov)
    },
    content = function(file){

      if(input$plot_choice_download_cov==".pdf")
      {pdf(file = file,onefile=FALSE, height = input$cov_height, width = input$cov_Width)}

      else if(input$plot_choice_download_cov==".png")
      {png(file = file, height = input$cov_height, width = input$cov_Width,units="in",res=1000)}

      else
      {tiff(file = file, height = input$cov_height, width = input$cov_Width,units="in",res=1000)}

      DefaultAssay(pbmc) <- "peaks"

      print(CoveragePlot(
        object = pbmc,
        region = region_reactive(),
        features = feat_reactive(), 
        idents = input$identCov,
        extend.upstream = input$range_min_1,
        extend.downstream = input$range_max_1
      )& theme(text = element_text(size=14),
               axis.title = element_text(size=14),
               axis.title.y.right = element_text(size = 14),
               legend.text=element_text(size=14),
               legend.title=element_text(size=14)))


      dev.off()
    }
  )


  ###########################################################
  #                    Footprint Plot                      ##
  ###########################################################

  # update dropdown list
  features_RNA= as.vector(unlist(pbmc@assays[["peaks"]]@motifs@motif.names))
  updateSelectizeInput(session = session, inputId = 'featFP', choices = features_RNA,selected = NULL, server = TRUE)

  # Generate plots
  observeEvent(input$featFP,{
    req(input$featFP)
    
    # motif analysis if it is not present in the provide seurat ovbject
    if (!input$featFP %in% names(pbmc@assays[["peaks"]]@positionEnrichment))
    {
      DefaultAssay(pbmc)="peaks"
      pbmc <<- Footprint(pbmc,
                        motif.name = input$featFP,
                        genome = BSgenome.Hsapiens.UCSC.hg38
      )
    }

  })


  observeEvent(c(input$featFP,input$identFP,
                 input$FP_height,input$FP_Width), {

                   req(input$featFP)
                   output$plot6 <- renderCachedPlot(
                     cacheKeyExpr = list(input$featFP,input$identFP,
                                         input$FP_height,input$FP_Width),
                     expr = {
                       DefaultAssay(pbmc)="peaks"

                       PlotFootprint(pbmc, idents=input$identFP,
                                     features = input$featFP)& theme(legend.position="right")+
                         theme(axis.title = element_text(size=14),
                               axis.title.y.right = element_text(size = 14),
                               legend.text=element_text(size=14),
                               legend.title=element_text(size=14))
                     }
                   )

                   output$FP_plot <- renderUI({
                     plotOutput("plot6" ,height = input$FP_height*100,width = input$FP_Width*100)
                   })

                 })

  ########### download plots   ###########
  output$download_FP_ui <- renderUI({downloadButton(outputId = "download_FP", label = "Download Plot")})

  output$download_FP <- downloadHandler(
    filename = function(){
      paste0(input$featFP,"-Footprint",input$plot_choice_download_FP)

    },
    content = function(file){

      if(input$plot_choice_download_FP==".pdf")
      {pdf(file = file,onefile=FALSE, height = input$FP_height, width = input$FP_Width)}

      else if(input$plot_choice_download_FP==".png")
      {png(file = file, height = input$FP_height, width = input$FP_Width,units="in",res=1000)}

      else
      {tiff(file = file, height = input$FP_height, width = input$FP_Width,units="in",res=1000)}

      DefaultAssay(pbmc)="peaks"

      print(PlotFootprint(pbmc, idents=input$identFP,
                    features = input$featFP)& theme(legend.position="right")+
        theme(axis.title = element_text(size=14),
              axis.title.y.right = element_text(size = 14),
              legend.text=element_text(size=14),
              legend.title=element_text(size=14)) )


      dev.off()
    }
  )

}

####################################
##       End of file    		      ##
####################################