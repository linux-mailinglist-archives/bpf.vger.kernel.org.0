Return-Path: <bpf+bounces-67294-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C52B4230D
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 16:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4872A586ACD
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 14:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9873126D5;
	Wed,  3 Sep 2025 14:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bFv3P0fA"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CEE3126C8
	for <bpf@vger.kernel.org>; Wed,  3 Sep 2025 14:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756908301; cv=none; b=JS70JY5h5U5IM5btxEK8Jjto7TCgklo4lObzJTUDzgnwIfExvDJn6ZHt5HNMuAVwhCNC/891RVWtkflgf/TI3VF6zv9RPcT4kTYAKeZc5WqcZXKwyetaKlgDqep1TWEdRetLFR1bAWCuSkorOnkcB0VlnD+Pk5iXJYyOEKjFEP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756908301; c=relaxed/simple;
	bh=r79xooPeZQgiBh+8BE9ekZG+Pfz+YkCUOCISoBf/sjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JMZ5SY1dfh0CDFK23ipV/oB1arK9A18iJyExYP+gJoHvtrXQl6RyL5FFZbfBZQkYxvRQHUl/BqrRyl32LChp3iL6wtMe0BmrQ9wAYZMhMrz7CVVzIu0dA3lmmyqCzDltxJLcNEFEMj/xr0pKpb1Fl52SKPzDxtSPnlRb4ksStd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bFv3P0fA; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756908298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VO4+XxUAXuURoBhxP9uL6g1WnU4Sc9zN43bvAtTq4H4=;
	b=bFv3P0fALFHHdcFeEtFvT+PiEIQJs/wyNRE+NPOxoWMVUal3Pb4lFJ65e/n9MoTmauXKIm
	HlJum43LVRNjIbauRt1Upu/X1bTpPPYJjQUq7056gwB2wBJ14u+qvSYoLq6h+MTPOZQw8Y
	7PwGk8tHO3CAPUSMrDfPKJHx3fRn4MQ=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kernel-patches-bot@fb.com,
	Leon Hwang <leon.hwang@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH bpf-next v3 1/2] selftests/bpf: Introduce experimental bpf_in_interrupt()
Date: Wed,  3 Sep 2025 22:04:37 +0800
Message-ID: <20250903140438.59517-2-leon.hwang@linux.dev>
In-Reply-To: <20250903140438.59517-1-leon.hwang@linux.dev>
References: <20250903140438.59517-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Filtering pid_tgid is meanlingless when the current task is preempted by
an interrupt.

To address this, introduce 'bpf_in_interrupt()' helper function, which
allows BPF programs to determine whether they are executing in interrupt
context.

'get_preempt_count()':

* On x86, '*(int *) bpf_this_cpu_ptr(&__preempt_count)'.
* On arm64, 'bpf_get_current_task_btf()->thread_info.preempt.count'.

Then 'bpf_in_interrupt()' will be:

* If !PREEMPT_RT, 'get_preempt_count() & (NMI_MASK | HARDIRQ_MASK
  | SOFTIRQ_MASK)'.
* If PREEMPT_RT, '(get_preempt_count() & (NMI_MASK | HARDIRQ_MASK))
  | (bpf_get_current_task_btf()->softirq_disable_cnt & SOFTIRQ_MASK)'.

As for other archs, it can be added support by updating
'get_preempt_count()'.

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../testing/selftests/bpf/bpf_experimental.h  | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index da7e230f2781..d89eda3fd8a3 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -599,4 +599,58 @@ extern void bpf_iter_dmabuf_destroy(struct bpf_iter_dmabuf *it) __weak __ksym;
 extern int bpf_cgroup_read_xattr(struct cgroup *cgroup, const char *name__str,
 				 struct bpf_dynptr *value_p) __weak __ksym;

+#define PREEMPT_BITS	8
+#define SOFTIRQ_BITS	8
+#define HARDIRQ_BITS	4
+#define NMI_BITS	4
+
+#define PREEMPT_SHIFT	0
+#define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
+#define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
+#define NMI_SHIFT	(HARDIRQ_SHIFT + HARDIRQ_BITS)
+
+#define __IRQ_MASK(x)	((1UL << (x))-1)
+
+#define SOFTIRQ_MASK	(__IRQ_MASK(SOFTIRQ_BITS) << SOFTIRQ_SHIFT)
+#define HARDIRQ_MASK	(__IRQ_MASK(HARDIRQ_BITS) << HARDIRQ_SHIFT)
+#define NMI_MASK	(__IRQ_MASK(NMI_BITS)     << NMI_SHIFT)
+
+extern bool CONFIG_PREEMPT_RT __kconfig __weak;
+#ifdef bpf_target_x86
+extern const int __preempt_count __ksym;
+#endif
+
+struct task_struct___preempt_rt {
+	int softirq_disable_cnt;
+} __attribute__((preserve_access_index));
+
+static inline int get_preempt_count(void)
+{
+#if defined(bpf_target_x86)
+	return *(int *) bpf_this_cpu_ptr(&__preempt_count);
+#elif defined(bpf_target_arm64)
+	return bpf_get_current_task_btf()->thread_info.preempt.count;
+#endif
+	return 0;
+}
+
+/* Description
+ *	Report whether it is in interrupt context. Only works on the following archs:
+ *	* x86
+ *	* arm64
+ */
+static inline int bpf_in_interrupt(void)
+{
+	struct task_struct___preempt_rt *tsk;
+	int pcnt;
+
+	pcnt = get_preempt_count();
+	if (!CONFIG_PREEMPT_RT)
+		return pcnt & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_MASK);
+
+	tsk = (void *) bpf_get_current_task_btf();
+	return (pcnt & (NMI_MASK | HARDIRQ_MASK)) |
+	       (tsk->softirq_disable_cnt & SOFTIRQ_MASK);
+}
+
 #endif
--
2.51.0


