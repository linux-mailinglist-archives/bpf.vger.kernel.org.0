Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8AF12C11FD
	for <lists+bpf@lfdr.de>; Mon, 23 Nov 2020 18:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731739AbgKWRcS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Nov 2020 12:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730667AbgKWRcR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Nov 2020 12:32:17 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B98AC0613CF
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2020 09:32:17 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id o25so15288967qkj.1
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2020 09:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=oXaU5c+8k021cMT48FUBTifmZRS7IJDVtgM5yLX1W+g=;
        b=JV+yTRpDSS45ad3z5kgLtuIs/5kGTLK0W8LAcKNp1tz/XQU0CoiHupmAYxtKHCFJ1E
         MbEfwyauyhZvKf8CIsJMOV9+fvoDhIjBRYDvKwlWQwYAtkSbW38jOezIw9WZI+8I85Fk
         BCIOuE3aXEyBLQ6top9DzvkkJpJHO5z43dGJzpq+dsOKgoYHtK14S0yLSdpFSqB9cCnc
         tgy7a+vHVvy5xiKDl4n47dnmCsMNYFvIBkcuuD84LOIK+MdLIDs9xJpLCm3b16mTSa+N
         tgq9uP0zskJNagz6Az6t0cCC8AwlZ5sdjMkbcEDzuMid27/g+VPHBqrWDqxJXgwkfdex
         3fGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=oXaU5c+8k021cMT48FUBTifmZRS7IJDVtgM5yLX1W+g=;
        b=A9gKq2m5Z34WcNykFf7jSkEtZo43URKoWSwQIBlQEAw05w4tS2rxBSjemNS8qOE8Ka
         wNZo5fE/4A9ZnLEhclL3HnAIvFVRHyTWSQvUXve6Uh+4cwslAP9JwldaAVAqG5u40fDE
         /Luc96nHUgr+AuzM8QvQa0GZf51Sx0O4DEJZo5YGD0xT52Wejkj5NJV+xIo8G02PCNvB
         hqUu87q5GNJeAZKn8AAZQYwpivAGe0bLMyZhVitDErECCOTcrdAvmrCucgLnlXnErOE6
         E1HqG8Fcstq+7446p85Y2+/zxZc5vX43d9im1xp/VqcBxu0psaneG1f4BDkEz+EC9qVo
         Jmhg==
X-Gm-Message-State: AOAM531F9FQxXytGboRpXGWp5AUsxOT0eyXGEvj5EhcGnDP5XhA9s+JU
        nllSNMexyJ1hrApOEErTx/aDQlDD1RqffmaaMTU+02JAFQYoJoE+Oo8+59SZEJmp6qUDg3XN8K6
        f3hG+qf0vIKNmdg7ooNELoK2wMVC9W6lOUiOSigoxrxTGp1AMZxyRIKQUFr3bzLk=
X-Google-Smtp-Source: ABdhPJxU3j5WzC7Er0skl23G7rTbgw6fasqLaHoUv0VECZGdZcRH21U/h3exjMFHzZPE31zZyKqpFMYPun3GUg==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a0c:f607:: with SMTP id
 r7mr509314qvm.47.1606152736581; Mon, 23 Nov 2020 09:32:16 -0800 (PST)
Date:   Mon, 23 Nov 2020 17:31:55 +0000
Message-Id: <20201123173202.1335708-1-jackmanb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH 0/7] Atomics for eBPF
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Status of the patches
=====================

This patchset is currently incomplete: it oughtn't be released as-is,
because that would necessitate incrementing architecture
version number for a partial feature-set. However I've implemented
the parts that I think are most interesting/controversial, so I'd
like to get the review started.

The missing elements that I'm aware of are:

* Atomic subtract
* Atomic & and |
* Documentation updates

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
* atomic[64]_[fetch_]sub (TODO)
* atomic[64]_[fetch_]and (TODO)
* atomic[64]_[fetch_]or  (TODO)
* atomic[64]_xchg
* atomic[64]_cmpxchg

