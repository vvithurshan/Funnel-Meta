vmd -dispdev text -eofexit < restraint_boxsize.tcl > restraint.log

file_name=FM_Aug-14-S8-unbiased-mut-97
cp MUTATED.pdb ./$file_name.pdb
cp MUTATED.psf ./$file_name.psf
mkdir original 
mv ionized.* ./original
#directory for your parameter file 
dir=/home/nmrbox/0014/vvarenthirarajah/Documents/Parameter


para="parameters $dir/par_all36_carb.prm
parameters $dir/par_all36_cgenff.prm
parameters $dir/par_all36_lipid.prm
parameters $dir/par_all36m_prot.prm
parameters $dir/par_all36_na.prm
parameters $dir/par_interface.prm
parameters $dir/toppar_water_ions_namd.str"


### minimization
cat <<EOF > Minimization.conf


############################################################################
##START HERE###
##Simulation Template##
# Simulation conditions
coordinates $file_name.pdb
structure $file_name.psf

# Simulation conditions
temperature 0


CUDASOAintegrate off
# Harmonic constraints

constraints on
consref ./restraint/protein_1.pdb
conskfile ./restraint/protein_1.pdb
constraintScaling 200
consexp 2
conskcol B


# Output Parameters
set output Minimization
binaryoutput no
outputname \$output
outputenergies 100
outputtiming 100
outputpressure 100
binaryrestart yes
dcdfile \$output.dcd
dcdfreq 1000
XSTFreq 100
restartfreq 100
restartname \$output.restart


# Thermostat Parameters
langevin on
langevintemp 0
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
firstTimestep 0
fullElectFrequency 2
nonbondedfreq 1
stepspercycle 10

# Force Field Parameters

paratypecharmm on



$para


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



#boundary
cellBasisVector1 109.81500244140625 0 0
cellBasisVector2 0 100.64699935913086 0
cellBasisVector3 0 0 100.32100296020508
cellOrigin 2.018160820007324 1.3376009464263916 1.8883253335952759


# Script

minimize 1000


###########
EOF
cat <<EOF > Minimization2.conf


############################################################################
##START HERE###
##Simulation Template##
# Simulation conditions
coordinates $file_name.pdb
structure $file_name.psf

set input Minimization
binCoordinates \$input.restart.coor
#binVelocities \$input.restart.vel
extendedSystem \$input.restart.xsc

# Simulation conditions
temperature 0

CUDASOAintegrate off

# Harmonic constraints

constraints on
consref ./restraint/protein_noh_2.pdb
conskfile ./restraint/protein_noh_2.pdb
constraintScaling 100
consexp 2
conskcol B


# Output Parameters
set output Minimization2
binaryoutput no
outputname \$output
outputenergies 100
outputtiming 100
outputpressure 100
binaryrestart yes
dcdfile \$output.dcd
dcdfreq 1000
XSTFreq 100
restartfreq 100
restartname \$output.restart


# Thermostat Parameters
langevin on
langevintemp 0
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
firstTimestep 0
fullElectFrequency 2
nonbondedfreq 1
stepspercycle 10

# Force Field Parameters

paratypecharmm on

set dir dirr

$para
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


#boundary

#cellBasisVector1 53.70100021362305 0 0
#cellBasisVector2 0 46.17199897766113 0
#cellBasisVector3 0 0 41.00600051879883
#cellOrigin -1.5399737358093262 -0.1962127536535263 1.0410041809082031


# Script

minimize 1000


###############

EOF

cat <<EOF > Minimization3.conf

############################################################################
##START HERE###
##Simulation Template##
# Simulation conditions
coordinates $file_name.pdb
structure $file_name.psf

set input Minimization2
binCoordinates \$input.restart.coor
#binVelocities \$input.restart.vel
extendedSystem \$input.restart.xsc

# Simulation conditions
temperature 0

CUDASOAintegrate off

# Harmonic constraints

constraints on
consref ./restraint/backbone_3.pdb
conskfile ./restraint/backbone_3.pdb
constraintScaling 100
consexp 2
conskcol B


