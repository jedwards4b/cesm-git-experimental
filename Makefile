#
# make file to automate cloning svn externals into the git based cesm repo.
#

CAM_SVN := $(shell perl -ne 'next LINE unless /^(.*)\s+(.*cam1.*)/; print "$$2 $$1"' SVN_EXTERNAL_DIRECTORIES) 
CISM_SVN :=$(shell perl -ne 'next LINE unless /^(.*)\s+(.*u\/glc.*)/; print "$$2 $$1"' SVN_EXTERNAL_DIRECTORIES) 
CICE_SVN :=$(shell perl -ne 'next LINE unless /^(.*)\s+(.*u\/cice.*)/; print "$$2 $$1"' SVN_EXTERNAL_DIRECTORIES) 
CLM_SVN := $(shell perl -ne 'next LINE unless /^(.*)\s+(.*clm2.*)/; print "$$2 $$1"' SVN_EXTERNAL_DIRECTORIES) 
POP_SVN := $(shell perl -ne 'next LINE unless /^(.*)\s+(.*u\/pop2.*)/; print "$$2 $$1"' SVN_EXTERNAL_DIRECTORIES) 
RTM_SVN :=$(shell perl -ne 'next LINE unless /^(.*)\s+(.*rivrtm.*)/; print "$$2 $$1"' SVN_EXTERNAL_DIRECTORIES) 
PIO_SVN := $(shell perl -ne 'next LINE unless /^(.*)\s+(.*parallelio.*)/; print "$$2 $$1"' SVN_EXTERNAL_DIRECTORIES) 
WW3_SVN := $(shell perl -ne 'next LINE unless /^(.*)\s+(.*u\/ww3.*)/; print "$$2 $$1"' SVN_EXTERNAL_DIRECTORIES) 


SVN_CO = svn co

# NOTE(bja, 2015-01) can probably do smarter things with the clone
# command using --trunk, --tags, --branches to pull in CESM specific
# layout.

CI_GIT := $(shell perl -ne 'next LINE unless /^(.*)\s+(.*CoupledInfrastructure.*)/; print "$$1 $$2"' SVN_EXTERNAL_DIRECTORIES) 
MCT_GIT := $(shell perl -ne 'next LINE unless /^(.*)\s+(.*MCT.*)/; print "$$1 $$2"' SVN_EXTERNAL_DIRECTORIES) 
CMAKE_GIT :=  $(shell perl -ne 'next LINE unless /^(.*)\s+(.*CMake_Fortran.*)/; print "$$1 $$2"' SVN_EXTERNAL_DIRECTORIES) 
GPTL_GIT := $(shell perl -ne 'next LINE unless /^(.*)\s+(.*jmrosinski.*)/; print "$$1 $$2"' SVN_EXTERNAL_DIRECTORIES) 

default: git-subtrees clone-svn
clone-svn : cam-svn cism-svn cice-svn clm-svn pop-svn rtm-svn pio-svn ww3-svn

cam-svn : FORCE
	$(SVN_CO) $(CAM_SVN)

cism-svn : FORCE
	$(SVN_CO) $(CISM_SVN) 

cice-svn : FORCE
	$(SVN_CO) $(CICE_SVN) 

clm-svn : FORCE
	$(SVN_CO) $(CLM_SVN) 

pop-svn : FORCE
	$(SVN_CO) $(POP_SVN) 

rtm-svn : FORCE
	$(SVN_CO) $(RTM_SVN) 

pio-svn : FORCE
	$(SVN_CO) $(PIO_SVN) 

ww3-svn : FORCE
	$(SVN_CO) $(WW3_SVN) 

# I think these were just one-off commands that don't have to be
# rerun, but I'm putting them here for documentation.
git-subtrees : coupled-infrastructure-git mct-git cmake-git gptl-git

coupled-infrastructure-git :
	git subtree add --prefix  $(CI_GIT) 

mct-git :
	git subtree add --prefix $(MCT_GIT) 

cmake-git :
	git subtree add --prefix $(CMAKE_GIT) 

gptl-git :
	git subtree add --prefix $(GPTL_GIT) 

# null rule to force things to happen
FORCE :
