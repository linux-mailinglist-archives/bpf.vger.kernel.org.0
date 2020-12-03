Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03D92CDAA8
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 17:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389271AbgLCQDv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 11:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389110AbgLCQDv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 11:03:51 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03511C061A4F
        for <bpf@vger.kernel.org>; Thu,  3 Dec 2020 08:03:11 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id n18so1550302wmk.0
        for <bpf@vger.kernel.org>; Thu, 03 Dec 2020 08:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Umt6coDnn4aZpAALuE3BNX1YhLXZCr34hXrUZ71njTk=;
        b=C3HBhRolseNEzsSxkUobwV6xR5RqddG0sq+ojtufOrz8uZMgV4OTse5wwhhFQtV6WE
         F4XNOoTPIJdC1LQ+a4N7SLUj9rfaAhc8gyOldkg0TSVPsokmAs/CDr93hjrvJkkTwj/b
         DYoyHS/Og/vzFT1cef/YEsJqTws3yLnj1CNVWbG/fZ/t16TLFVWZ56moJHvypdl+7dG9
         l/gWP5wgRyEplBhYtmi3CfKGSwbeHTj+nIju0Gd7l54w3CJscCiN8wYDMT6ocpUGnGhK
         lv3Yk01Y3c7BfKPXQmAAh0HSqDz111vRJWuQ1DVbhFhyqsI0ATkRhpamSCTYE+wTQ4rz
         g1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Umt6coDnn4aZpAALuE3BNX1YhLXZCr34hXrUZ71njTk=;
        b=NqR2GcwH8pCerVxo9yUL0AsavBsZQIzx8XR596WmDvJI3GvNPqtu9O03+vmTSsmJr8
         PyDUUNne6nUorwLbE82KaVdjZKLSgE9W3RE1Pes4jT+ME0KMsWXJupNVHI47qhqw9s2V
         lwNsO/m04Odg5onJxDfdlCHB8LAwgnqCgoojho4lqf0WEiFOKR6wQVuhUrdhtZrj0W+Y
         +Mn7O+Nv0pgDrEQh7lqPk1L1Lft934Ke2CIjKIa5P2um2T5bJyhVFCCTW0TiovKLwpmW
         4MBGaj1neRNKJZd7OFIY1msxKomuaaAITAoRxdTBIExxiSDk/u6fOkdDMNCPpW3jEBVg
         9WjQ==
X-Gm-Message-State: AOAM532/uO1QHnu2D5d4j9bKoiJGEAt/NS8zusBoIZ5Fl1/YwBTGG/i6
        aLwUC70iJnqKCwYOPbnXHYJGhr7+osaON2LrwS+Pm0j8ukmbsvellrnNbXV7DfNXL2dmbcXEZC3
        RgVdLvRObN53Tpi2t1ttu2/pIJFgJrnI3cINo3WMCxHUraTWIC+zMNtojVeuQdUU=
X-Google-Smtp-Source: ABdhPJzFt8qBiRvs5wq+69dJNKDvJH0zM4rlkm9pKh5y+4L6Qbvp1Dc/OIlZVrhocfA12YWxMT0WCX75hUXkFA==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a1c:2b03:: with SMTP id
 r3mr4146344wmr.184.1607011388856; Thu, 03 Dec 2020 08:03:08 -0800 (PST)
Date:   Thu,  3 Dec 2020 16:02:31 +0000
Message-Id: <20201203160245.1014867-1-jackmanb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH bpf-next v3 00/14] Atomics for eBPF
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

Thanks for the reviews! Differences from v2->v3 [1]:

* More minor fixes and naming/comment changes

* Dropped atomic subtract: compilers can implement this by preceding
  an atomic add with a NEG instruction (which is what the x86 JIT did
  under the hood anyway).

* Dropped the use of -mcpu=v4 in the Clang BPF command-line; there is
  no longer an architecture version bump. Instead a feature test is
  added to Kbuild - it builds a source file to check if Clang
  supports BPF atomics.

* Fixed the prog_test so it no longer breaks
  test_progs-no_alu32. This requires some ifdef acrobatics to avoid
  complicating the prog_tests model where the same userspace code
  exercises both the normal and no_alu32 BPF test objects, using the
  same skeleton header.

Differences from v1->v2 [1]:

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


