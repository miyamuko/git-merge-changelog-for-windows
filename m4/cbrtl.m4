# cbrtl.m4 serial 3
dnl Copyright (C) 2012 Free Software Foundation, Inc.
dnl This file is free software; the Free Software Foundation
dnl gives unlimited permission to copy and/or distribute it,
dnl with or without modifications, as long as this notice is preserved.

AC_DEFUN([gl_FUNC_CBRTL],
[
  m4_divert_text([DEFAULTS], [gl_cbrtl_required=plain])
  AC_REQUIRE([gl_MATH_H_DEFAULTS])
  AC_REQUIRE([gl_LONG_DOUBLE_VS_DOUBLE])
  AC_REQUIRE([gl_FUNC_CBRT])

  dnl Persuade glibc <math.h> to declare cbrtl().
  AC_REQUIRE([gl_USE_SYSTEM_EXTENSIONS])

  dnl Test whether cbrtl() exists. Assume that cbrtl(), if it exists, is
  dnl defined in the same library as cbrt().
  save_LIBS="$LIBS"
  LIBS="$LIBS $CBRT_LIBM"
  AC_CHECK_FUNCS([cbrtl])
  LIBS="$save_LIBS"
  if test $ac_cv_func_cbrtl = yes; then
    CBRTL_LIBM="$CBRT_LIBM"
    dnl Also check whether it's declared.
    dnl IRIX 6.5 has cbrtl() in libm but doesn't declare it in <math.h>.
    AC_CHECK_DECL([cbrtl], , [HAVE_DECL_CBRTL=0], [[#include <math.h>]])
    m4_ifdef([gl_FUNC_CBRTL_IEEE], [
      if test $gl_cbrtl_required = ieee && test $REPLACE_CBRTL = 0; then
        AC_CACHE_CHECK([whether cbrtl works according to ISO C 99 with IEC 60559],
          [gl_cv_func_cbrtl_ieee],
          [
            save_LIBS="$LIBS"
            LIBS="$LIBS $CBRTL_LIBM"
            AC_RUN_IFELSE(
              [AC_LANG_SOURCE([[
#ifndef __NO_MATH_INLINES
# define __NO_MATH_INLINES 1 /* for glibc */
#endif
#include <math.h>
]gl_LONG_DOUBLE_MINUS_ZERO_CODE[
]gl_LONG_DOUBLE_SIGNBIT_CODE[
static long double dummy (long double x) { return 0; }
int main (int argc, char *argv[])
{
  extern
  #ifdef __cplusplus
  "C"
  #endif
  long double cbrtl (long double);
  long double (*my_cbrtl) (long double) = argc ? cbrtl : dummy;
  long double f;
  /* Test cbrtl(-0.0).
     This test fails on IRIX 6.5.  */
  f = my_cbrtl (minus_zerol);
  if (!(f == 0.0L) || (signbitl (minus_zerol) && !signbitl (f)))
    return 1;
  return 0;
}
              ]])],
              [gl_cv_func_cbrtl_ieee=yes],
              [gl_cv_func_cbrtl_ieee=no],
              [gl_cv_func_cbrtl_ieee="guessing no"])
            LIBS="$save_LIBS"
          ])
        case "$gl_cv_func_cbrtl_ieee" in
          *yes) ;;
          *) REPLACE_CBRTL=1 ;;
        esac
      fi
    ])
  else
    HAVE_CBRTL=0
    HAVE_DECL_CBRTL=0
  fi
  if test $HAVE_CBRTL = 0 || test $REPLACE_CBRTL = 1; then
    dnl Find libraries needed to link lib/cbrtl.c.
    if test $HAVE_SAME_LONG_DOUBLE_AS_DOUBLE = 1; then
      CBRTL_LIBM="$CBRT_LIBM"
    else
      AC_REQUIRE([gl_FUNC_FREXPL])
      AC_REQUIRE([gl_FUNC_LDEXPL])
      CBRTL_LIBM=
      dnl Append $FREXPL_LIBM to CBRTL_LIBM, avoiding gratuitous duplicates.
      case " $CBRTL_LIBM " in
        *" $FREXPL_LIBM "*) ;;
        *) CBRTL_LIBM="$CBRTL_LIBM $FREXPL_LIBM" ;;
      esac
      dnl Append $LDEXPL_LIBM to CBRTL_LIBM, avoiding gratuitous duplicates.
      case " $CBRTL_LIBM " in
        *" $LDEXPL_LIBM "*) ;;
        *) CBRTL_LIBM="$CBRTL_LIBM $LDEXPL_LIBM" ;;
      esac
    fi
  fi
  AC_SUBST([CBRTL_LIBM])
])
