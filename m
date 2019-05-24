Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70DAC2A122
	for <lists+bpf@lfdr.de>; Sat, 25 May 2019 00:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404394AbfEXW10 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 May 2019 18:27:26 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51868 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404308AbfEXW1X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 May 2019 18:27:23 -0400
Received: by mail-wm1-f66.google.com with SMTP id f10so3354139wmb.1
        for <bpf@vger.kernel.org>; Fri, 24 May 2019 15:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kDi0w4K4kWFo9Ki7EzRbeQlWxZHvuD6jB3urT2QFBW4=;
        b=BnokRmZxK8UPuATgw0ngep3eV01tBBCrOpmxwMAXBDY5zFNC1+x0Xogw751FQqSMuQ
         sYaatu1jWwqINV+Bv1x0m9GeWyXQ3ON/YoCOk7aRkM4ayiUSUktwe+hVUIorz/XIyn/G
         f5IdOwdr+8tLgqGVFfxtJ91ZSn9g3ujSPvR2x1ZofWnJmCTxmCXrwAwas46P0YyjB8QN
         z5Cne0rpynfdbWhzGj/qzJ1sNygHd4Sg+Y5/OZRq+JU6ZYU3dVI30l/TzU2OPl93WQif
         32rUsJ8cVdoHAVZd7nrv6wXZyV+mFd3jkKlrXp+8sMHtFCNbx+cT5i1cEHj4hvOECsPR
         tZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kDi0w4K4kWFo9Ki7EzRbeQlWxZHvuD6jB3urT2QFBW4=;
        b=VsY1nKYbf8cuQealhXhegduucsm26jcyw07veNGGzaQpedODnicMLj4FxAk4sAq2e7
         s+XW5+ym7TwkRXp1peGy0bu1MKkqUfMXmOrIVIdF48rkrQfAMqm4xY0xd4usp6BFXvfH
         kCR56Eyko8Jsyz34hNCdEqW3igPfNZPRdtvW40Or/v4LzqqmL0A5zhCp3rMiW+6ZtlJH
         OZrfOBuR0o90qToXrurZj7OyyxMLHgo+nf5gfyhUlx21maYFQPDEbkzDZouD5nB3o9M9
         TJzWsgCDomkaxn3r7r7ZB+IO169Xj1uc+EsGwQWYjXdxOWFnlTej8YUl7h/c0OYezT8l
         BIOA==
X-Gm-Message-State: APjAAAUSb8TDw/2JVTfjvBRM3ZI2S1iM5hqYhBR6iC+NBeJDRvVR2ZUr
        Xg8Uttk6BmAo6hjQfNm5byg/Pg==
X-Google-Smtp-Source: APXvYqxBzJhFycWcceg8fVMo5ftgv216nWr6pPwJqo3febBQzH/CTOBLcTy4BUEEPlv1lAbkC/8KJA==
X-Received: by 2002:a1c:a64e:: with SMTP id p75mr1409607wme.62.1558736840180;
        Fri, 24 May 2019 15:27:20 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id y10sm7194961wmg.8.2019.05.24.15.27.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 May 2019 15:27:19 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, davem@davemloft.net,
        paul.burton@mips.com, udknight@gmail.com, zlim.lnx@gmail.com,
        illusionist.neo@gmail.com, naveen.n.rao@linux.ibm.com,
        sandipan@linux.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, jakub.kicinski@netronome.com,
        Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH v9 bpf-next 00/17] bpf: eliminate zero extensions for sub-register writes
Date:   Fri, 24 May 2019 23:25:11 +0100
Message-Id: <1558736728-7229-1-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

v9:
  - Split patch 5 in v8.
    make bpf uapi header file sync a separate patch. (Alexei)

v8:
  - For stack slot read, mark them as REG_LIVE_READ64. (Alexei)
  - Change DEF_NOT_SUBREG from -1 to 0. (Alexei)
  - Rebased on top of latest bpf-next.

