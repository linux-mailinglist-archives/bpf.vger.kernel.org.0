Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C342C6B14
	for <lists+bpf@lfdr.de>; Fri, 27 Nov 2020 18:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732165AbgK0R5t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Nov 2020 12:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732088AbgK0R5t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Nov 2020 12:57:49 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E278BC0613D2
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2020 09:57:48 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id z13so3760665wrm.19
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2020 09:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=mYHoyQQELFte9RcoqeMyfOMdhbka6OyGE7l8wA2dMYU=;
        b=JRCE5+AJnZ455uAlfvPFoUANq0PzfkPGfL1NhqGG2tmDSl9xHhFyZLBTtN+wbNuZr+
         prWRx9TbcnIaZb6gcgpUkYelsfbPkLKgxZOymdtP5+waXXZD66MeC4dwJesZUljMh5CC
         jHrUi1GYkTF7vQMwaRw5Vwp2foJ3qmao0DoUZWqQ1nF56UzH7FUCpxhNPPHdyAPUYEok
         qYlbhlLG9LQFB1mTiq9S7rxj4HuPhhiyEp0HmYSEY3rz5JVyjY1ax0sij9SFIvccygDa
         Fg3+0nkTGPL3aCuJBsUO4nG3hM0N3ezGxK+Ttmlnvon7m0Mpx43uP54THmKSshkf2IO1
         weOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=mYHoyQQELFte9RcoqeMyfOMdhbka6OyGE7l8wA2dMYU=;
        b=hXJd6q+zHsxewXGcpbNziQBjIFC2A28hVr6BeQishMyuS1rFz7C3/IVA3a7CqNyH8k
         f5fwBwTswLro0mvipxrLGgMEwheNfMvwTNdhj4ZIQXAhfU+n7lb5qq+D3mGxZArwAtwZ
         w1BvIC8S1WCGX0HEv1YLz80GVCKXhqBKMjq2f7B+LFf9CF8Xc2UZMkmo251uAZ9DAnOD
         ALETrAs1uSQL6gx8rE9cSnnDdFANjScTi2Af81e8NI6pndXcsbngGe5EyPZGgfkn989A
         3EnpTvNQB4+x8g9RQ+fIKvXXML4yWk0ui2A6sdmBSoQtqN1BT2nvpqW4HJqftyYxxWIL
         czRA==
X-Gm-Message-State: AOAM530hb7uTyFDWpIe5sPIk04EdnVthkwJPi6j6b4SDGISnFwPjire9
        conmraz9BUU7LUW70IR1vB+BMSUx+RZ6d4/1ojztJ3B1T3aaG1PEJSQtIP7W9DPnYfJi4VGdTTy
        PEkcefU0On7KmxOp3QTaVZhCf4i5MWKpPbZnb4y2ILyQN4rkBROPTCejBfYnRVys=
X-Google-Smtp-Source: ABdhPJwaYDoq4MpI4cYkRRPkIYQ+OePsqvvzDLpjGb0Cxk6S90w+e8XJnMZ0yll68qxCOZ9ZUxA86GCnXFQc7Q==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a1c:7e87:: with SMTP id
 z129mr10474359wmc.176.1606499867363; Fri, 27 Nov 2020 09:57:47 -0800 (PST)
Date:   Fri, 27 Nov 2020 17:57:25 +0000
Message-Id: <20201127175738.1085417-1-jackmanb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2 bpf-next 00/13] Atomics for eBPF
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Status of the patches
=====================

Thanks for the reviews! Differences from v1->v2 [1]:

* Fixed mistakes in the netronome driver

* Addd sub, add, or, xor operations

* The above led to some refactors to keep things readable. (Maybe I
  should have just waited until I'd implemented these before starting
  the review...)

* Replaced BPF_[CMP]SET | BPF_FETCH with just BPF_[CMP]XCHG, which
  include the BPF_FETCH flag

* Added a bit of documentation. Suggestions welcome for more places
  to dump this info...

The prog_test that's added depends on Clang/LLVM features added by
Yonghong in https://reviews.llvm.org/D72184

This only includes a JIT implementation for x86_64 - I don't plan to
implement JIT support myself for other architectures.

Operations
==========

This patchset adds atomic operations to the eBPF instruction set. The
use-case that motivated this work was a trivial and efficient way to
generate globally-unique cookies in BPF progs, but I think it's
obvious that these features are pretty widely applicable.  The
instructions that are added here can be summarised with this list of
kernel operations:

* atomic[64]_[fetch_]add
* atomic[64]_[fetch_]sub
* atomic[64]_[fetch_]and
* atomic[64]_[fetch_]or
* atomic[64]_xchg
* atomic[64]_cmpxchg

The following are left out of scope for this effort:

* 16 and 8 bit operations
* Explicit memory barriers

Encoding
========

I originally planned to add new values for bpf_insn.opcode. This was
rather unpleasant: the opcode space has holes in it but no entire
instruction classes[2]. Yonghong Song had a better idea: use the
immediate field of the existing STX XADD instruction to encode the
operation. This works nicely, without breaking existing programs,
because the immediate field is currently reserved-must-be-zero, and
extra-nicely because BPF_ADD happens to be zero.

