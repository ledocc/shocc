

function shocc__check_realpath_cmd()
{
    if [ ! -e $(which realpath) ]
    then
        [ "$(uname)" == "Linux" ] && install_realpath_command="apt-get install coreutils"
        [ "$(uname)" == "Darwin" ] && install_realpath_command="brew install coreutils"

        echo "$(basename $0): error: realpath executable required."
        echo "    install it with : "${install_realpath_command}

        return 1
    fi
    return 0
}

function shocc__real_dirname()
{
    [[ $# -eq 0 ]] && return 1
    shocc__check_realpath_cmd || return 2

    echo $(dirname $(realpath $1))
}
