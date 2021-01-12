Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98A8D2F3460
	for <lists+bpf@lfdr.de>; Tue, 12 Jan 2021 16:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391858AbhALPnV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jan 2021 10:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391798AbhALPnV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jan 2021 10:43:21 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEADC061786
        for <bpf@vger.kernel.org>; Tue, 12 Jan 2021 07:42:40 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id w5so1321530wrl.9
        for <bpf@vger.kernel.org>; Tue, 12 Jan 2021 07:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=f0JwdHauFUqAIxBNbaHAJHzOB/8wVtuBh61LCxKiibU=;
        b=Vwfjzf5N6aR/Hc0WeOcjd2gAeSI6d/LjBNWmeS1Rc9LUjbt4z9dCZvnIBb6F+1/LhA
         QwQhvw8aCm1Yarck4HsRfiRJiqxnb+79dZ9FUBlg+QIh2II5FtU/So/H6UaCpfStN7c6
         J83bGa0iFMb8CYHytBdB60QF9A1+RaP1a4Gmr10oFBGCjnResj7gL2UaURs4NPR+afBV
         Cq5osJFad2PPX9SQh4dvt3cCyGsXseJo2h5P6GRddTa3L3bEQXCXVs1jMs8iose4KeNN
         GzTJBxHTHLT7XRUx1USlbTPI5Ek8BiCd7T0JZEFVz1vIUgDe13k56cJwwRP5HDV93DEd
         nB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc:content-transfer-encoding;
        bh=f0JwdHauFUqAIxBNbaHAJHzOB/8wVtuBh61LCxKiibU=;
        b=HL3ULnsE2u+ctIiMoIEp0uQ3+O1omxHMGiruX5sTFyLLnGI0BDqGOZevrJIvFyxIHq
         ao5a1hwv+f//IXEeBhBpAYWQeiOZHG490dAs7oSDl5zohixCN8rOCUIKN+XDmAUY1P+1
         f/K9SfP+ws2cKpNj3eqlJ5PlNj0K2jep7/8U20Jbnx6i4FJsvNqBFCFi7xNBuZW1MXPu
         I4J5jKS0h+//Ee2KhFANK1kLl+sJCakPG9aDzNuBz9RsokbEpqFn7u7Lc9c2KvxA2l84
         SCpXqtOq00ydXMWVjBUjXGIDBrhueQMXIYDh0fCC8aSuJhx6aqO0Nu8PfZyIoYIFOX/B
         DL5A==
X-Gm-Message-State: AOAM530NoIckRGLEEqQOOfBupPDLLMjWTdmiAKUrK0E4A2nra7RsOp6O
        ibKLnUyC27BHMiZyA7Bbb7krtgr5qvAw7mBykXvgL97rZhGqmSIxSDJvXpdekyJA3fmJBMDCXQe
        HAVVDZuEe7Iwa8vQzPeflANK81PNYjcDejTxnRwtsMUkCVVc++CebSXfKkO+xVbA=
X-Google-Smtp-Source: ABdhPJwXPqQycoPC7JNP5w+Xw+f0ra2Qztm3tC777rAzi416/5WylM3d5MaUKEjkPnpOWCH27vPOXCEmhb9cFw==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a7b:c044:: with SMTP id
 u4mr529095wmc.1.1610466158716; Tue, 12 Jan 2021 07:42:38 -0800 (PST)
Date:   Tue, 12 Jan 2021 15:42:24 +0000
Message-Id: <20210112154235.2192781-1-jackmanb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH bpf-next v6 00/11] Atomics for eBPF
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org,
        "=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn.topel@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Happy new year everyone, and thanks once again for the reviews.

There's still one unresolved review comment from John[3] but I don't
think it needs to block the patchset as it stands, it can be a
separate patch. Hope that's OK.

Differences from v5->v6 [1]:

* Carried Bj=C3=B6rn T=C3=B6pel's ack for RISC-V code, plus a couple more a=
cks from
  Yonhgong.

* Doc fixups.

* Trivial cleanups.

Differences from v4->v5 [1]:

* Fixed bogus type casts in interpreter that led to warnings from
  the 0day robot.

* Dropped feature-detection for Clang per Andrii's suggestion in [4].
  The selftests will now fail to build unless you have llvm-project
  commit 286daafd6512. The ENABLE_ATOMICS_TEST macro is still needed
  to support the no_alu32 tests.

* Carried some Acks from John and Yonghong.

* Dropped confusing usage of __atomic_exchange from prog_test in
  favour of __sync_lock_test_and_set.

* [Really] got rid of all the forest of instruction macros
  (BPF_ATOMIC_FETCH_ADD and friends); now there's just BPF_ATOMIC_OP
  to define all the instructions as we use them in the verifier
  tests. This makes the atomic ops less special in that API, and I
  don't think the resulting usage is actually any harder to read.

Differences from v3->v4 [1]:

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

* Dropped the use of -mcpu=3Dv4 in the Clang BPF command-line; there is
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
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

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
=3D=3D=3D=3D=3D=3D=3D=3D

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
breaking userspace builds), and where we previously had .imm =3D 0, we
now have .imm =3D BPF_ADD (which is 0).

Operands
=3D=3D=3D=3D=3D=3D=3D=3D

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
    v1: https://lore.kernel.org/bpf/20201123173202.1335708-1-jackmanb@googl=
e.com/
    v2: https://lore.kernel.org/bpf/20201127175738.1085417-1-jackmanb@googl=
e.com/
    v3: https://lore.kernel.org/bpf/X8kN7NA7bJC7aLQI@google.com/
    v4: https://lore.kernel.org/bpf/20201207160734.2345502-1-jackmanb@googl=
e.com/
    v5: https://lore.kernel.org/bpf/20201215121816.1048557-1-jackmanb@googl=
e.com/

[2] Visualisation of eBPF opcode space:
    https://gist.github.com/bjackman/00fdad2d5dfff601c1918bc29b16e778

[3] Comment from John about propagating bounds in verifier:
    https://lore.kernel.org/bpf/5fcf0fbcc8aa8_9ab320853@john-XPS-13-9370.no=
tmuch/

[4] Mail from Andrii about not supporting old Clang in selftests:
    https://lore.kernel.org/bpf/CAEf4BzYBddPaEzRUs=3DjaWSo5kbf=3DLZdb7geAUV=
j85GxLQztuAQ@mail.gmail.com/

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

 Documentation/networking/filter.rst           |  61 ++++-
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
 include/linux/filter.h                        |  25 +-
 include/uapi/linux/bpf.h                      |  10 +-
 kernel/bpf/core.c                             |  67 ++++-
 kernel/bpf/disasm.c                           |  43 ++-
 kernel/bpf/verifier.c                         |  75 ++++--
 lib/test_bpf.c                                |  14 +-
 samples/bpf/bpf_insn.h                        |   4 +-
 samples/bpf/cookie_uid_helper_example.c       |   8 +-
 samples/bpf/sock_example.c                    |   2 +-
 samples/bpf/test_cgrp2_attach.c               |   5 +-
 tools/include/linux/filter.h                  |  24 +-
 tools/include/uapi/linux/bpf.h                |  10 +-
 tools/testing/selftests/bpf/Makefile          |   2 +
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
 44 files changed, 1466 insertions(+), 212 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/atomics.c
 create mode 100644 tools/testing/selftests/bpf/progs/atomics.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_and.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_fetch_add.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_or.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_xchg.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_xor.c


base-commit: e22d7f05e445165e58feddb4e40cc9c0f94453bc
--
2.30.0.284.gd98b1dd5eaa7-goog

