#!/bin/bash -l
module use /apps/modulefiles
cd /w/halla-scshelf2102/solid/shuo/sidis_new2
source setup_sidis
export LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64:$LD_LIBRARY_PATH
while IFS="," read -r f1
do
  ./get_cross_section 0 10.6 U U 0.31 0.405 0.4 0.00625 ${f1} 1 0.01>>compare/analysis/test/FuuT_cos_out.txt
  ./get_cross_section 0 10.6 U U 0.31 0.405 0.4 0.5625 ${f1} 1 0.01>>compare/analysis/test/FuuT_cos_out.txt
  ./get_cross_section 0 10.6 U U 0.31 0.405 0.4 1 ${f1} 1 0.01>>compare/analysis/test/FuuT_cos_out.txt
  ./get_cross_section 0 10.6 U U 0.31 0.6 0.4 0.00625 ${f1} 1 0.01>>compare/analysis/test/FuuT_cos_out.txt
  ./get_cross_section 0 10.6 U U 0.31 0.6 0.4 0.5625 ${f1} 1 0.01>>compare/analysis/test/FuuT_cos_out.txt
  ./get_cross_section 0 10.6 U U 0.31 0.6 0.4 1 ${f1} 1 0.01>>compare/analysis/test/FuuT_cos_out.txt
done < compare/analysis/test/phih.txt

