#!/bin/bash
#############################################################
#                                                           #
#                  Defining Commands                        #
#                                                           #
#############################################################

scriptName="MobileApp: Clean"

comments=()
commands=()

comments+=("NPM cache")
commands+=("sudo npm cache clean --force")

comments+=("Metro Data")
commands+=("rm -rf $TMPDIR/metro-*")

comments+=("Haste Data")
commands+=("rm -rf $TMPDIR/haste-*")

comments+=("Watchman delete all")
commands+=("watchman watch-del-all")

comments+=("Home Library Caches CocoaPods")
commands+=('rm -rf ~/Library/Caches/CocoaPods')

comments+=("Xcode DerivedData")
commands+=('rm -rf ~/Library/Developer/Xcode/DerivedData')

comments+=("ModuleCache")
commands+=('rm -rf "$(getconf DARWIN_USER_CACHE_DIR)/org.llvm.clang/ModuleCache"')

comments+=("Xcode Cache")
commands+=('rm -rf ~/Library/Caches/com.apple.dt.Xcode')

comments+=("Go into ios folder")
commands+=("cd ios")

comments+=("Pod cache --all")
commands+=('pod cache clean --all')

comments+=("Pod Clean")
commands+=('pod clean')

comments+=("Pod deintegrate")
commands+=("pod deintegrate")

comments+=("ios Builds")
commands+=("rm -rf build")

comments+=("Deleting xcworkspace")
commands+=("rm -rf Swosy.xcworkspace")

comments+=("Deleting Pods folder")
commands+=("rm -rf Pods")

comments+=("Deleting Podfile lock")
commands+=("rm Podfile.lock")

comments+=("Linking react-native-maps")
commands+=("cd ..")



#############################################################
#                    Arguments parsing                      #
#############################################################

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -ps|--percentagestart)
    PERCENTAGESTART="$2"
    shift # past argument
    shift # past value
    ;;
    -pe|--percentageend)
    PERCENTAGEEND="$2"
    shift # past argument
    shift # past value
    ;;
    -v|--verbose)
    VERBOSE="-v"
    shift # past argument
    ;;
    -h|--help)
    HELP=YES
    shift # past argument
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

if [[ -n $1 ]]; then
    echo "Unkown Argument: ${1}"
    echo "Use -h for Help"
    exit
fi

if [[ $HELP = YES ]]; then
    echo "Possible Parameters:"
    echo "-ps <1...100>      (Percentage Start: Default 1)"
    echo "-pe <1...100>      (Percentage End: Default 100)"
    echo "-v                 (Verbose: Shows output log)"
    echo "-h                 (Help: Shows this output)"
    exit
fi

PERCENTAGESTARTVARIABLE=${PERCENTAGESTART:-1}
PERCENTAGEENDVARIABLE=${PERCENTAGEEND:-100}
VERBOSEVARIABE=${VERBOSE:-" "}


#############################################################
#                    Progress Bar                           #
#############################################################
prog() {
    local w=80 percentagegiven=$1;  shift
    p=$((percentagegiven*(PERCENTAGEENDVARIABLE-PERCENTAGESTARTVARIABLE)/100+PERCENTAGESTARTVARIABLE))
    # print those dots on a fixed-width space plus the percentage etc.
    printf "\r\033[K| \e[32m%3d %%\e[0m | %s" "$(tput cols)" "" "$p" "$*";
}


#############################################################
#                  Verbose Mode Set                         #
#############################################################

VERBOSEMODE="&>/dev/null"
if [[ $VERBOSEVARIABE = "-v" ]]
then
    VERBOSEMODE=""
fi

run(){
    eval "$* ${VERBOSEMODE}"
}

#############################################################
#                                                           #
#                 Performing Commands                       #
#                                                           #
#############################################################

prog 1 ${scriptName}: Setup Start

commandsSize=${#commands[@]}
progressPercent=1

for i in "${!comments[@]}"; do
  prog ${progressPercent} ${scriptName}: ${comments[$i]}
  run ${commands[$i]}
  progressPercent=$((100*(i+1)/commandsSize))
done

prog 100 ${scriptName}: Setup Complete
echo ""

