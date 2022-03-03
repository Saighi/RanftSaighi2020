#!/bin/sh

{
	. ./globalvars.sh

	NB_PATTERN=1
	PATTERNSIZE=0.1
	PATTERNFREQUENCY=5
	SPARSITYPATTERN=1
	REFPAT=0.05
	SIMULATION_NAME="pattern_presentation_10h"
	OUTDIR="${OUTDIR_ROOT}${SIMULATION_NAME}"
	SIMTIME=38000
	SPIKETRAINS_FILE="spiketrains"
	PREVIOUS_SIM_NAME="Initialisation"
	LOADDIR="${OUTDIR_ROOT}${PREVIOUS_SIM_NAME}"
	mkdir -p $OUTDIR

	cp $0 $OUTDIR

	NB_SEGMENT=20
	RATE=4

	mkdir -p $OUTDIR

	eval "${PYTHON_PATH}python generate_spiketrains_final.py -rate ${RATE} -timesim ${SIMTIME} -nbneurons 2048 -nbsegment ${NB_SEGMENT} -outdir ${OUTDIR} -pattern -nbpattern ${NB_PATTERN} -patternsize ${PATTERNSIZE} -patternfrequency ${PATTERNFREQUENCY} -sparsitypattern ${SPARSITYPATTERN} -refpattern ${REFPAT}"

	make -C $DIR -j8 sim_script && mpirun -n $NP $DIR/sim_script \
		--load $LOADDIR/rf1 \
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



	# exit
}