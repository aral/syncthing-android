#!/bin/sh

cd "./syncthing"

echo "Setting GOPATH, GOROOT and GOBIN..."
export GOPATH=$(pwd)/gopath
mkdir -p $GOPATH/root
export GOROOT=$GOPATH/root
mkdir -p $GOPATH/bin
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN
echo "Installing godep..."
go get github.com/tools/godep
echo "Installing go vet..."
go get code.google.com/p/go.tools/cmd/vet
echo "Creating a symbolic link..."
mkdir -p $GOPATH/src/github.com/calmh
rm -f $GOPATH/src/github.com/calmh/syncthing
ln -s $(pwd) $GOPATH/src/github.com/calmh/syncthing

rm -f syncthing syncthing-x86 syncthing-armeabi-v7a syncthing-armeabi syncthing-mips

export GOOS=linux

export GOARCH=386

./build.sh
mv syncthing syncthing-x86

export GOARCH=arm

export GOARM=7
build
mv syncthing syncthing-armeabi-v7a

export GOARM=5
build
mv syncthing syncthing-armeabi

export GOARCH=mips
build
mv syncthing syncthing-mips
