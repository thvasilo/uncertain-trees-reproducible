#!/usr/bin/env bash

# NOTE: Reduce the number of repeats (--repeats argument) to speed up experiments.
# You can also try increasing the number of jobs (--njobs) and --learner-threads.

# Ensure the rf-pred environment is active
source activate rf-pred
# Env var for the MOA jar file
export MOA_JAR='./binaries/moa-2017.10-SNAPSHOT.jar'

# MER and MIS tables
# Expected runtime: 30 minutes+

# Perform the MondrianForest experiments
python uncertain-trees-experiments/skgarden_experiments.py  --input data/stationary  --repeats 10 --window 1000 --njobs 4  --verbose 1 --output output/results/stationary/single/MondrianForest --overwrite
# Perform the CP and OnlineQRF experiments
uncertain-trees-experiments/parameter_sweep.py --command "python uncertain-trees-experiments/moa_experiments.py  --moajar $MOA_JAR --input ./data/stationary  --repeats 10 --window 1000 --njobs 4 --max-calibration-instances 1000  --learner-threads 1 --verbose 1 --overwrite" --output-prefix output/results/stationary/single/ --sweep-argument meta --argument-list OnlineQRF  CPApproximate CPExact

# We can then create the output:
python uncertain-trees-experiments/generate_figures.py --input output/results/stationary/single/ --output output/figures/stationary --overwrite --dont-create-figures
python uncertain-trees-experiments/interval_metrics.py --input output/results/stationary/single/ --output output/figures/stationary --overwrite
# The (unformatted) tables file will be created at output/figures/stationary/mean_error_rate.means.tex and mean_interval_size.means.tex


# Significance level table
# Expected runtime: 1 hour+

# MondrianForest experiments
uncertain-trees-experiments/parameter_sweep.py --command "python skgarden_experiments.py  --input data/stationary/  --repeats 5 --window 1000 --njobs 1  --verbose 1 --overwrite" --sweep-argument confidence --argument-list 0.7 0.8 0.9 0.95 0.99 --output-prefix output/results/stationary/mf-confidence --njobs 2

# CP and OnlineQRF experiments
uncertain-trees-experiments/parameter_sweep.py --command "python moa_experiments.py  --moajar $MOA_JAR --input data/stationary/  --repeats 5 --window 1000 --njobs 4 --learner-threads 1 --overwrite --verbose 1" --sweep-argument meta --output-prefix output/results/stationary/moa-confidence --argument-list OnlineQRF  CPApproximate  CPExact --inner-sweep-argument confidence --inner-argument-list 0.7 0.8 0.9 0.95 0.99

# Copy over the results from MF to have all together:
cp -r output/results/stationary/mf-confidence/ output/results/stationary/moa-confidence/MondrianForest

# We create the tables separately, the final table was made by hand by copying the mean or median row out of rach method.
# Note: we need gnu paralllel. On Ubuntu: sudo apt get install parallel
parallel -q -j2 python uncertain-trees-experiments/generate_figures.py --input output/results/moa-confidence/{} --output output/figures/confidence/{} --exclude single --dont-create-figures ::: OnlineQRF  CPApproximate  CPExact MondrianForest

# Friedman Experiments
# Expected runtime 10 hours+

# Perform the MondrianForest experiments
python uncertain-trees-experiments/skgarden_experiments.py  --input data/friedman  --repeats 10 --window 10000 --njobs 4  --verbose 1 --output output/results/friedman/MondrianForest --overwrite
# Perform the CP and OnlineQRF experiments
uncertain-trees-experiments/parameter_sweep.py --command "python uncertain-trees-experiments/moa_experiments.py  --moajar $MOA_JAR --input ./data/friedman  --repeats 10 --window 10000 --njobs 4 --max-calibration-instances 1000  --learner-threads 1 --verbose 1 --overwrite" --output-prefix output/results/friedman/ --sweep-argument meta --argument-list OnlineQRF  CPApproximate CPExact

# Create the output
python uncertain-trees-experiments/generate_figures.py --input output/results/friedman/ --output output/figures/friedman --overwrite --fig-width 12 --mark-every 5
python uncertain-trees-experiments/interval_metrics.py --input output/results/friedman/ --output output/figures/friedman --overwrite

# Airlines experiments
# Expected runtime: 24 hours+
# NOTE: Removing CPExact should bring the runtime to  4-8 hours.

# MF
python uncertain-trees-experiments/skgarden_experiments.py  --input data/airlines/2M  --repeats 10 --window 1000 --njobs 4  --verbose 1 --output output/results/airlines/single/MondrianForest
# CP & QRF
uncertain-trees-experiments/parameter_sweep.py --command "python moa_experiments.py  --moajar $MOA_JAR --input data/airlines/2M  --repeats 10 --window 1000 --max-calibration-instances 1000 --learner-threads 4 --verbose 1 --overwrite" --output-prefix output/results/airlines/single/ --sweep-argument meta --argument-list OnlineQRF  CPApproximate CPExact --njobs 2

# We can then create the airlines figures:
python uncertain-trees-experiments/generate_figures.py --input output/results/airlines/single/ --output output/figures/airlines --overwrite -fig-width 12 --mark-every 5