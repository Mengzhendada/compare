echo "Using numbers in increase_grids.txt"
while IFS="" read -r p || [ -n "$p" ]
do
  echo "${p}"
  python main.py rc col 140 0.001148 0.5 3 ${p} >>results/Fac-results/Fine/EIC_1_col_rc.txt
  python main.py born col 140 0.001148 0.5 3 ${p} >>results/Fac-results/EIC_1_col_bn.txt
  python main.py rc unpol 140 0.001148 0.5 3 ${p} >>results/Fac-results/EIC_1_unpol_rc.txt
  python main.py born unpol 140 0.001148 0.5 3 [0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5,0.55,0.6]&>results/Fac-results/EIC_1_unpol_bn.txt
  python main.py rc siv 140 0.001148 0.5 3 [0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5,0.55,0.6]&>results/Fac-results/EIC_1_siv_rc.txt
  python main.py born siv 140 0.001148 0.5 3 [0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5,0.55,0.6]&>results/Fac-results/EIC_1_siv_bn.txt
done < analysis/increase_grids.txt
