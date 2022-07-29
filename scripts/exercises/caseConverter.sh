function caseConverter(){

    for fd in ${1};do
        
        tmpfile="/tmp/caseConverter-$(basename ${fd})"  
        tmptxtfile="/tmp/txt-$(basename ${fd})" 

        log_debug "Creating or truncating temporal file "
        echo "" >${tmpfile}

        log_debug "Creating temporal txt file and removing Windows EOF"
        cp ${fd} ${tmptxtfile}
        sed -i 's/\r$//' ${tmptxtfile}

        echo "-----------------------------------"
        echo "${fd}"

        while read line; do
            for w in ${line}; do
                
                w=${w~~}
                printf "${w} " >>${tmpfile}
            done   
            printf "\n">>${tmpfile}   
        done <"${tmptxtfile}"
        cat ${tmpfile}      
        echo "-----------------------------------"
    done    
}