function usage(){
cat<<EOF
    NAME
        ${0}
    SYNOPSIS
        ${0} <OPTION> <FUNCTION>
        ${0} [-v][-h|-s <URL|PATH>] [ -i|-f <FUNCTION NAME> ]

    DESCRIPTION :
        Debug level is available setting LOG_LEVEL variable. Allowed values <DEBUG|WARNING|CRITICAL>
        -h Display this menu
        -s An string with a list of folder, files and URLs separated by spaces to be analyzed. Ex: "http://google.com /mnt/texts /mnt/texts/enterSandman.txt"
        -i Enable interactive mode with and display a menu
        -f Function name to be executed. Allowed values < statsWords|statsUsageWords|findNames|statsSentences|blankLinesCounter|caseConverter|substringReplace|blockSelection >
        
    EXAMPLES
        ${0} -s "http://google.com /mnt/texts /mnt/texts/enterSandman.txt" -i
        ${0} -s "/mnt/texts" -f statsWords
EOF

}

function show_menu(){

cat<<EOF
[ menu ]

    Choice an option 0 al 9:

    1. statsWords
    2. statsUsageWords
    3. findNames
    4. statsSentences
    5. blankLinesCounter
    6. caseConverter
    7. substringReplace
    8. blockSelection
    0. EXIT
EOF
    echo -ne "> "
}

function files_menu(){

    local m_array=(${1})

    echo -e "\t [ files ]"
    echo -e "\t Choice a file from the list: \n"

    for i in ${!m_array[@]};do 
        echo -e "\t ${i}. ${m_array[$i]}"
    done
}

function menu(){

    local f_array=(${1})
    f_array+=("SELECT_ALL" "ABORT")

    while [ true ]; do

        files_menu "${f_array[*]}"

        d=""
        until [[ ${d} == +([0-9]) ]] ; do
            read -r -p "> " d
        done

        if [ "${d}" -lt 0 -o "${d}" -gt "${#f_array[@]}" ]; then
            log_critical "The option is not correct. Try again."
            continue
        fi

        opt=${f_array[${d}]}

        if [ "${opt}" == "SELECT_ALL" ]; then
            opt=${1}
        elif [ "${opt}" == "ABORT" ]; then 
            log_warning "Good Bye."
            exit 0
        else
            opt=${f_array[${d}]}
        fi 

        log_debug "choose ${opt}"

        show_menu
        read a

        case ${a} in
            1) statsWords "${opt}";;
            2) statsUsageWords  "${opt}";;
            3) findNames "${opt}";;
            4) statsSentences "${opt}";;
            5) blankLinesCounter "${opt}";;
            6) caseConverter "${opt}";;
            7) 
               read -p "Enter prefix : " opt1
               read -p "Enter suffix : " opt2
               substringReplace "${opt1}" "${opt2}" "${opt}"
               ;;
            8) 
               read -p "Enter P for paragraph or O for sentence <P|p|O|o> : " opt1
               read -p "Enter number of paragraph or sentence : " opt2
    
               if [[ ${opt1} =~ ^[poPO]$ ]] && [[ ${opt2} =~ ^[[:digit:]]+$ ]]; then
                    blockSelection "${opt1}" "${opt2}" "${opt}"
               else 
                    log_critical "You entered an invalid option "
                    sleep 1
               fi 
               ;;
            0) log_warning "Good Bye" && exit 0;;
            *) log_critical "Wrong option" && sleep 1;;
        esac 

        echo "\n Function completed. Press any key to continue ..."
        read x
    done
}