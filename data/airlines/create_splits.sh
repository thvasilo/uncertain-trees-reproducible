#!/usr/bin/env bash
# Creates the airlines train/test arff files according to instructions in
# M. P. Deisenroth and J. W. Ng. Distributed Gaussian processes. ICML 2015.

# 5M, 2M, and 700K train files are created, the first X lines used for training and the subsequent 100K for testing.

# After having run get_data.sh, the arff file can be created using Weka:
export WEKA_PATH=weka/weka.jar
echo "Converting to arff file..."
java -cp ${WEKA_PATH} weka.core.converters.CSVLoader plane_data_filtered.csv > plane_data_filtered.arff
# Then to get one-hot encoding:
# First remove the useless year column:
echo "Removing year column..."
java -cp ${WEKA_PATH} weka.filters.unsupervised.attribute.Remove -i plane_data_filtered.arff -o plane_data_filtered_noyear.arff -R 1
# Then we transform the Month, DayOfMonth, DayOfWeek vars to nominal from numeric
echo "Transform numeric to nominal..."
java -cp ${WEKA_PATH} weka.filters.unsupervised.attribute.NumericToNominal -i plane_data_filtered_noyear.arff -o plane_data_filtered_nominal.arff -R 1-3
# Finally, transform the nominal vars to one-hot encoding:
echo "Transform nominal to one-hot..."
java -cp ${WEKA_PATH} weka.filters.unsupervised.attribute.NominalToBinary -i plane_data_filtered_nominal.arff -o plane_data_filtered_onehot.arff -R 1-3
# Delete the intermediate files:
rm plane_data_filtered_noyear.arff plane_data_filtered_nominal.arff

echo "Creating splits..."
export DATA_FILE=plane_data_filtered_onehot.arff
mkdir 700k 2M 5M
# tvas: Yes these should be function calls, and the test file creation could be a one-liner.
# Create 5M file
head -61 ${DATA_FILE} > arff_header # onehot arff header should be 61 lines
# Get first 5M+header lines
head -5000061  < ${DATA_FILE} > 5M/plane_5M_train.arff
# Skip first 5M+header lines, use next 100K for test
# tail -n +5000061 $DATA_FILE | head -100000 > plane_5M_test.arff
# Prepend header to test data
# echo -e "$(cat arff_header)\n$(cat plane_5M_test.arff)" > plane_5M_test.arff
# Create 2M file
head -2000061  < ${DATA_FILE} > 2M/plane_2M_train.arff
#tail -n +2000061 $DATA_FILE | head -100000 > plane_2M_test.arff
#echo -e "$(cat arff_header)\n$(cat plane_2M_test.arff)" > plane_2M_test.arff
# Create 700K file
head -700061  < ${DATA_FILE} > 700k/plane_700K_train.arff
#tail -n +700061 $DATA_FILE | head -100000 > plane_700K_test.arff
#echo -e "$(cat arff_header)\n$(cat plane_700K_test.arff)" > plane_700K_test.arff
rm arff_header
