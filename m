Return-Path: <bpf+bounces-59926-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A15AD0942
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 23:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61A3C3B505C
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 21:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F79D21B185;
	Fri,  6 Jun 2025 21:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATKdDj7P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE87EA31
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 21:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749243872; cv=none; b=E/sHPQLBWmIisJeeAkFvt1xyon167k5MOAYHm1LUf87Y5o5BaWw5BuTgEDplHb0IAEMLjPiSVVHEG2/0FdaEj2i155WthCY1IRJ1LjSjaWjU3+Xl3397QECz7h/euczgCj3UlWTVey++KBAoMtKw3+jp8HNQxjAKCvBa2nZX1lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749243872; c=relaxed/simple;
	bh=4SkBHtmc9H3AJeQuv3c311Pel/9N+27oMXghCHD6oKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=COLQ846XDnIOrHv0uD4E8wEcfpfUwYTUCOeFzrqY52bmlwNQl/DpMocQs45X+uZHEWoSK5qUYm3trFCysR5sSpY2mh3PNMGcQeQSjfKCaF/AnJ7SePXFWZtqVIoY0D14i8mvWKSldNjNA8t7LU/uIhv4q1lGcMl2GfhFWDpKDpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATKdDj7P; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-234c5b57557so24390955ad.3
        for <bpf@vger.kernel.org>; Fri, 06 Jun 2025 14:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749243870; x=1749848670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Idc3GiWzhJGiCp70TyYxay+PJjY3nhZgc2KSe3k7/6U=;
        b=ATKdDj7P+Nd6mz8GtY+VQjpvP3IHOyKtSN33eaQV30I898vdiWscBYQ/RNux0J2KGH
         zbDQUI/Y7hqr4kQLPbfdKSxZdAqRCpMEeO4wwkWfw0NVqZfz+lz7tvMbgZnNooh8ljnx
         oniCHq5TVmeJhVSDkS0YqXO51ba3DR8hhRSeZUxI5wxKqcfgBXqb9mRRBCCsr5u+SRlg
         knfkjFawJt3f3Xsorsh8ZvtyUUDE9EJoaqcQ2hZjxEIw+v55v/Ej1hoU63Gcv7jzQq/6
         VcL37mavYBA6Py/CEZ8vwn6q7QZ5oCKwrzcV40FCfGcPGVX1a5uv2EK+eJP194AiNuc3
         CGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749243870; x=1749848670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Idc3GiWzhJGiCp70TyYxay+PJjY3nhZgc2KSe3k7/6U=;
        b=GqdMLU3QA6e9FfV6wYR3v7QzWLyLNA9S0dFr+yq6Hc8VdGq3cb4hE0pztPTR23oE7q
         nHkPs6ySLSp1vy5rsTRM+/FELVZH8mb+tGP8kiJbNjSTc5BIKZpu7XqB1t0Rz/dOcIBj
         /QlWhQSErxwGHEiVNHaUjevustLjIP2plPCyqtdmUfdNtv6ynBaGbQ4+J1B7PXOoELij
         lp2UAOt+lfB6NDQHBePz9G6VvnYcXmJtnWs57lUr4raGHAp2UxR2qw+Cad/3WzWK7kZD
         cqQDG8lCTXu7O5ePeZ+fakKoFF7BgNLoDLZzuYC/uovXpra/v1zGyMsLvl7463q+WJpB
         BW6Q==
X-Gm-Message-State: AOJu0YxvTJkp+CYIwEj7Yu4e7trx9eeEplo0d5ONUSSq7ZvJyZdF8DQI
	VgwoL0Yx4+aL+091vrSJ4SxiEAcqnVAVJKFhyVS7X2mJwiuJQuQj1x19RoHAvA34
