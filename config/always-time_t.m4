dnl #
dnl # Set TIME_T_FORMAT to the modifiers to %d or %u required to format a time_t.
dnl #
dnl # This means "l"  if sizeof(time_t) == sizeof(long),
dnl #        and "ll" if sizeof(time_t) == sizeof(long long).
dnl #
dnl # In practice, these are the only viable types,
dnl # so the second check can be omitted entirely.
dnl #
AC_DEFUN([ZFS_AC_CONFIG_ALWAYS_TIME_T_FORMAT],
[
  AC_COMPILE_IFELSE(
    [AC_LANG_SOURCE(
      [[#include <time.h>
        typedef char sizeof_time_t_eq_sizeof_long[(sizeof(time_t) == sizeof(long)) ? 1 : -1];
      ]])],
    [time_t_format="l"],
    [time_t_format="ll"])

  AC_DEFINE_UNQUOTED(ZFS_TIME_T_FORMAT, ["$time_t_format"],
    [Argument to %d/%u to format a time_t -- "l" if sizeof(time_t) == sizeof(long) or "ll" otherwise])
])
