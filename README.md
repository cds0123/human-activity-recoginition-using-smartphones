# Human Activity Recognition Using Smartphone Data Analysis

In this project, we will explore dataset from Human Activity Recognition Using Smartphone \[[1](#reference-1)]
([UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)).

(Note that the dataset used in this project is version 1.0 published at 2012.
Version 2.1 is available if you prefer to use the newer one.)

## 1 Objective

The data comes with numeric variables as sensor data, so that before starting data analysis,
we have to format the data and make it easy to analyze.

The objective of this project is preprocessing data for the later analysis, so that the analysis part is not included.

## 2 Repository Structure
This repository consists of two files (except this `README.md`) as following.

```
.
 |- helper.R 		# contains helper function to build data frame
 |- loader.R		# contains functions to load data from data set
 |- run_analysis.R	# script to process the dataset
 |- CodeBook.md		# description about the variables, data, and any steps taken in this project
```

## 3 Execution

### 3.1 Environment Setup
For this project, `R` is used. (To install `R`, visit [R documentation](https://www.r-project.org/))


Required package is following:
```
dplyr==1.0.6
```

The code is run on Ubuntu 20.04 so that may not work in other environment (e.g. Windows, Mac)

Once download data and unzip it, the structure will be following.
Here, the parent folder is renamed as `data/`, and we will use this directory name for consistency.

```
- data/
	|- train/
	|- test/
	|- activity_labels.txt
	|- feature_info.txt
	|- features.txt
	|- README.md
```

### 3.2 Execute script

All steps taken to preprocess are described in `CodeBook.md`.
If you use `data/` as the data directory as described at the previous section,
you have to call `set_data_dir("data")` to change the name of data directory.

## 4 TODO

- Analyze data (maybe or maybe not)

## References

\[1\] <a name="#reference-1" /> Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.