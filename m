Return-Path: <bpf+bounces-68886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69950B87B80
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 04:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D16867BC5DC
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 02:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA2A26E712;
	Fri, 19 Sep 2025 02:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiBgWBmE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B0A258ED2
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 02:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758248344; cv=none; b=r3OVIiF9JFjxn4n7+5P+Pr8u6zpy2DTOr/StRjTibSmlZUwF51Y1/BjJiMAwOSXOnyBS7PH2V97Im6ZeRsJl9GUkIRtrutpHHZvhZfod85TkFkYhvDS6CBjcDbEIl1U4m5vP/2o6XSqH8E3vHTKdX2TlURltRibdGZWL2oSBPzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758248344; c=relaxed/simple;
	bh=3rua70RKlJPPXL34vFN5+vxvk1K8chI8Omi4uVadUuI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UsnQxCgOQjzVItjSA0YG5m0xp3ywBNJUB22huPwleTS9o2IyNOMsjTL4ZWug0B5JEZEEdW1F35iwYM8z2g/TIDWqNCJpFVzXsrlBLjC28+/xhEPtLlW9wop+/pOLqX/5MFUKH5IAgSQw9rFZL+Aua5Eg1kZiTuwgG4UgVnNzXjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZiBgWBmE; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-26685d63201so15682135ad.0
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 19:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758248341; x=1758853141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fR+mqOYjRZOMxqmV6iC/wUxy5ivTL8bdwJkOgJkssig=;
        b=ZiBgWBmE5Ijwhq4yEtsLWieRls0mFnPG0pxZXBzXykaoSg0js448gf/4mrM2GjCyK8
         alkgR0MxTsJg9GTOAGk50cDmbaRBz9arvhPo/18aPQGZw7ZvOWTSZXX+ZMORevMYNxRM
         tzlIoHCOfipf6Tog0HWHqKbRBdYG03Llpf3rvDuxHU7nSVnISndraBLmEqP61jj3zjs5
         FhLOANUaMPxmbLl/53Y5afBuCgeVt49kDMAg3rnAacc32vIM0O6n5X2JqyAVzvIPaxvm
         Avd7McOTUGbdedziNXuymZnP/7MIC8+cW28zp99TLc/5pAMwc++d06IxTSOLHIETsqLo
         vcRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758248341; x=1758853141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fR+mqOYjRZOMxqmV6iC/wUxy5ivTL8bdwJkOgJkssig=;
        b=bIsGXPHFbtHm3jok3kJnyIKP9Sa6h1zpgEdnkDwDxcUMO2FV/R/M4+cFwg/fTZm4sQ
         sS8gGlJqTNjVnJ9qi9fQv3QywtvTHCgC6Ersn+q7B5UGLtkLCNDyM7eHe3TDfcxUNhiv
         pXPyzDCssXzwJmtrDXGBBt93N0hmDcR9rw5o9YVxfXgPAV4XXFEUisqVjMefxUyQ8Ok+
         4VV0B54sm5Ins13DFYd5beZYv4amcfO2OSmXXHv/AljRf3s3rPZRNWwfyP8w3/YHkNCB
         GjvJMe+0npmwUu2c9bsZwP1OD/tCcX7RcgojfXihSZMzox1+D2rvF0b2L6HV7StTlAGB
         y/fw==
X-Gm-Message-State: AOJu0YzMhD4IBj0AUITT/MToxRFYcihdfV8r8xtJyP5DxwPcakdKTY1P
	Gc89xFbRTOTCXf8OAhUSnfu6MXm/KmXoKNnOI0Ia3Krfy1NSOmxnVaQNkexsug==
X-Gm-Gg: ASbGncub+aBNfhe4gT3Wb1wKuFHVV5t4S7cEm+BtJ251AZ7coiNnTQtfhABByTZP/i/
	KY73wJclKfXBw64J3uVc+NKSsYD1javDcKMLkrNGyy2OovpLaRCgQjfzG1D7vD4MZr02a7Up+At
	kj9598sVP16SBbl1yIodMntLu1n4OhbBb46prEARPEZrZ47UuFafygWquyIgJVyaZbXE1JbMJnL
	bynUWuxRAb+5boCKrUUGmCZxuKZUp3VrWCzxe3yWxrMDpMd647325eAM1Qwcqo4eUAZcLk0d9oZ
	WR4w6NOnhtGY/M+jH19RZeYxvLfJd/3uMnETzO/l26dxMvJPk5V2B+3Pp2W/uqQ++TJ6LxPrqw1
	PtcY8xvwoP0Lj6X58
