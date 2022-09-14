
pshocc__log_message()
{
    local level=$1
    shift
    local message=$@

    case $level in
	info)
	    local prefix_color=$ColorBlue
	    local message_color=$ColorReset
	    ;;
	warning)
	    local prefix_color=$ColorBlue
	    local message_color=$ColorRed
	    ;;
	error)
	    local prefix_color=$ColorBlue
	    local message_color=$ColorBIRed
	    ;;
	*)
	    shocc__errcho "pshocc__log_message : error : unknown log level : \"${level}\"." && return 1
	    ;;
    esac

    local date_format="[%Y-%m-%d_%H:%M:%S]"
    local log__prefix="$prefix_color$(date +$date_format) -- $message_color"
    local log__suffix="$ColorReset"

    echo -e ${log__prefix}"$message"${log__suffix}
}

shocc__log()
{
    [[ $# -eq 0 ]] && shocc__errcho "shocc__log : error : no message provided." && return 1
    pshocc__log_message info "$@"
}

shocc__warn()
{
    [[ $# -eq 0 ]] && shocc__errcho "shocc__warn : error : no message provided." && return 1
    pshocc__log_message warning '$@'
}

shocc__error()
{
    [[ $# -eq 0 ]] && shocc__errcho "shocc__error : error : no message provided." && return 1
    pshocc__log_message error '$@'
}
