Return-Path: <bpf+bounces-38470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 876D9965170
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 23:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 445A4285725
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 21:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BED18C016;
	Thu, 29 Aug 2024 21:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MBRpu8nz"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1B718A955
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 21:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724965731; cv=none; b=QusMOkeEqVK5Hb29jcBaPSSLfCaNj4lmA5L/xcEKKZXNgpLziRe2AWZETVcHWErwwUbJaoQrVA2CLV3Gm9vb8wdECxaB5wGqaO2UCDNIHNmvyoU1DC1DkRrLknNpcl7FWDQl3aNa99CwKdym8B+VD10FKVdEeDBjCVU6+FV9BOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724965731; c=relaxed/simple;
	bh=Yf4xgNeXTRlZl6ijLFbCk2inW7dgejK8negwkjd5KUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k+UbQTK6BggJqGKX0cPSmnhfsQaD1RWjut1Bb4Qn0ew6dg/bcye/Bj1fge6R/d3MPcmCCNyZYzO9aT+GbGWnRPBihWXQWAxrP0pg4o8ymFTkn597soHdLeeOl3l9Cjqg6EFL2PtBdy9Y8P75lNBz5O98KyEXqNAT8TSoXueToFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MBRpu8nz; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724965726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QNXyF6/gA4Fvy2NblU6r5QMdHrXo/5nysw2QTdYfVTI=;
	b=MBRpu8nza0rTeE/puPv4z2DHsa48v+zeqASK4e7PUmxU8/Ze8IUIymV81Xc7DMd/3LMyIF
	e1SmpWa7G9J/4IG3/IdN53mODdGhdQ5X3HgkXuSke69BB57WGIfn0WQGt/F6AdavIUkegj
	+DnUH2u3H1cEYUqgBbSXR7qL8OEDZFE=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Amery Hung <ameryhung@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH v5 bpf-next 0/9] bpf: Add gen_epilogue to bpf_verifier_ops
Date: Thu, 29 Aug 2024 14:08:22 -0700
Message-ID: <20240829210833.388152-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

This set allows the subsystem to patch codes before BPF_EXIT.
The verifier ops, .gen_epilogue, is added for this purpose.
One of the use case will be in the bpf qdisc, the bpf qdisc
subsystem can ensure the skb->dev is in the correct value.
The bpf qdisc subsystem can either inline fixing it in the
epilogue or call another kernel function to handle it (e.g. drop)
in the epilogue. Another use case could be in bpf_tcp_ca.c to
enforce snd_cwnd has valid value (e.g. positive value).

v5:
 * Removed the skip_cnt argument from adjust_jmp_off() in patch 2.
   Instead, reuse the delta argument and skip
   the [tgt_idx, tgt_idx + delta) instructions.
 * Added a BPF_JMP32_A macro in patch 3.
 * Removed pro_epilogue_subprog.c in patch 6.
   The pro_epilogue_kfunc.c has covered the subprog case.
   Renamed the file pro_epilogue_kfunc.c to pro_epilogue.c.
   Some of the SEC names and function names are changed
   accordingly (mainly shorten them by removing the _kfunc suffix).
 * Added comments to explain the tail_call result in patch 7.
 * Fixed the following bpf CI breakages. I ran it in CI
   manually to confirm:
   https://github.com/kernel-patches/bpf/actions/runs/10590714532
 * s390 zext added "w3 = w3". Adjusted the test to
   use all ALU64 and BPF_DW to avoid zext.
   Also changed the "int a" in the "struct st_ops_args" to "u64 a".
 * llvm17 does not take:
       *(u64 *)(r1 +0) = 0;
   so it is changed to:
       r3 = 0;
       *(u64 *)(r1 +0) = r3;

v4:
 * Fixed a bug in the memcpy in patch 3
   The size in the memcpy should be
   epilogue_cnt * sizeof(*epilogue_buf)

v3:
 * Moved epilogue_buf[16] to env.
   Patch 1 is added to move the existing insn_buf[16] to env.
 * Fixed a case that the bpf prog has a BPF_JMP that goes back
   to the first instruction of the main prog.
   The jump back to 1st insn case also applies to the prologue.
   Patch 2 is added to handle it.
 * If the bpf main prog has multiple BPF_EXIT, use a BPF_JA
   to goto the earlier patched epilogue.
   Note that there are (BPF_JMP32 | BPF_JA) vs (BPF_JMP | BPF_JA)
   details in the patch 3 commit message.
 * There are subtle changes in patch 3, so I reset the Reviewed-by.
 * Added patch 8 and patch 9 to cover the changes in patch 2 and patch 3.
 * Dropped the kfunc call from pro/epilogue and its selftests.

v2:
 * Remove the RFC tag. Keep the ordering at where .gen_epilogue is
   called in the verifier relative to the check_max_stack_depth().
   This will be consistent with the other extra stack_depth
   usage like optimize_bpf_loop().
 * Use __xlated check provided by the test_loader to
   check the patched instructions after gen_pro/epilogue (Eduard).
 * Added Patch 3 by Eduard (Thanks!).

Eduard Zingerman (1):
  selftests/bpf: attach struct_ops maps before test prog runs

Martin KaFai Lau (8):
  bpf: Move insn_buf[16] to bpf_verifier_env
  bpf: Adjust BPF_JMP that jumps to the 1st insn of the prologue
  bpf: Add gen_epilogue to bpf_verifier_ops
  bpf: Export bpf_base_func_proto
  selftests/bpf: Test gen_prologue and gen_epilogue
  selftests/bpf: Add tailcall epilogue test
  selftests/bpf: A pro/epilogue test when the main prog jumps back to
    the 1st insn
  selftests/bpf: Test epilogue patching when the main prog has multiple
    BPF_EXIT

 include/linux/bpf.h                           |   2 +
 include/linux/bpf_verifier.h                  |   4 +
 include/linux/filter.h                        |  10 +
 kernel/bpf/helpers.c                          |   1 +
 kernel/bpf/verifier.c                         |  67 +++++-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 190 ++++++++++++++++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  11 +
 .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |   6 +
 .../selftests/bpf/prog_tests/pro_epilogue.c   |  60 ++++++
 .../selftests/bpf/progs/epilogue_exit.c       |  82 ++++++++
 .../selftests/bpf/progs/epilogue_tailcall.c   |  58 ++++++
 .../selftests/bpf/progs/pro_epilogue.c        | 154 ++++++++++++++
 .../bpf/progs/pro_epilogue_goto_start.c       | 149 ++++++++++++++
 tools/testing/selftests/bpf/test_loader.c     |  27 +++
 14 files changed, 813 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/pro_epilogue.c
 create mode 100644 tools/testing/selftests/bpf/progs/epilogue_exit.c
 create mode 100644 tools/testing/selftests/bpf/progs/epilogue_tailcall.c
 create mode 100644 tools/testing/selftests/bpf/progs/pro_epilogue.c
 create mode 100644 tools/testing/selftests/bpf/progs/pro_epilogue_goto_start.c

-- 
2.43.5


