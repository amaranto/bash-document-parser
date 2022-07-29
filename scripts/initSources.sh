export http_regex="^(http|https)://.*"
export source_files=""

function download(){
    allow_insecure=$( [ "${WGET_ALLOW_INSECURE^^}" == "TRUE" ] && echo --no-check-certificate )
    dest_path="${SOURCE_FOLDER}/${1##*/}"
    wget -q ${allow_insecure} -O ${dest_path} ${1} 2>&1 >/dev/null || ( log_critical "Can not download ${1}. ABORTING" && exit 3)
    log_debug "${dest_path} ... SAVED"
    source_files=$(echo ${source_files} ${SOURCE_FOLDER}/${1##*/})
}

function init_sources(){

    mkdir -p ${SOURCE_FOLDER}

    for f in ${@}; do
        if [[ ${f} =~ ${http_regex} ]]; then
            log_debug "${f} ... URL"
            download ${f}
        elif [ -f ${f} ]; then 
            log_debug "${f} ... FILE"
            source_files=$(echo ${source_files} ${f})
        elif [ -d ${f} ]; then 
            log_debug "${f} ... DIRECTORY"
            files_in_dir=$(ls -w1 ${f})
            for fid in ${files_in_dir}; do
                [ -d ${f}/${fid} ] && log_debug "${f}/${fid} is a sub-directory. Skipping." && continue
                source_files+="${f}/${fid} "            
            done
        else 
            log_critical "${f} ... ERROR"
            log_critical "${f} doesn't exist or it is not a valid URL. ABORTING."
            exit 1
        fi 
    done

    log_debug "Sources ${source_files}"
}

function get_files(){
    echo ${source_files}
}
