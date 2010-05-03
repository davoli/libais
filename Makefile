VERSION:=${shell cat VERSION}

#CXXFLAGS += -O3 -funroll-loops -fexpensive-optimizations -DNDEBUG
#CXXFLAGS += -ffast-math 

CXXFLAGS += -g3 -O0
CXXFLAGS += -D_GLIBCXX_DEBUG
CXXFLAGS := -Wall
CXXFLAGS += -Wimplicit 
CXXFLAGS += -pedantic 
CXXFLAGS += -W 
CXXFLAGS += -Wredundant-decls
CXXFLAGS += -Werror


SRCS:= ais.cpp ais123.cpp ais4_11.cpp ais5.cpp
OBJS:=${SRCS:.cpp=.o}

default:
	@echo
	@echo
	@echo "        Welcome to libais ${VERSION}"
	@echo
	@echo "Build options:"
	@echo
	@echo "  clean    - remove all objects and executables"
	@echo "  all      - build everything"
	@echo "  tar      - create a release source tar using VERSION"
	@echo
	@echo "  python   - build the python module"
	@echo "  libais.a - build a static archive library"
	@echo 
	@echo "Read the README for more information"

all: python libais.a

DIST:=libais-${shell cat VERSION}
TAR:=${DIST}.tar
tar:
	rm -rf ${DIST}
	mkdir ${DIST}
	cp -p *.cpp *.h [A-Z]* ${DIST}/
	tar cf ${TAR} ${DIST}
	bzip2 -9 ${TAR}
	rm -rf ${DIST}


# Remove the NDEBUG that python tries to use
python:
	CFLAGS="-m32 -O0 -g -D_GLIBCXX_DEBUG -UNDEBUG" /sw/bin/python setup.py build

libais.a: ${OBJS}
	ls ${OBJS}
	ar rv $@ $?
	ranlib $@

clean:
	-rm -rf *.o build *.a