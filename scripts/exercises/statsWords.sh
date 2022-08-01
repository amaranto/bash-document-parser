function statsWords(){

    for fd in ${1};do

        local total_words=0
        local total_length=0
        local longest_word=""
        local shortest_word=""

        echo "-----------------------------------"
        echo "${fd}"

        while read line; do
            for w in ${line}; do
                
                w=${w//[^[:alnum:]]/}

                [ -z "${shortest_word}" ] && shortest_word="${w}"
                [ ${#w} -gt ${#longest_word} ] && longest_word=${w}
                [ ${#w} -lt ${#shortest_word} ] && shortest_word=${w}

                total_words=$((total_words+1))
                total_length=$((total_length+${#w}))
                prom_length=$((total_length/total_words))
            done     
        done <"${fd}"

        printf '\r %s <%d> | %s <%d> | %s <%d> | %s <%d> | %s <%d> | %s ' "Words" "${total_words}" "Longest word" "${#longest_word}" "Shortest word" "${#shortest_word}" "Total length" "${total_length}" "Prom lenght" "${prom_length}" "${longest_word}"
        printf "\n"       
        echo "-----------------------------------"
    done
}


