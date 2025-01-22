Return-Path: <bpf+bounces-49470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACEBA19118
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 13:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40E4E3AB3DF
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 12:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E73211A02;
	Wed, 22 Jan 2025 12:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McSlVbiP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAED211703
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 12:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737547502; cv=none; b=t5SvIhgxvOhdqzw21s3hOAtBtXHLx0yzaFnrmn1cZDmALPAEbE0lMhvb8a8nGSLaRekBhScqtH9gtQT4XAf0hR+miZX0UshO5ZeLXDWe9QeZ/CMmnJxdwNiqfDOT7vxsxzl7oRHfSuJUnQfz5AgFvE8qA2iYNFyJb3hDWzqqiiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737547502; c=relaxed/simple;
	bh=UTZIgTU6WYKSZgNzCs4+VEFx6LCkws7Gc+nWGbV8vBM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uWWte0bAGfFmN20Gc3JPoKMSU0koK6XxAetsziJ4GFDLzy1qX4KV0eYg5KgQzyyZUP7Ng646B5so/7Ydtdww7h8KsrZOnrKpkMFwxVADwhOCbSJZQUnwiyW0SyLlYPpPsZHVbQO0xsIDpO/7MEiKRdXecyI1heKpG+xvR97CtwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=McSlVbiP; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2161eb94cceso84670075ad.2
        for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 04:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737547500; x=1738152300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NQV+iAEEgSIl6yPXT330jkVYdeTMVjZASsPE/DoOdkI=;
        b=McSlVbiPNq529AClwdX9KcKQDDcGFOuWeWT15esHk2BfhVbwb1JI4DrNqCCn3THZTW
         yIu81bmOYBwlI44F4oCBIDILGmcJk/1LbTvx5md9B72iKvGZtypC/DOTT1NFKxQPNAFG
         9mXFLWHSon/rt6COHwfclexSeaZ9rBjzYzj9z87drp+DXkvuZK6d0+QC1lv/UnZaXOTg
         mVeS28mEv/1w2UQp/gz53i05If9qfEaCkaIRIONe7GTKgyC0fSumsiQiqCiDCNt4itvX
         nR3RE5yEYtBDHP4io/Wx2x2qE3Yj1lFYxOe53zEqIleP8VI2h55SYgkE/tGpZf7X2nHL
         QqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737547500; x=1738152300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NQV+iAEEgSIl6yPXT330jkVYdeTMVjZASsPE/DoOdkI=;
        b=g2INmCBGFYA9U/DlUD4wSCSXM8lWyj0VGWeLBkG321nTD/F1ysp7fN9hGAyvLlFP+p
         xRRTv0xWeDEmWIIoRa0BNG3snxpanA9xmm7FJUPp3wNl7A6Vz+mzrtlcrN5SIEI9gmlm
         s5S2kJsZstN3d2LibPWwW/F4+A9N56A/inqNqyce4JPc37uSRwUbtemQycR9nJ7YSHby
         Fr3JGBmOJNfrhMrcasV9ZOsMJsrUA2H7mQ1PoFMpqCmNnQPD9StW835G4kBiTkIzZ65P
         oLDabY/LJLWC9ZJov9gi8VQK6gQMFcLCW6yHZmxp4UcC5etS8cCjUt/f0D2zv+dM1i9R
         Z9hA==
X-Gm-Message-State: AOJu0YwMeNAi9Tfi/PjRICqNa95m2vjemo5F1YTmiilu/1QGe5yDV8xg
	qcNRY6y4idq4XM7valt3W83aWW2qAHWPouf5viYYvJzPvOyskndpN1xAYw==
X-Gm-Gg: ASbGnct7HnY0VtNUMDlMJwlQ3x6BEzbYWAFY26JOVW+ibkJB/rH5LYQ3q1rqsOyya0i
	YVPeW9wDcu3vDLeJv3JPUbD74JyaUDmWxxP1oerv2gbDu8kLEv8orM/+WW0Sz9NofaGvAnHjmtq
	TAInhg5d1rxEP5SJliSl5UqssaP2dndvW7X4ChlGMp2fKrzDoPNqkxfpBh/8pQDkY9qQ2tqKGK2
	MjVKpTWxbTFiF6xq6FhlzX/mR1qJ9KltkG3EBM844xvtub7oNSLo+mMKJURrXT4Sw==
X-Google-Smtp-Source: AGHT+IGEA+AHvlHe0/4IUgUqsLa2SAHOllvslcUGLfM+ZbzSRcKQZHvvysDykU2T/ekeYKqR566LPg==
X-Received: by 2002:a05:6a20:432b:b0:1e6:8f39:d607 with SMTP id adf61e73a8af0-1eb2156845dmr39740486637.31.1737547500306;
        Wed, 22 Jan 2025 04:05:00 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab816412sm11055732b3a.66.2025.01.22.04.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 04:04:59 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next v1 0/7] bpf: improvements for iterator-based loops convergence
