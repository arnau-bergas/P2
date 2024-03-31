#! /bin/bash

best_total=0
best_alpha1=0
best_alpha2=0
best_min_silence=0
best_min_voice=0
best_init_counter=0

init_counter=16
min_silence=8
min_voice=3

for alpha1 in $(seq 6 1 10); do
    for alpha2 in $(seq 0 1 4); do
        # for min_silence in $(seq 0 2 10); do
        #     for min_voice in $(seq 0 2 10); do
                    alpha1_dot=$(echo "$alpha1" | tr ',' '.')
                    alpha2_dot=$(echo "$alpha2" | tr ',' '.')
                    echo -n "alpha1=$alpha1, alpha2=$alpha2, min_silence=$min_silence, min_voice=$min_voice, init_counter=$init_counter   RESULT:"
                    total=$(scripts/run_vad.sh $alpha1_dot $alpha2_dot $min_silence $min_voice $init_counter | grep TOTAL | awk '{print $3}' | tr -d '%')
                    echo "$total%"

                    if (( $(echo "$total > $best_total" | bc -l) )); then
                        best_total=$total
                        best_alpha1=$alpha1
                        best_alpha2=$alpha2
                        best_min_silence=$min_silence
                        best_min_voice=$min_voice
                        best_init_counter=$init_counter
                    fi
done done 
# done done

echo "Best total value: $best_total"
echo "Best parameters: alpha1=$best_alpha1, alpha2=$best_alpha2, min_silence=$best_min_silence, min_voice=$best_min_voice, init_counter=$best_init_counter"