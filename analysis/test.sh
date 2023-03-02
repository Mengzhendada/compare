echo "Using numbers in increase_grids.txt"
while IFS="" read -r p || [ -n "$p" ]
do
  echo "${p}"
  python main.py rc col 140 0.00114795918 0.5 3 ${p} >>results/Fac-results/Fine/EIC_1_col_rc.txt
done < analysis/increase_grids.txt
