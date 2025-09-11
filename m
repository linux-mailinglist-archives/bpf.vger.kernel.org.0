Return-Path: <bpf+bounces-68064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DECBB52571
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 03:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA666580787
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 01:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A091624C5;
	Thu, 11 Sep 2025 01:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjPRWtqs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B3184D02
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 01:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757552694; cv=none; b=uAk+iIz5Rev+xSpofqNUPOLbbdeiyUTn/Hwwp7IOD1L9lGCvtjAUHXGWZsqtwvla1I+brYfKxf3NkGIufM3iS9fXujDZ2/HtINn6lGVRdybFJLZPgS81RM9sLFN6sNZOPvFB3gEQV8GV773gpedVV0WG/DwiwNE4zAUFPpwhaZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757552694; c=relaxed/simple;
	bh=xQZKwVpvWZ9nWPrWcyiRmQN/G4iR/uQeK1ypHAdxY0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a4YCVyQWTLZQahcjwwLTSMTejxxaz2tDRuz+ZsbkyRrS8cXc9s1lU0Ha/elVtsZERTkFhKF1SzktAbxJQ1qa11GAfYGx7EpPmqGv4rIfCSgmiM1BCz2dwA0Bt+VX1pzKlX43uIDTB7zvJKwVOAFvbUoyVKZZvzyNgPcFctjL3gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjPRWtqs; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7722c88fc5fso138294b3a.2
        for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 18:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757552692; x=1758157492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vKRDrKtgFlXYRiOyHC82P/E947gPt98y6YkSCujCiG8=;
        b=IjPRWtqsQVhEbYMgz6mj+dIZF7HdnHRz5kXLoXpd1BDgjO+KImYMGNhfKEAiwmZi9P
         BQCJuIb7bVS4YVotBd80fhF40p48yvz5LBRdr45BKrWCI68gzMdgP7lCYbA54dgZVZh5
         bZgexheuYrKQP1kkE/S3UsXEYGzmFMptpH1beRLMA2HkmLqR4EUxi2Esh7gL0F5LGym4
         6gn8wRTGYUr4m8p2uo0OuiByj2BRQY1LnPzF0UC/avNMethqdRjEVwK+a++NWs3voc5R
         BOkFvnUY8s4x+sFzp1+5kBUMcTgE4Z0MFcKcvZ2vynKSgFzxdGuOdz0PQ8aIz7jfg1GQ
         2pWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757552692; x=1758157492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vKRDrKtgFlXYRiOyHC82P/E947gPt98y6YkSCujCiG8=;
        b=c5+A4xUysH2OOAPo7yajAEUE0U5JRrOH6KXKbW0JPOb6MIr8otyEPBEKOQh593bPwf
         x/7HXC8Dda2FBQiPQLXcTVmhr5aiWsM0ixVNbbTDbmMSyo6JdlidOIQQklzKVM4p6/9o
         NKc2qolWfEqg66uJMya5vO3NwL2kYgD4aCQ2U7zOOYgyZuLLArjaiqKq6JmqkR3lImwG
         avd/mQlmdQ8KMRxAcb9hw6yRCrhlg5mR7vBZzwAcBKESdMzrrQQvbjo+LoLAF996YVZJ
         wFh0yIeGIwyl82OvvkFL49gQR3oEcyOoihhfG6jIIP66EcO1xQ2KIdWhLLQm36vB1hGq
         aVqw==
X-Gm-Message-State: AOJu0YxMG5Zurw4wJBa0YfN7MZqac0UWd55W1i9SrInoI/PFlu903WcL
	8oEaYcTIJAfChE2i+y1RK/2isaJSGFzPRTg8mAqig8nBYI6YpA1TdVHfg5rXqg==
X-Gm-Gg: ASbGncuLqOAH7mNqB4vBoZGeRZoRznts+6eCfI5G2qIiaU5rww45RmyR/PYkzmBDngi
	LFbe5x9CziTHWst4NztFiojluZshDhCboL9GzAJrvp+0oeKZBurOU5Ws4CRdTvnvn74ASVAAKT/
	AnpbQuatDQtua/O67aeNNe6ghobQlVqHXPZraphTvPpEtDoJ6SX8GKnDGsXffjHKOVLwE6xknAl
	cc+gBr4mYfw4gXlsT3RDB0O8C/C20gV+v9r8TLWQgg4Aca7tpSRjI+vz4lK612UoRQLceP0QG23
	H/iYqdhqBCmopPmmQst3VglAR5CUraNeX3bexB2RplLUUd4ZDR4h9301CVEJ0k61mPstwG90DJ6
	5ZmP1T7ySrrrTCjCvxbu8ICslMh41CTDgm7QEoNHWi3X6
X-Google-Smtp-Source: AGHT+IE6yCkOMmheTCTdZXl5IhmaDy+4Cfxy5C+mknY9L796Y9Auxhva6o99oagvmxiQ+KKCzAjexg==
X-Received: by 2002:a05:6a21:6da6:b0:252:9bf:ad81 with SMTP id adf61e73a8af0-25344132c60mr29109526637.29.1757552691676;
        Wed, 10 Sep 2025 18:04:51 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd61eaa27sm545511a91.1.2025.09.10.18.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 18:04:51 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v1 00/10] bpf: replace path-sensitive with path-insensitive live stack analysis
Date: Wed, 10 Sep 2025 18:04:25 -0700
Message-ID: <20250911010437.2779173-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Eduard Zingerman (10):
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

 Documentation/bpf/verifier.rst                | 264 -------
 include/linux/bpf_verifier.h                  |  52 +-
 kernel/bpf/Makefile                           |   2 +-
 kernel/bpf/liveness.c                         | 723 ++++++++++++++++++
 kernel/bpf/log.c                              |  28 +-
 kernel/bpf/verifier.c                         | 564 ++++----------
 .../testing/selftests/bpf/prog_tests/align.c  | 178 ++---
 .../selftests/bpf/prog_tests/spin_lock.c      |  12 +-
 .../selftests/bpf/prog_tests/test_veristat.c  |  44 +-
 .../selftests/bpf/progs/exceptions_assert.c   |  34 +-
 .../selftests/bpf/progs/iters_state_safety.c  |   4 +-
 .../selftests/bpf/progs/iters_testmod_seq.c   |   6 +-
 .../bpf/progs/mem_rdonly_untrusted.c          |   4 +-
 .../selftests/bpf/progs/verifier_bounds.c     |  38 +-
 .../bpf/progs/verifier_global_ptr_args.c      |   4 +-
 .../selftests/bpf/progs/verifier_ldsx.c       |   2 +-
 .../selftests/bpf/progs/verifier_precision.c  |  16 +-
 .../selftests/bpf/progs/verifier_scalar_ids.c |  10 +-
 .../selftests/bpf/progs/verifier_spill_fill.c |  40 +-
 .../bpf/progs/verifier_subprog_precision.c    |   6 +-
 .../selftests/bpf/verifier/bpf_st_mem.c       |   4 +-
 21 files changed, 1107 insertions(+), 928 deletions(-)
 create mode 100644 kernel/bpf/liveness.c

-- 
2.47.3