v7:
  - Drop the first patch in v6, the one adding 32-bit return value and
    argument type. (Alexei)
  - Rename bpf_jit_hardware_zext to bpf_jit_needs_zext. (Alexei)
  - Use mov32 with imm == 1 to indicate it is zext. (Alexei)
  - JIT back-ends peephole next insn to optimize out unnecessary zext
    inserted by verifier. (Alexei)
  - Testing:
    + patch set tested (bpf selftest) on x64 host with llvm 9.0
      no regression observed no both JIT and interpreter modes.
    + patch set tested (bpf selftest) on x32 host.
      By Yanqing Wang, thanks!
      no regression observed on both JIT and interpreter modes.
    + patch set tested (bpf selftest) on RV64 host with llvm 9.0,
      By Björn Töpel, thanks!
      no regression observed before and after this set with JIT_ALWAYS_ON.
      test_progs_32 also enabled as LLVM 9.0 is used by Björn.
    + cross compiled the other affected targets, arm, PowerPC, SPARC, S390.

v6:
  - Fixed s390 kbuild test robot error. (kbuild)
  - Make comment style in backends patches more consistent.

v5:
  - Adjusted several test_verifier helpers to make them works on hosts
    w and w/o hardware zext. (Naveen)
  - Make sure zext flag not set when verifier by-passed, for example,
    libtest_bpf.ko. (Naveen)
  - Conservatively mark bpf main return value as 64-bit. (Alexei)
  - Make sure read flag is either READ64 or READ32, not the mix of both.
    (Alexei)
  - Merged patch 1 and 2 in v4. (Alexei)
  - Fixed kbuild test robot warning on NFP. (kbuild)
  - Proposed new BPF_ZEXT insn to have optimal code-gen for various JIT
    back-ends.
  - Conservately set zext flags for patched-insn.
  - Fixed return value zext for helper function calls.
  - Also adjusted test_verifier scalability unit test to avoid triggerring
    too many insn patch which will hang computer.
  - re-tested on x86 host with llvm 9.0, no regression on test_verifier,
    test_progs, test_progs_32.
  - re-tested offload target (nfp), no regression on local testsuite.

v4:
  - added the two missing fixes which addresses two Jakub's reviewes in v3.
  - rebase on top of bpf-next.

v3:
  - remove redundant check in "propagate_liveness_reg". (Jakub)
  - add extra check in "mark_reg_read" to prune more search. (Jakub)
  - re-implemented "prog_flags" passing mechanism, removed use of
    global switch inside libbpf.
  - enabled high 32-bit randomization beyond "test_verifier" and
    "test_progs". Now it should have been enabled for all possible
    tests. Re-run all tests, haven't noticed regression.
  - remove RFC tag.

v2:
  - rebased on top of bpf-next master.
  - added comments for what is sub-register def index. (Edward, Alexei)
  - removed patch 1 which turns bit mask from enum to macro. (Alexei)
  - removed sysctl/bpf_jit_32bit_opt. (Alexei)
  - merged sub-register def insn index into reg state. (Alexei)
  - change test methodology (Alexei):
      + instead of simple unit tests on x86_64 for which this optimization
        doesn't enabled due to there is hardware support, poison high
        32-bit for whose def identified as safe to do so. this could let
        the correctness of this patch set checked when daily bpf selftest
        ran which delivers very stressful test on host machine like x86_64.
      + hi32 poisoning is gated by a new BPF_F_TEST_RND_HI32 prog flags.
      + BPF_F_TEST_RND_HI32 is enabled for all tests of "test_progs" and
        "test_verifier", the latter needs minor tweak on two unit tests,
        please see the patch for the change.
      + introduced a new global variable "libbpf_test_mode" into libbpf.
        once it is set to true, it will set BPF_F_TEST_RND_HI32 for all the
        later PROG_LOAD syscall, the goal is to easy the enable of hi32
        poison on exsiting testsuite.
        we could also introduce new APIs, for example "bpf_prog_test_load",
        then use -Dbpf_prog_load=bpf_prog_test_load to migrate tests under
        test_progs, but there are several load APIs, and such new API need
        some change on struture like "struct bpf_prog_load_attr".
      + removed old unit tests. it is based on insn scan and requires quite
        a few test_verifier generic code change. given hi32 randomization
        could offer good test coverage, the unit tests doesn't add much
        extra test value.
  - enhanced register width check ("is_reg64") when record sub-register
    write, now, it returns more accurate width.
  - Re-run all tests under "test_progs" and "test_verifier" on x86_64, no
    regression. Fixed a couple of bugs exposed:
      1. ctx field size transformation was not taken into account.
      2. insn patch could cause lost of original aux data which is
         important for ctx field conversion.
      3. return value for propagate_liveness was wrong and caused
         regression on processed insn number.
      4. helper call arg wasn't handled properly that path prune may cause
         64-bit read info in pruned path lost.
  - Re-run Cilium bpf prog for processed-insn-number benchmarking, no
    regression.

