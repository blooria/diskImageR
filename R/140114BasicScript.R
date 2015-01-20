###############################################################################
#BASIC SCRIPT OUTLINE - Use if you want to go from pictures to dataframe all in one R session
###############################################################################
#Step 1 - load the R script
source(file.choose())
#Step 2 - run the imageJ macro
runImageJAnalysis("projectName")
#Step 3 - plot the raw data (make sure that imageJ properly found the disc)
plotRaw("projectName", ymax=250)
#Step 4 - run the maximum likelihood analysis
maxLik("projectName")
#Step 5 - create a dataframe of the parameter results
createDataframe("projectName")

runImageJAnalysis("MAT5.t4", imageJLoc = "loc2")
#Step 3 - plot the raw data (make sure that imageJ properly found the disc)
plotRaw("MAT5.t4", ymax=300, standardLoc = 3.5, dotedge = 4, standardLocPlot = TRUE, overwrite =FALSE)
#Step 4 - run the maximum likelihood analysis
maxLik("test", clearHalo = 3, ymax=300, standardLoc = 2.5, dotedge = 3.4, overwrite =FALSE, needML=FALSE)
#Step 5 - create a dataframe of the parameter results
createDataframe("test", typePlace=3)


####################
#BEFORE YOU START
####################
# Before you can use this script you need to install imageJ and R on your computer
# In R, you need to install two packages.  Go to "Packages&Data" and search for "Diversitree".  
# Install it (and click the box that says "install dependencies".  Do the same thing with the library "tcltk2".

# Nothing should be written on the bottom of your plates - label on the sides.

# The photos you want to analyze together should all be in the same folder
# Photo naming is very important.  They should be named according to how you eventually
# want to analyze the data.  A general name would be strain_factor1_factor2_rep
# so if you have photos of 4 different strains, took 2 pictures for each and have two different
# drug concentrations, you would have a folder with 4x2x2 = 16 photos labeled:
# strain1_dc1_a, strain1_dc1_b, strain1_dc2_a, strain1_dc2_b ...
# Conversely, you can simply number the pictures and add in all the other factors later, in excel
# (this may be easier!).
# Photos should be cropped around the disc.

# You need to make sure that there are no spaces or special characters in any of the folder names that are in the path that  lead to your pictures, the imageJ macro file, or the folder you will use as the main project folder.   The main project folder is the folder you will select to contain all of the output that this script will create for this project.  It should already exist on your computer before you start running the script.  
#Within the project folder the script will create two folders (if they do not already exist) - one called figures and one called parameter_files.  WIthin each of these folders the script will create new day-specific folders, thus, for each day you analyze data, new folders will be created.  If you repeat analyses multiple times on the same day the existing figures and files will be overwritten, so if you need to save them make sure to either manually change the figure/file names or rerun the script with a different project name (a new project name can be set using the functions "readInDir()", which reads in the output from imageJ or "readExistingDF()" which reads in an existing dataframe).

#Importantly for the script, you will need a picture of at least one plate that has a clear zone around the disc.  Take note of the name of this picture so that you can find out which numerical place it is in your dataset.

######################
#BASIC R INFORMATION 
######################
# Basic information about R can be found all over the web. Google is your friend.
# R is case sensitive
# You can not start a name/vector/dataframe etc. with a number (or any special character)

# To run R code from this document in the R console, highlight the relevant line and hit command-enter

# If you want to know what needs to be defined/can be defined for each function, copy the function name and "(" into the R console.  Any parameter that is not followed by an equals sign ("=") must be specified in the function call.  Parameters followed by an equals sign have default values that can be changed.

# A vector looks like this:
newVector <- c("V1", "V2", "V3")

# A new dataframe looks like this:
newDF <- data.frame("vector1" = c("V1", "V2", "V3"), "vector2" = c(0, 1, 2))

#A list looks like this:
newList <- list(oldList[[1]], oldList[[2]], oldList[[3]])

