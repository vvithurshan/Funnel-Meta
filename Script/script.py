
with open("out") as f:
    lines = f.readlines()
    lines = [line.rstrip() for line in lines]
    
    
f = open("pdb_save.tcl","a")
f.write("set A [atomselect top all]"+"\n")
f.write("\n")


for i in lines:
	f.write("animate goto "+str(int(float(i)))+"\n")
	f.write("$A writepdb "+str(int(float(i)))+".pdb"+"\n")
	f.write("\n")

