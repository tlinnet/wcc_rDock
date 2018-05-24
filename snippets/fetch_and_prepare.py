#Start a Pymol Session
import sys, pymol
stdout = sys.stdout
pymol.finish_launching()
sys.stdout = stdout

pdbid = "1gpk"

pymol.cmd.fetch(pdbid)
#Remove alternates
pymol.cmd.remove("not alt +A")
pymol.cmd.valence("guess", selection1=pdbid)

#Prepare molecules with polar hydrogens:
pymol.cmd.h_add("elem O or elem N or elem S")

#Delete Waters and Heteroatoms
pymol.cmd.remove("resn HOH")
pymol.cmd.remove("hetatm")
pymol.cmd.save("pymolprep.pdb")

os.system('obabel pymolprep.pdb -O %s_prep.mol2'%pdbid)
