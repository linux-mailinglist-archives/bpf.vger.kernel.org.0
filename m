Return-Path: <bpf+bounces-37783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB5795A857
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 01:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDD361C223A1
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 23:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E59217C9FC;
	Wed, 21 Aug 2024 23:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EPbbe8k7"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA79617C7C8
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 23:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724283306; cv=none; b=dmp4DzJt8B70jrWkJ3HDwL2X6wxINHENRK1U9zSny4Fawq/5QJEO5CpdVaAMdNNIWEFbUXzg77qib1po8eQdNevUnvDJT6aHeVPdKUJ73mBQfH8OwuHrVJUKVACGlIDXyZINMa7vnl7n7PlMFshOZ755tYLHIxGDFaJkCnZ7PjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724283306; c=relaxed/simple;
	bh=H7WG21jJlU3OaVewjz0Qcv6TR/1HBhfexVW/SUzbAIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jrh43GWjyoitf3Y8VBUl1uokcZ9Sn/2KktSdcCCqqSE+aQz3TSK1DQrwRm3qbuzF0OH8xv0LkXx8q5X7MfRn7IOPIRO967YX5jxmnVbpTh/i4oF80a9JslijiMTbnwxUJjdliVlQI6EEEtPnUDPKESmwiqe8Q+tD6WBMnJDO2Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EPbbe8k7; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724283302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zZ0EL4Ve+38xtAKvYBtIMhAjFDtkN2HxxL5YLoUGYRo=;
	b=EPbbe8k7TacI1zZW6H4Vs0Aw3OfCgyQAmvgWUa3nMSBK6xlGernP7YXj5MIHxEY3mF5SkF
	v8dDI05Khdf0npwnH9c3HPJKfFmx/YjnHBIkTfwryOn9dCzf8WQxbZdeCjXDV7DG0ugyFA
	N96M8y+c3OLMu8/GGh6Eo35G9wK94JA=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Amery Hung <ameryhung@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 0/8] bpf: Add gen_epilogue and allow kfunc call in pro/epilogue
Date: Wed, 21 Aug 2024 16:34:30 -0700
Message-ID: <20240821233440.1855263-1-martin.lau@linux.dev>
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
epilogue or call another kfunc to handle (e.g. drop) it in
the epilogue. Another use case could be in bpf_tcp_ca.c to
enforce snd_cwnd has sane value (e.g. non zero).

The existing .gen_prologue can call bpf helper.
This set also allows the existing .gen_prologue and the new
.gen_epilogue to call kfunc. Other than the skb drop
mentioned above, the bpf qdisc subsystem can call
kfunc to enforce initializing / releasing resources (e.g.
qdisc_watchdog_init/cancel) in some of the qdisc_ops.

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

Martin KaFai Lau (7):
  bpf: Add gen_epilogue to bpf_verifier_ops
  bpf: Export bpf_base_func_proto
  selftests/bpf: Test gen_prologue and gen_epilogue
  selftests/bpf: Add tailcall epilogue test
  bpf: Add module parameter to gen_prologue and gen_epilogue
  bpf: Allow pro/epilogue to call kfunc
  selftests/bpf: Add kfunc call test in gen_prologue and gen_epilogue

 include/linux/bpf.h                           |   4 +-
 include/linux/btf.h                           |   1 +
 kernel/bpf/btf.c                              |   2 +-
 kernel/bpf/cgroup.c                           |   3 +-
 kernel/bpf/helpers.c                          |   1 +
 kernel/bpf/verifier.c                         | 145 ++++++++++-
 net/core/filter.c                             |   6 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 228 ++++++++++++++++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  11 +
 .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |   6 +
 .../selftests/bpf/prog_tests/pro_epilogue.c   |  50 ++++
 .../selftests/bpf/progs/epilogue_tailcall.c   |  58 +++++
 .../selftests/bpf/progs/pro_epilogue_kfunc.c  | 174 +++++++++++++
 .../bpf/progs/pro_epilogue_subprog.c          | 143 +++++++++++
 tools/testing/selftests/bpf/test_loader.c     |  27 +++
 15 files changed, 850 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/pro_epilogue.c
 create mode 100644 tools/testing/selftests/bpf/progs/epilogue_tailcall.c
 create mode 100644 tools/testing/selftests/bpf/progs/pro_epilogue_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/pro_epilogue_subprog.c

-- 
2.43.5


