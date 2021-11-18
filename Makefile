.PHONY: all
all: build

.PHONY: test
test:
	python mirny_sim.py

.PHONY: build
build: build/mirny.vm6

build/mirny.vm6: mirny.py mirny_cpld.py
	python mirny_impl.py

.PHONY: legacy-almazny
legacy-almazny: mirny.py mirny_cpld.py
	python mirny_impl.py --legacy-almazny

REV:=$(shell git describe --always --abbrev=8 --dirty)

.PHONY: release
release: build/mirny.vm6
	cd build; tar czvf mirny_$(REV).tar.gz \
		mirny.v mirny.ucf mirny.xst \
		mirny.vm6 mirny.jed mirny.isc \
		mirny.tim mirny.rpt \
		mirny.pad mirny_pad.csv
