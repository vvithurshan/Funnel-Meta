rm -r HILLS_ROOT
source /home/vvithurshan/Documents/scripts/password.sh
dir=/home/nmrbox/0014/vvarenthirarajah/Documents/project_Meta/S1/PHASE-2/FM-OCT-10-S1-V1/HILLS_ROOT
dir2=/home/vvithurshan/Desktop/Research_22/PHASE-2/S1/FM-OCT-10-S1-V1/output
scp -r vvarenthirarajah@tin.nmrbox.org:$dir $dir2
cd HILLS_ROOT
cat HILLS.*| sort -n > HILLS
plumed sum_hills --hills HILLS --stride 1000 --mintozero
cd ..