###################################
#STEP 1
#LOAD THE R SCRIPT ("discAssayXXX.R")
###################################
# This is the absolute path to the file that contains all of the analysis scripts for R.  
# e.g., "/Users/acgerstein/Documents/Postdoc/Research/ 0CommonFiles/R script/discAssay1_5.R"
source(file.choose())

##############################################
#STEP 2
#RUN THE imageJ MACRO ON YOUR SET OF PHOTOS
##############################################
# This function call will bring up a pop-up box to select first the main experiment folder and then the folder that has the pictures in it.  
# From each photograph, the macro (in imageJ) will automatically determine where the disc is located, find the center of the disc, and draw 40mm lines out from the center of the disc every 5 degrees.  For each line, the pixel density will be determined at many along the line.  This data will be stored in the folder "imageJ-out" on your computer
# In R, the lines will be averaged together to create a composite dataframe for each picture, which is then stored in the list "projectName".  

# The output of "runImageJAnalysis" is a list named "projectName" with n elements, where n is the number of images in the location specified.  
# In the console, you can:
# accessed the list with the command: projectName 
# find the names of the photos with the command: names("projectName") 
# access a single element with: projectName[[n]]  
# plot the raw output of a single picture with: plot(projectName[[n]])

#runImageJAnalysis <- function(projectName = "projectName", discDiam = 6, imageJLoc="default")

#[projectName] you should replace "projectName" below with the name you will use repeatedly for this project -- it should be descriptive
#Optional Parameters that you can specify: 
#[discDiam] is the diameter of the discs you are using.  It is important that this is correct. [default: discDiam = 6]
#[imageJLoc] is absolute path (location) of imageJ on your computer.  Two common locations are listed below.  If your imageJ is located at "/Applications/ImageJ.app/" then you do not need to do anything.  If your imageJ program is located in a folder inside the Applications folder ("/Applications/ImageJ/ImageJ.app/") then should add "imageJLoc="loc2" into the function call.  If your program is located somewhere else entirely, you will need to put in the absolute path into the function call ("imageJLoc=absolutePath").  On a mac you can drag the file into a terminal window to find the path.  I'm ignoring that Windows users exist (sorry, I'm not perfect).

# When you run the line below, it will prompt you for:
# 1) The "main project folder" is the folder that will contain all of the output that this script will create for this project.  It should already exist on your computer before you start running the script.
# 2) The folder location of the photos you want to analyze
# 3) The imageJ disc assay script.  This is the text file (.txt) labelled something like "DiscAssayBatch.txt"
# You need to actually double click on the folder and make sure that the path shown at the bottom in the "selection box" is the correct path

runImageJAnalysis("projectName")

##############################################################################
#STEP 3
#PLOT THE RAW DATA (from the data saved in the folder "imageJ-out")
##############################################################################
#This function will plot the raw data from each composite dataframe stored in the list "projectName"

#plotRaw <- function(projectName,  standardLoc = 2.5, ymin = 0, ymax=200, xmin = 0, xmax = 40, dotedge = 3, xplots = 6, nameVector = TRUE , plotDot = TRUE, plotStandardLoc=TRUE, showNum=FALSE, popUp = TRUE, overwrite=TRUE)

