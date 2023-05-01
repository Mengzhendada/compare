source /apps/anaconda3/2021.05/etc/profile.d/conda.sh
conda activate shuoenv 
cd /w/halla-scshelf2102/solid/shuo/qedsidis-factorized 
python main.py born unpol 3.3 0.2 0.5 1.414 0.56 >>out.txt
python main.py born unpol 3.3 0.2 0.5 1.414 0.894 >>out.txt
python main.py born unpol 4.5 0.2 0.5 2 0.4 >>out.txt
python main.py born unpol 4.5 0.2 0.5 2 0.63 >>out.txt
python main.py born unpol 3.3 0.4 0.4 1.581 0.633 >>out.txt
python main.py born unpol 3.3 0.4 0.4 1.581 1 >>out.txt
