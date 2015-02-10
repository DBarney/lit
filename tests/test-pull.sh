#!/bin/sh

LIT=`pwd`/lit
BASE=`pwd`/test-pull
export LIT_CONFIG=$BASE/config
APP_DIR=$BASE/app
rm -rf $BASE
mkdir $BASE
echo "database: $BASE/db.git" > $LIT_CONFIG
echo "storage: git" >> $LIT_CONFIG

export LUVI_APP=`pwd`/app
$LIT auth creationix || exit -1
$LIT up ws://localhost:4822 || exit -1

mkdir $APP_DIR
cp app/package.lua $APP_DIR
cd $APP_DIR
$LIT install || exit -1
cd -

APP_DIR=$BASE/app2

mkdir $APP_DIR
cp app/package.lua $APP_DIR
cd $APP_DIR
$LIT install || exit -1
cd -

$LIT down || exit -1

APP_DIR=$BASE/app3

mkdir $APP_DIR
cp app/package.lua $APP_DIR
cd $APP_DIR
$LIT install || exit -1
cd -