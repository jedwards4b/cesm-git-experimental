#!/bin/csh -f

./Tools/ccsm_check_lockedfiles || exit -1

# NOTE - Are assumming that are already in $CASEROOT here
set CASE     = `./xmlquery CASE    -value`

./$CASE.build