v1:
  - Fixed the missing handling on callee-saved for bpf-to-bpf call,
    sub-register defs therefore moved to frame state. (Jakub Kicinski)
  - Removed redundant "cross_reg". (Jakub Kicinski)
  - Various coding styles & grammar fixes. (Jakub Kicinski, Quentin Monnet)

eBPF ISA specification requires high 32-bit cleared when low 32-bit
sub-register is written. This applies to destination register of ALU32 etc.
JIT back-ends must guarantee this semantic when doing code-gen. x86_64 and
AArch64 ISA has the same semantics, so the corresponding JIT back-end
doesn't need to do extra work.

However, 32-bit arches (arm, x86, nfp etc.) and some other 64-bit arches
(PowerPC, SPARC etc) need to do explicit zero extension to meet this
requirement, otherwise code like the following will fail.

  u64_value = (u64) u32_value
  ... other uses of u64_value

This is because compiler could exploit the semantic described above and
save those zero extensions for extending u32_value to u64_value, these JIT
back-ends are expected to guarantee this through inserting extra zero
extensions which however could be a significant increase on the code size.
Some benchmarks show there could be ~40% sub-register writes out of total
insns, meaning at least ~40% extra code-gen.

One observation is these extra zero extensions are not always necessary.
Take above code snippet for example, it is possible u32_value will never be
casted into a u64, the value of high 32-bit of u32_value then could be
ignored and extra zero extension could be eliminated.

This patch implements this idea, insns defining sub-registers will be
marked when the high 32-bit of the defined sub-register matters. For
those unmarked insns, it is safe to eliminate high 32-bit clearnace for
them.

Algo
====
We could use insn scan based static analysis to tell whether one
sub-register def doesn't need zero extension. However, using such static
analysis, we must do conservative assumption at branching point where
multiple uses could be introduced. So, for any sub-register def that is
active at branching point, we need to mark it as needing zero extension.
This could introducing quite a few false alarms, for example ~25% on
Cilium bpf_lxc.

It will be far better to use dynamic data-flow tracing which verifier
fortunately already has and could be easily extend to serve the purpose of
this patch set.

 - Split read flags into READ32 and READ64.

 - Record index of insn that does sub-register write. Keep the index inside
   reg state and update it during verifier insn walking.

 - A full register read on a sub-register marks its definition insn as
   needing zero extension on dst register.

   A new sub-register write overrides the old one.

 - When propagating read64 during path pruning, also mark any insn defining
   a sub-register that is read in the pruned path as full-register.

