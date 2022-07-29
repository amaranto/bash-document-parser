function searchw(){
    
    total_found=0

    while read line; do

        for w in ${line}; do
            w=${w^^}
            w=${w//[^[:alnum:]]/}

            if [ "${w}" == "${2}" ]; then 
                total_found=$((total_found+1))
            fi            
        done     
    done <"${1}"

    echo "${total_found}"
}

function statsUsageWords(){

    for fd in ${1};do

        tmpfile="/tmp/statsUsageWords-$(basename ${fd})"  
        tmptxtfile="/tmp/txt-$(basename ${fd})"  
        
        log_debug "Working on ${fd} "
        
        log_debug "Formatting input file ${tmpfile}"
        cp ${fd} ${tmptxtfile}
        sed -i 's/\r$//' ${tmptxtfile}
    
        log_debug "Creating tmp file ${tmpfile}"
        echo "" > ${tmpfile}

        while read line; do

            for wd in ${line}; do

                wd=${wd^^}
                wd=${wd//[^[:alnum:]]/}
                
                set +e
                already_processed=$(cat ${tmpfile} | grep -E "^${wd}[[:space:]][0-9]+$")
                set -e

                if [ ${#wd} -ge 4 -a -z "${already_processed}" ]; then 

                    num_of_rep=$(searchw "${tmptxtfile}" "${wd}")
                    log_debug "<${wd} ${num_of_rep}>"

                    log_debug "Saving ${wd} as processed"
                    echo "${wd} ${num_of_rep}" >>${tmpfile}       
                else 
                    log_debug "${wd} Already processed or less than 4 letters"
                fi
            done     
        done <"${tmptxtfile}"  

        echo "-----------------------------------"
        echo ${fd}
        sort -r -k 2 -g ${tmpfile} | head -n 10
        echo "-----------------------------------"

    done
}