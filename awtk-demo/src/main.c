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

