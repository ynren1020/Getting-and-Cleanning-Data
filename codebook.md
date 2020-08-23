Download dataset and unzip it,  UCI HAR Dataset in your working directory
Read datasets one by one by read.table, name columns
Merge datasets by rbind (each kind, e.g., x, y and subject) and cbind (these three kind datasets together)
Select columns which contain mean and std in their names, using grep function
Rename columns, replace abbreviation by its full name, e.g., f -- frequency
Summarize all columns by mean function.