#[projectName] - the first argument must be the experiment name
# Optional Parameters that you can specify: 
#[standardLoc] this parameter is used to standardize pixel intensity values among the different elements of data.  The default is to use pixel intensity at 2.5. Necessary if white balance/brightness settings are set to automatic.  [default: standardLoc = 2.5]
#[ymin] [ymax]	these can take any numerical value [defaults: ymin = 0, ymax = 200]
#[xmin] [xmax] these can take any numerical value [defaults: xmin = 0, xmax = 40] 
#[dotedge] if plotDot = TRUE, this will add a vertical dashed line on the graph at the edge of the dot.  This is useful for making sure that the imageJ macro correctly identified the disc and is a paramter used repeatedly below. Make sure that the dashed line is to the right of the disc (it's better to be a little too far to the right then to be too far to the left) [default: dotedge = 3]
#[xplots] the number of plots per row.  The number of plots per column will be determined from this number [default: xplots = 6]
#[nameVector] determines how to label the different graphs; TRUE to label each graph the same as the pictures are labeled, FALSE for no name, or a vector of length equal to the number of pictures with anything you choose [default: nameVector = TRUE] 
#[plotDot] whether you want a vertical line at this dot edge, this should be either TRUE or FALSE [default: plotDot = TRUE]
#[plotStandardLoc] whether you want a vertical line at the standardization location specified above, this should be either TRUE or FALSE [default: plotStandardLoc = TRUE]
#[showNum] indicates whether you want to display the numeric position of each picture in the list on the graph (can be useful if you later want to create sub-lists, as below) [default: showNum = FALSE]
#[popUp]	whether you want the figure to pop-up on your screen or not, can be either TRUE or FALSE [default: popUp = TRUE]
#[overwrite] If the function is run more than once, whether to overwrite the existing graph or not [default: overwrite = TRUE]

plotRaw("projectName")

##############################################################################
#STEP 4
#RUN THE MAXIMUM LIKELIHOOD ANALYSIS
##############################################################################
# This is the function that fits two logistic curves using maximum likelihood to the compostive pixel instensity line from each picture.
# The output of maxLik is 1) a list named "projectName.ML" with n elements, where n is the number of images.  You will use this if you want to replot single ML analysis fits (below), 2) a figure that displays the raw data and ML fit overlay (the red line on each figure).  The figure will contain many individual plots, one for each picture analyzed, and 3) a figure that displays the area under the curve

#maxLik <- function(projectName, clearHalo = 1, standardLoc = 2.5, dotedge=3, maxDist=30, ymax=200, xplots = 6, percentileHigh = 0.9, percentileLow = 0.2,  nameVector=TRUE, overwrite = TRUE, plotCompon = FALSE, legend = TRUE,  popUp = TRUE, needML = TRUE)

#["projectName"] The projectName
# Optional Parameters that you can specify: 
# [clearHalo] This specifies a photo number for a photograph where there is an area right beside the disc where there are no cells growing.  [defaul: clearHalo = 1]
#[standardLoc] this parameter is used to standardize pixel intensity values among the different elements of data.  The default is to use pixel intensity at 2.5. Necessary if white balance/brightness settings are set to automatic.  [default: standardLoc = 2.5]
# [dotedge] Where the edge of the dot is, this can take any numerical value [default: dotedge = 3]
# [maxDist] the maximum distance along the x-axis to examine, this can take any numerical value up to 40 [default: maxDist=30]
# [ymax]  this can take any numerical value (for plotting the ML fit on the raw graphs) [defaults: ymax=200]
# [xplots] the number of plots per row.  The number of plots per column will be determined from this number [default: xplots = 6]
# [percentileLow] [percentileHigh] parameters that define the halo bounds (i.e., where growth begins and where full growth is achieved) [default: percentileLow = 0.1, percentileHigh = 0.9]
#[nameVector] the name to display above figures.  [default: nameVector = TRUE, will display the photo name].  If nameVector = FALSE, no name will be displayed.  Otherwise, here you can provide a vector of length equal to the number of pictures specifying any names. (e.g., c("pic1", "pic2", "pic3" ...)
# [overwrite] If the function is run more than once, whether to overwrite the existing graph or not [default: overwrite = TRUE]
# [plotCompon] Whether to plot the two logistic curve components of the maximumum likelihood curve calculation (or just the composite curve, which is always plotted).  [default: plotCompon = FALSE]
# [legend] Whether to plot a legend on the ML plot or not [default: legend = TRUE]
#[popUp]	whether you want the figure to pop-up on your screen or not, can be either TRUE or FALSE [default: popUp = TRUE]
# [needML] You can set this to FALSE if you have already run maxLik, successfully found ML results, and are just rerunning it to play with the graphical parameters [default: needML = TRUE]


