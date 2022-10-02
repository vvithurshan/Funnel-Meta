cat COLVAR |awk '$2 >=0.3 && $2<=0.44' | awk '{printf $1"\n"}'>out

cat <<EOF > script.py
with open("out") as f:
    lines = f.readlines()
    lines = [line.rstrip() for line in lines]
    
    
f = open("pdb_save.tcl","a")
f.write("mkdir PDB_Snapshots"+"\n")
f.write("cd PDB_Snapshots"+"\n")
f.write("set A [atomselect top all]"+"\n")
f.write("\n")


for i in lines:
	f.write("animate goto "+str(int(float(i)))+"\n")
	f.write("\$A writepdb "+str(int(float(i)))+".pdb"+"\n")
	f.write("\n")
f.close()
EOF
python3 script.py