# Output Parameters
set output Minimization3
binaryoutput no
outputname \$output
outputenergies 100
outputtiming 100
outputpressure 100
binaryrestart yes
dcdfile \$output.dcd
dcdfreq 1000
XSTFreq 100
restartfreq 100
restartname \$output.restart


# Thermostat Parameters
langevin on
langevintemp 0
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
firstTimestep 0
fullElectFrequency 2
nonbondedfreq 1
stepspercycle 10

# Force Field Parameters

paratypecharmm on
#set dir /home/vithurshan/2021/toppar_c36_jul20


$para

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

#boundary

#cellBasisVector1 53.70100021362305 0 0
#cellBasisVector2 0 46.17199897766113 0
#cellBasisVector3 0 0 41.00600051879883
#cellOrigin -1.5399737358093262 -0.1962127536535263 1.0410041809082031


# Script

minimize 1000


#######################

EOF

cat <<EOF > Minimization4.conf

############################################################################
##START HERE###
##Simulation Template##
# Simulation conditions
coordinates $file_name.pdb
structure $file_name.psf

set input Minimization3
binCoordinates \$input.restart.coor
#binVelocities \$input.restart.vel
extendedSystem \$input.restart.xsc

# Simulation conditions
temperature 0

CUDASOAintegrate off

# Harmonic constraints

constraints off
consref fixed.pdb
conskfile fixed.pdb
constraintScaling 25
consexp 2
conskcol B


# Output Parameters
set output Minimization4
binaryoutput no
outputname \$output
outputenergies 100
outputtiming 100
outputpressure 100
binaryrestart yes
dcdfile \$output.dcd
dcdfreq 1000
XSTFreq 1000
restartfreq 1000
restartname \$output.restart


# Thermostat Parameters
langevin on
langevintemp 0
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
firstTimestep 0
fullElectFrequency 2
nonbondedfreq 1
stepspercycle 10

# Force Field Parameters

paratypecharmm on
#set dir /home/vithurshan/2021/toppar_c36_jul20


$para

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

#boundary

# Script

minimize 5000
reinitvels 0 
# do it after minimization

#################

EOF

cat <<EOF > Annealing.conf

############################################################################
##START HERE###
##Simulation Template##
# Simulation conditions
coordinates $file_name.pdb
structure $file_name.psf

set input Minimization4
binCoordinates \$input.restart.coor
#binVelocities \$inputname.restart.coor
extendedSystem \$input.restart.xsc

# Simulation conditions
temperature 0

CUDASOAintegrate on

# Harmonic constraints

constraints on
consref ./restraint/backbone_3.pdb
conskfile ./restraint/backbone_3.pdb
constraintScaling 20
consexp 2
conskcol B

# Output Parameters
set output Annealing

binaryoutput no
outputname \$output
outputenergies 100
outputtiming 100
outputpressure 100
binaryrestart yes
dcdfile \$output.dcd
dcdfreq 10000
XSTFreq 1000
restartfreq 1000
restartname \$output.restart


# Thermostat Parameters
langevin on
langevintemp 0
langevinHydrogen    off
langevindamping 1

# Barostat Parameters


langevinpiston off
usegrouppressure yes
useflexiblecell no
useConstantArea no
langevinpistontarget 1
langevinpistonperiod 200
langevinpistondecay 100
langevinpistontemp 300

# Integrator Parameters

timestep 2
firstTimestep 0
fullElectFrequency 2
nonbondedfreq 1
stepspercycle 10

# Force Field Parameters

paratypecharmm on
#set dir /home/vithurshan/2021/toppar_c36_jul20


$para

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

# Script
set Temp 300
set barostat 0
set nSteps  1000
for {set t 0} {\$t <= \$Temp} {incr t} {run \$nSteps;langevintemp \$t;if {\$barostat} {langevinpistontemp \$t}}


####################

EOF

## Equilibration
cat <<EOF > Equilibration.conf

############################################################################
##START HERE###
##Simulation Template##
# Simulation conditions
coordinates $file_name.pdb
structure $file_name.psf

set input Annealing

binCoordinates \$input.restart.coor
binVelocities \$input.restart.vel
extendedSystem \$input.restart.xsc

