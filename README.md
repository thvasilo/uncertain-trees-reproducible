## Instructions

The repository uses submodules to keep track of the
different repositories needed to run the algorithms,
so ensure you clone using the `--recursive` option,
i.e. `git clone --recursive https://github.com/thvasilo/uncertain-trees-reproducible.git`

## Installing the dependencies

### `uncertain-trees-experiments` and  `scikit-garden`

There are a few Python libraries needed to run the project,
so we recommend creating a virtual environment to avoid
messing up your default enviroment. We have used the Anaconda
Python distribution to make things easier.

We've made some small modifications to the original
`scikit-garden` library, so we need to install it
from the included submodule rather than the PyPI
repository.

```{bash}
conda env create -f rf-pred.yml  # Installs the base dependencies as a new virtual env
source activate rf-pred
pip install -e ./scikit-garden  # Install the customized scikit-garden repo.
```

### MOA

We recommend using the pre-built binaries under `moa-binaries`.

Alternatively you can build the MOA distribution by running `mvn package -DskipTests` in `/moa/moa`.

## Running the experiments

To re-run the experiments from the paper we can use the example commands
in `reproduce-output.sh`.

**NOTE:** Due to the random nature of the algorithms the exact results will
be different from those reported in the paper, unfortunately we didn't keep
track of all the random seeds used in our experiments. The overall performance
of the algorithms should not change significantly however.

## Troubleshooting

Ensure you did `git clone --recursive https://github.com/thvasilo/uncertain-trees-reproducible.git`
Please file an issue if you run into any problems.