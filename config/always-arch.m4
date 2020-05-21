dnl #
dnl # Set the target arch for libspl atomic implementation and the icp
dnl #
AC_DEFUN([ZFS_AC_CONFIG_ALWAYS_ARCH], [
	AC_MSG_CHECKING(for target asm dir)
	TARGET_ARCH=`echo ${target_cpu} | sed -e s/i.86/i386/`

	case $TARGET_ARCH in
	i386|x86_64)
		TARGET_ASM_DIR=asm-${TARGET_ARCH}
		;;
	*)
		TARGET_ASM_DIR=asm-generic
		;;
	esac

	AC_SUBST([TARGET_ASM_DIR])
	AM_CONDITIONAL([TARGET_ASM_X86_64], test $TARGET_ASM_DIR = asm-x86_64)
	AM_CONDITIONAL([TARGET_ASM_I386], test $TARGET_ASM_DIR = asm-i386)
	AM_CONDITIONAL([TARGET_ASM_GENERIC], test $TARGET_ASM_DIR = asm-generic)
	AC_MSG_RESULT([$TARGET_ASM_DIR])
])

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
AC_DEFUN([ZFS_AC_GUESS_TIME_T_FORMAT],
[
  AC_COMPILE_IFELSE(
    [AC_LANG_SOURCE(
      [[#include <time.h>
        typedef char sizeof_time_t_eq_sizeof_long[(sizeof(time_t) == sizeof(long)) ? 1 : -1];
      ]])],
    [time_t_format="l"],
    [time_t_format="ll"])

  AC_DEFINE(TIME_T_FORMAT, "$time_t_format",
    ["l" if sizeof(time_t) == sizeof(long) or "ll" if sizeof(time_t) == sizeof(long long)])
])