X-Gm-Gg: ASbGncudl1YVeLogUFH5QWjp/2CtWPdLTup1qLYBeZU8u+9lBbcqtTvE4IP8cAIQdu+
	m/eIegngD6SpuRbJUA5/zDzjqcHcEXwCPwUOyQYHfuwpihUiThFUVQoe4/q6l60pw1sMecmc5g7
	MNO2OEyLqkrtCgtagk+gS5cBV68hu4y+TwDQho8+fUWDhI/BBdV4Xx598/gxyTd7PwyAanVtnTJ
	1yGzybK2CwQfmbBHD9BIsga8vb1sqtf75m3EUm8+UuCMhoeH+CQIwZWbXgYgRU/0BqV4jZ+sMA8
	d7Z+di/d9T4huFP5QIKrlY0ETqJl1zoT06iVEmgRzmCF7FiLs0F0mfHcmg==
X-Google-Smtp-Source: AGHT+IF+rYCD9HigCj4Rd3VTrSNvylLu8KFULHvLHP2uH78gvzY0Vvzy/GhhSMY4NapQglHJndaSwA==
X-Received: by 2002:a17:902:ced1:b0:234:d292:be8f with SMTP id d9443c01a7336-23601cf3065mr72099295ad.1.1749243869769;
        Fri, 06 Jun 2025 14:04:29 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2f5ed58beasm1352640a12.15.2025.06.06.14.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 14:04:29 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 00/11] bpf: propagate read/precision marks over state graph backedges
Date: Fri,  6 Jun 2025 14:03:41 -0700
Message-ID: <20250606210352.1692944-1-eddyz87@gmail.com>
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

Changes in verification performance
-----------------------------------

There are some veristat regressions when comparing with master using
selftests and sched_ext BPF binaries. The comparison is done using
master from [6] and this patch-set from [7] where memory accounting
logic is added to veristat.

========= selftests: master vs patch-set =========

File                             Program                              Insns                          Peak memory (KiB)
-------------------------------  -----------------------------------  -----  ----  ----------------  ----  -----  ----------------
arena_list.bpf.o                 arena_list_add                         374   406      +32 (+8.56%)     0      0       +0 (+0.00%)
dynptr_success.bpf.o             test_copy_from_user_str_dynptr         268   284      +16 (+5.97%)   768   1024    +256 (+33.33%)
dynptr_success.bpf.o             test_probe_read_kernel_dynptr          994  1101    +107 (+10.76%)  1024   1240    +216 (+21.09%)
dynptr_success.bpf.o             test_probe_read_user_dynptr           1000  1107    +107 (+10.70%)  1024   1240    +216 (+21.09%)
iters.bpf.o                      checkpoint_states_deletion            1211  1216       +5 (+0.41%)   512   1288   +776 (+151.56%)
iters.bpf.o                      clean_live_states                      588   620      +32 (+5.44%)   256    764   +508 (+198.44%)
pyperf600_iter.bpf.o             on_event                              2591  5929  +3338 (+128.83%)  4648  11320  +6672 (+143.55%)

Total progs: 3600
Old success: 2084
New success: 2084

total_insns diff min     :    0.00 %
total_insns diff max     :  128.83 %
total_insns abs max old  : 837,487
total_insns abs max new  : 837,487
   0 .. 5    %: 3592
   5 .. 15   %: 6
  20 .. 30   %: 1
 125 .. 130  %: 1

mem_peak diff min     : -100.00 %
mem_peak diff max     :  198.44 %
mem_peak abs max old  : 269,312 KiB
mem_peak abs max new  : 269,312 KiB
-100 .. -95  %: 63
 -60 .. -50  %: 1
 -10 .. 0    %: 20
   0 .. 5    %: 3413
   5 .. 15   %: 6
  20 .. 30   %: 4
  30 .. 40   %: 7
  40 .. 50   %: 1
  50 .. 60   %: 3
  60 .. 70   %: 1
 140 .. 150  %: 1
 150 .. 160  %: 1
 195 .. 200  %: 1
0 -> something: 78

========= scx: master vs patch-set =========

