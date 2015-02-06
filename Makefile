#
# make file to automate cloning svn externals into the git based cesm repo.
#
CAM_SVN = https://svn-ccsm-models.cgd.ucar.edu/cam1/branches/newtesting/models/atm/cam
CISM_SVN = https://svn-ccsm-models.cgd.ucar.edu/glc/branches/newtesting
CICE_SVN = https://svn-ccsm-models.cgd.ucar.edu/cice/branches/newtesting
CLM_SVN = https://svn-ccsm-models.cgd.ucar.edu/clm2/branches/newtesting/models/lnd/clm
POP_SVN = https://svn-ccsm-models.cgd.ucar.edu/pop2/branches/newtesting
RTM_SVN = https://svn-ccsm-models.cgd.ucar.edu/rivrtm/branches/newtesting
PIO_SVN = https://parallelio.googlecode.com/svn/trunk_tags/pio1_9_10/pio
WW3_SVN = https://svn-ccsm-models.cgd.ucar.edu/ww3/branches/newtesting

# arbitrary starting point to speed up clones
SVN_HIST=65000
GIT_SVN_CLONE = git svn clone --no-follow-parent --no-minimize-url -r$(SVN_HIST):HEAD

SVN_CO = svn co

# NOTE(bja, 2015-01) can probably do smarter things with the clone
# command using --trunk, --tags, --branches to pull in CESM specific
# layout.

CI_GIT = https://github.com/CESM-Development/CoupledInfrastructure.git
MCT_GIT = https://github.com/MCSclimate/MCT.git


clone-svn : cam-svn cism-svn cice-svn clm-svn pop-svn rtm-svn pio-svn ww3-svn

cam-svn : FORCE
	$(SVN_CO) $(CAM_SVN) cesm/models/atm/cam

cism-svn : FORCE
	$(SVN_CO) $(CISM_SVN) cesm/models/glc/cism

cice-svn : FORCE
	$(SVN_CO) $(CICE_SVN) cesm/models/ice/cice

clm-svn : FORCE
	$(SVN_CO) $(CLM_SVN) cesm/models/lnd/clm

pop-svn : FORCE
	$(SVN_CO) $(POP_SVN) cesm/models/ocn/pop2

rtm-svn : FORCE
	$(SVN_CO) $(RTM_SVN) cesm/models/rof/rtm

pio-svn : FORCE
	$(SVN_CO) $(PIO_SVN) cesm/models/utils/pio

ww3-svn : FORCE
	$(SVN_CO) $(WW3_SVN) cesm/models/wav/ww3

# I think these were just one-off commands that don't have to be
# rerun, but I'm putting them here for documentation.
git-subtrees : coupled-infrastructure-git mct-git

coupled-infrastructure-git :
	git subtree add --prefix cesm $(CI_GIT) master

mct-git :
	git subtree add --prefix cesm/models/utils/mct $(MCT_GIT) NagFix_MCT_2.8.3

# null rule to force things to happen
FORCE :
