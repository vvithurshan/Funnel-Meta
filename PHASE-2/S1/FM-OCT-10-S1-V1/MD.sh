
File_NAME=FM-OCT-10-S1-V1

cat <<EOF > MD1.conf

############################################################################
##START HERE###
##Simulation Template##
# Simulation conditions
coordinates PDB_$File_NAME.pdb
structure PSF_$File_NAME.psf

set fts 0
set prev 0

set input ${File_NAME}_MD_\$prev

binCoordinates \$input.restart.coor
binVelocities \$input.restart.vel
extendedSystem \$input.restart.xsc

# Simulation conditions
#temperature 300

#CUDASOAintegrate on

plumed on
plumedfile Plumed_$File_NAME.dat

# Harmonic constraints

# Output Parameters

set output ${File_NAME}_MD_[expr \$prev+1]

binaryoutput no
outputname \$output
outputenergies 5000
outputtiming 5000
outputpressure 5000
binaryrestart yes
dcdfile \$output.dcd
dcdfreq 1000
XSTFreq 1000
restartfreq 1000
restartname \$output.restart


# Thermostat Parameters
langevin on
langevintemp 300
langevinHydrogen    off
langevindamping 1

# Barostat Parameters

usegrouppressure yes
useflexiblecell no
useConstantArea no
langevinpiston off
langevinpistontarget 1
langevinpistonperiod 200
langevinpistondecay 100
langevinpistontemp 300

# Integrator Parameters

timestep 2
firstTimestep \$fts
fullElectFrequency 2
nonbondedfreq 1
stepspercycle 10

# Force Field Parameters

paratypecharmm on

parameters /home/nmrbox/0014/vvarenthirarajah/Documents/Parameter/par_all36_carb.prm
parameters /home/nmrbox/0014/vvarenthirarajah/Documents/Parameter/par_all36_cgenff.prm
parameters /home/nmrbox/0014/vvarenthirarajah/Documents/Parameter/par_all36_lipid.prm
parameters /home/nmrbox/0014/vvarenthirarajah/Documents/Parameter/par_all36m_prot.prm
parameters /home/nmrbox/0014/vvarenthirarajah/Documents/Parameter/par_all36_na.prm
parameters /home/nmrbox/0014/vvarenthirarajah/Documents/Parameter/par_interface.prm
parameters /home/nmrbox/0014/vvarenthirarajah/Documents/Parameter/toppar_water_ions_namd.str


exclude scaled1-4
1-4scaling 1.0
rigidbonds all
cutoff 12.0
pairlistdist 14.0
switching on
switchdist 10.0
PME on
PMEGridspacing 1
wrapAll on
wrapWater on

#run 50000000

run [ expr 100000000 - (\$fts )  ] 


##################
EOF