Brendan Jackman (14):
  bpf: x86: Factor out emission of ModR/M for *(reg + off)
  bpf: x86: Factor out emission of REX byte
  bpf: x86: Factor out function to emit NEG
  bpf: x86: Factor out a lookup table for some ALU opcodes
  bpf: Rename BPF_XADD and prepare to encode other atomics in .imm
  bpf: Move BPF_STX reserved field check into BPF_STX verifier code
  bpf: Add BPF_FETCH field / create atomic_fetch_add instruction
  bpf: Add instructions for atomic_[cmp]xchg
  bpf: Pull out a macro for interpreting atomic ALU operations
  bpf: Add bitwise atomic instructions
  tools build: Implement feature check for BPF atomics in Clang
  bpf: Pull tools/build/feature biz into selftests Makefile
  bpf: Add tests for new BPF atomic operations
  bpf: Document new atomic instructions

 Documentation/networking/filter.rst           |  56 +++-
 arch/arm/net/bpf_jit_32.c                     |   7 +-
 arch/arm64/net/bpf_jit_comp.c                 |  16 +-
 arch/mips/net/ebpf_jit.c                      |  11 +-
 arch/powerpc/net/bpf_jit_comp64.c             |  25 +-
 arch/riscv/net/bpf_jit_comp32.c               |  20 +-
 arch/riscv/net/bpf_jit_comp64.c               |  16 +-
 arch/s390/net/bpf_jit_comp.c                  |  27 +-
 arch/sparc/net/bpf_jit_comp_64.c              |  17 +-
 arch/x86/net/bpf_jit_comp.c                   | 241 +++++++++++-----
 arch/x86/net/bpf_jit_comp32.c                 |   6 +-
 drivers/net/ethernet/netronome/nfp/bpf/jit.c  |  14 +-
 drivers/net/ethernet/netronome/nfp/bpf/main.h |   4 +-
 .../net/ethernet/netronome/nfp/bpf/verifier.c |  15 +-
 include/linux/filter.h                        |  97 ++++++-
 include/uapi/linux/bpf.h                      |   8 +-
 kernel/bpf/core.c                             |  66 ++++-
 kernel/bpf/disasm.c                           |  43 ++-
 kernel/bpf/verifier.c                         |  75 +++--
 lib/test_bpf.c                                |   2 +-
 samples/bpf/bpf_insn.h                        |   4 +-
 samples/bpf/sock_example.c                    |   2 +-
 samples/bpf/test_cgrp2_attach.c               |   4 +-
 tools/build/feature/Makefile                  |   4 +
 tools/build/feature/test-clang-bpf-atomics.c  |   9 +
 tools/include/linux/filter.h                  |  97 ++++++-
 tools/include/uapi/linux/bpf.h                |   8 +-
 tools/testing/selftests/bpf/.gitignore        |   1 +
 tools/testing/selftests/bpf/Makefile          |  42 +++
 .../selftests/bpf/prog_tests/atomics_test.c   | 262 ++++++++++++++++++
 .../bpf/prog_tests/cgroup_attach_multi.c      |   4 +-
 .../selftests/bpf/progs/atomics_test.c        | 154 ++++++++++
 .../selftests/bpf/verifier/atomic_and.c       |  77 +++++
 .../selftests/bpf/verifier/atomic_cmpxchg.c   |  96 +++++++
 .../selftests/bpf/verifier/atomic_fetch_add.c | 106 +++++++
 .../selftests/bpf/verifier/atomic_or.c        |  77 +++++
 .../selftests/bpf/verifier/atomic_xchg.c      |  46 +++
 .../selftests/bpf/verifier/atomic_xor.c       |  77 +++++
 tools/testing/selftests/bpf/verifier/ctx.c    |   7 +-
 .../testing/selftests/bpf/verifier/leak_ptr.c |   4 +-
 tools/testing/selftests/bpf/verifier/unpriv.c |   3 +-
 tools/testing/selftests/bpf/verifier/xadd.c   |   2 +-
 42 files changed, 1666 insertions(+), 186 deletions(-)
 create mode 100644 tools/build/feature/test-clang-bpf-atomics.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/atomics_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/atomics_test.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_and.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_fetch_add.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_or.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_xchg.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_xor.c


base-commit: 97306be45fbe7a02461c3c2a57e666cf662b1aaf
--
2.29.2.454.gaff20da3a2-goog

