echo "Using numbers in increase_grids.txt"
while IFS="" read -r p || [ -n "$p" ]
do
  echo "${p}"
  python main.py rc col 140 0.01 0.5 5 ${p} >>results/Fac-results/Fine/EIC_3_col_rc.txt
done < analysis/increase_grids.txt
