for ((W=0; W<16; W++))
do
cd walker_$W
cat <<EOF > Plumed_FM-OCT-10-S1-V1.dat

#RESTART

WHOLEMOLECULES ENTITY0=5,16,23,41,53,63,82,101,113,129,148,159,166,188,207,223,237,244,259,274,284,302,314,321,332,358,370,394,411,427,438,457,474,486,508,522,529,549,566,586,597,604,611,622,641,660,674,689,703,727,743,759,773,783,793,810,821,828,844,858,872,883,895,911,927,943,953,960,975,995,1007,1024,1031,1042,1053,1064,1079,1101,1120,1137,1159,1178,1200,1219,1229,1251,1267,1287,1309,1323,1334,1356,1377,1391,1402,1421,1435,1454,1468,1482,1494,1513,1527,1546,1565,1587,1606,1617,1631,1641,1651,1662,1682,1693,1710,1724,1740,1751,1761,1777,1788,1809,1821,1832,1842,1853,1865,1877,1897,1907,1917,1924,1938,1952,1963,1979,1993,2007,2014,2038,2045,2064,2078,2102,2126,2136,2150,2166,2178,2190,2214,2233,2250,2267,2277,2288,2309,2321,2340,2359,2370,2384,2398,2412,2423,2445,2467,2488,2512,2519,2533,2555,2574,2596,2608,2618,2635,2654,2665,2675,2682,2692,2703,2710,2726,2737,2748,2759,2776,2783,2795,2806,2813,2822,2834,2853,2869,2880,2902,2924,2938,2945,2955,2979,2993,3012,3028,3035,3054,3070,3081,3105,3112,3123,3134,3148,3159,3170,3184,3195,3211,3223,3230,3246,3267,3277,3301,3317,3331,3341,3360,3376,3390,3414,3430,3447,3464,3478,3497,3507,3517,1409,3530,3534,3535,3536,3538,3540,3543,3544,3546,3548,3550,3552,3554,3555,3556

lig: COM ATOMS=3530,3534,3535,3536,3538,3540,3543,3544,3546,3548,3550,3552,3554,3555,3556

fps: FUNNEL_PS LIGAND=lig REFERENCE=Funnel_ref.pdb ANCHOR=1409 POINTS=0.1,0.0,0.1,1.078,0.9129,-0.538

FUNNEL ARG=fps.lp,fps.ld ZCC=1.2 ALPHA=0.45 RCYL=0.1 MINS=-0.6 MAXS=6.0 KAPPA=50100 NBINS=500 NBINZ=500 FILE=BIAS LABEL=funnel

D0: DISTANCE ATOMS=2800,3554 NOPBC ## ser 195 - s1

METAD ARG=D0 SIGMA=0.05 HEIGHT=2 PACE=1000 TEMP=300 BIASFACTOR=15 GRID_MIN=-1 GRID_MAX=6 GRID_SPARSE GRID_WFILE=grid_w.dat GRID_WSTRIDE=250000  WALKERS_DIR=../HILLS_ROOT WALKERS_RSTRIDE=500 WALKERS_N=16 WALKERS_ID=$W LABEL=metad

LOWER_WALLS ARG=fps.lp AT=-0.1 KAPPA=500000 EXP=2 OFFSET=0 LABEL=lwall

UPPER_WALLS ARG=fps.lp AT=5.3 KAPPA=500000 EXP=2 OFFSET=0 LABEL=uwall

UPPER_WALLS ARG=D0 AT=5.5 KAPPA=500000 EXP=2 OFFSET=0 LABEL=uwall_D0

PRINT STRIDE=1000 ARG=* FILE=../COLVAR/COLVAR_FM-OCT-10-S1-V1_$W

EOF
cd ..
done