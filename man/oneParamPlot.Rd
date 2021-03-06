% Generated by roxygen2 (4.1.0.9001): do not edit by hand
% Please edit documentation in R/oneParamPlot.R
\name{oneParamPlot}
\alias{oneParamPlot}
\title{Used to plot a single parameter}
\usage{
oneParamPlot(projectName, type, param = "ZOI20", ymin = 0, ymax = 100,
  width = 6, height = 4, xlabels = "line", xlabAngle = NA, order = NA,
  orderFactor = "line", overwrite = TRUE, savePDF = TRUE, popUp = TRUE,
  barplot = TRUE)
}
\arguments{
\item{projectName}{the short name to be used for the project}

\item{ymin}{a numeric value indicating the minimum y value plotted in each graph}

\item{ymax}{a numeric value indicating the maximum y value plotted in each graph}

\item{width}{a numeric value indicating the width of the pdf file generated}

\item{height}{a numeric value indicating the height of the pdf file generated}

\item{xlabels}{either a vector containing the desired x-axis labels, or a single value indicating the column name that contains the values to use (likely either the 'line' column or one of the type columns), default = "line".}

\item{xlabAngle}{indicates whether to print the x axis labels on a angle, if a number is provided this will be the angle used. The defauilt is not to plot on an angle, default = NA.}

\item{order}{can be either "factor" or "custom". If custom, supply a numberial vector the same length as the dataframe to indicate the desired order. If factor, supply the column name in \code{ordeFactor} to be used to factor.}

\item{orderFactor}{if \code{order = "factor"} supply the column name to be used to factor.}

\item{overwrite}{a logical value indicating whether to overwrite existing figures created on the same day for the same project name}

\item{savePDF}{a logical value indicating whether to save a PDF file or open a new quartz. Defaults to TRUE.}

\item{popUp}{a logical value indicating whether to pop up the figure after it has been created}

\item{barplot}{whether to plot values as a barplot (barplot = TRUE) or dotplot (barplot = FALSE), default = TRUE. Only possible when \code{type = "ag"}}
}
\value{
Either a pdf figure figure (projectName_ZOI-fAUC.pdf) saved to the 'figures' directory or a figure on screen
}
\description{
This function creates a pdf figure of plots showing the results of the imageJ analysis for resistance (ZOI), sensitivity (slope) and tolerance (AUC).
}
\details{
Basic parameter plotting functions to plot a single  parameter. Input can be the dataframe from either \code{\link{createDataframe}} \code{type="df"} or from \code{\link{aggregateData}} \code{type=="ag"}.
}
\author{
Aleeza C. Gerstein
}

