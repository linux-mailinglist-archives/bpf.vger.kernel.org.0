Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB43F37EF1E
	for <lists+bpf@lfdr.de>; Thu, 13 May 2021 01:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhELW7O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 May 2021 18:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239220AbhELVnE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 May 2021 17:43:04 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1034CC08C5C1
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 14:33:01 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id k15so6511645pgb.10
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 14:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Lz7fHseilMZIy8SoFfewCZeTFLpVCBh8QUkQsuz2vYI=;
        b=hQZJ8IlwH+ZsgLaGB5JFhP/VfgSW5CtLViP11yC74BbW/2mRCl01JUWX1j+Uld3IXp
         NI7ac4hLZsjDXmdaUU6EwTHHhIaII8l3kedPxjuDxpM8PAy1WofNRScvKbzztd5qJhNd
         VT+fcD48CbkFHMRAKxQnX/XoEzvXNj3oiIpBaFCONiEjJgNeupI20d8GM8xwDYpQJ8Oc
         4/2wb343Bsqiq5aTRKWjPYJytzmC13kymEQG2+yoc2DzDC65mKbvCDF/JkIOsRuYvQYi
         3Z6c6S9dYbSSPj/GYAbyO9qomWHXCpf6tVNJ6xBFSiVBfTNo3t2wBpoIfmYNOkKh9T9G
         Nu6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Lz7fHseilMZIy8SoFfewCZeTFLpVCBh8QUkQsuz2vYI=;
        b=HvtEEQfD8hP8+C2XplsPlwct949tgaq/p4CqyQY054VYD8ONjC/qZHjXgVxr/xNcR2
         MLRp/6Dp8e1nwtvuAWe8h3JV18U9atHaYflNEtqe0L1C4QdXUIM0/Hb6JV0iRzYED0kL
         ZMt+5oY0hKfM5E/ZCjHOYXahb2jslrWRxUj1nFAvvd6rUhAo8RvP2I7x+Ot0h5NcZShd
         PS9VBCQDLlsWSiJj4YJC90Cc2woVhBwOz8YaPfavicCxPgJEMkF8feiR/hx/kLP8qt2t
         A1WE4S749SPZNyJo7VTOHM8qbH5lK1UidNkewVJUByN/KvZM0VpCBDdxCKUUkSPKEICh
         LfeA==
X-Gm-Message-State: AOAM531Jm0jYJrDcO0YW0fCtX2gAoZYz4EaP+SRpkARlZX+PH16x5zdB
        FFD7Hnh8XBQT+O0F2Rwj0Zs=
X-Google-Smtp-Source: ABdhPJy9MjB09Nzl4OOEW45Etb0whpnLWm1UX/7Y2bMOq86mAU3957S4rr0MWMc+p472Bs7IixN+FA==
X-Received: by 2002:a63:5557:: with SMTP id f23mr38718087pgm.104.1620855180449;
        Wed, 12 May 2021 14:33:00 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.4])
        by smtp.gmail.com with ESMTPSA id c128sm609222pfa.189.2021.05.12.14.32.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 May 2021 14:32:59 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 bpf-next 00/21] bpf: syscall program, FD array, loader program, light skeleton.
Date:   Wed, 12 May 2021 14:32:35 -0700
Message-Id: <20210512213256.31203-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

v4->v5:
- addressed a bunch of minor comments from Andrii.
- the main difference is that lskel is now more robust in case of errors
  and a bit cleaner looking.

v3->v4:
- cleaned up closing of temporary FDs in case intermediate sys_bpf fails during
  execution of loader program.
- added support for rodata in the skeleton.
- enforce bpf_prog_type_syscall to be sleepable, since it needs bpf_copy_from_user
  to populate rodata map.
- converted test trace_printk to use lskel to test rodata access.
- various small bug fixes.

v2->v3: Addressed comments from Andrii and John.
- added support for setting max_entries after signature verification
  and used it in ringbuf test, since ringbuf's max_entries has to be updated
  after skeleton open() and before load(). See patch 20.
- bpf_btf_find_by_name_kind doesn't take btf_fd anymore.
  Because of that removed attach_prog_fd from bpf_prog_desc in lskel.
  Both features to be added later.
- cleaned up closing of fd==0 during loader gen by resetting fds back to -1.
- converted loader gen to use memset(&attr, cmd_specific_attr_size).
  would love to see this optimization in the rest of libbpf.
