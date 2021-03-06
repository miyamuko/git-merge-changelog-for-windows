/* Test of logb() function.
   Copyright (C) 2010-2012 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* Written by Bruno Haible <bruno@clisp.org>, 2010.  */

#include <config.h>

#include <math.h>

#include "signature.h"
SIGNATURE_CHECK (logb, double, (double));

#include <float.h>

#include "macros.h"

volatile double x;
double y;

int
main ()
{
  /* Some particular values.  */
  x = 0.6;
  y = logb (x);
  ASSERT (y == -1.0);

  x = 1.2;
  y = logb (x);
  ASSERT (y == 0.0);

  x = 2.1;
  y = logb (x);
  ASSERT (y == 1.0);

  x = 3.9;
  y = logb (x);
  ASSERT (y == 1.0);

  x = 4.0;
  y = logb (x);
  ASSERT (y == (FLT_RADIX == 2 ? 2.0 : 1.0));

  x = 0.25;
  y = logb (x);
  ASSERT (y == (FLT_RADIX == 2 ? -2.0 : -1.0));

  return 0;
}
