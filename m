Return-Path: <bpf+bounces-56270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12151A94007
	for <lists+bpf@lfdr.de>; Sat, 19 Apr 2025 00:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E2B61B6647B
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 22:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47122566E7;
	Fri, 18 Apr 2025 22:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uBVMlMWc"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C3B255E46
	for <bpf@vger.kernel.org>; Fri, 18 Apr 2025 22:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745016461; cv=none; b=d41v1NH6DVWTIz7qMI9eBaPjfNZWdeDH3Ofox8P8HQsSE5J5g8HnD4Af8VpL6io9JmKPGqMf3CyIVBZx3SfoeTo0HmHJBGVxLIMYW/WtP1/HNu2PAoT3/STswZd5fotLB5nqwViGvcuH7v2zggdLD993TuV6Zvprptc84svpaEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745016461; c=relaxed/simple;
	bh=0SN6REfasD/fc0mS2aOpYJqurDJOEn0ehNvLSPZonTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n5eqVGJ9sQXkmpGnuijWi0ve5UYiF7ykBzB21D/b9CKCtHOu9lazMIfX7rUcNdWqKvDkmXhjVAtLEEVasPgvkU6T+A8IJRvW7aJKqIcwzh2DFV1swROJ9jeU101nU+ZGRcJbYQORE0u9yB3MDCSSD5M5LqHTFBe88HOB4ZlKIlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uBVMlMWc; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745016458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lfKAcsBzxqCYQ2eXy+4UKh7uCnTy+R1SZsq5aN6RNms=;
	b=uBVMlMWc537xYxnBL8fxDR8H/vuNzdOfqVSC3OxXT3MVxF1AhBr74AWZl8tnZOhM9+joXa
	gtmijwbNEwxPHRy5cfpiePHt9DV8tBw6rzIzENPQBp/TTjHDYhhfJ7MgdSrzCqYJN1VolV
	pFMQIgZKUS7lCk6cxTRnoiuoLylFjdE=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	kernel-team@meta.com,
	'Amery Hung ' <ameryhung@gmail.com>
Subject: [RFC PATCH bpf-next 11/12] bpf: net: Add a qdisc kfunc to set sk_pacing_status.
Date: Fri, 18 Apr 2025 15:46:49 -0700
Message-ID: <20250418224652.105998-12-martin.lau@linux.dev>
In-Reply-To: <20250418224652.105998-1-martin.lau@linux.dev>
References: <20250418224652.105998-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

bpf_qdisc_set_sk_pacing() is added to set the sk_pacing_status. This
can tell the tcp stack that the qdisc can do pacing and the tcp
stack does not need to do its own internal pacing.

It is only allowed in the enqueue ops.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 net/sched/bpf_qdisc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index 9f32b305636f..45776918efcf 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -7,6 +7,7 @@
 #include <linux/filter.h>
 #include <net/pkt_sched.h>
 #include <net/pkt_cls.h>
+#include <net/sock.h>
 
 #define QDISC_OP_IDX(op)	(offsetof(struct Qdisc_ops, op) / sizeof(void (*)(void)))
 #define QDISC_MOFF_IDX(moff)	(moff / sizeof(void (*)(void)))
@@ -214,6 +215,17 @@ __bpf_kfunc void bpf_qdisc_skb_drop(struct sk_buff *skb,
 	__qdisc_drop(skb, (struct sk_buff **)to_free_list);
 }
 
+__bpf_kfunc int bpf_qdisc_set_sk_pacing(struct sk_buff *skb, enum sk_pacing pacing)
+{
+	struct sock *sk = skb->sk;
+
+	if (!sk || sk_listener_or_tw(sk) || pacing != SK_PACING_FQ)
+		return -EINVAL;
+
+	smp_store_release(&sk->sk_pacing_status, pacing);
+	return 0;
+}
+
 /* bpf_qdisc_watchdog_schedule - Schedule a qdisc to a later time using a timer.
  * @sch: The qdisc to be scheduled.
  * @expire: The expiry time of the timer.
@@ -274,6 +286,7 @@ BTF_KFUNCS_START(qdisc_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_skb_get_hash, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_kfree_skb, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_qdisc_skb_drop, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_qdisc_set_sk_pacing, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_dynptr_from_skb, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_qdisc_watchdog_schedule, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_qdisc_init_prologue, KF_TRUSTED_ARGS)
@@ -290,6 +303,7 @@ BTF_SET_END(qdisc_common_kfunc_set)
 BTF_SET_START(qdisc_enqueue_kfunc_set)
 BTF_ID(func, bpf_qdisc_skb_drop)
 BTF_ID(func, bpf_qdisc_watchdog_schedule)
+BTF_ID(func, bpf_qdisc_set_sk_pacing)
 BTF_SET_END(qdisc_enqueue_kfunc_set)
 
 BTF_SET_START(qdisc_dequeue_kfunc_set)
-- 
2.47.1