maxLik("projectName")

##############################################################################
#STEP 5
# DATAFRAME OF RESULTS
##############################################################################
# Make a dataframe that contains all disc assay parameters from the maximum likelihood procedure and area under curve calculation: minHalo, the point at which 10% of growth is reached; ZOI, the point at which 90% of growth is reached; and AUC, the area under the curve from the edge of the disc to the ZOI (n.b., 10% and 90% are the default settings but they can be changed). 
# The output of createDataframe is a dataframe called "projectName.df" as well as a csv file that can be opened in excel (saved in the folder "parameter_ files").  
# After this point you can stop using R, all the information you need will be stored in the file you can open in excel.
# In the .csv file and the dataframe are a series of columns with 1 row for each photo that was analyzed.  The parameters that were fit for each photograph are:
	#lines = the photo names
	
#createDataframe <- function(projectName, typePlace, dotedge = 3, maxDist = 30, standardLoc = 2.5, clearHalo = 1, xplots = 6,  ymax = 200, percentileHigh = 0.9, percentileLow = 0.1, nameVector=TRUE, showNum=FALSE, popUp=FALSE, typeVector=TRUE, makePlot=FALSE, clearHalo = 1, order="default")

#["projectName"] The projectName
#[typePlace] If the labeling of pictures includes more than one factor (e.g., name_rep_otherFactor) you can specify which factor to use  [default: typePlace = 2, which in this case would use "rep" as the type; lenType =3 would store "otherFactor"].  If you prefer to manually identify one or more qualitative variables, you can include either a vector or a dataframe here that will be used (or you can use typeVector = FALSE and manually add this after the function call)
# Optional Parameters that you can specify: 
# [dotedge] Where the edge of the dot is, this can take any numerical value [default: dotedge = 3]
#[maxDist] the maximum distance along the x-axis to examine, this can take any numerical value up to 40 [default: maxDist=30]
#[standardLoc] this parameter is used to standardize pixel intensity values among the different elements of data.  The default is to use pixel intensity at 2.5. Useful if lighting is not perfect and the pictures vary in brightness.  [default: standardLoc = 2.5]
# [clearHalo] This specifies a photo number for a photograph where there is an area right beside the disc where there are no cells growing.  [defaul: clearHalo = 1]
# [xplots] the number of plots per row.  The number of plots per column will be determined from this number [default: xplots = 6]
# [ymax]  this can take any numerical value (for plotting the ML fit on the raw graphs) [defaults: ymax=200]
# [percentileLow] [percentileHigh] parameters that define the halo bounds (i.e., where growth begins and where full growth is achieved) [default: percentileLow = 0.1, percentileHigh = 0.9]
#[nameVector] determines how to label each different graphs; TRUE to label each graph the same as the pictures are labeled, FALSE for no name, or a vector of length equal to the number of pictures with anything you choose [default: nameVector = TRUE] 
#[showNum] indicates whether you want to display the numeric position of each picture in the list on the graph (can be useful if you later want to create sub-lists, as below)
#[popUp]	whether you want the figure to pop-up on your screen or not, can be either TRUE or FALSE [default: popUp = FALSE]
#[typeVector] used if there is a quanitative quality that differentiates the strains you are examining. If included in the strain name (e.g., photos were labeled as "name_type") and typeVector = TRUE, whatever follows the "_" will automatically be used as they type vector.  
# [order] how you want the dataframe to be ordered (primarily just for ease of looking at the dataframe in R).  The default is to order the dataframe based on line names, but column names can be specified here (i.e., if you have specified columns from the typeVector command above).  [default: order = "default"]


createDataframe("projectName")