Benchmark
=========
 - I estimate the JITed image could be 10% ~ 30% smaller on these affected
   arches (nfp, arm, x32, risv, ppc, sparc, s390), depending on the prog.

 - For Cilium bpf_lxc, there is ~11500 insns in the compiled binary (use
   latest LLVM snapshot, and with -mcpu=v3 -mattr=+alu32 enabled), 4460 of
   them has sub-register writes (~40%). Calculated by:

    cat dump | grep -P "\tw" | wc -l       (ALU32)
    cat dump | grep -P "r.*=.*u32" | wc -l (READ_W)
    cat dump | grep -P "r.*=.*u16" | wc -l (READ_H)
    cat dump | grep -P "r.*=.*u8" | wc -l  (READ_B)

   After this patch set enabled, > 25% of those 4460 could be identified as
   doesn't needing zero extension on the destination, and the percentage
   could go further up to more than 50% with some follow up optimizations
   based on the infrastructure offered by this set. This leads to
   significant save on JITed image.

Jiong Wang (17):
  bpf: verifier: mark verified-insn with sub-register zext flag
  bpf: verifier: mark patched-insn with sub-register zext flag
  bpf: introduce new mov32 variant for doing explicit zero extension
  bpf: verifier: insert zero extension according to analysis result
  bpf: introduce new bpf prog load flags "BPF_F_TEST_RND_HI32"
  tools: bpf: sync uapi header bpf.h
  bpf: verifier: randomize high 32-bit when BPF_F_TEST_RND_HI32 is set
  libbpf: add "prog_flags" to
    bpf_program/bpf_prog_load_attr/bpf_load_program_attr
  selftests: bpf: adjust several test_verifier helpers for insn
    insertion
  selftests: bpf: enable hi32 randomization for all tests
  arm: bpf: eliminate zero extension code-gen
  powerpc: bpf: eliminate zero extension code-gen
  s390: bpf: eliminate zero extension code-gen
  sparc: bpf: eliminate zero extension code-gen
  x32: bpf: eliminate zero extension code-gen
  riscv: bpf: eliminate zero extension code-gen
  nfp: bpf: eliminate zero extension code-gen

 arch/arm/net/bpf_jit_32.c                          |  42 ++-
 arch/powerpc/net/bpf_jit_comp64.c                  |  36 ++-
 arch/riscv/net/bpf_jit_comp.c                      |  43 ++-
 arch/s390/net/bpf_jit_comp.c                       |  41 ++-
 arch/sparc/net/bpf_jit_comp_64.c                   |  29 +-
 arch/x86/net/bpf_jit_comp32.c                      |  83 ++++--
 drivers/net/ethernet/netronome/nfp/bpf/jit.c       | 115 ++++----
 drivers/net/ethernet/netronome/nfp/bpf/main.h      |   2 +
 drivers/net/ethernet/netronome/nfp/bpf/verifier.c  |  12 +
 include/linux/bpf.h                                |   1 +
 include/linux/bpf_verifier.h                       |  14 +-
 include/linux/filter.h                             |  15 ++
 include/uapi/linux/bpf.h                           |  18 ++
 kernel/bpf/core.c                                  |   9 +
 kernel/bpf/syscall.c                               |   4 +-
 kernel/bpf/verifier.c                              | 297 +++++++++++++++++++--
 tools/include/uapi/linux/bpf.h                     |  18 ++
 tools/lib/bpf/bpf.c                                |   1 +
 tools/lib/bpf/bpf.h                                |   1 +
 tools/lib/bpf/libbpf.c                             |   3 +
 tools/lib/bpf/libbpf.h                             |   1 +
 tools/testing/selftests/bpf/Makefile               |  10 +-
 .../selftests/bpf/prog_tests/bpf_verif_scale.c     |   1 +
 tools/testing/selftests/bpf/test_sock_addr.c       |   1 +
 tools/testing/selftests/bpf/test_sock_fields.c     |   1 +
 tools/testing/selftests/bpf/test_socket_cookie.c   |   1 +
 tools/testing/selftests/bpf/test_stub.c            |  40 +++
 tools/testing/selftests/bpf/test_verifier.c        |  31 ++-
 28 files changed, 723 insertions(+), 147 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/test_stub.c

-- 
2.7.4

