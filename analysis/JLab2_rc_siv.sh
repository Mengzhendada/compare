echo "Using numbers in increase_grids.txt"
while IFS="" read -r p || [ -n "$p" ]
do
  echo "${p}"
  python main.py rc siv 4.724 0.48 0.375 2.828 ${p} >>results/Fac-results/Fine/JLab_2_siv_rc.txt
done < analysis/increase_grids.txt
