
function shocc__errcho(){ >&2 echo $@; }


# usage log_and_do <log_message> <command> <...>
function shocc__log_and_do()
{
    local date_format="[%Y-%m-%d_%H:%M:%S]"
    local log__success_color="$ColorGreen"
    local log__error_color="$ColorRed"
    local log__reset_color="$ColorReset"
    local log__message_color="$ColorBlue"

    local log__prefix="$log__message_color"
    local log__suffix="$log__reset_color"

    local message=$1
    shift

    echo -e ${log__prefix}$(date +$date_format)" ===>> $message ..."${log__suffix}

    if [ -v SHOCC__LOG_AND_DO__VERBOSE ]
    then
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
    echo -e ${log__prefix}$(date +$date_format)" ===>> $message ${status_message}"${log__suffix}"\n"
    return $command_result
}
