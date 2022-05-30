conda activate /afs/cern.ch/work/c/chuw/Hgg_mass/.env
source /afs/cern.ch/work/c/chuw/Hgg_mass/.env/ROOT/root/bin/thisroot.sh
python python_scripts/train_qRC_data.py -c  config/config_qRC_training_5M.yaml -v probeCovarianceIeIp -q 0.3 -N 4700000 -E EE

