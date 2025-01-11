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

