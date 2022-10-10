
File_NAME=FM-OCT-10-S1-V1

source MD.sh
################

mkdir COLVAR
mkdir HILLS_ROOT
## HILLS
#cd HILLS_ROOT
#for ((h=0; h<16; h++))
#do
#touch HILLS.$((h))
#done
#cd ..
## COLVAR
#cd COLVAR
#for ((c=0; c<16; c++))
#do
#touch COLVAR_FM-Sep-17-S1-V1_$c
#done
#cd ..
for ((W=0; W<16; W++))
do
## make dir for all walker
mkdir walker_$W
cd walker_$W 

cp ../MD_0.restart.vel ./${File_NAME}_MD_0.restart.vel
cp ../MD_0.restart.coor ./${File_NAME}_MD_0.restart.coor
cp ../MD_0.restart.xsc ./${File_NAME}_MD_0.restart.xsc

cp ../Funnel_ref.pdb ./
cp ../MD1.conf ./
cp ../PDB_$File_NAME.pdb ./
cp ../PSF_$File_NAME.psf ./

cat <<EOF > gpu_A100.sh

PE_0=0-63
PE_1=64-127
PE_2=128-191
PE_3=192-255
PE_4=0-63
PE_5=64-127
PE_6=128-191
PE_7=192-255
PE_8=0-63
PE_9=64-127
PE_10=128-191
PE_11=192-255
PE_12=0-63
PE_13=64-127
PE_14=128-191
PE_15=192-255

ppn=64

namd2=/home/nmrbox/0014/vvarenthirarajah/Documents/2022/NAMD_Build/June/NAMD_2.14_Linux-x86_64-multicore-CUDA/namd2

echo "MD1";
\$namd2 +p\${ppn} +idlepoll +setcpuaffinity  +isomalloc_sync +pemap \$PE_$W  MD1.conf > MD1.log
grep "WRITING COORDINATES" MD1.log | tail -1|awk '{print $8}'

EOF
cd ..
done
