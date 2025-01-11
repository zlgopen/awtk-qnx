# AWTK QNX 移植笔记

SDL 支持 QNX, AWTK 可以直接通过 SDL 支持 QNX，所以整个移植过程还是比较简单的。

## 1. Makefile 

QNX 应用程序，默认使用 makefile 进行编译，所以 AWTK 使用 makefile 进行编译。我们把需要的参数放到 awtk_common.mk 中，然后在 makefile 中引入 awtk_common.mk 即可。

## 2. 获取屏幕大小

> 为了调用 gui_app_start，需要获取屏幕大小，这里使用 screen 库获取屏幕大小。

```c
#include "tkc/types_def.h"
#include <screen/screen.h>

bool_t qnx_get_screen_size(int* w, int* h) {
  screen_context_t screen_ctx;
  int ret = screen_create_context(&screen_ctx, SCREEN_APPLICATION_CONTEXT);
  return_value_if_fail(ret == 0, FALSE);

  int count = 0;
  screen_get_context_property_iv(screen_ctx, SCREEN_PROPERTY_DISPLAY_COUNT, &count);
  screen_display_t *screen_disps = calloc(count, sizeof(screen_display_t));
  screen_get_context_property_pv(screen_ctx, SCREEN_PROPERTY_DISPLAYS, (void **)screen_disps);

  screen_display_t screen_disp = screen_disps[0];
  free(screen_disps);

  int dims[2] = { 0, 0 };
  screen_get_display_property_iv(screen_disp, SCREEN_PROPERTY_SIZE, dims);

  *w = dims[0];
  *h = dims[1];
  screen_destroy_context(screen_ctx);

  return TRUE;
}
```

## 3. 支持鼠标

SDL 虽热支持键盘，但是不支持鼠标，所以需要自己实现鼠标支持。我们需要在 awtk/3rd/SDL/src/video/qnx/video.c 的 pumpEvents 函数中添加鼠标事件处理。

```c
        case SCREEN_EVENT_POINTER: {
          int x = 0;
          int y = 0;
          int pressed = 0;
          SDL_Mouse *mouse = SDL_GetMouse();

          screen_get_event_property_iv(screen_ev, SCREEN_PROPERTY_DEVICE, &val);
          screen_get_event_property_iv(screen_ev, SCREEN_PROPERTY_POSITION, pair);
          x = pair[0];
          y = pair[1];
          screen_get_event_property_iv(screen_ev, SCREEN_PROPERTY_DISPLACEMENT, pair);
          pressed =  val;
          screen_get_event_property_iv(screen_ev, SCREEN_PROPERTY_MOUSE_HORIZONTAL_WHEEL, &val);
          screen_get_event_property_iv(screen_ev, SCREEN_PROPERTY_MOUSE_WHEEL, &val);
    
          if (prev_pressed == pressed) {
              SDL_SendMouseMotion(mouse->focus, mouse->mouseID, 0, x, y); 
          } else {
              prev_pressed = pressed;
              SDL_SendMouseButton(mouse->focus, mouse->mouseID, pressed ? SDL_PRESSED : SDL_RELEASED, 1); 
          }   
        }  
```

 没有在多点触控设备上测试，所以没有支持多点触控事件，如果需要支持多点触控事件，需要在 pumpEvents 函数中添加 SCREEN_EVENT_TOUCH 事件处理。具体实现方法可以参考 qnx800/source/src/apps/screen/tutorials/events/events.c。

## 4. 程序入口

QNX 应用程序的入口函数是 main，在 main 函数中调用 gui_app_start 即可。

```c
#include "awtk.h"

extern int gui_app_start(int lcd_w, int lcd_h);
extern bool_t qnx_get_screen_size(int* w, int* h);

int main(int argc, char* argv[]) {
  int lcd_w = 0;
  int lcd_h = 0;

  qnx_get_screen_size(&lcd_w, &lcd_h);

  assert(lcd_w > 0 && lcd_h > 0);
  gui_app_start(lcd_w, lcd_h);

  return 0;
}
```