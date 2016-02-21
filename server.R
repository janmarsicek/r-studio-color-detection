library(shiny)
library("reshape")
library("ggplot2")
library("readbitmap")

shinyServer(function(input, output) {

  output$plotDetect <- reactivePlot(function() {
    download.file(input$imgurl, "tempPicture.jpg", mode = "wb")
    readImage <- readJPEG("tempPicture.jpg")
    longImage <- melt(readImage)
    rgbImage <- reshape(longImage, timevar = "X3", idvar = c("X1", "X2"), direction = "wide")
    rgbImage$X1 <- -rgbImage$X1
    kColors <- (input$ncolors)  # Number of palette colors
    kMeans <- kmeans(rgbImage[, 3:5], centers = kColors)
    approximateColor <- kMeans$centers[kMeans$cluster, ]
    col = rgb(approximateColor)
    barvy <- sort(table(col))
    barva <- row.names(barvy)
    barplot(barvy, col=barva, horiz=TRUE)
    approximateColor <- kMeans$centers[kMeans$cluster, ]
    with(rgbImage, plot(X2, X1, col = rgb(approximateColor), asp = 1, pch = "."))
    })
    
  output$plotcolors <- reactivePlot(function() {
    download.file(input$imgurl, "tempPicture.jpg", mode = "wb")
    readImage <- readJPEG("tempPicture.jpg")
    longImage <- melt(readImage)
    rgbImage <- reshape(longImage, timevar = "X3", idvar = c("X1", "X2"), direction = "wide")
    rgbImage$X1 <- -rgbImage$X1
    kColors <- (input$ncolors)  # Number of palette colors
    kMeans <- kmeans(rgbImage[, 3:5], centers = kColors)
    approximateColor <- kMeans$centers[kMeans$cluster, ]
    col = rgb(approximateColor)
    barvy <- sort(table(col))
    barva <- row.names(barvy)
    barplot(barvy, col=barva, horiz=TRUE)
  })
    
  output$downloadData <- downloadHandler(
    filename = "export.png",
    content = function(file) {
      png(file, width = 980, height = 600, units = "px", pointsize = 12, bg = "white", res = NA)
      download.file(input$imgurl, "tempPicture.jpg", mode = "wb")
      readImage <- readJPEG("tempPicture.jpg")
      longImage <- melt(readImage)
      rgbImage <- reshape(longImage, timevar = "X3", idvar = c("X1", "X2"), direction = "wide")
      rgbImage$X1 <- -rgbImage$X1
      kColors <- (input$ncolors)  # Number of palette colors
      kMeans <- kmeans(rgbImage[, 3:5], centers = kColors)
      approximateColor <- kMeans$centers[kMeans$cluster, ]
      col = rgb(approximateColor)
      barvy <- sort(table(col))
      barva <- row.names(barvy)
      barplot(barvy, col=barva, horiz=TRUE)
      approximateColor <- kMeans$centers[kMeans$cluster, ]
      with(rgbImage, plot(X2, X1, col = rgb(approximateColor), asp = 1, pch = "."))
      imgpng <- approximateColor <- kMeans$centers[kMeans$cluster, ]
                with(rgbImage, plot(X2, X1, col = rgb(approximateColor), asp = 1, pch = "."))
      dev.off()
    },
    contentType = 'image/png'
  )
})