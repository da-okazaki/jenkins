shinyServer(
  function(input, output, session) {
    output$contents <- renderTable({
      
      # input$file will be NULL initially. After the user selects
      # and uploads a file, it will be a data frame with 'name',
      # 'size', 'type', and 'datapath' columns. The 'datapath'
      # column will contain the local filenames where the data can
      # be found.

      inFile <- input$file
      
      if (is.null(inFile))
        return(NULL)
      
      if(1){
        inFile <- input$file
        if (is.null(inFile))
          return(NULL)
        #data <- read.csv(inFile$datapath, header=input$header, sep=input$sep, 
        #                 quote=input$quote)
        data <- read.csv(inFile$datapath, header=TRUE)
        x<-data$Day
        y<-data$Number
        
        x<-data$Day
        y<-data$Number
        print(x)
        max_x<-length(x)
        max_y<-length(y)
        RSS_array<-c(1:max_x)
        RSS_array<-RSS_array-RSS_array
        parameter_array<-c(1:max_x)
        parameter_array<-parameter_array-parameter_array
        filename<-"data/sample"
        data<-cbind(x,y)
        plot(data,xlim=c(0,x[max_x]*2), ylim=c(0, y[max_y]*2))
        Sys.sleep(1)
        x_axis<-seq(0,x[max_x]*2)
        for(i in 4:max_x){
          tmpfilename<-paste("data/",i)
          tmpfilename<-paste(tmpfilename,".txt")
          tmppictname<-paste(filename,i)
          tmppictname<-paste(tmppictname,".png")
          tmpx<-x[0:i]
          tmpy<-y[0:i]
          print(i)
          ansans<-try(ansans<-nls(tmpy~SSlogis(tmpx,A,B,C),trace=TRUE,control=nls.control(warnOnly=TRUE)))
          cat("Ans\n")
          if(class(ansans)!="try-error"){
            print(ansans)
            print("end")
            parameter<-ansans$m$getPars()
            parameter_array[i]=parameter[1]
            print(parameter)
            result<-summary(ansans)
            predict.c <- predict(ansans,list(tmpx = x_axis))
            #Save Graph	start
            #png(tmppictname)
            #plot(data,xlim=c(0,x[max_x]), ylim=c(0, y[max_y]), xlab="Day", ylab="# of Issues" )
            #lines(x_axis,predict.c)
            #abline(v=x[i])
            #abline(h=parameter_array[i])
            #dev.off()
            #Save Graph	end
            RSS_predict <- predict(ansans,list(tmpx = x))
            RSS<-sum((y-RSS_predict)^2)
            RSS_array[i]<-RSS
            #Save plot data as csv
            predicted_data <- data.frame(x_axis,predict.c)
            write.csv(predicted_data,file=tmpfilename)
          }
        }
        #Save Graph	start
        plot.new()
        png("data/Plot.png")
        plot(data,xlim=c(0,x[max_x]), ylim=c(0, y[max_y]*1.5), xlab="Day", ylab="# of Issues" )
        lines(x_axis,predict.c)
        dev.off()
        #Save Graph	end
        #The Data for Behavier of RSS
        RSS_summary<-data.frame(x,RSS_array)
        frame()
        plot.new()
        png("data/RSS.png")
        plot(RSS_summary, type="l" , xlab="Day", ylab="# of Issues" )
        abline(h=y[max_y])
        dev.off()
        write.csv(RSS_summary, file="data/RSS.csv")
        #The Data for Behavier of Predicted number of Issues
        param_summary<-data.frame(x,parameter_array)
        frame()
        plot.new()
        png("data/Predicted_Issues.png")
        plot(param_summary, type="l", xlab="Day", ylim=c(0, y[max_y]*1.5), ylab="# of Predicted Issues" )
        abline(h=y[max_y])
        dev.off()
        write.csv(param_summary, file="data/Predicted_Issues.csv")
        print(ansans)
        print("end")
    }

      read.csv(inFile$datapath, header=TRUE)
    })

    output$plot1 <- renderPlot({
      inFile <- input$file
      if (is.null(inFile))
        return(NULL)
      
      data <- read.csv(inFile$datapath, header=TRUE)

      
      plot(data)
      x<-data$Day
      y<-data$Number
      file_number <- input$animation
      #persentage to integer
      max_x <- length(x)
      number <- as.integer(file_number/100 * max_x)
      read_file_name <- paste("data/", number)
      read_file_name <- paste(read_file_name,".txt")
      if(file.exists(read_file_name)){
        Predicted_data <- read.csv(read_file_name, header=TRUE)
        tmpPX <- Predicted_data$x_axis
        tmpPY <- Predicted_data$predict.c
        data <- data.frame(tmpPX,tmpPY)
        lines(data,type="l")
        abline(v=x[number])
        abline(h=tmpPY[length(tmpPY)])
      } else {
        while(!file.exists(read_file_name)){
          number <- number + 1
          read_file_name <- paste("data/", number)
          read_file_name <- paste(read_file_name,".txt")
        }
        print(read_file_name)
        Predicted_data <- read.csv(read_file_name, header=TRUE)
        tmpPX <- Predicted_data$x_axis
        tmpPY <- Predicted_data$predict.c
        data <- data.frame(tmpPX,tmpPY)
        lines(data,type="l")
        abline(v=x[number])
        abline(h=tmpPY[length(tmpPY)])
      }
      
      
      
    })

    output$plot2 <- renderPlot({
      inFile <- input$file
      if (is.null(inFile))
        return(NULL)
      data <- read.csv(inFile$datapath, header=TRUE)
      if(file.exists("data/Predicted_Issues.csv")){
        print("exits")
        Predicted_data <- read.csv("data/Predicted_Issues.csv", header=TRUE)
        tmpPX <- Predicted_data$x
        tmpPY <- Predicted_data$parameter_array
        print(tmpPX)
        print(tmpPY)
        data <- data.frame(tmpPX,tmpPY)
      }
      plot(data, type = "l")
    })
})