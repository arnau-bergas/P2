#!/bin/bash

# Be sure that this file has execution permissions:
# Use the nautilus explorer or chmod +x run_vad.sh

# Assigning alpha1 argument to a variable
alpha1=${1:-6.6}
alpha2=${2:-5.9}
zcr_stv=${3:-4000}
zcr_vts=${4:-2400}
min_silence=${5:-8}
min_voice=${6:-9}
init_counter=${7:-0}

# Establecemos que el código de retorno de un pipeline sea el del último programa con código de retorno
# distinto de cero, o cero si todos devuelven cero.
set -o pipefail

# Write here the name and path of your program and database
DIR_P2=$HOME/PAV/P2
DB=$DIR_P2/db.v4
CMD=$DIR_P2/bin/vad


for filewav in $DB/*/*wav; do
        echo "**************** $filewav ****************"
        if [[ ! -f $filewav ]]; then 
            echo "Wav file not found: $filewav" >&2
            exit 1
        fi

        filevad=${filewav/.wav/.vad}
        $CMD -i $filewav -o $filevad -1 $alpha1 -2 $alpha2 -Z $zcr_stv -X $zcr_vts -V $min_voice -S $min_silence -I $init_counter || exit 1

done 

scripts/vad_evaluation.pl $DB/*/*lab

exit 0
