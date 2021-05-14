Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36B9380129
	for <lists+bpf@lfdr.de>; Fri, 14 May 2021 02:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhENAhj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 May 2021 20:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbhENAhi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 May 2021 20:37:38 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64196C061574
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 17:36:28 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id pi6-20020a17090b1e46b029015cec51d7cdso461451pjb.5
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 17:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dygiw/K8JeQ/kHose6ONuZAhmiJQ+7QazoHWnUECnjU=;
        b=JEBCaNB0ZSFKvrMliQQvkpLS6KaQBqZ7hsPElHyuFeoKZHfuGzT9PAT8CHaa4WDB+7
         lxn+eCDfSjOmBknkfQc/cvCUWxL/9rUADT3qw81YewGSQ/2eZWoaaWaVpbHyIEqholgL
         8cU/utpYn4HVxXP4J4ia6FESkeeAhH9ZAeN3CVfTkQZmkpw82cuIPcngs+EsFw5UNrfE
         qx4Xqsh3rJd58pLSyGwvgGqFQQwTicwIEyvDNhQ2ZpXXyOpOYl8zX1e74cdp5uKm8dXx
         TwR+pi50DO6hDrlbJaCMW2tTjHgodvdz01+EKg73UdqIJ/LNzIi7jEt8eLBCjthPrkjl
         xaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dygiw/K8JeQ/kHose6ONuZAhmiJQ+7QazoHWnUECnjU=;
        b=B4OGL0sn2RU9gs29EdaqrMqG0RNQdI1u1ANTIbmn4UKzuVYMe3MARtxLV8w6iWvLob
         9KJNIHq/aHDmkrFsns4/qLjxyyEG1zaqxLR+CZKVKCrwso/DhnWcCAaoUTKEkYhXzIoS
         V2WLzIhDDmZf1QIKTSTaSWcFLLnJqkleWB0dfomIJ7hYs3SzwQ9WVwkFUTxbf1DSzXMX
         c6bqOAsF7Nymt0jAQFnsgzj8dmFaMoAVD2eAQ46qfMnna76Dw4G60KBnloB6ZmO0PHgy
         sTuMXS77M17OOXmdUsSXRctAY/KESc8R6r4g+92OX7oCyaH5ke7uAUlseyWsSltLc5IJ
         6zfw==
X-Gm-Message-State: AOAM530TT0BmU/9CnasN1/lZTSW2Fphd3r2rq/XV+16jyjVisoSlvloL
        PY8Mx3U0tNqq5HgUbaTntCA=
X-Google-Smtp-Source: ABdhPJw0LlE4FGvOLKcpXkGgg5ZoSRCwhHPZql5ieV0bUNK4N1TIYk3j71pO7UEfK/9FcD+9ORXLQQ==
X-Received: by 2002:a17:902:9f97:b029:ef:9a89:6e72 with SMTP id g23-20020a1709029f97b02900ef9a896e72mr5729998plq.45.1620952587679;
        Thu, 13 May 2021 17:36:27 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.4])
        by smtp.gmail.com with ESMTPSA id b9sm302336pfo.107.2021.05.13.17.36.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 May 2021 17:36:26 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 bpf-next 00/21] bpf: syscall program, FD array, loader program, light skeleton.
Date:   Thu, 13 May 2021 17:36:02 -0700
Message-Id: <20210514003623.28033-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

v5->v6:
- fixed issue found by bpf CI. The light skeleton generation was
  doing a dry-run of loading the program where all actual sys_bpf syscalls
  were replaced by calls into gen_loader. Turned out that search for valid
  vmlinux_btf was not stubbed out which was causing light skeleton gen
  to fail on older kernels.
- significantly reduced verbosity of gen_loader.c.
- an example trace_printk.lskel.h generated out of progs/trace_printk.c
  https://gist.github.com/4ast/774ea58f8286abac6aa8e3bf3bf3b903

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
 kernel/bpf/syscall.c                          | 194 ++++-
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
 tools/lib/bpf/bpf_gen_internal.h              |  41 +
 tools/lib/bpf/gen_loader.c                    | 729 ++++++++++++++++++
 tools/lib/bpf/libbpf.c                        | 387 ++++++++--
 tools/lib/bpf/libbpf.h                        |  13 +
 tools/lib/bpf/libbpf.map                      |   2 +
 tools/lib/bpf/libbpf_internal.h               |   2 +
 tools/lib/bpf/skel_internal.h                 | 123 +++
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
 42 files changed, 2474 insertions(+), 258 deletions(-)
 create mode 100644 include/linux/bpfptr.h
 create mode 100644 tools/lib/bpf/bpf_gen_internal.h
 create mode 100644 tools/lib/bpf/gen_loader.c
 create mode 100644 tools/lib/bpf/skel_internal.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/syscall.c
 create mode 100644 tools/testing/selftests/bpf/progs/syscall.c

-- 
2.30.2

