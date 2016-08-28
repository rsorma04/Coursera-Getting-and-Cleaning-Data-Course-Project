# Coursera-Getting-and-Cleaning-Data-Course-Project

### The strategy to obtain the final data set was as follows:

* Download the data set.
* Bring in the feature term set and activity labels; clean the feature dataset as necessary.
* Combine the fact, attributes, and subjects data sets for the test and training sets.
* Bind the test and training sets into one untidy data set.
* Merge the activity labels in the untidy dataset.
* Extract from the data only those features that are a mean and standard deviation.
* Create the 'tidy' dataset using a melt and dcast function to average the means and standard deviations grouped by subject and activity.
* Write the tidy data set to a file called `tidy.txt`.
