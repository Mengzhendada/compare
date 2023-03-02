#/bin/bash
source /apps/anaconda3/2021.05/etc/profile.d/conda.sh
conda activate shuoenv 
cd /w/halla-scshelf2102/solid/shuo/qedsidis-factorized 
echo "Using numbers in increase_grids.txt"
while IFS="" read -r p || [ -n "$p" ]
do
  echo "${p}"
  python main.py born unpol 6.71096567 0.48 0.375 3.872983346 ${p} >>results/Fac-results/Fine/JLab_3_unpol_born.txt
done < analysis/increase_grids.txt
