FROM tlinnet/rdock:02_rdock

# Get data
RUN cd $HOME && \
    svn export https://github.com/tlinnet/wcc_pdbbind_data/trunk/pdbbind_v2017_refined pdbbind_v2017_refined

# Copy over files
COPY rdock.py $HOME/rdock.py
COPY test_rdock_object.py $HOME/test_rdock_object.py
COPY 1gpk_ligand.sd $HOME/1gpk_ligand.sd
COPY 1gpk_rdock.mol2 $HOME/1gpk_rdock.mol2

# Copy over notebooks
COPY 01_initial_try.ipynb $HOME/01_initial_try.ipynb