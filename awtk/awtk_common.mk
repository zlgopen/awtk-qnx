MAKEFILE_PATH := $(lastword $(MAKEFILE_LIST))
MAKEFILE_DIR := $(dir $(MAKEFILE_PATH))

AWTK_DIR=$(MAKEFILE_DIR)/awtk
MINIZ_SRCS = $(call rwildcard, awtk/3rd/miniz, c)
LIBUNIBREAK_SRCS = $(call rwildcard, awtk/3rd/libunibreak, c)
TKC_SRCS = $(call rwildcard, awtk/src/tkc, c)
BASE_SRCS = $(call rwildcard, awtk/src/base, c)
LAYOUTERS_SRCS = $(call rwildcard, awtk/src/layouters, c)
WIDGETS_SRCS = $(call rwildcard, awtk/src/widgets, c)
UI_LOADER_SRCS = $(call rwildcard, awtk/src/ui_loader, c)
XML_SRCS = $(call rwildcard, awtk/src/xml, c)
SVG_SRCS = $(call rwildcard, awtk/src/svg, c)
CLIP_BOARD_SRCS = $(call rwildcard, awtk/src/clip_board, c)
FONT_LOADER_SRCS = $(call rwildcard, awtk/src/font_loader, c)
GRAPHIC_BUFFER_SRCS = $(call rwildcard, awtk/src/graphic_buffer, c)
EXT_WIDGETS_SRCS_C = $(wildcard awtk/src/ext_widgets/*/*.c) awtk/src/ext_widgets/ext_widgets.c
CUSTOM_WIDGETS_SRC_C = $(wildcard awtk/src/custom_widgets/*/*.c)
CUSTOM_WIDGETS_SRC_CC = $(wildcard awtk/src/custom_widgets/*/*.cc)
CUSTOM_WIDGETS_SRC_CPP = $(wildcard awtk/src/custom_widgets/*/*.cpp)
CUSTOM_WIDGETS_SRC_CXX = $(wildcard awtk/src/custom_widgets/*/*.cxx)

WIDGET_ANIMATORS_SRCS = $(call rwildcard, awtk/src/widget_animators, c)
WINDOW_ANIMATORS_SRCS = $(call rwildcard, awtk/src/window_animators, c)
DIALOG_HIGHLIGHTERS_SRCS = $(call rwildcard, awtk/src/dialog_highlighters, c)
UBJSON_SRCS = $(call rwildcard, awtk/src/ubjson, c)
STREAMS_BUFFERED_SRCS = $(call rwildcard, awtk/src/streams/buffered, c)
STREAMS_MEM_SRCS = $(call rwildcard, awtk/src/streams/mem, c)
STREAMS_FILE_SRCS = $(call rwildcard, awtk/src/streams/file, c)
STREAMS_SERIAL_SRCS = $(call rwildcard, awtk/src/streams/serial, c)
STREAMS_SRCS = $(call rwildcard, awtk/src/streams, c)
CSV_SRCS = $(call rwildcard, awtk/src/csv, c)
CONF_IO_SRCS = $(call rwildcard, awtk/src/conf_io, c)
FSCRIPT_EXT_SRCS = $(call rwildcard, awtk/src/fscript_ext, c)
CHARSET_SRCS = $(call rwildcard, awtk/src/charset, c)
BLEND_SRCS = $(call rwildcard, awtk/src/blend, c)

SDL_SRCS=$(wildcard awtk/3rd/SDL/src/atomic/*.c) \
    $(wildcard awtk/3rd/SDL/src/audio/directsound/*.c) \
    $(wildcard awtk/3rd/SDL/src/audio/disk/*.c) \
    $(wildcard awtk/3rd/SDL/src/audio/dummy/*.c) \
    $(wildcard awtk/3rd/SDL/src/audio/*.c) \
    $(wildcard awtk/3rd/SDL/src/audio/winmm/*.c) \
    $(wildcard awtk/3rd/SDL/src/audio/wasapi/*.c) \
    $(wildcard awtk/3rd/SDL/src/core/unix/*.c) \
    $(wildcard awtk/3rd/SDL/src/cpuinfo/*.c) \
    $(wildcard awtk/3rd/SDL/src/events/*.c) \
    $(wildcard awtk/3rd/SDL/src/file/*.c) \
    $(wildcard awtk/3rd/SDL/src/filesystem/unix/*.c) \
    $(wildcard awtk/3rd/SDL/src/libm/*.c) \
    $(wildcard awtk/3rd/SDL/src/loadso/dummy/*.c) \
    $(wildcard awtk/3rd/SDL/src/power/*.c) \
    $(wildcard awtk/3rd/SDL/src/render/direct3d/*.c) \
    $(wildcard awtk/3rd/SDL/src/render/direct3d11/*.c) \
    $(wildcard awtk/3rd/SDL/src/render/opengl/*.c) \
    $(wildcard awtk/3rd/SDL/src/render/opengles2/*.c) \
    $(wildcard awtk/3rd/SDL/src/render/software/*.c) \
    $(wildcard awtk/3rd/SDL/src/render/*.c) \
    $(wildcard awtk/3rd/SDL/src/stdlib/*.c) \
    $(wildcard awtk/3rd/SDL/src/thread/generic/SDL_syscond.c) \
    $(wildcard awtk/3rd/SDL/src/thread/SDL_thread.c) \
    $(wildcard awtk/3rd/SDL/src/thread/pthread/*.c) \
    $(wildcard awtk/3rd/SDL/src/timer/SDL_timer.c) \
    $(wildcard awtk/3rd/SDL/src/timer/unix/*.c) \
    $(wildcard awtk/3rd/SDL/src/video/dummy/*.c) \
    $(wildcard awtk/3rd/SDL/src/video/qnx/*.c) \
    $(wildcard awtk/3rd/SDL/src/video/*.c) \
    $(wildcard awtk/3rd/SDL/src/video/yuv2rgb/*.c) \
    $(wildcard awtk/3rd/SDL/src/*.c)

ifdef WITH_NANOVG_AGGE
SDL_GL_FLAGS = -DSDL_VIDEO_OPENGL_EGL -DSDL_VIDEO_OPENGL_ES2 
AWTK_VGCANVAS_FLAGS=-DWITH_NANOVG_AGGE
AWTK_VGCANVAS_SRCS=awtk/src/vgcanvas/vgcanvas_nanovg_soft.c \
  awtk/src/lcd/lcd_sdl2.c \
  $(wildcard awtk/3rd/nanovg/base/*.c) \
  $(wildcard awtk/3rd/nanovg/agge/*.cpp) \
  $(wildcard awtk/3rd/agge/agge/*.cpp) 
AWTK_NANOVG_INCLUDES=-I${AWTK_DIR}/3rd/nanovg/base -I${AWTK_DIR}/3rd/nanovg/agge -I${AWTK_DIR}/3rd/agge 
else
SDL_GL_FLAGS = -DSDL_VIDEO_OPENGL_EGL -DSDL_VIDEO_OPENGL_ES2 
AWTK_VGCANVAS_FLAGS=-DWITH_GPU -DWITH_VGCANVAS_LCD \
										-DWITH_NANOVG_PLUS_GPU -DWITH_NANOVG_GPU -DWITH_GPU_GL \
										-DWITH_GPU_GLES2 -DNVGP_GLES2

AWTK_VGCANVAS_SRCS=awtk/src/vgcanvas/vgcanvas_nanovg_plus.c \
  awtk/src/lcd/lcd_nanovg.c \
  $(wildcard awtk/3rd/nanovg_plus/base/*.c) \
  $(wildcard awtk/3rd/nanovg_plus/gl/*.c) 
AWTK_NANOVG_INCLUDES=-I${AWTK_DIR}/3rd/nanovg_plus/base -I${AWTK_DIR}/3rd/nanovg_plus/gl
endif


SDL_FLAGS= -DSDL_TIMER_UNIX  -DSDL_LOADSO_DLOPEN \
					 -DSDL_STATIC_LIB -D__FLTUSED__ \
					 -DSDL_REAL_API -DSDL_HAPTIC_DISABLED -DSDL_SENSOR_DISABLED -DSDL_JOYSTICK_DISABLED \
					 -DHAVE_MALLOC -DSDL_AUDIO_DRIVER_DUMMY -DSDL_VIDEO_DRIVER_QNX -DSDL_AUDIO_DISABLED 

AWTK_INCLUDES = -I$(AWTK_DIR)/src -I$(AWTK_DIR)/3rd -I$(AWTK_DIR)/src/ext_widgets -I${AWTK_DIR}/3rd/gpinyin/include \
								-I${AWTK_DIR}/3rd/libunibreak -I${AWTK_DIR}/ext_widgets -I${AWTK_DIR}/custom_widgets \
								-I${AWTK_DIR}/3rd/SDL/src -I${AWTK_DIR}/3rd/SDL/include -I${AWTK_DIR}/3rd/SDL/khronos \
								${AWTK_NANOVG_INCLUDES} \
								-I${AWTK_DIR}/3rd/nanovg

AWTK_BASE_SRCS=${MINIZ_SRCS} ${LIBUNIBREAK_SRCS} ${TKC_SRCS} ${BASE_SRCS} ${LAYOUTERS_SRCS}  ${WIDGETS_SRCS} \
					${UI_LOADER_SRCS} ${XML_SRCS} ${SVG_SRCS} ${CLIP_BOARD_SRCS} ${FONT_LOADER_SRCS} \
					${GRAPHIC_BUFFER_SRCS} ${EXT_WIDGETS_SRCS_C} ${CUSTOM_WIDGETS_SRC_C}  ${CUSTOM_WIDGETS_SRC_CC} \
					${CUSTOM_WIDGETS_SRC_CPP} ${CUSTOM_WIDGETS_SRC_CXX} ${} ${} \
					${WIDGET_ANIMATORS_SRCS} ${WINDOW_ANIMATORS_SRCS} ${DIALOG_HIGHLIGHTERS_SRCS} ${UBJSON_SRCS} \
					${STREAMS_BUFFERED_SRCS} ${STREAMS_MEM_SRCS} ${STREAMS_FILE_SRCS} ${STREAMS_SERIAL_SRCS} \
					${CSV_SRCS} ${CONF_IO_SRCS} ${FSCRIPT_EXT_SRCS} ${CHARSET_SRCS} ${BLEND_SRCS}  

AWTK_3RD_SRCS=$(call rwildcard, awtk/3rd/gpinyin/src, cpp) \
							$(call rwildcard, awtk/3rd/libunibreak, c) \
							${SDL_SRCS}

AWTK_COMMON_SRCS= ${AWTK_BASE_SRCS} \
	$(call rwildcard, awtk/src/streams/inet, c) \
	$(call rwildcard, awtk/src/image_loader, c) \
	$(call rwildcard, awtk/src/platforms/pc, c) \
	${AWTK_VGCANVAS_SRCS} \
  awtk/src/awtk_global.c \
	awtk/src/main_loop/main_loop_sdl.c \
	awtk/src/main_loop/main_loop_simple.c \
	awtk/src/native_window/native_window_sdl.c \
  awtk/src/input_engines/input_engine_pinyin.cpp \
  awtk/src/input_methods/input_method_creator.c \
  awtk/src/window_manager/window_manager_default.c \
  awtk/src/streams/stream_factory.c \
  $(wildcard awtk/src/lcd/lcd_mem*.c) 

AWTK_SRCS=${AWTK_COMMON_SRCS}

AWTK_COMMON_FLAGS=-DWITH_ASSET_LOADER  -DWITH_STB_FONT -DWITHOUT_GLAD \
								-DSTBTT_STATIC -DSTB_IMAGE_STATIC -DWITH_STB_IMAGE \
								-DWITH_VGCANVAS -DWITH_UNICODE_BREAK -DWITH_DESKTOP_STYLE \
								-DHAS_PTHREAD -DHAS_GET_TIME_US64=1 \
								-DWITH_DATA_READER_WRITER=1 -DWITH_SOCKET=1 -DLINUX=1 -DQNX=1 \
								-DWITHOUT_NATIVE_FILE_DIALOG=1 -DUSE_GUI_MAIN=1 \
								-DWITH_IME_PINYIN=1 -DHAS_STDIO=1 -DWITH_SDL=1 \
								${AWTK_VGCANVAS_FLAGS} \
								${SDL_FLAGS}
								



