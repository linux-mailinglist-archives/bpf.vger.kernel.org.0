Return-Path: <bpf+bounces-47272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3398C9F6E39
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 20:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ED287A3163
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 19:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F63153824;
	Wed, 18 Dec 2024 19:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MpZS+BR2"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4A31FC10F
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 19:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734550226; cv=none; b=Ho23/pmwPgOPtuuHrRhXe5H8b5Y4ZbmR9I0mfylnmrOmWzFlHgPGsM7NUOMPmsnIrAspdwO6KzygC7Axke4+p14131q1AKPs4zo764AQmxqiYw7INZguGM6wFWCJMOF2FOK6LndItw4aL2pNjEejRzt1OFS8TqIUjTvywhaJqhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734550226; c=relaxed/simple;
	bh=5QvGOWYdp+BrUUiAlwRzCuhirLxoYLqN8wDrBFPMR1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j9Pt2ON7WiH5gaILK5mrrfgZO4w4lm96U2Hy/EK7pZt9PPeVtDbCESq6ljEvm8bzpRiOVp/c2X9yLA8DfP4h7tVTcBdG1mrmafuLIHaGVOMSETs7bgSHfAzeEc6e3bQmxdx0DG9jn0pFaN2ZImeExoaR70iacMaNIkIfwdxCH2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MpZS+BR2; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734550219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1Xt8n6wz13CrbEO3Owqi3Fdv44pPnG6RDuvQRBq0OAU=;
	b=MpZS+BR2m97s3t5+MvqxETV/5tZ0xNjo9eV7lQ/ZIcvqRA3XJQgKXhbQB4tdVvU6L1eHVr
	+QzyphS1gpCJw0YdE68OOEYOL9BWUbR6BIyhQHEGRrQ664n/Gpadgpup+sst6dFkjfNDz/
	3MKcTiGCo98aOMTswtsTZy43UAWBIwQ=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@meta.com
Subject: [PATCH bpf-next] bpf: bpf_local_storage: Always use bpf_mem_alloc in PREEMPT_RT
Date: Wed, 18 Dec 2024 11:30:00 -0800
Message-ID: <20241218193000.2084281-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

In PREEMPT_RT, kmalloc(GFP_ATOMIC) is still not safe in non preemptible
context. bpf_mem_alloc must be used in PREEMPT_RT. This patch is
to enforce bpf_mem_alloc in the bpf_local_storage when CONFIG_PREEMPT_RT
is enabled.

[   35.118559] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
[   35.118566] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1832, name: test_progs
[   35.118569] preempt_count: 1, expected: 0
[   35.118571] RCU nest depth: 1, expected: 1
[   35.118577] INFO: lockdep is turned off.
    ...
[   35.118647]  __might_resched+0x433/0x5b0
[   35.118677]  rt_spin_lock+0xc3/0x290
[   35.118700]  ___slab_alloc+0x72/0xc40
[   35.118723]  __kmalloc_noprof+0x13f/0x4e0
[   35.118732]  bpf_map_kzalloc+0xe5/0x220
[   35.118740]  bpf_selem_alloc+0x1d2/0x7b0
[   35.118755]  bpf_local_storage_update+0x2fa/0x8b0
[   35.118784]  bpf_sk_storage_get_tracing+0x15a/0x1d0
[   35.118791]  bpf_prog_9a118d86fca78ebb_trace_inet_sock_set_state+0x44/0x66
[   35.118795]  bpf_trace_run3+0x222/0x400
[   35.118820]  __bpf_trace_inet_sock_set_state+0x11/0x20
[   35.118824]  trace_inet_sock_set_state+0x112/0x130
[   35.118830]  inet_sk_state_store+0x41/0x90
[   35.118836]  tcp_set_state+0x3b3/0x640

There is no need to adjust the gfp_flags passing to the
bpf_mem_cache_alloc_flags() which only honors the GFP_KERNEL.
The verifier has ensured GFP_KERNEL is passed only in sleepable context.

It has been an old issue since the first introduction of the
bpf_local_storage ~5 years ago, so this patch targets the bpf-next.

bpf_mem_alloc is needed to solve it, so the Fixes tag is set
to the commit when bpf_mem_alloc was first used in the bpf_local_storage.

Fixes: 08a7ce384e33 ("bpf: Use bpf_mem_cache_alloc/free in bpf_local_storage_elem")
Reported-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 kernel/bpf/bpf_local_storage.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 7e6a0af0afc1..e94820f6b0cd 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -841,8 +841,12 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 	smap->elem_size = offsetof(struct bpf_local_storage_elem,
 				   sdata.data[attr->value_size]);
 
-	smap->bpf_ma = bpf_ma;
-	if (bpf_ma) {
+	/* In PREEMPT_RT, kmalloc(GFP_ATOMIC) is still not safe in non
+	 * preemptible context. Thus, enforce all storages to use
+	 * bpf_mem_alloc when CONFIG_PREEMPT_RT is enabled.
+	 */
+	smap->bpf_ma = IS_ENABLED(CONFIG_PREEMPT_RT) ? true : bpf_ma;
+	if (smap->bpf_ma) {
 		err = bpf_mem_alloc_init(&smap->selem_ma, smap->elem_size, false);
 		if (err)
 			goto free_smap;
-- 
2.43.5


