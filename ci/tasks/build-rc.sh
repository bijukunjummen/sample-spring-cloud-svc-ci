#!/usr/bin/env bash
set -e

export GRADLE_OPTS=-Dorg.gradle.native=false
version=`cat version/number`
cd repo
gradle assemble -Pversion=$version
gradle --full-stacktrace --parallel --no-daemon assemble -Pversion=$version -Dmaven.repo.local=../m2/rootfs/opt/m2
cp build/libs/*.jar ../build/

ls ../build
