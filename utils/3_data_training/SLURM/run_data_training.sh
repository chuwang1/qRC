#!/bin/bash

configSS=$1
configPI=$2
configCI=$3
N_evts=$4
EBEE=$5


for var in "probeCovarianceIeIp" "probeSigmaIeIe" "probeEtaWidth" "probePhiWidth" "probeR9" "probeS4";
do
    echo Submitting training jobs for variable $var on data
    for q in 0.01 0.99 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6 0.65 0.7 0.75 0.8 0.85 0.9 0.95;
    do
	echo Submitting training job for quantile $q on data
	# sbatch SLURM/job_train_qRC_data.sh ${configSS} ${var} ${q} ${N_evts} ${EBEE}
    echo "python /afs/cern.ch/work/c/chuw/Hgg_mass/qRC/utils/3_data_training/python_scripts/train_qRC_data.py -c ${configSS} -v ${var} -q ${q} -N ${N_evts} -E ${EBEE} " >run_train_qRC_data_${var}_${q}_${N_evts}_${EBEE}.sh
    done
done

echo Training jobs for shower shapes submitted!

for var in "probePhoIso";
do
    echo Submitting training jobs for variable $var on data
    for q in 0.01 0.99 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6 0.65 0.7 0.75 0.8 0.85 0.9 0.95;
    do
	echo Submitting training job for quantile $q on data
	# sbatch SLURM/job_train_qRC_I_data.sh ${configPI} ${var} ${q} ${N_evts} ${EBEE}
    echo "python /afs/cern.ch/work/c/chuw/Hgg_mass/qRC/utils/3_data_training/python_scripts/train_qRC_I_data.py -c ${configPI} -v ${var} -q ${q} -N ${N_evts} -E ${EBEE} " >run_train_qRC_I_data_PI_${var}_${q}_${N_evts}_${EBEE}.sh
    printf "executable              = run_train_qRC_I_data_PI_${var}_${q}_${N_evts}_${EBEE}.sh \narguments               = \$(ClusterId)\$(ProcId)\noutput                  = condor_output/run_train_qRC_I_data_PI_${var}_${q}_${N_evts}_${EBEE}.\$(ClusterId)\$(ProcId).out\noutput                  = condor_output/run_train_qRC_I_data_PI_${var}_${q}_${N_evts}_${EBEE}.\$(ClusterId)\$(ProcId).out\nerror                   = condor_output/run_train_qRC_I_data_PI_${var}_${q}_${N_evts}_${EBEE}.\$(ClusterId).\$(ProcId).err\nlog                     = condor_output/run_train_qRC_I_data_PI_${var}_${q}_${N_evts}_${EBEE}.\$(ClusterId).log\nqueue 1" >run_train_qRC_I_data_PI_${var}_${q}_${N_evts}_${EBEE}.sub
    condor_submit run_train_qRC_I_data_PI_${var}_${q}_${N_evts}_${EBEE}.sub 
    done
done

echo Training jobs for Photon Iso submitted!

for var in "probeChIso03" "probeChIso03worst";
do
    echo Submitting training jobs for variable $var on data
    for q in 0.01 0.99 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6 0.65 0.7 0.75 0.8 0.85 0.9 0.95;
    do
	echo Submitting training job for quantile $q on data
	# sbatch SLURM/job_train_qRC_I_data.sh ${configCI} ${var} ${q} ${N_evts} ${EBEE}
    echo "python /afs/cern.ch/work/c/chuw/Hgg_mass/qRC/utils/3_data_training/python_scripts/train_qRC_I_data.py -c ${configCI} -v ${var} -q ${q} -N ${N_evts} -E ${EBEE} " >run_train_qRC_I_data_CI_${var}_${q}_${N_evts}_${EBEE}.sh
    done
done

echo Training jobs for Charged Iso submitted!
