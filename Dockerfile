# Docker info: https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/

# Possible minimise install: https://www.dajobe.org/blog/2015/04/18/making-debian-docker-images-smaller/
# Layering RUN instructions and generating commits conforms to commits are cheap and containers
# can be created from any point in an images history.

# See latest tag at: 
# http://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html
# https://github.com/jupyter/docker-stacks/commits/master/scipy-notebook/Dockerfile
# http://jupyter-docker-stacks.readthedocs.io/en/latest/
# https://hub.docker.com/r/jupyter/scipy-notebook/
FROM jupyter/scipy-notebook:4ebeb1f2d154

# Set root
USER root

# Initial update
RUN apt-get update

# General packages.
ENV BUILD_PACKAGES="htop curl wget unzip git nano subversion"

# Build packages for rDock.
# packages before compiling and running rDock:
# gcc and g++ compilers version > 3.3, make, cppunit and cppunit-devel, popt and popt-devel.
ENV BUILD_PACKAGES="$BUILD_PACKAGES csh gcc g++ make libcppunit-dev libpopt-dev"

# Install pymol
ENV BUILD_PACKAGES="$BUILD_PACKAGES pymol"

# Install
RUN echo "Installing these packages" $BUILD_PACKAGES

# Install all packages in 1 RUN
RUN apt-get update && \
    apt-get install --no-install-recommends -y $BUILD_PACKAGES && \
    rm -rf /var/lib/apt/lists/*

# Set variables    
#ENV NB_USER jovyan
# Set user back
USER ${NB_USER}

################################################################################
#FROM tlinnet/rdock:01_packages
################################################################################

# Set variables    
#ENV NB_USER jovyan
# Set user
USER ${NB_USER}

#ENV ANACONDA_PACKAGES=""
ENV BIOCONDA_PACKAGES="openbabel"
ENV PIP_PACKAGES="autopep8"
#ENV PIP_PACKAGES="$PIP_PACKAGES other-package"

# Install
RUN echo "" && \
    conda install -c bioconda $BIOCONDA_PACKAGES  && \
    pip install $PIP_PACKAGES
#    conda install -c anaconda $ANACONDA_PACKAGES  && \

# Install rDock
RUN cd $HOME && \
    curl -L https://sourceforge.net/projects/rdock/files/rDock_2013.1_src.tar.gz/download -o rDock_2013.1_src.tar.gz && \
    tar -zxvf rDock_2013.1_src.tar.gz && \
    rm rDock_2013.1_src.tar.gz && \
    cd rDock_2013.1_src/build && \
    make linux-g++-64

# Run test
RUN cd $HOME && \
    cd rDock_2013.1_src/build && \
    sed -i 's/ "The test /("The test /g' test/RBT_HOME/check_test.py && \
    sed -i 's/were raised."/were raised.")/g' test/RBT_HOME/check_test.py && \
    sed -i 's/using rDock!!"/using rDock!!")/g' test/RBT_HOME/check_test.py && \
    make test

ENV RBT_ROOT /home/jovyan/rDock_2013.1_src
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:$RBT_ROOT/lib
ENV PATH $PATH:$RBT_ROOT/bin

# Fix RMSD script from python 2 to python 3
RUN cd $HOME && \
    cd /home/jovyan/rDock_2013.1_src/bin && \
    # Fix print and 3 stuff && \
    2to3 -w sdrmsd && \
    mv sdrmsd.bak sdrmsd.bak_or && \
    cp sdrmsd sdrmsd.bak_2to3 && \
    # Fix tab characters to 4 spaces && \
    autopep8 -i sdrmsd

# hacked rdock code to remove check for 3D structures
RUN cd $HOME && \
    curl -L https://github.com/InformaticsMatters/rdock_docker/commit/c07a70f4e4b7113203aa7ceceb177205da59977b.patch -o hacked_rdock_code_to_remove_check_for_3D_structures.patch && \
    cat rDock_2013.1_src/src/lib/RbtMdlFileSource.cxx | grep -A 3 "DM 08 Aug 2000" && \
    git apply hacked_rdock_code_to_remove_check_for_3D_structures.patch && \
    cat rDock_2013.1_src/src/lib/RbtMdlFileSource.cxx | grep -A 3 "DM 08 Aug 2000" && \
    cd rDock_2013.1_src/build && \
    make linux-g++-64 && \
    make test

################################################################################
#FROM tlinnet/rdock:02_rdock
################################################################################

# Get data
#RUN cd $HOME && \
#    svn export https://github.com/tlinnet/wcc_pdbbind_data/trunk/pdbbind_v2017_refined pdbbind_v2017_refined

# Copy over files
#COPY rdock.py $HOME/rdock.py
#COPY test_rdock_object.py $HOME/test_rdock_object.py
#COPY 1gpk_ligand.sd $HOME/1gpk_ligand.sd
#COPY 1gpk_rdock.mol2 $HOME/1gpk_rdock.mol2

# Copy over notebooks
#COPY 01_initial_try.ipynb $HOME/01_initial_try.ipynb

WORKDIR $HOME/work
