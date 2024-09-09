Return-Path: <bpf+bounces-39370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D70972575
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 00:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43841B22E28
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 22:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D940518C923;
	Mon,  9 Sep 2024 22:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/EqOHNC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545BE18DF63;
	Mon,  9 Sep 2024 22:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725922158; cv=none; b=DAGBiIrrrisCwutSRlK8o34C9V3xUBV7FcMTUUxWe4+/uzY+CiRCVOA4fPmrsmhdbXbBb0Q/oibnVqJi86h7+m1Wh+HzDMRYil3cwmVHU25lP9cioUiFSbZuE8+Mlai2UoGOzBeRjQdyJsTF73N5xvtdt6b8eGQQcgcq89ZLAaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725922158; c=relaxed/simple;
	bh=THYLFg3kjLTPYm13kyoEYDqmRzKJALbi+j9hfhgBwow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h8cvKax465bSvIkKZNIC/tDGt3TBfyiGv3z4A5F8MtOcgzG54jD5m6eWalT7FPMYKwv5dNKNScDxRsgawb1+9WyltMmIHsMRCGxTvJbr9eaHARd1mD2qHMpVxHC1VLydA8QKYji2x/lU9ZwPs5JV+72kUnG2yh6CT2Bsfb3x/W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/EqOHNC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDDA0C4CEC5;
	Mon,  9 Sep 2024 22:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725922158;
	bh=THYLFg3kjLTPYm13kyoEYDqmRzKJALbi+j9hfhgBwow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h/EqOHNCKrRaRTdRlMHnqzqyaGgPC6wjPR4DvcOmMAxm22c+tHHsIqUE55OrrAgAY
	 ntnv5Y+/MniUUoxq9TEPUJkagRmWsyhjXdXro0ZMwS7dfIdYHRp/cYr5snDRffACCq
	 mBbVTCwIBwhUTrYJp6x+dyv5sFCtjmlvbpnkjkZSCCkPGFU/oi9BQK0GuYJ8RYKgL6
	 7UXkaqadY00xgHrBfu2ta5gTGAJDDk1CA2NUc3vku4Z2yYgrRdg3hW7usv/2RfxMw0
	 JnsZLeWQJDnq1PYkwPluG6fMgklN1LeE0g6bWgaPUbwKf55FB55zafeM6P5PXM6xbF
	 n3vh66nYsrmug==
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
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH 3/3] uprobes: implement SRCU-protected lifetime for single-stepped uprobe
Date: Mon,  9 Sep 2024 15:49:03 -0700
Message-ID: <20240909224903.3498207-4-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240909224903.3498207-1-andrii@kernel.org>
References: <20240909224903.3498207-1-andrii@kernel.org>
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
 kernel/events/uprobes.c | 55 ++++++++++++++++++++++++-----------------
 2 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 1b194c51d4d3..31cf7306cdf6 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -114,7 +114,7 @@ struct uprobe_task {
 		};
 	};
 
-	struct uprobe			*active_uprobe;
+	struct hprobe			active_hprobe;
 	struct timer_list		ri_timer;
 	unsigned long			xol_vaddr;
 
@@ -122,7 +122,7 @@ struct uprobe_task {
 
 	struct return_instance		*return_instances;
 	unsigned int			depth;
-};
+} ____cacheline_aligned;
 
 struct return_instance {
 	unsigned long		func;
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index b047e68499d5..d9ab5e0dd9dd 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1894,11 +1894,16 @@ unsigned long __weak uprobe_get_swbp_addr(struct pt_regs *regs)
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
@@ -1927,14 +1932,17 @@ void uprobe_free_utask(struct task_struct *t)
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
@@ -1958,6 +1966,8 @@ static void ri_timer(struct timer_list *timer)
 	/* RCU protects return_instance from freeing. */
 	guard(rcu)();
 
+	hprobe_expire(&utask->active_hprobe);
+
 	for_each_ret_instance_rcu(ri, utask->return_instances) {
 		hprobe_expire(&ri->hprobe);
 	}
@@ -2190,20 +2200,15 @@ pre_ssout(struct uprobe *uprobe, struct pt_regs *regs, unsigned long bp_vaddr)
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
@@ -2211,15 +2216,17 @@ pre_ssout(struct uprobe *uprobe, struct pt_regs *regs, unsigned long bp_vaddr)
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
+	mod_timer(&utask->ri_timer, jiffies + RI_TIMER_PERIOD);
+
 	return 0;
-err_out:
-	put_uprobe(uprobe);
-	return err;
 }
 
 /*
@@ -2236,7 +2243,7 @@ bool uprobe_deny_signal(void)
 	struct task_struct *t = current;
 	struct uprobe_task *utask = t->utask;
 
-	if (likely(!utask || !utask->active_uprobe))
+	if (likely(!utask || !utask_has_pending_sstep_uprobe(utask)))
 		return false;
 
 	WARN_ON_ONCE(utask->state != UTASK_SSTEP);
@@ -2553,8 +2560,10 @@ static void handle_singlestep(struct uprobe_task *utask, struct pt_regs *regs)
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
@@ -2562,8 +2571,8 @@ static void handle_singlestep(struct uprobe_task *utask, struct pt_regs *regs)
 	else
 		WARN_ON_ONCE(1);
 
-	put_uprobe(uprobe);
-	utask->active_uprobe = NULL;
+	hprobe_finalize(&utask->active_hprobe, uprobe, under_rcu);
+
 	utask->state = UTASK_RUNNING;
 	xol_free_insn_slot(current);
 
@@ -2580,7 +2589,7 @@ static void handle_singlestep(struct uprobe_task *utask, struct pt_regs *regs)
 /*
  * On breakpoint hit, breakpoint notifier sets the TIF_UPROBE flag and
  * allows the thread to return from interrupt. After that handle_swbp()
- * sets utask->active_uprobe.
+ * sets utask->active_hprobe.
  *
  * On singlestep exception, singlestep notifier sets the TIF_UPROBE flag
  * and allows the thread to return from interrupt.
@@ -2595,7 +2604,7 @@ void uprobe_notify_resume(struct pt_regs *regs)
 	clear_thread_flag(TIF_UPROBE);
 
 	utask = current->utask;
-	if (utask && utask->active_uprobe)
+	if (utask && utask_has_pending_sstep_uprobe(utask))
 		handle_singlestep(utask, regs);
 	else
 		handle_swbp(regs);
@@ -2626,7 +2635,7 @@ int uprobe_post_sstep_notifier(struct pt_regs *regs)
 {
 	struct uprobe_task *utask = current->utask;
 
-	if (!current->mm || !utask || !utask->active_uprobe)
+	if (!current->mm || !utask || !utask_has_pending_sstep_uprobe(utask))
 		/* task is currently not uprobed */
 		return 0;
 
-- 
2.43.5