Note that this of course makes immediate-source atomic operations
impossible. It's hard to imagine a measurable speedup from such
instructions, and if it existed it would certainly not benefit x86,
which has no support for them.

The BPF_OP opcode fields are re-used in the immediate, and an
additional flag BPF_FETCH is used to mark instructions that should
fetch a pre-modification value from memory.

So, BPF_XADD is now called BPF_ATOMIC (the old name is kept to avoid
breaking userspace builds), and where we previously had .imm = 0, we
now have .imm = BPF_ADD (which is 0).

Operands
========

Reg-source eBPF instructions only have two operands, while these
atomic operations have up to four. To avoid needing to encode
additional operands, then:

- One of the input registers is re-used as an output register
  (e.g. atomic_fetch_add both reads from and writes to the source
  register).

- Where necessary (i.e. for cmpxchg) , R0 is "hard-coded" as one of
  the operands.

This approach also allows the new eBPF instructions to map directly
to single x86 instructions.

[1] Previous patchset:
    https://lore.kernel.org/bpf/20201123173202.1335708-1-jackmanb@google.com/

[2] Visualisation of eBPF opcode space:
    https://gist.github.com/bjackman/00fdad2d5dfff601c1918bc29b16e778


Brendan Jackman (13):
  bpf: x86: Factor out emission of ModR/M for *(reg + off)
  bpf: x86: Factor out emission of REX byte
  bpf: x86: Factor out function to emit NEG
  bpf: x86: Factor out a lookup table for some ALU opcodes
  bpf: Rename BPF_XADD and prepare to encode other atomics in .imm
  bpf: Move BPF_STX reserved field check into BPF_STX verifier code
  bpf: Add BPF_FETCH field / create atomic_fetch_add instruction
  bpf: Add instructions for atomic_[cmp]xchg
  bpf: Pull out a macro for interpreting atomic ALU operations
  bpf: Add instructions for atomic[64]_[fetch_]sub
  bpf: Add bitwise atomic instructions
  bpf: Add tests for new BPF atomic operations
  bpf: Document new atomic instructions

 Documentation/networking/filter.rst           |  57 ++-
 arch/arm/net/bpf_jit_32.c                     |   7 +-
 arch/arm64/net/bpf_jit_comp.c                 |  16 +-
 arch/mips/net/ebpf_jit.c                      |  11 +-
 arch/powerpc/net/bpf_jit_comp64.c             |  25 +-
 arch/riscv/net/bpf_jit_comp32.c               |  20 +-
 arch/riscv/net/bpf_jit_comp64.c               |  16 +-
 arch/s390/net/bpf_jit_comp.c                  |  27 +-
 arch/sparc/net/bpf_jit_comp_64.c              |  17 +-
 arch/x86/net/bpf_jit_comp.c                   | 252 ++++++++++----
 arch/x86/net/bpf_jit_comp32.c                 |   6 +-
 drivers/net/ethernet/netronome/nfp/bpf/jit.c  |  14 +-
 drivers/net/ethernet/netronome/nfp/bpf/main.h |   4 +-
 .../net/ethernet/netronome/nfp/bpf/verifier.c |  15 +-
 include/linux/filter.h                        | 117 ++++++-
 include/uapi/linux/bpf.h                      |   8 +-
 kernel/bpf/core.c                             |  67 +++-
 kernel/bpf/disasm.c                           |  41 ++-
 kernel/bpf/verifier.c                         |  77 +++-
 lib/test_bpf.c                                |   2 +-
 samples/bpf/bpf_insn.h                        |   4 +-
 samples/bpf/sock_example.c                    |   2 +-
 samples/bpf/test_cgrp2_attach.c               |   4 +-
 tools/include/linux/filter.h                  | 117 ++++++-
 tools/include/uapi/linux/bpf.h                |   8 +-
 tools/testing/selftests/bpf/Makefile          |  12 +-
 .../selftests/bpf/prog_tests/atomics_test.c   | 329 ++++++++++++++++++
 .../bpf/prog_tests/cgroup_attach_multi.c      |   4 +-
 .../selftests/bpf/progs/atomics_test.c        | 124 +++++++
 .../selftests/bpf/verifier/atomic_and.c       |  77 ++++
 .../selftests/bpf/verifier/atomic_cmpxchg.c   |  96 +++++
 .../selftests/bpf/verifier/atomic_fetch_add.c | 106 ++++++
 .../selftests/bpf/verifier/atomic_or.c        |  77 ++++
 .../selftests/bpf/verifier/atomic_sub.c       |  44 +++
 .../selftests/bpf/verifier/atomic_xchg.c      |  46 +++
 .../selftests/bpf/verifier/atomic_xor.c       |  77 ++++
 tools/testing/selftests/bpf/verifier/ctx.c    |   7 +-
 .../testing/selftests/bpf/verifier/leak_ptr.c |   4 +-
 tools/testing/selftests/bpf/verifier/unpriv.c |   3 +-
 tools/testing/selftests/bpf/verifier/xadd.c   |   2 +-
 40 files changed, 1754 insertions(+), 188 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/atomics_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/atomics_test.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_and.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_fetch_add.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_or.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_sub.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_xchg.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_xor.c

--
2.29.2.454.gaff20da3a2-goog

