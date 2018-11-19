#!/bin/sh
set -e

#
# Function to ensure a variable is set
# parameter 1: variable value
# parameter 2: variable name
# parameter 3: example value
#
function checkVar() {

if [ -z ${1} ]; then
  echo "ENVIRONMENT VAR [$2] not set, set it on the run command with:"
  echo "-e \"$2=$3\"."
  echo "Exiting.";
  exit 1;
else
  echo "VAR $2 = '${1}'";
fi

}
###################################################################
#                      Runtime validation                         #
###################################################################
checkVar "${PULL_TAG}" "PULL_TAG" "busybox:latest"
checkVar "${OUTPUT_FILE}" "OUTPUT_FILE" "/tmp/images/busybox.tar"


###################################################################
# Runtime replacement of configuration prior to launching dockerd #
###################################################################

# Replace Insecure Registries - no certficiate verification
sed -i "s/INSECURE_REGS/${INSECURE_REGS}/g" /etc/docker/daemon.json

###################################################################
#                      Run dockerd                                #
###################################################################
dockerd &

while ! ps aux | grep -v "grep" | grep -q "dockerd" ; do
 echo "***********************WAITING FOR DOCKER TO START***********************";
 sleep 2;
done
echo "***********************DOCKER STARTED***********************"

###################################################################
#                      Pull and save the image                    #
###################################################################
docker pull "${PULL_TAG}"

echo "Saving file to: ${OUTPUT_FILE}"

docker save -o "${OUTPUT_FILE}" "${PULL_TAG}"