Program                   Insns                          Peak memory (KiB)
------------------------  -----  -----  ---------------  -----  -----  -----------------
arena_topology_node_init   2129   2391   +262 (+12.31%)    768    768        +0 (+0.00%)
arena_topology_node_init   2129   2391   +262 (+12.31%)    768    768        +0 (+0.00%)
arena_topology_print        591    826   +235 (+39.76%)    256    256        +0 (+0.00%)
arena_topology_print        591    826   +235 (+39.76%)    256    256        +0 (+0.00%)
chaos_init                 4261   5090   +829 (+19.46%)   2540   3032     +492 (+19.37%)
lavd_cpu_offline           5074   5706   +632 (+12.46%)   3940   6304    +2364 (+60.00%)
lavd_cpu_online            5074   5706   +632 (+12.46%)   3940   6304    +2364 (+60.00%)
lavd_dispatch             41769  47578  +5809 (+13.91%)   6208  29200  +22992 (+370.36%)
lavd_enqueue              24190  27749  +3559 (+14.71%)  22740  42872   +20132 (+88.53%)
lavd_init                  6748   7474   +726 (+10.76%)   5096   6864    +1768 (+34.69%)
lavd_select_cpu           27243  30802  +3559 (+13.06%)  26056  45048   +18992 (+72.89%)
layered_dispatch           8909  13295  +4386 (+49.23%)   7976  18028  +10052 (+126.03%)
layered_dump               1890   2097   +207 (+10.95%)   2036   3036    +1000 (+49.12%)
layered_init               4149   4531    +382 (+9.21%)   2716   2896      +180 (+6.63%)
layered_runnable           2566   2601     +35 (+1.36%)    748   1244     +496 (+66.31%)
p2dq_init                  3640   4474   +834 (+22.91%)   2004   2504     +500 (+24.95%)
refresh_layer_cpumasks      735   1048   +313 (+42.59%)    256    756    +500 (+195.31%)
rusty_init_task           31104  31104      +0 (+0.00%)   2164   2368      +204 (+9.43%)
rusty_select_cpu           1110   1110      +0 (+0.00%)    768   1004     +236 (+30.73%)
tp_cgroup_attach_task       149    203    +54 (+36.24%)      0      0        +0 (+0.00%)

Total progs: 147
Old success: 134
New success: 134
total_insns diff min     :    0.00 %
total_insns diff max     :   49.23 %
total_insns abs max old  :  72,434
total_insns abs max new  :  72,434
   0 .. 5    %: 132
   5 .. 15   %: 9
  15 .. 25   %: 2
  35 .. 45   %: 3
  45 .. 50   %: 1

mem_peak diff min     :   -0.95 %
mem_peak diff max     :  370.36 %
mem_peak abs max old  :  26,056 KiB
mem_peak abs max new  :  45,048 KiB
  -5 .. 0    %: 4
   0 .. 5    %: 128
   5 .. 15   %: 2
  15 .. 25   %: 2
  30 .. 40   %: 2
  45 .. 55   %: 1
  60 .. 70   %: 3
  70 .. 80   %: 1
  85 .. 95   %: 1
 125 .. 135  %: 1
 195 .. 205  %: 1
 370 .. 375  %: 1

Changelog
---------

v1: https://lore.kernel.org/bpf/20250524191932.389444-1-eddyz87@gmail.com/
v1 -> v2:
- Rebase
- added mem_peak statistics (Alexei)
- selftests: fixed comments and removed useless r7 assignments (Yonghong)

Links
-----

[1] https://lore.kernel.org/bpf/20250312031344.3735498-1-eddyz87@gmail.com/
[2] commit 96a30e469ca1 ("bpf: use common instruction history across all states")
[3] https://github.com/eddyz87/scc-test
[4] https://lore.kernel.org/bpf/20250426104634.744077-1-eddyz87@gmail.com/
[5] https://github.com/eddyz87/bpf/tree/propagate-read-and-precision-in-cfg
[6] https://github.com/eddyz87/bpf/tree/veristat-memory-accounting
[7] https://github.com/eddyz87/bpf/tree/scc-accumulate-backedges

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
 kernel/bpf/verifier.c                     | 970 +++++++++++++++-------
 tools/testing/selftests/bpf/progs/iters.c | 277 ++++++
 3 files changed, 998 insertions(+), 326 deletions(-)

-- 
2.48.1