# Simulation conditions
#temperature 60

CUDASOAintegrate on

# Harmonic constraints

constraints off
consref ./restraint/pocket_md.pdb
conskfile ./restraint/pocket_md.pdb
constraintScaling 10
consexp 2
conskcol B

# Output Parameters
set output MD_0
binaryoutput no
outputname \$output
outputenergies 100
outputtiming 100
outputpressure 100
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


langevinpiston on
usegrouppressure yes
useflexiblecell no
useConstantArea no
langevinpistontarget 1
langevinpistonperiod 200
langevinpistondecay 100
langevinpistontemp 300

# Integrator Parameters

timestep 2
firstTimestep 0
fullElectFrequency 2
nonbondedfreq 1
stepspercycle 10

# Force Field Parameters

paratypecharmm on
#set dir /home/vithurshan/2021/toppar_c36_jul20


$para

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


run 1000000 
## for 2 ns


###################
EOF

for((MD=1;MD<=10;MD++))
do
## Production
cat <<EOF > MD$MD.conf

############################################################################
##START HERE###
##Simulation Template##
# Simulation conditions
coordinates $file_name.pdb
structure $file_name.psf

set input MD_$((MD-1))

binCoordinates \$input.restart.coor
binVelocities \$input.restart.vel
extendedSystem \$input.restart.xsc

# Simulation conditions
#temperature 0

CUDASOAintegrate on

# Harmonic constraints

constraints off
consref ./restraint/pocket_md.pdb
conskfile ./restraint/pocket_md.pdb
constraintScaling 10
consexp 2
conskcol B

# Output Parameters

set output MD_$((MD))

binaryoutput no
outputname \$output
outputenergies 5000
outputtiming 5000
outputpressure 5000
binaryrestart yes
dcdfile \$output.dcd
dcdfreq 2000
XSTFreq 1000
restartfreq 5000
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
firstTimestep 0
fullElectFrequency 2
nonbondedfreq 1
stepspercycle 10

# Force Field Parameters

paratypecharmm on
$para

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

run 5000000


##################3

EOF
done



cat <<EOF > bash_for_gpu.sh

ppn=4
namd3=/home/nmrbox/0014/vvarenthirarajah/Documents/NAMD_3.0alpha12_Linux-x86_64-multicore-CUDA/namd3
MD_Times=10
pe=240-243


echo "Minimization";
\$namd3 +p\${ppn} +idlepoll +setcpuaffinity  +isomalloc_sync +devices 0  +pemap \$pe   Minimization.conf > Minimization1.log

echo "Minimization2";
\$namd3 +p\${ppn} +idlepoll +setcpuaffinity  +isomalloc_sync +devices 0  +pemap \$pe   Minimization2.conf > Minimization2.log

echo "Minimization3";
\$namd3 +p\${ppn} +idlepoll +setcpuaffinity  +isomalloc_sync +devices 0  +pemap \$pe   Minimization3.conf > Minimization3.log

echo "Minimization4";
\$namd3 +p\${ppn} +idlepoll +setcpuaffinity  +isomalloc_sync +devices 0  +pemap \$pe  Minimization4.conf > Minimization4.log

for (( min=1; min<=4; min++))
do
	mkdir min_\$min
	mv Minimization\$min.log ./min_\$min
	cd min_\$min
	source /home/nmrbox/0014/vvarenthirarajah/Documents/2021_Reseach/scripts/energy.sh
	cd ../../
done

echo "Annealing";
\$namd3 +p\${ppn} +idlepoll +setcpuaffinity  +isomalloc_sync +devices 0  +pemap \$pe   Annealing.conf > Annealing.log

echo "Equilibration";
\$namd3 +p\${ppn} +idlepoll +setcpuaffinity  +isomalloc_sync +devices 0  +pemap \$pe  Equilibration.conf > Equilibration.log

for (( X=1; X<=\${MD_Times}; X++))
do
	echo "MD\${X} is running";
	\$namd3 +p\${ppn} +idlepoll +setcpuaffinity  +isomalloc_sync +devices 0  +pemap \$pe MD\${X}.conf > MD\${X}.log
done

echo "Done";
EOF

