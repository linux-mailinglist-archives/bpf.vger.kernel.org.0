Return-Path: <bpf+bounces-60371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FBFAD5FCC
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 22:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B75FB1BC2C20
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 20:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BFE288C96;
	Wed, 11 Jun 2025 20:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGfNY5Vf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F5C286D57
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 20:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749672356; cv=none; b=MvMAaIZDwTfDR4juc7KYvWBIGg0I/fHahxyk64kuH1eFG97fxgcKl97Dz6xJumGanQOMqWRLOIzZDOD7TcBaf6ETKhqjjYnuZSz1OGOEH/mpmbe/ik4uEHKPaQ8NXQ1w0G10Ovoqm8dawdEbWmhlXhmT9z1ItQl1Rt8Upm0jXTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749672356; c=relaxed/simple;
	bh=dUfjLp5P7SZXWaslSxDF9HaS41BgJHewRIW3K+XJbes=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q4I+5fn0FHP9U2OTkfR4367BwcEMckM9yjuJtL3LNBebP+ank/fJOK+QFOFlmrRyQZUIkshQUk8iDwBMd3HlIo07fJ/9xiYW1Qc7hERe+kezhUwzr1NiKnwH27crsAd9Qa9N8dRYn5gaLbaXe6QIqEap7EgYrSLOljZvJ2df3xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGfNY5Vf; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e8187601f85so177661276.2
        for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 13:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749672354; x=1750277154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SesyB7fmyq478ErBxc9W6Jq9Kx8H0NcI9QQCLjFmy8o=;
        b=TGfNY5VffUbTqAXNkh1hUQRpZGotYSGtDN2pdRGPfx5TdrRacNfkkanL1JW+EJ0PgG
         e7fuiUPRrBjRMPlcrjTpKSROgqUHBtF49YWOCIaoRJx2dGUfZIsTDohvyZDD5eBoEcOd
         5IbLNa4oNH2uTul555whxP1HtK3PWLJYXgIAzmbQFqG6LtFuIZctEXzF4e7QnYukcQw+
         277O0Heonpx12ZtcZbxdpN5QUj+tskihY97tUjdl+gehzawt+gGwRqh+FecB0A2g3RBv
         HyR2yIg9tM66pq+oUbenVKU2eEMqt0mhgPbPJ7XorkxJWXroo2iDBL1jDAM70E5TWGIS
         u+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749672354; x=1750277154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SesyB7fmyq478ErBxc9W6Jq9Kx8H0NcI9QQCLjFmy8o=;
        b=pVjFZFCXGW7q5Jm28s+N8NGbuxGe6i4i/y1zb0FEybtNH8sLXMNjEWGiYBS7XBbVMl
         4FEQiwwFVNa9wywNHzkDCgdHROXDI+DdAjMc6RXhPbbcOfqAY5jFMHjt6DpocHjWXXUH
         BVQxZnoKsf+OrtbL1MVu74uvBbkoZlWM2RG4TPNO4kNYD7k7q4yHnyiqGovIl69z2oRN
         gheMssd37RJ2tVmTRqZYJ2Cbi+fPyln8u2yIYq/B66iVYtagEkgyk2la9q8pj0YECRGS
         xTeKCO4R2gwVos5dmIIJAd1KMp+KxxHzkIjXb/VXVutoXuHlAwl4N3OUuVglelc0PRZk
         dtgg==
X-Gm-Message-State: AOJu0YxrmCZJLGNeGNEhNzVT7rEKptvMQZZFYR4dHKQHXYKK53THAg5G
	WrLKNOWLSJAqhyNK+xDz8Hr/rostBNA6Ar6d0XbB8pZ7VzaOB4kprKNR/9xkgrTU
X-Gm-Gg: ASbGncvegSdh+tl8z02qBygaBw48nj0wIuWy6WLX9oCFu071DLZr553u8IkL9cuuoHq
	Dw4Qjp1rRmz2CQ1KhKvfeY3A+JgoLTHM6yVIjbGHjQPg8UCINuFJw6o/19ityospHMgAS63gJWP
	sByh278FU55IjmUMy4JXP2ivxJokZYkreikejzqMGco+zrCKACG5Gue6M00nZnd9mUGPeuFXCDA
	QPhCeBwdi6/UfLJIxwFcjPC/pK23j2qx0muk+ao/94hJbL2HYZbyodZp8zIqRJchNoAJ5Evn0PP
	8t5UEp/K4T+vdL31mlHQ0KHMDLA0VL2q6NTh+WN/R2YgKd+bWCtGhYZG2ERsp3H0
X-Google-Smtp-Source: AGHT+IGJXv8F/yycO2f/7k5L2CVgTK9lJtXzJZ+g5jnyWSu8oqrvEDuia4EemZWPJ8dE1Rg1MqLNVA==
X-Received: by 2002:a05:6902:1ac5:b0:e81:9b3c:b795 with SMTP id 3f1490d57ef6-e81fe6ea793mr6792707276.23.1749672353740;
        Wed, 11 Jun 2025 13:05:53 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4e::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e820e09fa44sm15206276.24.2025.06.11.13.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 13:05:53 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v3 00/11] bpf: propagate read/precision marks over state graph backedges
Date: Wed, 11 Jun 2025 13:05:35 -0700
Message-ID: <20250611200546.4120963-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
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

