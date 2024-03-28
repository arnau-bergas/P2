#! /bin/bash

for alpha1 in $(seq 4 0.1 6); do
    alpha1_dot=$(echo "$alpha1" | tr ',' '.')
    echo -n "$alpha1_dot: "
    scripts/run_vad.sh $alpha1_dot | grep TOTAL
done