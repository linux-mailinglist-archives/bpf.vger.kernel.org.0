Return-Path: <bpf+bounces-36999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDE294FCBD
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 06:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90C271F2252E
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 04:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4555C1311B6;
	Tue, 13 Aug 2024 04:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsFyfNFI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAF27CF16;
	Tue, 13 Aug 2024 04:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723523413; cv=none; b=YpF2VprY/QqrygCTymSPO2Vx3rINFEVplVbyDSLNMIptY8MnKCoP0LJcRsPfRZrHmp0sB+E/vs6swtayR8flZMnaYjWkWycVkQ+eDoDOU7mWnvHRIeyIWmo59DkzYrAeEVrD8tIkLt3syL2pW9yrfZnBu/eoBOcrS9hibQs1lD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723523413; c=relaxed/simple;
	bh=lE/xzipeIMKlpu3HvFd4L+QxhBM6/Hk0Qs9hd5OSsYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n4C75PmnZ0klYfXNnQS2s//5bghvBBKZYvApe9cBYpu0sIMoNW0Q5R3ziiH2RRwsosgRlpWPeXjsiTFU3Tgm3olUi43poevGEtLn5GKfblx4gT/1U9u1qx+O+dUtLd/JnKZAWELlKxQ4XjzVlaarkj75xnyL3H/ZE/7hu66T2G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsFyfNFI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2116BC4AF11;
	Tue, 13 Aug 2024 04:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723523413;
	bh=lE/xzipeIMKlpu3HvFd4L+QxhBM6/Hk0Qs9hd5OSsYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VsFyfNFI1aH1yYtea8NqaJI8dNdgsqy7CbBuR0QzPL1quQeQDPrXwLZh7di5rL9uS
	 jRz1DW3DAlmVOhkzhAt4IpDSk5aRrst+Gkj55GZpizSIJUhFwV//P2uGNHw++ixzfm
	 0uZ3uhs8RHOv8cjppbjx20zTHVBGNXxZ8sufUBJXsguCXTtIbe/Z2khO/SRP55lbI1
	 bjB4AS7YmyAZDbVkW/BPle9cTfX+7DdCW5b4IzgU7Ht3uEkotHkag+cQMm2rkYR9BD
	 yeEZ1V1yoh3bSUXYAgctMa8IAVOv39IoRp9hmW6CX5P/v8fWj7R6UkPdGXIeY0tnbd
	 YvHBquD/4SPMg==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org,
	oleg@redhat.com
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jolsa@kernel.org,
	paulmck@kernel.org,
	willy@infradead.org,
	surenb@google.com,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH RFC v3 10/13] uprobes: implement SRCU-protected lifetime for single-stepped uprobe
Date: Mon, 12 Aug 2024 21:29:14 -0700
Message-ID: <20240813042917.506057-11-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240813042917.506057-1-andrii@kernel.org>
References: <20240813042917.506057-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similarly to how we SRCU-protect uprobe instance (and avoid refcounting
it unnecessarily) when waiting for return probe hit, use hprobe approach
to do the same with single-stepped uprobe. Same hprobe_* primitives are
used. We also reuse ri_timer() callback to expire both pending
single-step uprobe and return instances.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/uprobes.h |  4 +--
 kernel/events/uprobes.c | 56 ++++++++++++++++++++++++-----------------
 2 files changed, 35 insertions(+), 25 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 9a0aa0b2a5fe..cc9d3cb055b5 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -107,7 +107,7 @@ struct uprobe_task {
 		};
 	};
 
-	struct uprobe			*active_uprobe;
+	struct hprobe			active_hprobe;
 	struct timer_list		ri_timer;
 	unsigned long			xol_vaddr;
 
@@ -115,7 +115,7 @@ struct uprobe_task {
 
 	struct return_instance		*return_instances;
 	unsigned int			depth;
-};
+} ____cacheline_aligned;
 
 struct return_instance {
 	unsigned long		func;
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 26acd06871e6..713824c8ca77 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1860,11 +1860,16 @@ unsigned long __weak uprobe_get_swbp_addr(struct pt_regs *regs)
 	return instruction_pointer(regs) - UPROBE_SWBP_INSN_SIZE;
 }
 
