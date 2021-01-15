PWD=$(shell pwd)

ENTRYJS_HOME = $(PWD)/../entryjs
ENTRYHW_HOME = $(PWD)/../entry-hw

ENTRYJS_MODULE_HOME=$(PWD)/node_modules/entry-js
ENTRYHW_MODULE_HOME=$(PWD)/node_modules/entry-hw

NSIS_BIN = "$(shell cygpath -u "C:\Program Files (x86)\NSIS")"


all: entryjs entryhw dist setup

dist:
	@yarn dist:win

setup:
	@cd build && $(NSIS_BIN)/makensis.exe /V3 entryx64.nsi
	@cd build && $(NSIS_BIN)/makensis.exe /V3 entryx86.nsi
	
entryjs:
	@cd $(ENTRYJS_HOME) && $(ENTRYJS_HOME)/scripts/build.sh 
	@cd $(ENTRYJS_HOME) && rsync -aR build $(ENTRYJS_MODULE_HOME)
	
entryhw:
	@cd $(ENTRYHW_HOME) && $(ENTRYHW_HOME)/scripts/build.sh 
	@cd $(ENTRYHW_HOME) && rsync -aR build-base $(ENTRYHW_MODULE_HOME)


