# x32 builds

### Motivation and Context
I use the debian x32 port on one of my machines, but #844 prevented building the userspace tools: no longer.

### Description
Patch 1 adds proper x32 handling to the SPL ISA (well, ABI) detection header – if both `__x86_64__` *and* `_ILP32` are defined, `_LP64` is *not*, whereas previously it *was*, which yielded [an error](https://github.com/openzfs/zfs/issues/844#issuecomment-260155030) later in the header (and, if that error was circumvented, segfaults in libuutil as it picked the wrong pointer/long types for its bit-twiddling magic).

Patch 2 adds a new `ZFS_TIME_T_FORMAT` config entry, which evaluates to `"l"` when `sizeof(time_t) == sizeof(long)` and `"ll"` otherwise and uses it in the two places using just `"l"` yielded warnings on x32.

This approach is heavy-handed and could be replaced by casting it to `[unsigned] long long` and formatting with `"ll"` in both of those places. Thoughts?

### How Has This Been Tested?
I've used the userspace tools for the better part of a week now, with all the usual create/destroy/send/receive/scrub operations working. `zfs-tests.sh` passes as well.

### Types of changes
- [x] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Performance enhancement (non-breaking change which improves efficiency)
- [ ] Code cleanup (non-breaking change which makes code smaller or more readable)
- [ ] Breaking change (fix or feature that would cause existing functionality to change)
- [ ] Documentation (a change to man pages or other documentation)

### Checklist:
- [x] My code follows the ZFS on Linux [code style requirements](https://github.com/zfsonlinux/zfs/blob/master/.github/CONTRIBUTING.md#coding-conventions).
- [ ] I have updated the documentation accordingly – AFAICT no documentation needs updating?
- [x] I have read the [**contributing** document](https://github.com/zfsonlinux/zfs/blob/master/.github/CONTRIBUTING.md).
- [ ] I have added [tests](https://github.com/zfsonlinux/zfs/tree/master/tests) to cover my changes – none needed.
- [x] I have run the ZFS Test Suite with this change applied.