+static bool utask_has_pending_sstep_uprobe(struct uprobe_task *utask)
+{
+	return utask->active_hprobe.stable != NULL;
+}
+
 unsigned long uprobe_get_trap_addr(struct pt_regs *regs)
 {
 	struct uprobe_task *utask = current->utask;
 
-	if (unlikely(utask && utask->active_uprobe))
+	if (unlikely(utask && utask_has_pending_sstep_uprobe(utask)))
 		return utask->vaddr;
 
 	return instruction_pointer(regs);
@@ -1893,14 +1898,17 @@ void uprobe_free_utask(struct task_struct *t)
 {
 	struct uprobe_task *utask = t->utask;
 	struct return_instance *ri;
+	struct uprobe *uprobe;
+	bool under_rcu;
 
 	if (!utask)
 		return;
 
 	timer_delete_sync(&utask->ri_timer);
 
-	if (utask->active_uprobe)
-		put_uprobe(utask->active_uprobe);
+	/* clean up pending single-stepped uprobe */
+	uprobe = hprobe_consume(&utask->active_hprobe, &under_rcu);
+	hprobe_finalize(&utask->active_hprobe, uprobe, under_rcu);
 
 	ri = utask->return_instances;
 	while (ri)
@@ -1924,6 +1932,8 @@ static void ri_timer(struct timer_list *timer)
 	/* RCU protects return_instance from freeing. */
 	guard(rcu)();
 
+	hprobe_expire(&utask->active_hprobe);
+
 	for_each_ret_instance_rcu(ri, utask->return_instances) {
 		hprobe_expire(&ri->hprobe);
 	}
@@ -2166,20 +2176,15 @@ pre_ssout(struct uprobe *uprobe, struct pt_regs *regs, unsigned long bp_vaddr)
 {
 	struct uprobe_task *utask;
 	unsigned long xol_vaddr;
-	int err;
+	int err, srcu_idx;
 
 	utask = get_utask();
 	if (!utask)
 		return -ENOMEM;
 
-	if (!try_get_uprobe(uprobe))
-		return -EINVAL;
-
 	xol_vaddr = xol_get_insn_slot(uprobe);
-	if (!xol_vaddr) {
-		err = -ENOMEM;
-		goto err_out;
-	}
+	if (!xol_vaddr)
+		return -ENOMEM;
 
 	utask->xol_vaddr = xol_vaddr;
 	utask->vaddr = bp_vaddr;
@@ -2187,15 +2192,18 @@ pre_ssout(struct uprobe *uprobe, struct pt_regs *regs, unsigned long bp_vaddr)
 	err = arch_uprobe_pre_xol(&uprobe->arch, regs);
 	if (unlikely(err)) {
 		xol_free_insn_slot(current);
-		goto err_out;
+		return err;
 	}
 
-	utask->active_uprobe = uprobe;
+	srcu_idx = __srcu_read_lock(&uretprobes_srcu);
+
+	hprobe_init_leased(&utask->active_hprobe, uprobe, srcu_idx);
 	utask->state = UTASK_SSTEP;
+
+	if (!timer_pending(&utask->ri_timer))
+		mod_timer(&utask->ri_timer, jiffies + RI_TIMER_PERIOD);
+
 	return 0;
-err_out:
-	put_uprobe(uprobe);
-	return err;
 }
 
 /*
@@ -2212,7 +2220,7 @@ bool uprobe_deny_signal(void)
 	struct task_struct *t = current;
 	struct uprobe_task *utask = t->utask;
 
-	if (likely(!utask || !utask->active_uprobe))
+	if (likely(!utask || !utask_has_pending_sstep_uprobe(utask)))
 		return false;
 
 	WARN_ON_ONCE(utask->state != UTASK_SSTEP);
@@ -2528,8 +2536,10 @@ static void handle_singlestep(struct uprobe_task *utask, struct pt_regs *regs)
 {
 	struct uprobe *uprobe;
 	int err = 0;
+	bool under_rcu;
+
+	uprobe = hprobe_consume(&utask->active_hprobe, &under_rcu);
 
-	uprobe = utask->active_uprobe;
 	if (utask->state == UTASK_SSTEP_ACK)
 		err = arch_uprobe_post_xol(&uprobe->arch, regs);
 	else if (utask->state == UTASK_SSTEP_TRAPPED)
@@ -2537,8 +2547,8 @@ static void handle_singlestep(struct uprobe_task *utask, struct pt_regs *regs)
 	else
 		WARN_ON_ONCE(1);
 
-	put_uprobe(uprobe);
-	utask->active_uprobe = NULL;
+	hprobe_finalize(&utask->active_hprobe, uprobe, under_rcu);
+
 	utask->state = UTASK_RUNNING;
 	xol_free_insn_slot(current);
 
@@ -2556,7 +2566,7 @@ static void handle_singlestep(struct uprobe_task *utask, struct pt_regs *regs)
 /*
  * On breakpoint hit, breakpoint notifier sets the TIF_UPROBE flag and
  * allows the thread to return from interrupt. After that handle_swbp()
- * sets utask->active_uprobe.
+ * sets utask->active_hprobe.
  *
  * On singlestep exception, singlestep notifier sets the TIF_UPROBE flag
  * and allows the thread to return from interrupt.
@@ -2571,7 +2581,7 @@ void uprobe_notify_resume(struct pt_regs *regs)
 	clear_thread_flag(TIF_UPROBE);
 
 	utask = current->utask;
-	if (utask && utask->active_uprobe)
+	if (utask && utask_has_pending_sstep_uprobe(utask))
 		handle_singlestep(utask, regs);
 	else
 		handle_swbp(regs);
@@ -2602,7 +2612,7 @@ int uprobe_post_sstep_notifier(struct pt_regs *regs)
 {
 	struct uprobe_task *utask = current->utask;
 
-	if (!current->mm || !utask || !utask->active_uprobe)
+	if (!current->mm || !utask || !utask_has_pending_sstep_uprobe(utask))
 		/* task is currently not uprobed */
 		return 0;
 
-- 
2.43.5


