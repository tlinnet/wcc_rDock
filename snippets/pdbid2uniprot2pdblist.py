from bioservices import UniProt
import urllib2
import xmltodict
from collections import OrderedDict

pdbid = "1gpk"

record = {}
record['PDBid']= pdbid
try:
	#Make a uniprot object
	u = UniProt(verbose=False)
	#Get the correct uniprot entry
	#			try:
	#				uniprot_id= u.mapping(fr="PDB_ID", to="ACC", query=str(pdbid))[pdbid][0]
	#				#print "PDBid " + str(pdbid) +" has UniProtID " + str(uniprot_id)
	#				record['UniprotACC1'] = uniprot_id
	#			except:
	#				print "PDBid %s has NO uniprotID associated"%pdbid
	#				record['UniprotACC1'] = 'No uniprotID'
	#Get Accession Number via RCSB.
	url = 'http://www.rcsb.org/pdb/rest/customReport.xml?pdbids=%s&customReportColumns=uniprotAcc,uniprotRecommendedName&format=xml&service=Download'%pdbid
	xmlstring = urllib2.urlopen(url).read()
	result = xmltodict.parse(xmlstring)
	pdbrec = result['dataset']['record']
	if type(pdbrec) == type(OrderedDict()):
		uniprotacc = pdbrec['dimEntity.uniprotAcc']
		record['UniprotACC2'] = uniprotacc
	elif type(pdbrec) == list:
		ACCid = set()
		for chain in pdbrec:
			ACCid.add(chain['dimEntity.uniprotAcc'])
		if len(ACCid) == 1:
			record['UniprotACC2'] = ACCid.pop()
		else:
			record['UniprotACC2'] = "Heterochains found"
	else:
		print "unknown RCSB lookup error of UniprotAcc for pdbid %s"%pdbid
except:
	print "Error in fetching Structure Information"


u = UniProt(verbose=False)

#for uniprot_id in uniprots:
uniprot_id = record['UniprotACC2']

pdbidlist = []

try:
	pdbidlist = u.mapping(fr="ACC", to="PDB_ID", query=str(uniprot_id))[uniprot_id]
	record["Alternative PDBids"] = pdbidlist
except:
	try:
		pdbidlist = u.mapping(fr="ACC", to="PDB_ID", query=str(uniprot_id))[uniprot_id]
		record["Alternative PDBids"] = pdbidlist
	except:
		print "Failed"


print record

