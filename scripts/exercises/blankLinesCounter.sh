function blankLinesCounter(){

    for fd in ${1};do

        local total_blank_l=0

        echo "-----------------------------------"
        echo "${fd}"

        while read line; do
            
            ( echo ${line} | grep -E '^([[:space:]]+$|^$)' >/dev/null ) && total_blank_l=$((total_blank_l+1))
                           
        done <"${fd}"
        echo "Total blank lines ${total_blank_l}"
        echo "-----------------------------------"
    done

}