echo "Using numbers in increase_grids.txt"
while IFS="" read -r p || [ -n "$p" ]
do
  echo "${p}"
  python main.py rc siv 140 0.01276 0.5 10 ${p} >>results/Fac-results/Fine/EIC_2_siv_rc.txt
done < analysis/increase_grids.txt