X-Google-Smtp-Source: AGHT+IHbJUmW333ZWvrWDawijwHTzVLhuDVIx0W2/Vh2AG10/7GbtQoQLgVkoyNnOwXSSvjZIz4J8g==
X-Received: by 2002:a17:903:1209:b0:267:bd8d:1a5 with SMTP id d9443c01a7336-269ba42d5b8mr23705455ad.22.1758248340838;
        Thu, 18 Sep 2025 19:19:00 -0700 (PDT)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698033a3e5sm39186235ad.126.2025.09.18.19.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 19:19:00 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 00/12] bpf: replace path-sensitive with path-insensitive live stack analysis
Date: Thu, 18 Sep 2025 19:18:33 -0700
Message-ID: <20250918-callchain-sensitive-liveness-v3-0-c3cd27bacc60@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20250910-callchain-sensitive-liveness-89a18daff6f0
Content-Transfer-Encoding: 8bit

Consider the following program, assuming checkpoint is created for a
state at instruction (3):

  1: call bpf_get_prandom_u32()
  2: *(u64 *)(r10 - 8) = 42
  -- checkpoint #1 --
  3: if r0 != 0 goto +1
  4: exit;
  5: r0 = *(u64 *)(r10 - 8)
  6: exit

The verifier processes this program by exploring two paths:
 - 1 -> 2 -> 3 -> 4
 - 1 -> 2 -> 3 -> 5 -> 6

When instruction (5) is processed, the current liveness tracking
mechanism moves up the register parent links and records a "read" mark
for stack slot -8 at checkpoint #1, stopping because of the "write"
mark recorded at instruction (2).

This patch set replaces the existing liveness tracking mechanism with
a path-insensitive data flow analysis. The program above is processed
as follows:
 - a data structure representing live stack slots for
   instructions 1-6 in frame #0 is allocated;
 - when instruction (2) is processed, record that slot -8 is written at
   instruction (2) in frame #0;
 - when instruction (5) is processed, record that slot -8 is read at
   instruction (5) in frame #0;
 - when instruction (6) is processed, propagate read mark for slot -8
   up the control flow graph to instructions 3 and 2.

The key difference is that the new mechanism operates on a control
flow graph and associates read and write marks with pairs of (call
chain, instruction index). In contrast, the old mechanism operates on
verifier states and register parent links, associating read and write
marks with verifier states.

Motivation
==========

As it stands, this patch set makes liveness tracking slightly less
precise, as it no longer distinguishes individual program paths taken
by the verifier during symbolic execution.
See the "Impact on verification performance" section for details.

However, this change is intended as a stepping stone toward the
following goals:
 - Short term, integrate precision tracking into liveness analysis and
   remove the following code:
   - verifier backedge states accumulation in is_state_visited();
   - most of the logic for precision tracking;
   - jump history tracking.
 - Long term, help with more efficient loop verification handling.

 Why integrating precision tracking?
 -----------------------------------

In a sense, precision tracking is very similar to liveness tracking.
The data flow equations for liveness tracking look as follows:

  live_after =
    U [state[s].live_before for s in insn_successors(i)]

  state[i].live_before =
    (live_after / state[i].must_write) U state[i].may_read

While data flow equations for precision tracking look as follows:

  precise_after =
    U [state[s].precise_before for s in insn_successors(i)]

  // if some of the instruction outputs are precise,
  // assume its inputs to be precise
  induced_precise =
    ⎧ state[i].may_read   if (state[i].may_write ∩ precise_after) ≠ ∅
    ⎨
    ⎩ ∅                   otherwise

  state[i].precise_before =
    (precise_after / state[i].must_write) ∩ induced_precise

Where:
 - `may_read` set represents a union of all possibly read slots
   (any slot in `may_read` set might be by the instruction);
 - `must_write` set represents an intersection of all possibly written slots
   (any slot in `must_write` set is guaranteed to be written by the instruction).
 - `may_write` set represents a union of all possibly written slots
   (any slot in `may_write` set might be written by the instruction).

This means that precision tracking can be implemented as a logical
extension of liveness tracking:
 - track registers as well as stack slots;
 - add bit masks to represent `precise_before` and `may_write`;
 - add above equations for `precise_before` computation;
 - (linked registers require some additional consideration).

Such extension would allow removal of:
 - precision propagation logic in verifier.c:
   - backtrack_insn()
   - mark_chain_precision()
   - propagate_{precision,backedges}()
 - push_jmp_history() and related data structures, which are only used
   by precision tracking;
 - add_scc_backedge() and related backedge state accumulation in
   is_state_visited(), superseded by per-callchain function state
   accumulated by liveness analysis.

The hope here is that unifying liveness and precision tracking will
reduce overall amount of code and make it easier to reason about.

 How this helps with loops?
 --------------------------

As it stands, this patch set shares the same deficiency as the current
liveness tracking mechanism. Liveness marks on stack slots cannot be
used to prune states when processing iterator-based loops:
 - such states still have branches to be explored;
 - meaning that not all stack slot reads have been discovered.

