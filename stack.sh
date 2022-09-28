# A stack, using bash arrays.
# ---------------------------------------------------------------------------
# Based on: https://gist.github.com/bmc/1323553 by Brian Clapper (bmc) <bmc@clapper.org>

# Create a new stack.
#
# Usage: shocc__stack__new name
#
# Example: shocc__stack__new x
function shocc__stack__new
{
    : ${1?'Missing stack name'}

    if shocc__stack__exists $1
    then
        shocc__errcho "shocc__stack__new : error : Stack already exists -- $1"
        return 1
    fi

    eval "declare -ag _stack_$1"
    eval "declare -ig _stack_$1_i=1"

    return 0
}

# Destroy a stack
#
# Usage: shocc__stack__delete name
function shocc__stack__delete
{
    : ${1?'Missing stack name'}

    if ! shocc__stack__exists $1
    then
        shocc__errcho "shocc__stack__delete : error : No such stack -- $1"
        return 1
    fi

    eval "unset _stack_$1 _stack_$1_i"
    return 0
}

# Push one or more items onto a stack.
#
# Usage: shocc__stack__push stack item ...
function shocc__stack__push
{
    : ${1?'Missing stack name'}
    : ${2?'Missing item(s) to push'}

    if ! shocc__stack__exists $1
    then
        shocc__errcho "shocc__stack__push : error : No such stack -- $1"
        return 1
    fi

    stack=$1
    shift 1

    while (( $# > 0 ))
    do
        eval '_i=$'"_stack_${stack}_i"
        eval "_stack_${stack}[$_i]='$1'"
        eval "let _stack_${stack}_i+=1"
        shift 1
    done

    unset _i
    return 0
}

# Print a stack to stdout.
#
# Usage: shocc__stack__print name
function shocc__stack__print
{
    : ${1?'Missing stack name'}

    if shocc__stack__no_such_stack $1
    then
        shocc__errcho "shocc__stack__print : error : No such stack -- $1"
        return 1
    fi

    local tmp=""
    eval 'let _i=$'"_stack_$1_i"'-1'
    while (( $_i > 0 ))
    do
        eval 'e=$'"{_stack_$1[$_i]}"
	[[ "x$tmp" == "x" ]] && tmp="$e" || tmp="$tmp, $e"
        let _i=${_i}-1
    done
    echo "(" $tmp ")"
}

# Get the size of a stack
#
# Usage: shocc__stack__size name var
#
# Example:
#    shocc__stack__size mystack n
#    echo "Size is $n"
function shocc__stack__size
{
    : ${1?'Missing stack name'}

    if ! shocc__stack__exists $1
    then
        shocc__errcho "shocc__stack__size : error : No such stack -- $1"
        return 1
    fi
    eval 'echo $'"{#_stack_$1[*]}"
}

# Pop the top element from the stack.
#
# Usage: shocc__stack__pop name var
#
# Example:
#    shocc__stack__pop mystack top
#    echo "Got $top"
function shocc__stack__pop
{
    : ${1?'Missing stack name'}

    if ! shocc__stack__exists $1
    then
        shocc__errcho "shocc__stack__pop : error : No such stack -- $1"
        return 1
    fi

    eval 'let _i=$'"_stack_$1_i"
    if [[ "$_i" -eq 1 ]]
    then
        echo "Empty stack -- $1" >&2
        return 1
    fi

    let _i-=1
    eval 'echo $'"{_stack_$1[$_i]}"
    
    eval "unset _stack_$1[$_i]"
    eval "_stack_$1_i=$_i"
    unset _i
}

function shocc__stack__exists
{
    : ${1?'Missing stack name'}

    eval '[[ -v '"_stack_$1_i"' ]]'
}
