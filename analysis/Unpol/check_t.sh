#!/bin/bash -l
module use /apps/modulefiles
cd /w/halla-scshelf2102/solid/shuo/sidis
source setup_sidis
export LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64:$LD_LIBRARY_PATH
while IFS="," read -r f1
do
  #./get_cross_section 0 5.75 U U 0.2 0.93 0.5 0.16 ${f1} 1 0.01>>out.txt
  #./get_cross_section 0 5.75 U U 0.2 0.93 0.5 0.4 ${f1} 1 0.01>>out.txt
  #./get_cross_section 0 5.75 U U 0.2 0.93 0.5 0.632 ${f1} 1 0.01>>out.txt
  ./get_cross_section 0 11.0 U L 0.4 0.48 0.5 0.16 ${f1} 1 0.01>>out.txt
  ./get_cross_section 0 11.0 U L 0.4 0.48 0.5 0.4 ${f1} 1 0.01>>out.txt
  ./get_cross_section 0 11.0 U L 0.4 0.48 0.5 0.632 ${f1} 1 0.01>>out.txt
done < compare/analysis/Unpol/phih.txt
#./get_cross_section 0 5.75 U U 0.2 0.93 0.5 0.16 3 1 0.01>>out.txt
#./get_cross_section 0 5.75 U U 0.2 0.93 0.5 0.4 3 1 0.01>>out.txt
#./get_cross_section 0 11.0 U U 0.2 0.93 0.5 0.16 3 1 0.01>>out.txt
#./get_cross_section 0 11.0 U U 0.2 0.46 0.5 0.16 3 1 0.01>>out.txt
#./get_cross_section 0 11.0 U U 0.2 0.36 0.5 0.16 3 1 0.01>>out.txt
#./get_cross_section 0 11.0 U U 0.2 0.93 0.5 0.4 3 1 0.01>>out.txt
#./get_cross_section 0 5.75 U U 0.4 0.58 0.4 0.16 0 1 0.01>>out.txt
#./get_cross_section 0 5.75 U U 0.4 0.58 0.4 0.4 0 1 0.01>>out.txt
#./get_cross_section 0 5.75 U U 0.4 0.58 0.4 0.16 3 1 0.01>>out.txt
#./get_cross_section 0 5.75 U U 0.4 0.58 0.4 0.4 3 1 0.01>>out.txt