For example:

  1: while(iter_next()) {
  2:   if (...)
  3:     r0 = *(u64 *)(r10 - 8)
  4:   if (...)
  5:     r0 = *(u64 *)(r10 - 16)
  6:   ...
  7: }

For any checkpoint state created at instruction (1), it is only
possible to rely on read marks for slots fp[-8] and fp[-16] once all
child states of (1) have been explored. Thus, when the verifier
transitions from (7) to (1), it cannot rely on read marks.

However, sacrificing path-sensitivity makes it possible to run
analysis defined in this patch set before main verification pass,
if estimates for value ranges are available.
E.g. for the following program:

  1: while(iter_next()) {
  2:   r0 = r10
  3:   r0 += r2
  4:   r0 = *(u64 *)(r2 + 0)
  5:   ...
  6: }

If an estimate for `r2` range is available before the main
verification pass, it can be used to populate read marks at
instruction (4) and run the liveness analysis. Thus making
conservative liveness information available during loops verification.

Such estimates can be provided by some form of value range analysis.
Value range analysis is also necessary to address loop verification
from another angle: computing boundaries for loop induction variables
and iteration counts.

The hope here is that the new liveness tracking mechanism will support
the broader goal of making loop verification more efficient.

Validation
==========

The change was tested on three program sets:
 - bpf selftests
 - sched_ext
 - Meta's internal set of programs

