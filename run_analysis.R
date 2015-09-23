library(dplyr)

trainX<-read.table("UCI HAR Dataset/train/X_train.txt")
trainY<-read.table("UCI HAR Dataset/train/y_train.txt")
testX<-read.table("UCI HAR Dataset/test/X_test.txt")
testY<-read.table("UCI HAR Dataset/test/y_test.txt")
X<-rbind(trainX, testX)
y<-rbind(trainY, testY)
d<-read.table("UCI HAR Dataset/features.txt")
names(X)<-d[,2]
imean<-grep("mean", names(X))
istd<-grep("std", names(X))
i<-sort(c(imean, istd))
X<-X[,i]
names(y)<-c("activity_label")
Z<-cbind(y,X)
activity_labels<-read.table("UCI HAR Dataset/activity_labels.txt")
Z<-mutate(Z, label=activity_labels[activity_label,2])
res<-tapply(Z[,2], Z$activity_label, mean)
for (i in 3:80) {
    res<-cbind(res,tapply(Z[,i], Z$activity_label, mean))
}
colnames(res)<-names(Z[2:80])
write.table(res, "result.txt", row.name=FALSE)