//
// Included Files
//
#include <stdlib.h>

#include "device.h"
#include "driverlib.h"

#include "device_init.h"

int main() {
  volatile int i = 1;
  dummy_fcn(i);
  float a = 0.98;
  i = a * 9;
  return 0;
}
