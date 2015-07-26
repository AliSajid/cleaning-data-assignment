### Introduction

This repository is for the course project for "Getting and Cleaning Data" Coursera course, part of their Data Science track

The purpose of this project is to demonstrate the collection, work with, and cleaning of this data set. Tidy data have been prepared so can be used for later analysis.

### Data Set

The data set "Human Activity Recognition Using Smartphones" was taken from [UCI](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

### Execution and files

The script is run_analysis.R. It tests if you have data already in your working directory. If it does, not, it downloads and extracts the data.

The file codebook.Rmd and its cousin codebook.md describe the variables, the data, and the steps performed to clean it up. It can be executed in R, RStudio or through RScript on the commandline. It does not need any parameters.

The file codebook.html is a generated HTML file of the codebook.Rmd

The above file results in a text file called "tidy-data.csv" which is the inal cleaned up data and contains the means and standard deviation of the individual variables for each activity and each subject.