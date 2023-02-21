echo "Using numbers in increase_grids.txt"
while IFS="" read -r p || [ -n "$p" ]
do
  echo "${p}"
  python main.py born unpol 6.68 0.48 0.375 3.873 ${p} >>results/Fac-results/Fine/JLab_3_unpol_born.txt
done < analysis/increase_grids.txt
