#!/usr/bin/env bash
set -ex

REPO_HOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../.." && pwd )"
export GRADLE_USER_HOME=$REPO_HOME/../gradle
echo "Gradle Home: ${GRADLE_USER_HOME}"

if [ "$1" == "init" ]; then
	mkdir -p $GRADLE_USER_HOME
fi

ls -al $GRADLE_USER_HOME

cd repo
./gradlew clean build --project-cache-dir $GRADLE_USER_HOME
cd ..
tar -C gradle -cf rootfs.tar .
mv rootfs.tar ../to-push