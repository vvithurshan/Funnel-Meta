for i in *pdb ; do printf "mol addfile %s waitfor all\n" $i ; done > load_pdb.tcl