File                  Program                              Insns                           Peak memory (KiB)
--------------------- -----------------------------------  -----  -----  ----------------  ----  -----  ----------------
bpf_qdisc_fq.bpf.o    bpf_fq_dequeue                        1187   1645    +458 (+38.58%)   768   1240    +472 (+61.46%)
dynptr_success.bpf.o  test_copy_from_user_str_dynptr         208    279     +71 (+34.13%)   512   1024   +512 (+100.00%)
dynptr_success.bpf.o  test_copy_from_user_task_str_dynptr    205    263     +58 (+28.29%)   512   1024   +512 (+100.00%)
dynptr_success.bpf.o  test_probe_read_kernel_str_dynptr      686    857    +171 (+24.93%)   992   1724    +732 (+73.79%)
dynptr_success.bpf.o  test_probe_read_user_str_dynptr        689    860    +171 (+24.82%)  1016   1744    +728 (+71.65%)
iters.bpf.o           checkpoint_states_deletion            1211   1216       +5 (+0.41%)   512   1280   +768 (+150.00%)
pyperf600_iter.bpf.o  on_event                              2591   5929  +3338 (+128.83%)  4744  11176  +6432 (+135.58%)
verifier_gotol.bpf.o  gotol_large_imm                      40004  40004       +0 (+0.00%)  1024   1536    +512 (+50.00%)

Total progs: 3725
Old success: 2157
New success: 2157
total_insns diff min:    0.00%
total_insns diff max:  128.83%
0 -> value: 0
value -> 0: 0
total_insns abs max old: 837,487
total_insns abs max new: 837,487
   0 .. 5    %: 3710
   5 .. 15   %: 6
  20 .. 30   %: 6
  30 .. 40   %: 2
 125 .. 130  %: 1

mem_peak diff min:  -27.78%
mem_peak diff max:  198.44%
mem_peak abs max old: 269,312 KiB
mem_peak abs max new: 269,312 KiB
 -30 .. -20  %: 1
  -5 .. 0    %: 18
   0 .. 5    %: 3568
   5 .. 15   %: 4
  15 .. 25   %: 3
  45 .. 55   %: 4
  60 .. 70   %: 1
  70 .. 80   %: 2
 100 .. 110  %: 3
 135 .. 145  %: 1
 150 .. 160  %: 1
 195 .. 200  %: 1

========= scx: master vs patch-set =========

Program                   Insns                          Peak memory (KiB)
------------------------  -----  -----  ---------------  -----  -----  -----------------
arena_topology_node_init   2133   2395   +262 (+12.28%)    768    768        +0 (+0.00%)
chaos_dispatch             2835   2868     +33 (+1.16%)   1972   1720     -252 (-12.78%)
chaos_init                 4324   5210   +886 (+20.49%)   2528   3028     +500 (+19.78%)
lavd_cpu_offline           5107   5726   +619 (+12.12%)   4188   6304    +2116 (+50.53%)
lavd_cpu_online            5107   5726   +619 (+12.12%)   4188   6304    +2116 (+50.53%)
lavd_dispatch             41775  47601  +5826 (+13.95%)   6196  29192  +22996 (+371.14%)
lavd_enqueue              20238  24188  +3950 (+19.52%)  22084  42156   +20072 (+90.89%)
lavd_init                  6974   7685   +711 (+10.20%)   5428   6928    +1500 (+27.63%)
lavd_select_cpu           22138  26088  +3950 (+17.84%)  24448  43688   +19240 (+78.70%)
layered_dispatch          17847  26581  +8734 (+48.94%)  11728  28740  +17012 (+145.05%)
layered_dump               1891   2098   +207 (+10.95%)   2036   3048    +1012 (+49.71%)
layered_runnable           2606   2634     +28 (+1.07%)    748   1240     +492 (+65.78%)
p2dq_init                  3691   4554   +863 (+23.38%)   2016   2528     +512 (+25.40%)
rusty_enqueue             28853  28853      +0 (+0.00%)   2072   1824     -248 (-11.97%)
rusty_init_task           31128  31128      +0 (+0.00%)   2176   2560     +384 (+17.65%)

Total progs: 148
Old success: 135
New success: 135
total_insns diff min:    0.00%
total_insns diff max:   48.94%
0 -> value: 0
value -> 0: 0
total_insns abs max old: 41,775
total_insns abs max new: 47,601
   0 .. 5    %: 133
   5 .. 15   %: 7
  15 .. 25   %: 4
  35 .. 45   %: 3
  45 .. 50   %: 1

mem_peak diff min:  -12.78%
mem_peak diff max:  371.14%
mem_peak abs max old: 24,448 KiB
mem_peak abs max new: 43,688 KiB
 -15 .. -5   %: 2
  -5 .. 0    %: 2
   0 .. 5    %: 129
   5 .. 15   %: 1
  15 .. 25   %: 2
  25 .. 35   %: 2
  45 .. 55   %: 3
  65 .. 75   %: 1
  75 .. 85   %: 1
  90 .. 100  %: 1
 145 .. 155  %: 1
 195 .. 205  %: 1
 370 .. 375  %: 1

Changelog
---------

v1: https://lore.kernel.org/bpf/20250524191932.389444-1-eddyz87@gmail.com/
v1 -> v2:
- Rebase
- added mem_peak statistics (Alexei)
- selftests: fixed comments and removed useless r7 assignments (Yonghong)
v2: https://lore.kernel.org/bpf/20250606210352.1692944-1-eddyz87@gmail.com/
v2 -> v3:
- Rebase

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
2.47.1


