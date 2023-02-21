echo "Using numbers in increase_grids.txt"
while IFS="" read -r p || [ -n "$p" ]
do
  echo "${p}"
  python main.py born unpol 140 0.01276 0.5 10 ${p} >>results/Fac-results/Fine/EIC_2_unpol_born.txt
done < analysis/increase_grids.txt
