# time_t-format-string.m4
dnl Copyright (C) 2002-2020 Free Software Foundation, Inc.
dnl This file is free software; the Free Software Foundation
dnl gives unlimited permission to copy and/or distribute it,
dnl with or without modifications, as long as this notice is preserved.

dnl From nabijaczleweli.

dnl Sets the TIME_T_FORMAT variable to the modifiers
dnl to %d or %u required to C-style format a time_t from time.h.
dnl
dnl This means "l"  if sizeof(time_t) == sizeof(long),
dnl        and "ll" if sizeof(time_t) == sizeof(long long).
dnl In practice, these are the only viable types,
dnl so the second check can be omitted entirely.
AC_DEFUN([GUESS_TIME_T_FORMAT],
[
  AC_COMPILE_IFELSE(
    [AC_LANG_SOURCE(
      [[#include <time.h>
        typedef char sizeof_time_t_eq_sizeof_long[(sizeof(time_t) == sizeof(long)) ? 1 : -1];
      ]])],
    [TIME_T_FORMAT="l"],
    [TIME_T_FORMAT="ll"])

  AC_SUBST([TIME_T_FORMAT])
])
