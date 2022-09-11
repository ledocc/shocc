

function shocc__check_realpath_cmd()
{
    if [ ! -e $(which realpath_) ]
    then
        [ "$(uname)" == "Linux" ] && install_realpath_command="apt-get install coreutils"
        [ "$(uname)" == "Darwin" ] && install_realpath_command="brew install coreutils"

        echo "$(basename $0): error: realpath executable required."
        echo "    install it with : "${install_realpath_command}

        return 1
    fi
    return 0
}

function shocc__get_this_script_dir()
{
    shocc__check_realpath_cmd || exit 1

    echo $(dirname $(realpath $0))

    return 0
}
function shocc__get_this_script_name()
{
    echo $(basename $0)

    return 0
}
