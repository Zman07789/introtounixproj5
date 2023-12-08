#!/bin/bash

IFS=","

declare inFile="$1"
declare outFile="$2"
declare -a lastNames
declare -a firstNames
declare -ai ages
declare -A people

readFile() {
    declare -i lineNumber=0
    while read lastName firstName age
    do
        lastNames[$lineNumber]=$lastName
        firstNames[$lineNumber]=$firstName
        ages[$lineNumber]=$age
        ((lineNumber++))
    done < "$inFile"
}

altReadFile() {
    declare -i lineNumber=0
    declare -ir ROWS=6
    declare -ir COLUMNS=3
    while read lastName firstName age
    do
        for ((i=0; i < ROWS; i++)); do
            for ((j=0; j < COLUMNS; j++)); do
                if [ $j -eq 0 ]; then
                    people[$i,$j]=$lastName
                elif [ $j -eq 1 ]; then
                    people[$i,$j]=$firstName
                else
                    people[$i,$j]=$age
                fi
            done
        done
        ((lineNumber++))
    done < "$inFile"
}

printLastNames() {
    for ((i=0; i < ${#lastNames[@]}; i++)); do
        echo -e "${lastNames[i]}\n"
    done
}

printMdArray() {
    declare -ir ROWS=6
    declare -ir COLUMNS=3
    for ((i=0; i < ROWS; i++)); do
        for ((j=0; j < COLUMNS; j++)); do
            echo "${people[$i,$j]}"
        done
    done
}

writeNewFile() {
    for ((i=0; i < ${#lastNames[@]}; i++)); do
        echo "${lastNames[i]}" >> "$outFile"
    done
}

countSocialSecurityEligible() {
    declare -i eligibleCount=0
    for ((i=0; i < ${#ages[@]}; i++)); do
        if [ "${ages[i]}" -ge 65 ]; then
            ((eligibleCount++))
        fi
    done
    echo "Number of employees eligible for social security benefits: $eligibleCount"
}

main() {
    readFile
    altReadFile
    printLastNames
    printMdArray
    writeNewFile
    countSocialSecurityEligible
    exit 0
}

main
