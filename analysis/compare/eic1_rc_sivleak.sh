#/bin/bash
source /apps/anaconda3/2021.05/etc/profile.d/conda.sh
conda activate shuoenv 
cd /w/halla-scshelf2102/solid/shuo/qedsidis-factorized 
echo "Using numbers in increase_grids.txt"
while IFS="" read -r p || [ -n "$p" ]
do
  echo "${p}"
  python main.py rc sivleak 140 0.00114795918 0.5 3 ${p} >>results/Fac-results/Fine/EIC_1_sivleak_rc.txt
done < analysis/increase_grids_eic1.txt
