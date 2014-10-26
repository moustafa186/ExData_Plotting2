setwd("/home/moustafa/R-projects/UCI HAR Dataset")
library(data.table)
# 1- Merge the training and the test sets to create one data set.

# 1.1 - read - 'features.txt': List of all features.
features <- read.table('./features.txt', header = FALSE, sep = " ", quote = "", colClasses=c('numeric', 'character'), col.names = c('id','feature'), stringsAsFactors=FALSE)
features$feature <- tolower(gsub("[-(),]", "", features$feature))

# 1.2 - read - 'activity_labels.txt': Links the class labels with their activity name.
labels <- read.table('./activity_labels.txt', header = FALSE, sep = " ", quote = "", colClasses=c('numeric', 'character'), col.names = c('label','activity.name'), stringsAsFactors=FALSE)
labels$activity.name <- factor(labels$activity, levels = labels$activity, ordered=TRUE )

# 1.3 - read - 'test/X_test.txt': Test set.
xtest <- read.table('./test/X_test.txt', header = FALSE, quote = "", colClasses = "numeric", stringsAsFactors=FALSE)

# 1.4 - read - 'test/y_test.txt': Test labels.
ytest <- read.table('./test/y_test.txt', header = FALSE, quote = "", colClasses="numeric", col.names = c('label'), stringsAsFactors=FALSE)

# 1.5 - read - 'train/X_train.txt': Training set.
xtrain <- read.table('./train/X_train.txt', header = FALSE, quote = "", colClasses="numeric", stringsAsFactors=FALSE)

# 1.6 - read - 'train/y_train.txt': Training labels.
ytrain <- read.table('./train/y_train.txt', header = FALSE, quote = "", colClasses="numeric", col.names = c('label'), stringsAsFactors=FALSE)

xytest <- cbind(xtest,ytest)
xytrain <- cbind(xtrain,ytrain)
merged <- rbind(xytrain, xytest)

names(merged) <- c(features$feature, "activity")

# 2- Extract only the measurements on the mean and standard deviation for each measurement.
means <- grep('mean',features$feature, value=TRUE)
std <- grep('std',features$feature, value=TRUE)
extractcols <- c(means, std, "activity")
extracted <- merged[, extractcols]

# 3- Use descriptive activity names to name the activities in the data set.
mergedActivities = merge(extracted, labels, by.x="activity", by.y="label")

# 4- Appropriately label the data set with descriptive variable names.


# 5- From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
