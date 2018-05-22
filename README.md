# wcc_rDock
Try rDock

# Preparation

## Download from pdbbind.org.cn

Register at pdbbind.org.cn

* Download:  **ID 3** *Protein-ligand complexes: The refined set*, 593.5MB

## Install rDock

http://rdock.sourceforge.net/

This is rDock for Linux. We can either use use a Docker image

* https://hub.docker.com/r/informaticsmatters/rdock/
* https://github.com/InformaticsMatters/rdock_docker

Or bioconda. This is currently only packaged for linux.

* https://anaconda.org/bioconda/rdock
* https://bioconda.github.io/recipes/rdock/README.html
* https://quay.io/repository/biocontainers/rdock

### Docker image

```bash
source build_Dockerfile.sh
```

# Launch on mybinder

* [![Binder](https://mybinder.org/badge.svg)](https://mybinder.org/v2/gh/tlinnet/wcc_rDock/master) https://mybinder.org/v2/gh/tlinnet/wcc_rDock/master
* [![Binder](https://mybinder.org/badge.svg)](https://mybinder.org/v2/gh/tlinnet/wcc_rDock/master?filepath=01_initial_try.ipynb) 01_initial_try.ipynb


