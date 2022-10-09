resetpsf
set F FM-Sep-23-S1-V1
mol load psf PSF_${F}.psf pdb PDB_${F}.pdb

set a [atomselect top "not protein"]
set l [lsort -unique [$a get segid]]

package require psfgen
readpsf PSF_${F}.psf
coordpdb PDB_${F}.pdb

foreach s $l {
delatom $s
}

writepsf PSF_${F}_dry.psf
writepdb PDB_${F}_dry.pdb