The following are left out of scope for this effort:

* 16 and 8 bit operations
* Explicit memory barriers

Encoding
========

I originally planned to add new values for bpf_insn.opcode. This was
rather unpleasant: the opcode space has holes in it but no entire
instruction classes[1]. Yonghong Song had a better idea: use the
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

[1] Visualisation of eBPF opcode space:
    https://gist.github.com/bjackman/00fdad2d5dfff601c1918bc29b16e778

Brendan Jackman (7):
  bpf: Factor out emission of ModR/M for *(reg + off)
  bpf: x86: Factor out emission of REX byte
  bpf: Rename BPF_XADD and prepare to encode other atomics in .imm
  bpf: Move BPF_STX reserved field check into BPF_STX verifier code
  bpf: Add BPF_FETCH field / create atomic_fetch_add instruction
  bpf: Add instructions for atomic_cmpxchg and friends
  bpf: Add tests for new BPF atomic operations

 Documentation/networking/filter.rst           |  27 ++--
 arch/arm/net/bpf_jit_32.c                     |   7 +-
 arch/arm64/net/bpf_jit_comp.c                 |  16 +-
 arch/mips/net/ebpf_jit.c                      |  11 +-
 arch/powerpc/net/bpf_jit_comp64.c             |  25 ++-
 arch/riscv/net/bpf_jit_comp32.c               |  20 ++-
 arch/riscv/net/bpf_jit_comp64.c               |  16 +-
 arch/s390/net/bpf_jit_comp.c                  |  26 ++--
 arch/sparc/net/bpf_jit_comp_64.c              |  14 +-
 arch/x86/net/bpf_jit_comp.c                   | 131 ++++++++++------
 arch/x86/net/bpf_jit_comp32.c                 |   6 +-
 drivers/net/ethernet/netronome/nfp/bpf/jit.c  |  14 +-
 drivers/net/ethernet/netronome/nfp/bpf/main.h |   4 +-
 .../net/ethernet/netronome/nfp/bpf/verifier.c |  13 +-
 include/linux/filter.h                        |  47 +++++-
 include/uapi/linux/bpf.h                      |   9 +-
 kernel/bpf/core.c                             |  64 ++++++--
 kernel/bpf/disasm.c                           |  25 ++-
 kernel/bpf/verifier.c                         |  72 ++++++---
 lib/test_bpf.c                                |   2 +-
 samples/bpf/bpf_insn.h                        |   4 +-
 samples/bpf/sock_example.c                    |   3 +-
 samples/bpf/test_cgrp2_attach.c               |   6 +-
 tools/include/linux/filter.h                  |  47 +++++-
 tools/include/uapi/linux/bpf.h                |   9 +-
 tools/testing/selftests/bpf/Makefile          |   2 +-
 .../selftests/bpf/prog_tests/atomics_test.c   | 145 ++++++++++++++++++
 .../bpf/prog_tests/cgroup_attach_multi.c      |   6 +-
 .../selftests/bpf/progs/atomics_test.c        |  61 ++++++++
 .../selftests/bpf/verifier/atomic_cmpxchg.c   |  96 ++++++++++++
 .../selftests/bpf/verifier/atomic_fetch_add.c | 106 +++++++++++++
 .../selftests/bpf/verifier/atomic_xchg.c      | 113 ++++++++++++++
 tools/testing/selftests/bpf/verifier/ctx.c    |   6 +-
 .../testing/selftests/bpf/verifier/leak_ptr.c |   4 +-
 tools/testing/selftests/bpf/verifier/unpriv.c |   3 +-
 tools/testing/selftests/bpf/verifier/xadd.c   |   2 +-
 36 files changed, 1002 insertions(+), 160 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/atomics_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/atomics_test.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_fetch_add.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_xchg.c

--
2.29.2.454.gaff20da3a2-goog

