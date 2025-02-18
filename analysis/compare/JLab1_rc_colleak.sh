#/bin/bash
source /apps/anaconda3/2021.05/etc/profile.d/conda.sh
conda activate shuoenv 
cd /w/halla-scshelf2102/solid/shuo/qedsidis-factorized 
echo "Using numbers in increase_grids.txt"
while IFS="" read -r p || [ -n "$p" ]
do
  echo "${p}"
  python main.py rc colleak 3.209261397 0.32 0.55 1.52 ${p} >>results/Fac-results/Fine/JLab_1_colleak_rc.txt
done < analysis/increase_grids_JLab1.txt
