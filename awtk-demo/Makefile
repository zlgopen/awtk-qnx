ARTIFACT = awtk-demo

#Build architecture/variant string, possible values: x86, armv7le, etc...
PLATFORM ?= x86_64

#Build profile, possible values: release, debug, profile, coverage
BUILD_PROFILE ?= debug

CONFIG_NAME ?= $(PLATFORM)-$(BUILD_PROFILE)
OUTPUT_DIR = build/$(CONFIG_NAME)
TARGET = $(OUTPUT_DIR)/$(ARTIFACT)

#Compiler definitions

CC = qcc -Vgcc_nto$(PLATFORM)
CXX = q++ -Vgcc_nto$(PLATFORM)_cxx
LD = $(CC)

#User defined include/preprocessor flags and libraries

include ../awtk/awtk_common.mk

#INCLUDES += -I/path/to/my/lib/include
INCLUDES += ${AWTK_INCLUDES} 

#LIBS += -L/path/to/my/lib/$(PLATFORM)/usr/lib -lmylib
LIBS += -L../awtk/$(OUTPUT_DIR) -lawtk -lawtk3rd -lawtk -lEGL -lGLESv2 -lscreen -lsocket -lstdc++ -lm 

#Compiler flags for build profiles
CCFLAGS_release += -O2
CCFLAGS_debug += -g -O0 -fno-builtin
CCFLAGS_coverage += -g -O0 -ftest-coverage -fprofile-arcs
LDFLAGS_coverage += -ftest-coverage -fprofile-arcs
CCFLAGS_profile += -g -O0 -finstrument-functions
LIBS_profile += -lprofilingS

#Generic compiler flags (which include build type flags)
CCFLAGS_all += -Wall -fmessage-length=0
CCFLAGS_all += $(CCFLAGS_$(BUILD_PROFILE))
#Shared library has to be compiled with -fPIC
#CCFLAGS_all += -fPIC
LDFLAGS_all += $(LDFLAGS_$(BUILD_PROFILE))
LIBS_all += $(LIBS_$(BUILD_PROFILE))
DEPS = -Wp,-MMD,$(@:%.o=%.d),-MT,$@

#Macro to expand files recursively: parameters $1 -  directory, $2 - extension, i.e. cpp
rwildcard = $(wildcard $(addprefix $1/*.,$2)) $(foreach d,$(wildcard $1/*),$(call rwildcard,$d,$2))

#Source list
APP_DIR=awtk-demo-app
APP_SRCS_ROOT_C = $(wildcard ${APP_DIR}/src/*.c)
APP_SRCS_C = $(wildcard ${APP_DIR}/src/*/*.c)
APP_SRCS_CC = $(wildcard ${APP_DIR}/src/*/*.cc)
APP_SRCS_CPP = $(wildcard ${APP_DIR}/src/*/*.cpp)
APP_SRCS_CXX = $(wildcard ${APP_DIR}/src/*/*.cxx)
CCFLAGS_all += ${AWTK_COMMON_FLAGS}

SRCS = ${APP_SRCS_ROOT_C} ${APP_SRCS_C} ${APP_SRCS_CC} ${APP_SRCS_CXX} ${APP_SRCS_CPP} src/main.c

#Object files list
OBJS = $(addprefix $(OUTPUT_DIR)/,$(addsuffix .o, $(basename $(SRCS))))

#Compiling rule
$(OUTPUT_DIR)/%.o: %.c
	@mkdir -p $(dir $@)
	$(CC) -c $(DEPS) -o $@ $(INCLUDES) $(CCFLAGS_all) $(CCFLAGS) $<

#Linking rule
$(TARGET):$(OBJS)
	$(LD) -o $(TARGET) $(LDFLAGS_all) $(LDFLAGS) $(OBJS) $(LIBS_all) $(LIBS)

#Rules section for default compilation and linking
all: $(TARGET)

clean:
	rm -fr $(OUTPUT_DIR)

rebuild: clean all

#Inclusion of dependencies (object files to source and includes)
-include $(OBJS:%.o=%.d)
