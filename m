Return-Path: <bpf+bounces-37072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 199B8950C83
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 20:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9F69282CE4
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 18:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E031A3BD2;
	Tue, 13 Aug 2024 18:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xRdLaQmt"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B7E1A0B06
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 18:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723574998; cv=none; b=qq8Spwrgfx9XbgNLHwjuCGk9exHN+ROCSVa2JPovYPWwZmtaRQ/Pvag9v/YoNsSqlu2RsgtGVDR3nPFuy60oYs3OtfrQwox9bfWLi0VZAsSJWyUnN/9pfMrCGy5hBs6x0dVKioMqgGs7adYB4/NdHKm04wg8MdGnvI2vtgoMFlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723574998; c=relaxed/simple;
	bh=Hd7PVl9aat9ZZg1QdXuSRVVa1XwFczB375QnBSmdjEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sCpeA0hBfgQX1IgVFqn+Ef3dNMglfeSb3lEa4eoVGFcXsM7DI87i06tjQEptU1fT9TNyyihbVkVw9ufth8ACfsQAMVv4gpYOVexFLgb0hBRlyPJ0eMzdUaH4jtNr8rbNwy4f/1wPg90c790e7/d7a1mxKXQobOAPpZPl0AvOKso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xRdLaQmt; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723574993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=76NOycYPciQdEzKfq+w+5bD8s5v6T9k/XrTqwZqgmDI=;
	b=xRdLaQmt77fch5aoVw2Q8kMGKIaMoFNCZkwl1yYuba8G48Ghuga3s541ll/i0Mupq9ePb6
	PfORBA01xRRbj3kP7uJz/0JasEajRA7xf4Xq3MX7Nd+Artn6Gc4Oqob2BT2nPyuac5jiyY
	DkkqHodlLah6Lr2fobP0nHlpMAy/pvk=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Yonghong Song <yonghong.song@linux.dev>,
	Amery Hung <ameryhung@gmail.com>,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next 0/6] bpf: Add gen_epilogue and allow kfunc call in pro/epilogue
Date: Tue, 13 Aug 2024 11:49:33 -0700
Message-ID: <20240813184943.3759630-1-martin.lau@linux.dev>
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

It is under RFC because the .gen_epilogue will need 8 extra
bytes in the stack to save the ctx pointer. It is now
done after the check_max_stack_depth. The ctx pointer
saving will need to be done earlier before check_max_stack_depth.

Martin KaFai Lau (6):
  bpf: Add gen_epilogue to bpf_verifier_ops
  bpf: Export bpf_base_func_proto
  selftests/test: test gen_prologue and gen_epilogue
  bpf: Add module parameter to gen_prologue and gen_epilogue
  bpf: Allow pro/epilogue to call kfunc
  selftests/bpf: Add kfunc call test in gen_prologue and gen_epilogue

 include/linux/bpf.h                           |   4 +-
 include/linux/btf.h                           |   1 +
 kernel/bpf/btf.c                              |   2 +-
 kernel/bpf/cgroup.c                           |   3 +-
 kernel/bpf/helpers.c                          |   1 +
 kernel/bpf/verifier.c                         | 146 ++++++++++-
 net/core/filter.c                             |   6 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 228 ++++++++++++++++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  11 +
 .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |   6 +
 .../bpf/prog_tests/struct_ops_syscall.c       |  92 +++++++
 .../selftests/bpf/progs/struct_ops_syscall.c  | 113 +++++++++
 12 files changed, 604 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/struct_ops_syscall.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_syscall.c

-- 
2.43.5


