## Instructions

The repository uses submodules to keep track of the
different repositories needed to run the algorithms,
so ensure you clone using the `--recursive` option,
i.e. `git clone --recursive https://github.com/thvasilo/uncertain-trees-reproducible.git`

We also make use of Git Large File Storage, see instructions
below on obtaining the large data files.

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

```{bash}
conda env create -f rf-pred.yml  # Installs the base dependencies as a new virtual env
source activate rf-pred
pip install -e ./scikit-garden  # Install the customized scikit-garden repo.
```

### MOA

We recommend using the pre-built binaries under `moa-binaries`.

Alternatively you can build the MOA distribution by running `mvn package -DskipTests` in `/moa/moa`.

## Obtaining the data

The small scale data are included with the repository under the `small-mid` directory.
The large airlines data are stored using [Git Large File Storage](https://git-lfs.github.com/).
If you'd rather not use Git LFS we have included scripts to re-create the files.

### Using Git LFS (recommended)

To install Git LFS:

```{bash}
wget https://github.com/git-lfs/git-lfs/releases/download/v2.3.4/git-lfs-linux-amd64-2.3.4.tar.gz
tar -xvf git-lfs-linux-amd64-2.3.4.tar.gz
cd git-lfs-2.3.4
sudo ./install.sh
```

If you haven't cloned the repo yet, then the `git clone --recursive https://github.com/thvasilo/uncertain-trees-reproducible.git`
command will also get the large files one you have GIT LFS installed.
If you've alread cloned the repository, `git lfs pull`  will pull the files.

### Re-creating the files

If you'd rather not install Git LFS it's possible to re-create the files
using the scripts we've included in the `data/airlines` directory.

You just need to run in succession:
```{bash}
./get_files.sh
./create_splits.sh
```

These two scripts will pull the original data, transform to csv,
apply the pre-processing steps, and create the 700k, 2M and 5M splits in arff format.

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