####################################
##       ShinyMultiome.UiO        ##
####################################
# Authors: Ankush Sharma and Akshay Akshay
# Note:  If you find this code useful and utilize any part of it, 
#        we kindly request that you acknowledge its usage by citing the ShinyMultiomeUiO preprint.




# Load libraries so they are available
# Run the app through this file.
source("ui.R")
source("server.R")

shinyApp(ui:ui, server:shinyServer)

####################################
##       End of file    		      ##
####################################