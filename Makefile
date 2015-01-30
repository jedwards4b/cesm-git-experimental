#
# make file to automate cloning svn externals into the git based cesm repo.
#
ATM_SVN = https://svn-ccsm-models.cgd.ucar.edu/cam1/branches/newtesting/models/atm/cam
GLC_SVN = https://svn-ccsm-models.cgd.ucar.edu/glc/branches/newtesting
ICE_SVN = https://svn-ccsm-models.cgd.ucar.edu/cice/branches/newtesting
LND_SVN = https://svn-ccsm-models.cgd.ucar.edu/clm2/branches/newtesting/models/lnd/clm
OCN_SVN = https://svn-ccsm-models.cgd.ucar.edu/pop2/branches/newtesting
ROF_SVN = https://svn-ccsm-models.cgd.ucar.edu/rivrtm/branches/newtesting
PIO_SVN = https://parallelio.googlecode.com/svn/trunk_tags/pio1_9_10/pio
WAV_SVN = https://svn-ccsm-models.cgd.ucar.edu/ww3/branches/newtesting

# arbitrary starting point to speed up clones
SVN_HIST=65000
GIT_SVN_CLONE = git svn clone --no-follow-parent --no-minimize-url -r$(SVN_HIST):HEAD
# NOTE(bja, 2015-01) can probably do smarter things with the clone
# command using --trunk, --tags, --branches to pull in CESM specific
# layout.

CI_GIT = https://github.com/CESM-Development/CoupledInfrastructure.git
MCT_GIT = https://github.com/MCSclimate/MCT.git


clone-svn : atm-svn glc-svn ice-svn lnd-svn ocn-svn rof-svn pio-svn wav-svn

atm-svn : FORCE
	$(GIT_SVN_CLONE) $(ATM_SVN) cesm/models/atm/cam

glc-svn : FORCE
	$(GIT_SVN_CLONE) $(GLC_SVN) cesm/models/glc/cism

ice-svn : FORCE
	$(GIT_SVN_CLONE) $(ICE_SVN) cesm/models/ice/cice

lnd-svn : FORCE
	$(GIT_SVN_CLONE) $(LND_SVN) cesm/models/lnd/clm

ocn-svn : FORCE
	$(GIT_SVN_CLONE) $(OCN_SVN) cesm/models/ocn/pop2

rof-svn : FORCE
	$(GIT_SVN_CLONE) $(RTM_SVN) cesm/models/rof/rtm

pio-svn : FORCE
	$(GIT_SVN_CLONE) $(PIO_SVN) cesm/models/utils/pio

wav-svn : FORCE
	$(GIT_SVN_CLONE) $(WAV_SVN) cesm/models/wav/ww3

# I think these were just one-off commands that don't have to be
# rerun, but I'm putting them here for documentation.
git-subtrees : coupled-infrastructure-git mct-git

coupled-infrastructure-git :
	git subtree add --prefix cesm $(CI_GIT) master

mct-git :
	git subtree add --prefix cesm/models/utils/mct $(MCT_GIT) NagFix_MCT_2.8.3

# null rule to force things to happen
FORCE :
