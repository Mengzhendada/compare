#/bin/bash
source /apps/anaconda3/2021.05/etc/profile.d/conda.sh
conda activate shuoenv 
cd /w/halla-scshelf2102/solid/shuo/qedsidis-factorized 
echo "Using numbers in increase_grids.txt"
while IFS="" read -r p || [ -n "$p" ]
do
  echo "${p}"
  python main.py born unpol 4.74536931662858 0.48 0.375 2.8284271247461903 ${p} >>results/Fac-results/Fine/JLab_2_unpol_born.txt
done < analysis/increase_grids.txt
