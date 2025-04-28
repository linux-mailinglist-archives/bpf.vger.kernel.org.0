Return-Path: <bpf+bounces-56817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1732EA9E6B6
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 05:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2080A1898968
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 03:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4633C1E7C38;
	Mon, 28 Apr 2025 03:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Gf5dRr3T"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319051E7C34
	for <bpf@vger.kernel.org>; Mon, 28 Apr 2025 03:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745811423; cv=none; b=sNQiq4tBEaTKLEMifmM1rxLvK+ySd0spp/H2YiXCq72G/cp3nBviRkfeMM/H9qzxWjtdB9Ddzm2DbaffBsXe9qwNnIoQu72neTCBq3RZgHBTdAykkFoRemHJaMUs5E5IN7CXif0XyYQg5lXRnx0bstmgO812lmqP/UakBDv8iUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745811423; c=relaxed/simple;
	bh=MSuCn/IFWqQlylKlbdwaS8cTvPrEiuR18JIMnVpqPEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OIrCW+6dI6aSYIMwRc4qvK5fRcG6vOne941XqQ0ZsYVb7ZHWocOYyg8CCyoktYTrlI1yi70/9QtCKJEMgBiT1BAW+vWCaj/eKe2/0dc7Op86WYf4RrM3jBLeEv6k4iELjlLa4eGjw7n/xPYA8FoII3Dp4J06DxrqrPmTaDC3nYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Gf5dRr3T; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745811420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5mgjhUpiTMjjN/y1DN45zRe/y1CtVNZ7gASyknJ+oe4=;
	b=Gf5dRr3TIZDIRx58GflQe6YhjrDUw+0tzYVZbiKzXUNkPSh7HUd7ek/cBcTFcLuHz3q+G4
	96GXvmnprLNKAGeRu8Zk/E1HlHIvJXfcWn8DjkRrxGuKHhy7GYP+ik89uT0QxKhw9T72Vp
	oJoSXAS2Ltc8+hfooGk4XMHgY8G/unk=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	David Rientjes <rientjes@google.com>,
	Josh Don <joshdon@google.com>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH rfc 09/12] sched: psi: bpf hook to handle psi events
Date: Mon, 28 Apr 2025 03:36:14 +0000
Message-ID: <20250428033617.3797686-10-roman.gushchin@linux.dev>
In-Reply-To: <20250428033617.3797686-1-roman.gushchin@linux.dev>
References: <20250428033617.3797686-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Introduce a bpf hook to handle psi events. The primary intended
purpose of this hook is to declare OOM events based on the reaching
a certain memory pressure level, similar to what systemd-oomd and oomd
are doing in userspace.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 kernel/sched/psi.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 1396674fa722..4c4eb4ead8f6 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -176,6 +176,32 @@ static void psi_avgs_work(struct work_struct *work);
 
 static void poll_timer_fn(struct timer_list *t);
 
+#ifdef CONFIG_BPF_SYSCALL
+__bpf_hook_start();
+
+__weak noinline int bpf_handle_psi_event(struct psi_trigger *t)
+{
+	return 0;
+}
+
+__bpf_hook_end();
+
+BTF_KFUNCS_START(bpf_psi_hooks)
+BTF_ID_FLAGS(func, bpf_handle_psi_event, KF_SLEEPABLE)
+BTF_KFUNCS_END(bpf_psi_hooks)
+
+static const struct btf_kfunc_id_set bpf_psi_hook_set = {
+	.owner = THIS_MODULE,
+	.set   = &bpf_psi_hooks,
+};
+
+#else
+static inline int bpf_handle_psi_event(struct psi_trigger *t)
+{
+	return 0;
+}
+#endif
+
 static void group_init(struct psi_group *group)
 {
 	int cpu;
@@ -489,6 +515,7 @@ static void update_triggers(struct psi_group *group, u64 now,
 
 		/* Generate an event */
 		if (cmpxchg(&t->event, 0, 1) == 0) {
+			bpf_handle_psi_event(t);
 			if (t->of)
 				kernfs_notify(t->of->kn);
 			else
@@ -1655,6 +1682,8 @@ static const struct proc_ops psi_irq_proc_ops = {
 
 static int __init psi_proc_init(void)
 {
+	int err = 0;
+
 	if (psi_enable) {
 		proc_mkdir("pressure", NULL);
 		proc_create("pressure/io", 0666, NULL, &psi_io_proc_ops);
@@ -1662,9 +1691,14 @@ static int __init psi_proc_init(void)
 		proc_create("pressure/cpu", 0666, NULL, &psi_cpu_proc_ops);
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 		proc_create("pressure/irq", 0666, NULL, &psi_irq_proc_ops);
+#endif
+#ifdef CONFIG_BPF_SYSCALL
+		err = register_btf_fmodret_id_set(&bpf_psi_hook_set);
+		if (err)
+			pr_err("error while registering bpf psi hooks: %d", err);
 #endif
 	}
-	return 0;
+	return err;
 }
 module_init(psi_proc_init);
 
-- 
2.49.0.901.g37484f566f-goog


