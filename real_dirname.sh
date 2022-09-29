

function shocc__check_realpath_cmd()
{
    type realpath &> /dev/null
    if [[ $? -eq 1 ]]
    then
        [[ "$(uname)" == "Linux" ]] && install_realpath_command="apt-get install coreutils"
        [[ "$(uname)" == "Darwin" ]] && install_realpath_command="brew install coreutils"

        echo -e "$(basename $0): error: realpath executable required."
        echo -e "    install it with : "${install_realpath_command}

        return 1
    fi
    return 0
}

function shocc__real_dirname()
{
    : ${1?'no path provided.'}
    shocc__check_realpath_cmd || return 2

    echo $(dirname $(realpath $1))
}
