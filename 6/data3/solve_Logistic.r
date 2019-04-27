sink("data/console.txt")
data<-read.csv("data.csv")
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
x_axis<-seq(0,x[max_x]*2)
for(i in 4:max_x){
	tmpfilename<-paste(filename,i)
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
		png(tmppictname)
		plot(data,xlim=c(0,x[max_x]), ylim=c(0, y[max_y]), xlab="Day", ylab="# of Issues" )
		lines(x_axis,predict.c)
		abline(v=x[i])
		abline(h=parameter_array[i])
		dev.off()
#Save Graph	end
		RSS_predict <- predict(ansans,list(tmpx = x))
		RSS<-sum((y-RSS_predict)^2)
		RSS_array[i]<-RSS
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
write.table(RSS_summary, file="data/RSS.csv")
#The Data for Behavier of Predicted number of Issues
param_summary<-data.frame(x,parameter_array)
frame()
plot.new()
png("data/Predicted_Issues.png")
plot(param_summary, type="l", xlab="Day", ylim=c(0, y[max_y]*1.5), ylab="# of Predicted Issues" )
abline(h=y[max_y])
dev.off()
write.table(param_summary, file="data/Predicted_Issues.csv")
print(ansans)
print("end")
sink()
