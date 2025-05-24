Return-Path: <bpf+bounces-58892-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2077BAC3104
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 21:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 902D317B725
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 19:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AE81C07C3;
	Sat, 24 May 2025 19:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTp/nZlK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F30433997
	for <bpf@vger.kernel.org>; Sat, 24 May 2025 19:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748114391; cv=none; b=Y1nILNWH/XRHiWApF1p8K2COsZhibTfmo1+MXdSPKhPKa4wg4k+4d7twxANUmo317OIBdq4TaU3cTMvsVkUoxqQPWD6LGfuqiw/gpCarHoFRfmCevDJMHTOJyibrW2QN6IjdplTCrKYRb9XteacxJVTpqpnPT/BqC97DAlKA7AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748114391; c=relaxed/simple;
	bh=AIhn0o9RUZ1l2hV0Wb9GtwJh17v5rl2qc2fHaXqGCZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l3Ti+HiEF7o5UP6hEZpu3OiIoLgNPHdTnI6fVFFVSsz8TAuXYX1v0v7QSIaIdrlJFVruM13tzynGovq9yThIKVbeGD3T2L0tSjOfWoY0dus2SCLx6N8Yd5FD0yQBNBdVbMwpNBQXZ7ZCq66rLx9jwaZQ6bqdxfPDBRbicFBElpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTp/nZlK; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-742c9907967so1071065b3a.1
        for <bpf@vger.kernel.org>; Sat, 24 May 2025 12:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748114388; x=1748719188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zliX1GYRcsgbBrLAurBbvaUnEkCfLemmdkjwED//PJA=;
        b=VTp/nZlK1MyfSbQbNUPhR6kWoNl4CuIZiV6pLVEsckpiao39o78zXexCe6QW7yNYvL
         bBHhvCeonoR8Zg7oQnIICVe1s3tDTOlcFVq2EyqBeTUsmbHF47xOpxh+gHZ6yivgcvFm
         JDxIZIMi7IP9qvxqZhZli8ftVLs9TqUDWLi+gYdMGtADqYHKA0sSBVO8NJMl+uSRlzm+
         JkIevVZTUSyN+0DmxliAxiv03ajZS5ptkd6moGieyl+7omLgq82rHkdmPMxafjY6RySx
         hfLiu6Yxdw8Hdz6M1ifDnAEAUaUZn08ozC4yJHb9npJy0/UGSFbNxZiW5OscJh/CH34G
         h6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748114388; x=1748719188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zliX1GYRcsgbBrLAurBbvaUnEkCfLemmdkjwED//PJA=;
        b=UHDkpJTxawAK3bPZMJJtLVOPnLVF8iGXkbjhBK/dCyfR7nSgrVqRQNKExP6JxuOTuc
         QSIShEx6vzKyBfUt0c+avRVFVBdZxbvP6qvIDrqanyHSmOk/eoL3llHknW+YlXhVvrht
         yt7VKmPqFOxxuVmCd0NmCQ0KHePJkgJuE6F/p6aqalwu5Yik3gPi05sVk5iPPSVYbstd
         Lm3HW8XyeFGJaU2R38VucqFeF4qCq6ZNqyw8tTfGJ0PBj2Fl5OMEHfCI3sC1uZcEH1vu
         P5+VO2HxephOer9QVDMbq0BTXXG6pSEw7fwZ3mZhQRVHUSd0/ZL19RfsrVUE79Grnxu9
         bGUw==
X-Gm-Message-State: AOJu0YyIzBwWd4lXLPYneG89vWnb7YCj+LVAAO8pNIlwNN4qwrV8sf0A
	LQ3n2Y+YgL0zR+2+JFVfm5JdCoVTrG096EOXVQ/mqQy5fmLfgRykX0te3A0B2tZw
X-Gm-Gg: ASbGncvrZOJlUV1gnvlBk9VJuW/H+FWBvUXxHFahKkRiBPH5KIZfqvFeTN8ACTVP3P8
	N5SsxGLj7C6QpzgkkNOobU071eAz4+mzhZSdTBBvJTTaClmJdzdzwxo5b8a7vGaX3rI8U5/VRo4
	bsrWlVTgKt6Z/htla3wEUfbNQqry6PhykuE4i5IMi7UO3mCkP3yuWm/LFXAbgUQYZMrlVo2XxXb
	jN/n4hJQ3DZZBbd+4d4Ku1Ou69x1jDq4JXi3B3ADfM65/EAYKWI/KWZLiZxOJUCTsSKK/tcVLgX
	5IW536VOl97qZHw1dlAu0plz8osXfXou0IGmiIPX3+Fa69l11k2oc1KJJg==