- fixed memory leak during loader_gen in case of enomem.
- support for fd_array kernel feature is added in patch 9 to have
  exhaustive testing across all selftests and then partially reverted
  in patch 15 to keep old style map_fd patching tested as well.
- since fentry_test/fexit_tests were extended with re-attach had to add
  support for per-program attach method in lskel and use it in the tests.
- cleanup closing of fds in lskel in case of partial failures.
- fixed numerous small nits.

v1->v2: Addressed comments from Al, Yonghong and Andrii.
- documented sys_close fdget/fdput requirement and non-recursion check.
- reduced internal api leaks between libbpf and bpftool.
  Now bpf_object__gen_loader() is the only new libbf api with minimal fields.
- fixed light skeleton __destroy() method to munmap and close maps and progs.
- refactored bpf_btf_find_by_name_kind to return btf_id | (btf_obj_fd << 32).
- refactored use of bpf_btf_find_by_name_kind from loader prog.
- moved auto-gen like code into skel_internal.h that is used by *.lskel.h
  It has minimal static inline bpf_load_and_run() method used by lskel.
- added lksel.h example in patch 15.
- replaced union bpf_map_prog_desc with struct bpf_map_desc and struct bpf_prog_desc.
- removed mark_feat_supported and added a patch to pass 'obj' into kernel_supports.
- added proper tracking of temporary FDs in loader prog and their cleanup via bpf_sys_close.
- rename gen_trace.c into gen_loader.c to better align the naming throughout.
- expanded number of available helpers in new prog type.
- added support for raw_tp attaching in lskel.
  lskel supports tracing and raw_tp progs now.
  It correctly loads all networking prog types too, but __attach() method is tbd.
- converted progs/test_ksyms_module.c to lskel.
- minor feedback fixes all over.

The description of V1 set is still valid:
----
This is a first step towards signed bpf programs and the third approach of that kind.
The first approach was to bring libbpf into the kernel as a user-mode-driver.
The second approach was to invent a new file format and let kernel execute
that format as a sequence of syscalls that create maps and load programs.
This third approach is using new type of bpf program instead of inventing file format.
1st and 2nd approaches had too many downsides comparing to this 3rd and were discarded
after months of work.

To make it work the following new concepts are introduced:
1. syscall bpf program type
A kind of bpf program that can do sys_bpf and sys_close syscalls.
It can only execute in user context.

2. FD array or FD index.
Traditionally BPF instructions are patched with FDs.
What it means that maps has to be created first and then instructions modified
which breaks signature verification if the program is signed.
Instead of patching each instruction with FD patch it with an index into array of FDs.
That makes the program signature stable if it uses maps.

3. loader program that is generated as "strace of libbpf".
When libbpf is loading bpf_file.o it does a bunch of sys_bpf() syscalls to
load BTF, create maps, populate maps and finally load programs.
Instead of actually doing the syscalls generate a trace of what libbpf
would have done and represent it as the "loader program".
The "loader program" consists of single map and single bpf program that
does those syscalls.
Executing such "loader program" via bpf_prog_test_run() command will
replay the sequence of syscalls that libbpf would have done which will result
the same maps created and programs loaded as specified in the elf file.
The "loader program" removes libelf and majority of libbpf dependency from
program loading process.

4. light skeleton
Instead of embedding the whole elf file into skeleton and using libbpf
to parse it later generate a loader program and embed it into "light skeleton".
Such skeleton can load the same set of elf files, but it doesn't need
libbpf and libelf to do that. It only needs few sys_bpf wrappers.

Future steps:
- support CO-RE in the kernel. This patch set is already too big,
so that critical feature is left for the next step.
- generate light skeleton in golang to allow such users use BTF and
all other features provided by libbpf
- generate light skeleton for kernel, so that bpf programs can be embeded
in the kernel module. The UMD usage in bpf_preload will be replaced with
such skeleton, so bpf_preload would become a standard kernel module
without user space dependency.
- finally do the signing of the loader program.

The patches are work in progress with few rough edges.

