#!/usr/bin/env bash
set -ex

export GRADLE_OPTS=-Dorg.gradle.native=false
export GRADLE_USER_HOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../../../../gradle/rootfs" && pwd )"
echo "GRADLE_USER_HOME: ${GRADLE_USER_HOME}"
ls -al ${GRADLE_USER_HOME}

cd repo
gradle --full-stacktrace --parallel --no-daemon build sonarqube -Dsonar.host.url=$SONAR_URL -Dsonar.verbose=true
