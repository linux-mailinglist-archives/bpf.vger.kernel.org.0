Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF4F2D1597
	for <lists+bpf@lfdr.de>; Mon,  7 Dec 2020 17:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgLGQJB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 11:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgLGQJA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Dec 2020 11:09:00 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6469CC061794
        for <bpf@vger.kernel.org>; Mon,  7 Dec 2020 08:08:14 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id g198so4267312wme.7
        for <bpf@vger.kernel.org>; Mon, 07 Dec 2020 08:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=E0InZ8YZUfmsCX5q8vbmB+szGdatzjXmt6ix8T6lxf4=;
        b=nVMu+fGewDY1zDQdPGGQ8jHDq6e7myODHrQfB5e36P28BmmtZROYSceh7a5jGMF9aT
         PTE8hmaEXd4Z/cSwnfdJx9/VuCiySGKEr8YSPG8wLwqH4l/VFLq2mvVY3c39QCFrtx7R
         xAScRFDTVKGqmNKZMoYPkYAvfZ09OkygR1H+oSTuqXFgAF0tTfVkkctRNiocgyBEzPIA
         lVzKuu8N844HCUnB5ux+klIWQQFDa+bknl0bxeEJgovqHSN0p8X7m8D3JfHbqXDvrcBS
         Hn+E3CbCpjhGJ1KusmEAuY/hn5rVyK1yZ9xpx9T1dBnIjcvISDy5sp6ivlIW489yjWFb
         iV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=E0InZ8YZUfmsCX5q8vbmB+szGdatzjXmt6ix8T6lxf4=;
        b=Da9jGNWiftfT6+kAC/m8WrD29f/Mkpw27z4iSwjwORfXsv9URPADKPxWyd/Y2EAuoP
         E2DJsnEgpl4sGe9KKs/cRJqdXu3T9WH404wqVvLyshjznXSyzyA3tH7zYf27i8T2Buhb
         rkeEfjcqt4M8ImIyY/31/6hqqM8nxpzuDSrxv8eGDHuJEN9CAMZmdd3d3WXXF1+vTvb4
         ulGvzgyRyF8Kb2k/kWewwnlls1EEDtfKC9GsZIgQfjalSlCfoCcc3qA1l8V68SdjR9cz
         PYuUsybcv+ejzzwlnL2SpCO0rdbI+Z87DPnOUwMOPXL0l5458vMI0Mm/irzUuJ/Z98AD
         Qh0A==
X-Gm-Message-State: AOAM530as/QaLorGdxfKJtgRLRgfL1eu9dKNjS4lJfbr5+3LGPyZFCLm
        z5Bnj5zdkbhFLDa8A34rERDkG8P+QLuFVz3UmtIz3V7rlwVemlvOiPw4Yym+PYQJAV/9df8dTH2
        A+curVb03XJCK7pKqYgCiLE1z2Gg1wWKjLEo7ZPJHKaj0qnJNr40xJoHHN8j0BKA=
X-Google-Smtp-Source: ABdhPJxCX8A1qT/ZQ1/gDS2KbHS06qSbCWaXPHVo/0WPS09S7vvdN38mkmkY16n3pWMAhYWelSSaLmDtk37cDQ==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:adf:e490:: with SMTP id
 i16mr20247219wrm.337.1607357292756; Mon, 07 Dec 2020 08:08:12 -0800 (PST)
Date:   Mon,  7 Dec 2020 16:07:23 +0000
Message-Id: <20201207160734.2345502-1-jackmanb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH bpf-next v4 00/11] Atomics for eBPF
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

Thanks for the reviews! Differences from v3->v4 [1]:

* Added one Ack from Yonghong. He acked some other patches but those
  have now changed non-trivally so I didn't add those acks.

* Fixups to commit messages.

* Fixed disassembly and comments: first arg to atomic_fetch_* is a
  pointer.

* Improved prog_test efficiency. BPF progs are now all loaded in a
  single call, then the skeleton is re-used for each subtest.

* Dropped use of tools/build/feature in favour of a one-liner in the
  Makefile.

* Dropped the commit that created an emit_neg helper in the x86
  JIT. It's not used any more (it wasn't used in v3 either).

* Combined all the different filter.h macros (used to be
  BPF_ATOMIC_ADD, BPF_ATOMIC_FETCH_ADD, BPF_ATOMIC_AND, etc) into
  just BPF_ATOMIC32 and BPF_ATOMIC64.