Date: Wed, 22 Jan 2025 04:04:35 -0800
Message-ID: <20250122120442.3536298-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This RFC consists of a bug fix and two improvements for
iterator/callback based loops handling:
- Patch #1 fixes a bug in copy_verifier_state(), where field
  'loop_entry' was not copied. The fix has negative impact on
  verification performance.
- Patch #3 mitigates negative impact from patch #1 by avoiding
  clean_live_states() for states that have loop_entry that is still
  being verified. This reduces amount of processed instructions for
  sched_ext by 28-92% for some programs.
- Patches #5,6 introduce a simple live registers DFA analysis.
  Results of this analysis are used in func_states_equal() and further
  reduce amount of processed instructions for sched_ext by 17-30% for
  some programs.

Below are veristat results comparing master to this RFC.

selftests:

File                   Program                     Insns      (DIFF)  States    (DIFF)
---------------------  --------------------------  -----------------  ----------------
arena_htab.bpf.o       arena_htab_llvm                -294 (-41.00%)     -20 (-35.09%)
arena_htab_asm.bpf.o   arena_htab_asm                 -152 (-25.46%)     -10 (-21.28%)
arena_list.bpf.o       arena_list_add                 +329 (+22.04%)      +7 (+23.33%)
arena_list.bpf.o       arena_list_del                 -161 (-52.10%)     -12 (-52.17%)
iters.bpf.o            checkpoint_states_deletion   -16914 (-93.32%)    -778 (-95.11%)
iters.bpf.o            iter_nested_deeply_iters       -293 (-49.41%)     -30 (-44.78%)
iters.bpf.o            iter_nested_iters              -181 (-22.26%)     -17 (-21.52%)
iters.bpf.o            iter_subprog_iters             -430 (-39.31%)     -29 (-32.95%)
iters.bpf.o            loop_state_deps2               -158 (-32.99%)     -14 (-30.43%)
pyperf600_iter.bpf.o   on_event                      -8633 (-69.97%)    -189 (-42.86%)

sched_ext:

Program                 Insns      (DIFF)  States    (DIFF)
----------------------  -----------------  ----------------
lavd_dispatch            -34018 (-22.00%)   -1885 (-21.06%)
layered_dispatch          -5378 (-46.81%)    -313 (-36.91%)
layered_dump              -3689 (-49.71%)    -455 (-66.81%)
layered_enqueue           -4038 (-30.90%)    -351 (-29.80%)
layered_init            -995483 (-99.55%)  -84233 (-99.48%)
layered_runnable          -1587 (-49.32%)    -172 (-58.31%)
refresh_layer_cpumasks   -15597 (-94.60%)   -1684 (-95.14%)
rustland_init               -85 (-17.07%)      -7 (-17.07%)
rustland_init               -85 (-17.07%)      -7 (-17.07%)
rusty_select_cpu           -706 (-33.65%)     -55 (-30.39%)
rusty_set_cpumask        -15934 (-78.67%)   -1359 (-81.62%)
tp_cgroup_attach_task       -57 (-27.67%)      -4 (-22.22%)
central_dispatch            -87 (-13.68%)      -9 (-14.29%)
central_init               -476 (-52.19%)     -12 (-25.00%)
pair_dispatch           -998423 (-99.84%)  -58264 (-99.78%)
qmap_dispatch              -581 (-24.28%)     -48 (-24.49%)
userland_dispatch           -36 (-22.78%)      -4 (-23.53%)

('layered_init' and 'pair_dispatch' hit 1M on master,
 but are verified ok with this patch-set).

sched_ext used for testing:
commit 2b7f3bba928f ("Merge pull request #1197 from devnexen/code_simpl4")

Eduard Zingerman (7):
  bpf: copy_verifier_state() should copy 'loop_entry' field
  selftests/bpf: test correct loop_entry update in copy_verifier_state
  bpf: don't do clean_live_states when state->loop_entry->branches > 0
  selftests/bpf: check states pruning for deeply nested iterator
  bpf: DFA-based liveness analysis for program registers
  bpf: use register liveness information for func_states_equal
  selftests/bpf: test cases for compute_live_registers()

 include/linux/bpf_verifier.h                  |   6 +
 kernel/bpf/verifier.c                         | 372 ++++++++++++++++--
 .../testing/selftests/bpf/prog_tests/align.c  |  11 +-
 .../bpf/prog_tests/compute_live_registers.c   |   9 +
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  12 +
 .../bpf/progs/compute_live_registers.c        | 363 +++++++++++++++++
 tools/testing/selftests/bpf/progs/iters.c     | 139 +++++++
 .../selftests/bpf/progs/verifier_gotol.c      |   6 +-
 .../bpf/progs/verifier_iterating_callbacks.c  |   6 +-
 9 files changed, 886 insertions(+), 38 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/compute_live_registers.c
 create mode 100644 tools/testing/selftests/bpf/progs/compute_live_registers.c

-- 
2.47.1