X-Google-Smtp-Source: AGHT+IHYwzkFCqxHIH7oAL258ka96EhK8iq0qLMJrWLolrTyiL3fIUE+4rr28hCyxeQ6HmNIGFbeDw==
X-Received: by 2002:a05:6a00:1381:b0:740:9d7c:8f5c with SMTP id d2e1a72fcca58-745fe036213mr6522612b3a.18.1748114387827;
        Sat, 24 May 2025 12:19:47 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a986b38bsm14558298b3a.129.2025.05.24.12.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 May 2025 12:19:47 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 00/11] bpf: propagate read/precision marks over state graph backedges
Date: Sat, 24 May 2025 12:19:21 -0700
Message-ID: <20250524191932.389444-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current loop_entry-based states comparison logic does not handle the
following case:

 .-> A --.  Assume the states are visited in the order A, B, C.
 |   |   |  Assume that state B reaches a state equivalent to state A.
 |   v   v  At this point, state C is not processed yet, so state A
 '-- B   C  has not received any read or precision marks from C.
            As a result, these marks won't be propagated to B.

If B has incomplete marks, it is unsafe to use it in states_equal()
checks. This issue was first reported in [1].

This patch-set
--------------

Here is the gist of the algorithm implemented by this patch-set:
- Compute strongly connected components (SCCs) in the program CFG.
- When a verifier state enters an SCC, that state is recorded as the
  SCC's entry point.
- When a verifier state is found to be equivalent to another
  (e.g., B to A in the example above), it is recorded as a
  states-graph backedge.
- Backedges are accumulated per SCC (*).
- When an SCC entry state reaches `branches == 0`, propagate read and
  precision marks through the backedges until a fixed point is reached
  (e.g., from A to B, from C to A, and then again from A to B).

(*) This is an oversimplification, see patch #8 for details.

Unfortunately, this means that commit [2] needs to be reverted,
as precision propagation requires access to jump history,
and backedges represent history not belonging to `env->cur_state`.

Details are provided in patch #8; a comment in `is_state_visited()`
explains most of the mechanics.

Patch #2 adds a `compute_scc()` function, which computes SCCs in the
program CFG. This function was tested using property-based testing in
[3], but it is not included in selftests.

Previous attempt
----------------

A previous attempt to fix this is described in [4]:
1. Within the states loop, `states_equal(... RANGE_WITHIN)` ignores
   read and precision marks.
2. For states outside the loop, all registers for states within the
   loop are marked as read and precise.

This approach led to an 86x regression on the `cond_break1` selftest.
In that test, one loop was followed by another, and a certain variable
was incremented in the second loop. This variable was marked as
precise due to rule (2), which hindered convergence in the first loop.

After some off-list discussion, it was decided that this might be a
typical case and such regressions are undesirable.

This patch-set avoids such eager precision markings.

Alternatives
------------

Another option is to associate a mask of read/written/precise stack
slots with each instruction. This mask can be populated during
verifier states exploration. Upon reaching an `EXIT` instruction or an
equivalent state, the accumulated masks can be used to propagate
read/written/precise bits across the program's control flow graph
using an analysis similar to use-def.

Unfortunately, a naive implementation of this approach [5] results in
a 10x regression in `veristat` for some `sched_ext` programs due to
the inability to express the must-write property. This issue requires
further investigation.

Veristat changes
----------------

There are some veristat regressions when comparing with master using
selftests and sched_ext BPF binaries.

========= selftests: master vs patch-set =========

File                                Program                            Insns (A)  Insns (B)  Insns     (DIFF)
----------------------------------  ---------------------------------  ---------  ---------  ----------------
arena_list.bpf.o                    arena_list_add                           374        406      +32 (+8.56%)
dynptr_success.bpf.o                test_copy_from_user_dynptr               497        498       +1 (+0.20%)
dynptr_success.bpf.o                test_copy_from_user_str_dynptr           268        284      +16 (+5.97%)
dynptr_success.bpf.o                test_probe_read_kernel_dynptr            994       1101    +107 (+10.76%)
dynptr_success.bpf.o                test_probe_read_kernel_str_dynptr        927        965      +38 (+4.10%)
dynptr_success.bpf.o                test_probe_read_user_dynptr             1000       1107    +107 (+10.70%)
dynptr_success.bpf.o                test_probe_read_user_str_dynptr          930        968      +38 (+4.09%)
iters.bpf.o                         checkpoint_states_deletion              1211       1216       +5 (+0.41%)
iters.bpf.o                         clean_live_states                        588        620      +32 (+5.44%)
iters.bpf.o                         iter_subprog_check_stacksafe             128        136       +8 (+6.25%)
pyperf600_iter.bpf.o                on_event                                2591       5929  +3338 (+128.83%)
test_usdt.bpf.o                     usdt12                                  1803       1860      +57 (+3.16%)
verifier_iterating_callbacks.bpf.o  cond_break2                               90        110     +20 (+22.22%)