* Removed some references to BPF_STX_XADD from tools/, samples/ and
  lib/ that I missed before.

Differences from v2->v3 [1]:

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
Yonghong in commit 286daafd6512 (was
https://reviews.llvm.org/D72184).

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

[1] Previous iterations:
    v1: https://lore.kernel.org/bpf/20201123173202.1335708-1-jackmanb@google.com/
    v2: https://lore.kernel.org/bpf/20201127175738.1085417-1-jackmanb@google.com/
    v3: https://lore.kernel.org/bpf/X8kN7NA7bJC7aLQI@google.com/

[2] Visualisation of eBPF opcode space:
    https://gist.github.com/bjackman/00fdad2d5dfff601c1918bc29b16e778

Brendan Jackman (11):
  bpf: x86: Factor out emission of ModR/M for *(reg + off)
  bpf: x86: Factor out emission of REX byte
  bpf: x86: Factor out a lookup table for some ALU opcodes
  bpf: Rename BPF_XADD and prepare to encode other atomics in .imm
  bpf: Move BPF_STX reserved field check into BPF_STX verifier code
  bpf: Add BPF_FETCH field / create atomic_fetch_add instruction
  bpf: Add instructions for atomic_[cmp]xchg
  bpf: Pull out a macro for interpreting atomic ALU operations
  bpf: Add bitwise atomic instructions
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
 arch/x86/net/bpf_jit_comp.c                   | 217 ++++++++++-----
 arch/x86/net/bpf_jit_comp32.c                 |   6 +-
 drivers/net/ethernet/netronome/nfp/bpf/jit.c  |  14 +-
 drivers/net/ethernet/netronome/nfp/bpf/main.h |   4 +-
 .../net/ethernet/netronome/nfp/bpf/verifier.c |  15 +-
 include/linux/filter.h                        | 118 ++++++++-
 include/uapi/linux/bpf.h                      |  10 +-
 kernel/bpf/core.c                             |  67 ++++-
 kernel/bpf/disasm.c                           |  43 ++-
 kernel/bpf/verifier.c                         |  75 ++++--
 lib/test_bpf.c                                |  14 +-
 samples/bpf/bpf_insn.h                        |   4 +-
 samples/bpf/cookie_uid_helper_example.c       |   6 +-
 samples/bpf/sock_example.c                    |   2 +-
 samples/bpf/test_cgrp2_attach.c               |   5 +-
 tools/include/linux/filter.h                  | 127 ++++++++-
 tools/include/uapi/linux/bpf.h                |  10 +-
 tools/testing/selftests/bpf/Makefile          |  10 +
 .../selftests/bpf/prog_tests/atomics.c        | 246 ++++++++++++++++++
 .../bpf/prog_tests/cgroup_attach_multi.c      |   4 +-
 tools/testing/selftests/bpf/progs/atomics.c   | 154 +++++++++++
 .../selftests/bpf/test_cgroup_storage.c       |   2 +-
 .../selftests/bpf/verifier/atomic_and.c       |  77 ++++++
 .../selftests/bpf/verifier/atomic_cmpxchg.c   |  96 +++++++
 .../selftests/bpf/verifier/atomic_fetch_add.c | 106 ++++++++
 .../selftests/bpf/verifier/atomic_or.c        |  77 ++++++
 .../selftests/bpf/verifier/atomic_xchg.c      |  46 ++++
 .../selftests/bpf/verifier/atomic_xor.c       |  77 ++++++
 tools/testing/selftests/bpf/verifier/ctx.c    |   7 +-
 .../bpf/verifier/direct_packet_access.c       |   4 +-
 .../testing/selftests/bpf/verifier/leak_ptr.c |  10 +-
 .../selftests/bpf/verifier/meta_access.c      |   4 +-
 tools/testing/selftests/bpf/verifier/unpriv.c |   3 +-
 .../bpf/verifier/value_illegal_alu.c          |   2 +-
 tools/testing/selftests/bpf/verifier/xadd.c   |  18 +-
 44 files changed, 1665 insertions(+), 210 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/atomics.c
 create mode 100644 tools/testing/selftests/bpf/progs/atomics.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_and.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_fetch_add.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_or.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_xchg.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_xor.c


base-commit: 34da87213d3ddd26643aa83deff7ffc6463da0fc
--
2.29.2.576.ga3fc446d84-goog

