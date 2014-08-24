library(plyr)

meanAndStd <- c(1,2,3,4,5,6, 
                41, 42, 43, 44, 45, 46, 
                81, 82, 83, 84, 85, 86,
                121, 122, 123, 124, 125, 126,
                161, 162, 163, 164, 165, 166,
                201, 202,
                214, 215,
                227, 228,
                240, 241,
                253, 254,
                266, 267, 268, 269, 270, 271,
                345, 346, 347, 348, 349, 350,
                424, 425, 426, 427, 428, 429,
                503, 504,
                517, 518,
                529, 530,
                542, 543)
features <- as.vector(read.table('features.txt')$V2)

testData <- as.data.frame.matrix(read.table('test//subject_test.txt'))
testData <- rename(testData, c('V1'='subject'))
testData$y <- read.table('test/y_test.txt')$V1
testData <-cbind(testData, read.table('test/X_test.txt', col.names = features)[meanAndStd])

trainData <- as.data.frame.matrix(read.table('train//subject_train.txt'))
trainData <- rename(trainData, c('V1'='subject'))
trainData$y <- read.table('train/y_train.txt')$V1
trainData <-cbind(trainData, read.table('train/X_train.txt', col.names = features)[meanAndStd])

fullData <- rbind(testData, trainData)
activities <- read.table('activity_labels.txt')
activities <- rename(activities, c('V1'='id', 'V2'='activity'))

fullData <- merge(x = fullData, y = activities, by.x = 'y', by.y = 'id')
fullData <- fullData[,2:69]
agData<-aggregate(fullData[,2:67], by = list(subject=fullData$subject, activity=fullData$activity), FUN = mean)
write.table(agData, 'tidy_data.txt', row.name=FALSE)