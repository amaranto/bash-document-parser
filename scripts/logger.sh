LOG_LEVEL=${LOG_LEVEL:-CRITICAL}

lvl1="^(CRITICAL|WARNING|DEBUG)*"
lvl2="^(WARNING|DEBUG)*"
lvl3="^DEBUG$"

function log_debug(){
   if [[ ${LOG_LEVEL^^} =~ ${lvl3} ]]; then
        echo "[ DEBUG ] ${@}"
   fi
}

function log_warning(){
    if [[ ${LOG_LEVEL^^} =~ ${lvl2} ]]; then
        echo "[ WARNING ] ${@}"
    fi 
}

function log_critical(){
    if [[ ${LOG_LEVEL^^} =~ ${lvl1} ]]; then 
        echo "[ CRITICAL ] ${@}"
    fi 
}