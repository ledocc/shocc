
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
     
source ${SHOCC_DIR}/color.sh
source ${SHOCC_DIR}/get_this_script_dir.sh
source ${SHOCC_DIR}/log_and_do.sh
