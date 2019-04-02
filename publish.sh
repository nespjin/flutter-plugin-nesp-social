#!/bin/bash
LOCAL_PATH=$(cd `dirname $0`; pwd)
cd $LOCAL_PATH

flutter packages pub publish --dry-run

flutter packages pub publish

