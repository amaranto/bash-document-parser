function findNames(){
    for fd in ${1};do

        log_debug "Working on < ${fd} >"
        local names=()
        local name_regex="^[A-Z][a-z]+$"
        
        while read line; do
            for w in ${line}; do
                
                if [[ ${w} =~ ${name_regex} ]]; then
                    log_debug "${w} is a name"
                    names+=("${w}")
                else 
                    log_debug "${w} is not a name"
                fi
            done     
        done <"${fd}"

        echo "-----------------------------------"
        echo "${fd}"
        echo "${names[*]}"
        echo "Total names: ${#names[@]}"
        echo "-----------------------------------"
    done    
}