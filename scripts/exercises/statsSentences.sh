function statsSentences(){
    #local http_regex='^(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]$'
    #local email_regex='^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}'
    #local ip_regex='([0-9]{1,3}\.?){4}'

    temp_local=${IFS}

    for fd in ${1};do

        local total_sentences=0
        local total_length=0
        local longest_sentence=""
        local shortest_sentence=""

        echo "-----------------------------------"
        echo "${fd}"

        IFS='.'
        while read -ra line; do 


            [ -z "${shortest_sentence}" ] && shortest_sentence=${line}               
            [ ${#line} -gt ${#longest_sentence} ] && longest_sentence=${line}
            [ ${#line} -lt ${#shortest_sentence} ] && shortest_sentence=${line}
                        
            total_sentences=$((total_sentences+1))
            total_length=$((total_length+${#line}))
            prom_length=$((total_length/total_sentences))
            printf '\r %s <%d> | %s <%d> | %s <%d> | %s <%d> | %s <%d>' "Sentences" "${total_sentences}" "Shortest " "${#shortest_sentence}" "Longest " "${#longest_sentence}" "Total length" "${total_length}" "Prom lenght" "${prom_length}"

        done <"${fd}"
        IFS=' '
        printf "\n"       
        echo 
        
    done
}