Commit [#8] enables a special mode where both the current and new
liveness analyses are enabled simultaneously. This mode signals an
error if the new algorithm considers a stack slot dead while the
current algorithm assumes it is alive. This mode was very useful for
debugging. At the time of posting, no such errors have been reported
for the above program sets.

[#8] "bpf: signal error if old liveness is more conservative than new"

Impact on memory consumption
============================

Debug patch [1] extends the kernel and veristat to count the amount of
memory allocated for storing analysis data. This patch is not included
in the submission. The maximal observed impact for the above program
sets is 2.6Mb.

Data below is shown in bytes.

For bpf selftests top 5 consumers look as follows:

  File                     Program           liveness mem
  -----------------------  ----------------  ------------
  pyperf180.bpf.o          on_event               2629740
  pyperf600.bpf.o          on_event               2287662
  pyperf100.bpf.o          on_event               1427022
  test_verif_scale3.bpf.o  balancer_ingress       1121283
  pyperf_subprogs.bpf.o    on_event                756900

For sched_ext top 5 consumers loog as follows:

  File       Program                          liveness mem
  ---------  -------------------------------  ------------
  bpf.bpf.o  lavd_enqueue                           164686
  bpf.bpf.o  lavd_select_cpu                        157393
  bpf.bpf.o  layered_enqueue                        154817
  bpf.bpf.o  lavd_init                              127865
  bpf.bpf.o  layered_dispatch                       110129

For Meta's internal set of programs top consumer is 1Mb.

[1] https://github.com/kernel-patches/bpf/commit/085588e787b7998a296eb320666897d80bca7c08

Impact on verification performance
==================================

Veristat results below are reported using
`-f insns_pct>1 -f !insns<500` filter and -t option
(BPF_F_TEST_STATE_FREQ flag).

 master vs patch-set, selftests (out of ~4K programs)
 ----------------------------------------------------

  File                              Program                                 Insns (A)  Insns (B)  Insns    (DIFF)
  --------------------------------  --------------------------------------  ---------  ---------  ---------------
  cpumask_success.bpf.o             test_global_mask_nested_deep_array_rcu       1622       1655     +33 (+2.03%)
  strobemeta_bpf_loop.bpf.o         on_event                                     2163       2684   +521 (+24.09%)
  test_cls_redirect.bpf.o           cls_redirect                                36001      42515  +6514 (+18.09%)
  test_cls_redirect_dynptr.bpf.o    cls_redirect                                 2299       2339     +40 (+1.74%)
  test_cls_redirect_subprogs.bpf.o  cls_redirect                                69545      78497  +8952 (+12.87%)
  test_l4lb_noinline.bpf.o          balancer_ingress                             2993       3084     +91 (+3.04%)
  test_xdp_noinline.bpf.o           balancer_ingress_v4                          3539       3616     +77 (+2.18%)
  test_xdp_noinline.bpf.o           balancer_ingress_v6                          3608       3685     +77 (+2.13%)

 master vs patch-set, sched_ext (out of 148 programs)
 ----------------------------------------------------

  File       Program           Insns (A)  Insns (B)  Insns    (DIFF)
  ---------  ----------------  ---------  ---------  ---------------
  bpf.bpf.o  chaos_dispatch         2257       2287     +30 (+1.33%)
  bpf.bpf.o  lavd_enqueue          20735      22101   +1366 (+6.59%)
  bpf.bpf.o  lavd_select_cpu       22100      24409  +2309 (+10.45%)
  bpf.bpf.o  layered_dispatch      25051      25606    +555 (+2.22%)
  bpf.bpf.o  p2dq_dispatch           961        990     +29 (+3.02%)
  bpf.bpf.o  rusty_quiescent         526        534      +8 (+1.52%)
  bpf.bpf.o  rusty_runnable          541        547      +6 (+1.11%)

Perf report
===========

In relative terms, the analysis does not consume much CPU time.
For example, here is a perf report collected for pyperf180 selftest:

 # Children      Self  Command   Shared Object         Symbol
 # ........  ........  ........  ....................  ........................................
        ...
      1.22%     1.22%  veristat  [kernel.kallsyms]     [k] bpf_update_live_stack
        ...

Changelog
=========

v1: https://lore.kernel.org/bpf/20250911010437.2779173-1-eddyz87@gmail.com/T/
v1 -> v2:
 - compute_postorder() fixed to handle jumps with offset -1 (syzbot).
 - is_state_visited() in patch #9 fixed access to uninitialized `err`
   (kernel test robot, Dan Carpenter).
 - Selftests added.
 - Fixed bug with write marks propagation from callee to caller,
   see verifier_live_stack.c:caller_stack_write() test case.
 - Added a patch for __not_msg() annotation for test_loader based
   tests.

v2: https://lore.kernel.org/bpf/20250918-callchain-sensitive-liveness-v2-0-214ed2653eee@gmail.com/
v2 -> v3:
 - Added __diag_ignore_all("-Woverride-init", ...) in liveness.c for
   bpf_insn_successors() (suggested by Alexei).

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
Eduard Zingerman (12):
      bpf: bpf_verifier_state->cleaned flag instead of REG_LIVE_DONE
      bpf: use compute_live_registers() info in clean_func_state
      bpf: remove redundant REG_LIVE_READ check in stacksafe()
      bpf: declare a few utility functions as internal api
      bpf: compute instructions postorder per subprogram
      bpf: callchain sensitive stack liveness tracking using CFG
      bpf: enable callchain sensitive stack liveness tracking
      bpf: signal error if old liveness is more conservative than new
      bpf: disable and remove registers chain based liveness
      bpf: table based bpf_insn_successors()
      selftests/bpf: __not_msg() tag for test_loader framework
      selftests/bpf: test cases for callchain sensitive live stack tracking

 Documentation/bpf/verifier.rst                     | 264 --------
 include/linux/bpf_verifier.h                       |  52 +-
 kernel/bpf/Makefile                                |   2 +-
 kernel/bpf/liveness.c                              | 733 +++++++++++++++++++++
 kernel/bpf/log.c                                   |  28 +-
 kernel/bpf/verifier.c                              | 568 +++++-----------
 tools/testing/selftests/bpf/prog_tests/align.c     | 178 ++---
 .../bpf/prog_tests/prog_tests_framework.c          | 125 ++++
 tools/testing/selftests/bpf/prog_tests/spin_lock.c |  12 +-
 .../selftests/bpf/prog_tests/test_veristat.c       |  44 +-
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
 tools/testing/selftests/bpf/progs/bpf_misc.h       |   9 +
 .../selftests/bpf/progs/exceptions_assert.c        |  34 +-
 .../selftests/bpf/progs/iters_state_safety.c       |   4 +-
 .../selftests/bpf/progs/iters_testmod_seq.c        |   6 +-
 .../selftests/bpf/progs/mem_rdonly_untrusted.c     |   4 +-
 .../testing/selftests/bpf/progs/verifier_bounds.c  |  38 +-
 .../selftests/bpf/progs/verifier_global_ptr_args.c |   4 +-
 tools/testing/selftests/bpf/progs/verifier_ldsx.c  |   2 +-
 .../selftests/bpf/progs/verifier_live_stack.c      | 294 +++++++++
 .../selftests/bpf/progs/verifier_precision.c       |  16 +-
 .../selftests/bpf/progs/verifier_scalar_ids.c      |  10 +-
 .../selftests/bpf/progs/verifier_spill_fill.c      |  40 +-
 .../bpf/progs/verifier_subprog_precision.c         |   6 +-
 tools/testing/selftests/bpf/test_loader.c          | 201 ++++--
 tools/testing/selftests/bpf/test_progs.h           |  17 +
 tools/testing/selftests/bpf/verifier/bpf_st_mem.c  |   4 +-
 27 files changed, 1718 insertions(+), 979 deletions(-)
---
base-commit: 3547a61ee2fe8f1fc46d4326a9517d97ae3614cd
change-id: 20250910-callchain-sensitive-liveness-89a18daff6f0

