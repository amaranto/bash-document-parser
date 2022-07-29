#!/bin/bash -e

source ${SCRIPTS_FOLDER}/logger.sh
source ${SCRIPTS_FOLDER}/menu.sh
source ${SCRIPTS_FOLDER}/initSources.sh
source ${SCRIPTS_FOLDER}/exercises/statsWords.sh
source ${SCRIPTS_FOLDER}/exercises/statsUsageWords.sh
source ${SCRIPTS_FOLDER}/exercises/findNames.sh
source ${SCRIPTS_FOLDER}/exercises/statsSentences.sh
source ${SCRIPTS_FOLDER}/exercises/blankLinesCounter.sh
source ${SCRIPTS_FOLDER}/exercises/caseConverter.sh 
source ${SCRIPTS_FOLDER}/exercises/substringReplace.sh
source ${SCRIPTS_FOLDER}/exercises/blockSelection.sh

export SOURCE_FOLDER="/mnt/texts"
export TEXT_FILES=${TEXT_FILES}

while getopts :s:f:v:hi opt; do
    case ${opt} in
    h)
        usage
        exit 0
        ;;
    s)  src=${OPTARG}
        init_sources ${src}
        TEXT_FILES=$(get_files)
        ;;
    f) 
        if [ -z "${TEXT_FILES}" ]; then
          init_sources ${SOURCE_FOLDER}
          TEXT_FILES=$(get_files)
        fi 
        
        log_debug "TEXT_FILES : < ${TEXT_FILES} >"
        [ -z "${TEXT_FILES}" ] && log_critical "init_sources was not initialized or source folder is empety. Aborting." && exit 2

        foo=${OPTARG}
        ${foo} "${TEXT_FILES}"
        ;;
    i)
        if [ -z "${TEXT_FILES}" ]; then
          init_sources ${SOURCE_FOLDER}
          TEXT_FILES=$(get_files)
        fi

        log_debug "TEXT_FILES : < ${TEXT_FILES} >"
        [ -z "${TEXT_FILES}" ] && log_critical "init_sources was not initialized or source folder is empety. Aborting." && exit 2

        menu "${TEXT_FILES}"
        ;;   
    *)
        printf "Invalid Option: ${OPTARG}.\n"
        usage
        exit 5
    ;;
    esac
done
