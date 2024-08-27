Return-Path: <bpf+bounces-38195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F9396182A
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 21:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6677B2852EB
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 19:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B041D2F53;
	Tue, 27 Aug 2024 19:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ERIgG9vZ"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AEA1C57AB
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 19:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724788135; cv=none; b=qOm8o4XAh2Dga5JeilYlFmcNFKOlCtIteZkHILQ/Xn0faRlq/l+rosZg8/dmLUJtYlW7b2c883Ln6KMTK/cGhlSCjYCE2v/04kuf7O+gEedmpGNd9kxvOF7H4ePXXwW1WwfOJJDI6AndkBavTZzBkq+lglkyep/ifOQIle+3gRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724788135; c=relaxed/simple;
	bh=scT6AvAvFJWE4ixnqMeCvYBWpfJL9Y6l+9/gqPHmLXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T25Kb6bBXdxPpbuG3R5FRnNrYXdVUdEU5RaYJw8becMyjRz8RcK08qSis8uYZK00zFI52tZFREj55mPPTMwciGzcsiexIYKpgZgIoNi1iqpvQEHuII+gjOEjK2AQMq0o804qnWWF8jcbhjZmPcq+z9F6GV6PFYvSdXXt5erazJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ERIgG9vZ; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724788130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7zV9RPv803skIE/o3GKPVHACrQfJG5qFnHDAh6OoMnw=;
	b=ERIgG9vZ+L5OP24FQmWaPAlGL7XwGwNJknGwKHJ21WTcuswHHtkaKdF49XW3nTVOSTErDF
	4Wf1fFvo2G6DiAENOueLNB3jOxJ+zorIAS8pPPXyY4eWdEOpe4tPkbWs3e05vRlxHs8uol
	YliQkn2DZH00tgVuPcQal9tjAfDM+N0=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Amery Hung <ameryhung@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH v4 bpf-next 0/9] bpf: Add gen_epilogue to bpf_verifier_ops
Date: Tue, 27 Aug 2024 12:48:23 -0700
Message-ID: <20240827194834.1423815-1-martin.lau@linux.dev>
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
 kernel/bpf/helpers.c                          |   1 +
 kernel/bpf/verifier.c                         |  73 +++++--
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 190 ++++++++++++++++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  11 +
 .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |   6 +
 .../selftests/bpf/prog_tests/pro_epilogue.c   |  54 +++++
 .../selftests/bpf/progs/epilogue_exit.c       |  78 +++++++
 .../selftests/bpf/progs/epilogue_tailcall.c   |  58 ++++++
 .../bpf/progs/pro_epilogue_goto_start.c       | 149 ++++++++++++++
 .../selftests/bpf/progs/pro_epilogue_kfunc.c  | 156 ++++++++++++++
 .../bpf/progs/pro_epilogue_subprog.c          | 125 ++++++++++++
 tools/testing/selftests/bpf/test_loader.c     |  27 +++
 14 files changed, 922 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/pro_epilogue.c
 create mode 100644 tools/testing/selftests/bpf/progs/epilogue_exit.c
 create mode 100644 tools/testing/selftests/bpf/progs/epilogue_tailcall.c
 create mode 100644 tools/testing/selftests/bpf/progs/pro_epilogue_goto_start.c
 create mode 100644 tools/testing/selftests/bpf/progs/pro_epilogue_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/pro_epilogue_subprog.c

-- 
2.43.5


