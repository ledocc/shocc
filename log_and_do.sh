
function shocc__log_and_do__is_verbose()
{
    if [ -v SHOCC__LOG_AND_DO__VERBOSE ]
    then
	echo 1
    else
	echo 0
    fi
}

function shocc__to_enable_disable()
{
    [[ $# -eq 0 ]] && return 1
    [[ $1 -eq 0 ]] && echo disable && return 0
    [[ $1 -eq 1 ]] && echo enable && return 0
    return 2
}

function shocc__log_and_do__set_verbose()
{
    local prev_verbosity=$(shocc__log_and_do__is_verbose)

    if [[ $# -gt 0 ]] && [[ $1 -gt 0 ]]
    then
	export SHOCC__LOG_AND_DO__VERBOSE
    else
	unset SHOCC__LOG_AND_DO__VERBOSE
    fi

    local new_verbosity=$(shocc__log_and_do__is_verbose)


    if [[ ${prev_verbosity} != ${new_verbosity} ]]
    then
	echo "shocc__log_and_do verbosity changed : $(shocc__to_enable_disable ${new_verbosity})."
    fi
}


# usage log_and_do <log_message> <command> <...>
function shocc__log_and_do()
{
    local log__success_color="$ColorGreen"
    local log__error_color="$ColorRed"


    local message=$1
    shift

    shocc__log " ===>> $message ..."

    local is_verbose=$(shocc__log_and_do__is_verbose)
    if [[ ${is_verbose} -eq 1 ]]
    then
	echo $@
	$@
    else
	$@ > /dev/null 2>&1
    fi

    local command_result=$?
    if [[ $command_result == 0 ]]
    then
        local status_message="${log__success_color}Done"
    else
        local status_message="${log__error_color}Failed"
    fi
    shocc__log " ===>> $message ${status_message}"
    echo -e "\n"

    return $command_result
}
