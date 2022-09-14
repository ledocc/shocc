
if [[ -v BASH_VERSION ]]
then
    SHOCC_DIR=$(realpath ${BASH_SOURCE[0]%/*})
elif [[ -v ZSH_VERSION ]]
then
     SHOCC_DIR=$(realpath $(dirname $0))
else
    echo "shell no supported. shocc only work with bash and zsh."
    return 1
fi

[[ "x${SHOCC__INCLUDE_GUARD}x" == "x1x" ]] && return 0

source ${SHOCC_DIR}/color.sh
source ${SHOCC_DIR}/errcho.sh
source ${SHOCC_DIR}/log.sh
source ${SHOCC_DIR}/log_and_do.sh
source ${SHOCC_DIR}/real_dirname.sh

SHOCC__INCLUDE_GUARD=1