Alexei Starovoitov (21):
  bpf: Introduce bpf_sys_bpf() helper and program type.
  bpf: Introduce bpfptr_t user/kernel pointer.
  bpf: Prepare bpf syscall to be used from kernel and user space.
  libbpf: Support for syscall program type
  selftests/bpf: Test for syscall program type
  bpf: Make btf_load command to be bpfptr_t compatible.
  selftests/bpf: Test for btf_load command.
  bpf: Introduce fd_idx
  bpf: Add bpf_btf_find_by_name_kind() helper.
  bpf: Add bpf_sys_close() helper.
  libbpf: Change the order of data and text relocations.
  libbpf: Add bpf_object pointer to kernel_supports().
  libbpf: Preliminary support for fd_idx
  libbpf: Generate loader program out of BPF ELF file.
  libbpf: Cleanup temp FDs when intermediate sys_bpf fails.
  libbpf: Introduce bpf_map__initial_value().
  bpftool: Use syscall/loader program in "prog load" and "gen skeleton"
    command.
  selftests/bpf: Convert few tests to light skeleton.
  selftests/bpf: Convert atomics test to light skeleton.
  selftests/bpf: Convert test printk to use rodata.
  selftests/bpf: Convert test trace_printk to lskel.

 include/linux/bpf.h                           |  19 +-
 include/linux/bpf_types.h                     |   2 +
 include/linux/bpf_verifier.h                  |   1 +
 include/linux/bpfptr.h                        |  75 ++
 include/linux/btf.h                           |   2 +-
 include/uapi/linux/bpf.h                      |  38 +-
 kernel/bpf/bpf_iter.c                         |  13 +-
 kernel/bpf/btf.c                              |  70 +-
 kernel/bpf/syscall.c                          | 194 +++--
 kernel/bpf/verifier.c                         |  89 ++-
 net/bpf/test_run.c                            |  45 +-
 tools/bpf/bpftool/Makefile                    |   2 +-
 tools/bpf/bpftool/gen.c                       | 386 +++++++++-
 tools/bpf/bpftool/main.c                      |   7 +-
 tools/bpf/bpftool/main.h                      |   1 +
 tools/bpf/bpftool/prog.c                      | 107 ++-
 tools/bpf/bpftool/xlated_dumper.c             |   3 +
 tools/include/uapi/linux/bpf.h                |  38 +-
 tools/lib/bpf/Build                           |   2 +-
 tools/lib/bpf/bpf_gen_internal.h              |  41 ++
 tools/lib/bpf/gen_loader.c                    | 697 ++++++++++++++++++
 tools/lib/bpf/libbpf.c                        | 385 ++++++++--
 tools/lib/bpf/libbpf.h                        |  13 +
 tools/lib/bpf/libbpf.map                      |   2 +
 tools/lib/bpf/libbpf_internal.h               |   2 +
 tools/lib/bpf/skel_internal.h                 | 123 ++++
 tools/testing/selftests/bpf/.gitignore        |   1 +
 tools/testing/selftests/bpf/Makefile          |  16 +-
 .../selftests/bpf/prog_tests/atomics.c        |  72 +-
 .../selftests/bpf/prog_tests/fentry_fexit.c   |   6 +-
 .../selftests/bpf/prog_tests/fentry_test.c    |  10 +-
 .../selftests/bpf/prog_tests/fexit_sleep.c    |   6 +-
 .../selftests/bpf/prog_tests/fexit_test.c     |  10 +-
 .../selftests/bpf/prog_tests/kfunc_call.c     |   6 +-
 .../selftests/bpf/prog_tests/ksyms_module.c   |   2 +-
 .../selftests/bpf/prog_tests/ringbuf.c        |   8 +-
 .../selftests/bpf/prog_tests/syscall.c        |  55 ++
 .../selftests/bpf/prog_tests/trace_printk.c   |   5 +-
 tools/testing/selftests/bpf/progs/syscall.c   | 121 +++
 .../selftests/bpf/progs/test_ringbuf.c        |   4 +-
 .../selftests/bpf/progs/test_subprogs.c       |  13 +
 .../selftests/bpf/progs/trace_printk.c        |   6 +-
 42 files changed, 2441 insertions(+), 257 deletions(-)
 create mode 100644 include/linux/bpfptr.h
 create mode 100644 tools/lib/bpf/bpf_gen_internal.h
 create mode 100644 tools/lib/bpf/gen_loader.c
 create mode 100644 tools/lib/bpf/skel_internal.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/syscall.c
 create mode 100644 tools/testing/selftests/bpf/progs/syscall.c

-- 
2.30.2

