#! /bin/bash

best_total=0
best_alpha1=0
best_alpha2=0
best_zcr_stv=0
best_zcr_vts=0
best_min_silence=0
best_min_voice=0
best_init_counter=0

min_silence=8 
min_voice=4
init_counter=0
alpha1=6.6 
alpha2=5.9
zcr_stv=4000
zcr_vts=2400


# for alpha1 in $(seq 6.5 0.1 7); do
#     for alpha2 in $(seq 2 0.1 6); do
        # for zcr_stv in $(seq 3500 100 4500); do
#             for zcr_vts in $(seq 2200 100 2800); do
        for min_silence in $(seq 0 1 10); do
            for min_voice in $(seq 0 1 10); do
                #  for init_counter in $(seq 0 1 20); do
                    alpha1_dot=$(echo "$alpha1" | tr ',' '.')
                    alpha2_dot=$(echo "$alpha2" | tr ',' '.')
                    echo -n "alpha1=$alpha1, alpha2=$alpha2, zcr_stv=$zcr_stv, zcr_vts=$zcr_vts, min_silence=$min_silence, min_voice=$min_voice, init_counter=$init_counter   RESULT:"
                    total=$(scripts/run_vad.sh $alpha1_dot $alpha2_dot $zcr_stv $zcr_vts $min_silence $min_voice $init_counter | grep TOTAL | awk '{print $3}' | tr -d '%')
                    echo "$total%"

                    if (( $(echo "$total > $best_total" | bc -l) )); then
                        best_total=$total
                        best_alpha1=$alpha1
                        best_alpha2=$alpha2
                        best_zcr_stv=$zcr_stv
                        best_zcr_vts=$zcr_vts
                        best_min_silence=$min_silence
                        best_min_voice=$min_voice
                        best_init_counter=$init_counter
                    fi
# done done 
done done
#done

echo "Best total value: $best_total"
echo "Best parameters: alpha1=$best_alpha1, alpha2=$best_alpha2, zcr_stv=$best_zcr_stv, zcr_vts=$best_zcr_vts,min_silence=$best_min_silence, min_voice=$best_min_voice, init_counter=$best_init_counter"