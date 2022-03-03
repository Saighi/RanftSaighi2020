#!/bin/sh
{

. ./globalvars.sh

SIMULATION_NAME="Initialisation"
OUTDIR="${OUTDIR_ROOT}${SIMULATION_NAME}"
SPIKETRAINS_FILE="spiketrains"
SIMTIME=2000

mkdir -p $OUTDIR
cp $0 $OUTDIR

NB_SEGMENT=4
RATE=4


eval "${PYTHON_PATH}python generate_spiketrains_final.py -rate ${RATE} -timesim ${SIMTIME} -nbneurons 2048 -nbsegment ${NB_SEGMENT} -outdir ${OUTDIR}"

make -C . -j8 sim_script 

mpirun -n $NP $DIR/sim_script \
	--dir $OUTDIR \
	--prefix rf1 --size 2048 --save \
	--xi $XI \
	--wee 0.20 --wext 0.20 --wei 1 --wii 0.08 --wie 0.1 \
	--simtime $SIMTIME --tauf $TAUF --taud $TAUD \
	--intsparse 0.1 \
	--extsparse 0.2 \
	--off 2.0 --on 1.0 \
	--beta $BETA --eta $ETA --bgrate 4 --scale $SCALE --weight_a $WEIGHTA --alpha 1 --delta 0.02 \
	--nocons \
	--input_spiketrains $SPIKETRAINS_FILE \
	--nb_segment $NB_SEGMENT

	exit
}

#--wee 0.05 --wext 0.15 --wei 0.2 --wii 0.4 --wie 1 \
