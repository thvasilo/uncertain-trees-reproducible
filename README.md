## Instructions

The repository uses submodules to keep track of the
different repositories needed to run the algorithms,
so ensure you clone using the `--recursive` option,
i.e. `git clone --recursive https://github.com/thvasilo/uncertain-trees-reproducible.git`

## Installing the dependencies

### `uncertain-trees-experiments` and  `scikit-garden`

There are a few Python libraries needed to run the project,
so we recommend creating a virtual environment to avoid
messing up your default environment. We have used the Anaconda
Python distribution to make things easier.

We've made some small modifications to the original
`scikit-garden` library, so we need to install it
from the included submodule rather than the PyPI
repository.

```bash
conda env create -f rf-pred.yml  # Installs the base dependencies as a new virtual env
source activate rf-pred
pip install -e ./scikit-garden  # Install the customized scikit-garden repo.
```

### MOA

We recommend using the pre-built binaries under `moa-binaries`. The only requirement
is Java 8. We've tested with the Oracle JDK, OpenJDK seems to causes issues with the
results.

Alternatively you can build the MOA distribution using Maven by running `mvn package -DskipTests` in `moa/moa`.

## Obtaining the data

The small scale data are included with the repository under the `data/small-mid` directory.
The large airlines data are compressed under `data/airlines`. To decompress them, `cd` into
`data/airlines` and run:
```bash
for FILE in *.tar.gz; do tar -zxf ${FILE}; done
```

### Re-creating the files

It's also possible to re-create the files
using the scripts we've included in the `data/airlines` directory.

You just need to run in succession:
```bash
./get_data.sh
./create_splits.sh
```

These two scripts will pull the original data, transform to csv,
apply the pre-processing steps, and create the 700k, 2M and 5M splits in arff format using Weka.

## Running the experiments

After you've prepared the environment and data, to re-run the experiments from the paper we can use the example commands
in `reproduce-output.sh`.

**NOTE:** Due to the random nature of the algorithms the exact results will
be slightly different from those reported in the paper, unfortunately we didn't keep
track of all the random seeds used in our experiments. The overall performance
of the algorithms should not change significantly however.

## Troubleshooting

Ensure you did `git clone --recursive https://github.com/thvasilo/uncertain-trees-reproducible.git`.
Please file an issue if you run into any problems.