Total progs: 3597
Old success: 2081
New success: 2081
States diff min:    0.00%
States diff max:  121.88%
   0 .. 5    %: 3589
   5 .. 15   %: 4
  15 .. 25   %: 2
  30 .. 40   %: 1
 120 .. 125  %: 1

========= sched_ext: master vs patch-set =========

File       Program                Insns (A)  Insns (B)  Insns    (DIFF)
---------  ---------------------  ---------  ---------  ---------------
bpf.bpf.o  bpfland_init                 975       1012     +37 (+3.79%)
bpf.bpf.o  chaos_dispatch              4229       4259     +30 (+0.71%)
bpf.bpf.o  chaos_init                  3462       3819   +357 (+10.31%)
bpf.bpf.o  lavd_cpu_offline            5063       5695   +632 (+12.48%)
bpf.bpf.o  lavd_cpu_online             5063       5695   +632 (+12.48%)
bpf.bpf.o  lavd_dispatch              41769      47578  +5809 (+13.91%)
bpf.bpf.o  lavd_enqueue               24190      27749  +3559 (+14.71%)
bpf.bpf.o  lavd_init                   6748       7474   +726 (+10.76%)
bpf.bpf.o  lavd_select_cpu            27243      30802  +3559 (+13.06%)
bpf.bpf.o  layered_dispatch            8909      13295  +4386 (+49.23%)
bpf.bpf.o  layered_dump                1890       2097   +207 (+10.95%)
bpf.bpf.o  layered_enqueue             8154       8207     +53 (+0.65%)
bpf.bpf.o  layered_init                3890       4274    +384 (+9.87%)
bpf.bpf.o  layered_runnable            1834       1868     +34 (+1.85%)
bpf.bpf.o  p2dq_dispatch               1057       1086     +29 (+2.74%)
bpf.bpf.o  p2dq_dispatch               1057       1086     +29 (+2.74%)
bpf.bpf.o  p2dq_init                   3067       3418   +351 (+11.44%)
bpf.bpf.o  p2dq_init                   3067       3418   +351 (+11.44%)
bpf.bpf.o  rusty_init                 35707      35766     +59 (+0.17%)
bpf.bpf.o  tp_cgroup_attach_task        149        203    +54 (+36.24%)

Total progs: 147
Old success: 134
New success: 134
States diff min:    0.00%
States diff max:   45.09%
   0 .. 5    %: 138
   5 .. 15   %: 5
  15 .. 25   %: 2
  25 .. 35   %: 1
  45 .. 50   %: 1

[1] https://lore.kernel.org/bpf/20250312031344.3735498-1-eddyz87@gmail.com/
[2] commit 96a30e469ca1 ("bpf: use common instruction history across all states")
[3] https://github.com/eddyz87/scc-test
[4] https://lore.kernel.org/bpf/20250426104634.744077-1-eddyz87@gmail.com/
[5] https://github.com/eddyz87/bpf/tree/propagate-read-and-precision-in-cfg

Eduard Zingerman (11):
  Revert "bpf: use common instruction history across all states"
  bpf: compute SCCs in program control flow graph
  bpf: frame_insn_idx() utility function
  bpf: starting_state parameter for __mark_chain_precision()
  bpf: set 'changed' status if propagate_precision() did any updates
  bpf: set 'changed' status if propagate_liveness() did any updates
  bpf: move REG_LIVE_DONE check to clean_live_states()
  bpf: propagate read/precision marks over state graph backedges
  bpf: remove {update,get}_loop_entry functions
  bpf: include backedges in peak_states stat
  selftests/bpf: tests with a loop state missing read/precision mark

 include/linux/bpf_verifier.h              |  77 +-
 kernel/bpf/verifier.c                     | 968 +++++++++++++++-------
 tools/testing/selftests/bpf/progs/iters.c | 277 +++++++
 3 files changed, 997 insertions(+), 325 deletions(-)

-- 
2.48.1


