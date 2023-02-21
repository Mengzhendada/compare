echo "Using numbers in increase_grids.txt"
while IFS="" read -r p || [ -n "$p" ]
do
  echo "${p}"
  python main.py born unpol 3.2 0.32 0.55 1.52 ${p} >>results/Fac-results/Fine/JLab_1_unpol_born.txt
done < analysis/increase_grids.txt
