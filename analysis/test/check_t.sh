#!/bin/bash -l
module use /apps/modulefiles
cd /w/halla-scshelf2102/solid/shuo/sidis
source setup_sidis
export LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64:$LD_LIBRARY_PATH
while IFS="," read -r f1
do
  #./get_cross_section 0 10.6 U U 0.31 0.405 0.4 0.00625 ${f1} 1 0.01>>compare/analysis/test/all_out.txt
  #./get_cross_section 0 10.6 U U 0.31 0.405 0.4 0.5625 ${f1} 1 0.01>>compare/analysis/test/all_out.txt
  #./get_cross_section 0 10.6 U U 0.31 0.405 0.4 1 ${f1} 1 0.01>>compare/analysis/test/all_out.txt
  #./get_cross_section 0 10.6 U U 0.31 0.6 0.4 0.00625 ${f1} 1 0.01>>compare/analysis/test/all_out.txt
  #./get_cross_section 0 10.6 U U 0.31 0.6 0.4 0.5625 ${f1} 1 0.01>>compare/analysis/test/all_out.txt
  #./get_cross_section 0 10.6 U U 0.31 0.6 0.4 1 ${f1} 1 0.01>>compare/analysis/test/all_out.txt
  ./get_cross_section 0 6.535 U U 0.31 0.6576 0.4 0.00625 ${f1} 1 0.01>>compare/analysis/test/all_out_6.txt
  ./get_cross_section 0 6.535 U U 0.31 0.6576 0.4 0.5625 ${f1} 1 0.01>>compare/analysis/test/all_out_6.txt
  ./get_cross_section 0 6.535 U U 0.31 0.6576 0.4 1 ${f1} 1 0.01>>compare/analysis/test/all_out_6.txt
  ./get_cross_section 0 6.535 U U 0.31 0.9733 0.4 0.00625 ${f1} 1 0.01>>compare/analysis/test/all_out_6.txt
  ./get_cross_section 0 6.535 U U 0.31 0.9733 0.4 0.5625 ${f1} 1 0.01>>compare/analysis/test/all_out_6.txt
  ./get_cross_section 0 6.535 U U 0.31 0.9733 0.4 1 ${f1} 1 0.01>>compare/analysis/test/all_out_6.txt
  ./get_cross_section 0 7.546 U U 0.31 0.5695 0.4 0.00625 ${f1} 1 0.01>>compare/analysis/test/all_out_7.txt
  ./get_cross_section 0 7.546 U U 0.31 0.5695 0.4 0.5625 ${f1} 1 0.01>>compare/analysis/test/all_out_7.txt
  ./get_cross_section 0 7.546 U U 0.31 0.5695 0.4 1 ${f1} 1 0.01>>compare/analysis/test/all_out_7.txt
  ./get_cross_section 0 7.546 U U 0.31 0.8429 0.4 0.00625 ${f1} 1 0.01>>compare/analysis/test/all_out_7.txt
  ./get_cross_section 0 7.546 U U 0.31 0.8429 0.4 0.5625 ${f1} 1 0.01>>compare/analysis/test/all_out_7.txt
  ./get_cross_section 0 7.546 U U 0.31 0.8429 0.4 1 ${f1} 1 0.01>>compare/analysis/test/all_out_7.txt
  ./get_cross_section 0 8.4 U U 0.31 0.5116 0.4 0.00625 ${f1} 1 0.01>>compare/analysis/test/all_out_8.txt
  ./get_cross_section 0 8.4 U U 0.31 0.5116 0.4 0.5625 ${f1} 1 0.01>>compare/analysis/test/all_out_8.txt
  ./get_cross_section 0 8.4 U U 0.31 0.5116 0.4 1 ${f1} 1 0.01>>compare/analysis/test/all_out_8.txt
  ./get_cross_section 0 8.4 U U 0.31 0.7572 0.4 0.00625 ${f1} 1 0.01>>compare/analysis/test/all_out_8.txt
  ./get_cross_section 0 8.4 U U 0.31 0.7572 0.4 0.5625 ${f1} 1 0.01>>compare/analysis/test/all_out_8.txt
  ./get_cross_section 0 8.4 U U 0.31 0.7572 0.4 1 ${f1} 1 0.01>>compare/analysis/test/all_out_8.txt
done < compare/analysis/test/phih.txt

