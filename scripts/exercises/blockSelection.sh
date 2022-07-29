function searchP(){
    for fd in ${2}; do
        
        tmpPfile="/tmp/blockSelection-p-$(basename ${fd})"  

        log_debug "Creating temporal txt file and removing Windows EOF"
        cp ${fd} ${tmpPfile}
        sed -i 's/\r$//' ${tmpPfile}
        sed -i -r "s/\.[[:space:]]+/. /g" ${tmpPfile}

        local current_paragraph=0

        echo -e "\n ----- ${fd} -----"
        IFS=$'\n'
        while read -ra line; do 

            set +e
            echo "$line" | grep -E "\.([[:space:]]+|)$" >/dev/null 2>&1
            is_end_of_paragraph=$?
            set -e

            if [ "${current_paragraph}" -eq "${1}" ]; then
                echo $line
            fi

            [ ${is_end_of_paragraph} -eq 0 ] && [ "${current_paragraph}" -eq "${1}" ] && break
            [ ${is_end_of_paragraph} -eq 0 ] && current_paragraph+=$((current_paragraph+1))

        done <"${tmpPfile}"
        IFS=' '
        echo -e "----- PARAGRAPH END ----- \n"
    done
}

function searchO(){
    for fd in ${2}; do
        
        tmpOfile="/tmp/blockSelection-o-$(basename ${fd})" 

        log_debug "Creating temporal txt file and removing Windows EOF"
        cp ${fd} ${tmpOfile}
        sed -i 's/\r$//' ${tmpOfile}
        sed -i -r "s/\.[[:space:]]+/. /g" ${tmpOfile}

        local current_sentence=0

        echo -e "\n ----- ${fd} -----"
        IFS='.'
        while read -ra line; do 

            if [ "${current_sentence}" -eq "${1}" ]; then
                echo $line
                break
            fi

            current_sentence+=$((current_sentence+1))

        done <"${tmpOfile}"
        IFS=' '
        echo -e "----- SENTENCE END ----- \n"
    done
}

function blockSelection(){
    
    if [ "${1^^}" == "P" ]; then 
        searchP "${2}" "${3}" 
    elif [ "${1^^}" == "O" ]; then
        searchO "${2}" "${3}"
    else
        log_critical "blockSelection received an invalid option"
    fi
}